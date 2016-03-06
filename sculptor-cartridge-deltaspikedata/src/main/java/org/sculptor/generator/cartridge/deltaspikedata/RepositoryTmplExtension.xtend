package org.sculptor.generator.cartridge.deltaspikedata

import javax.inject.Inject
import org.sculptor.generator.chain.ChainOverride
import org.sculptor.generator.ext.Helper
import org.sculptor.generator.ext.Properties
import org.sculptor.generator.template.repository.RepositoryTmpl
import org.sculptor.generator.util.HelperBase
import org.sculptor.generator.util.OutputSlot
import sculptormetamodel.Repository
import sculptormetamodel.RepositoryOperation

@ChainOverride
class RepositoryTmplExtension extends RepositoryTmpl {

	@Inject extension HelperBase helperBase
	@Inject extension Helper helper
	@Inject extension Properties properties

	override String repository(Repository it) {
		if (!jpa) {
			error("Deltaspike Data JPA is not supported for 'jpa.provider=none'.")
		}
		if (!pureEjb3) {
			error("Deltaspike Data JPA is only supported for the project nature 'pure-ejb3'.")
		}
		if (it.gapClass) {
			error(
				"With Deltaspike Data marking the whole repository '" + it.name + "' as gap class is not supported." +
					" Instead mark the corresponding repository methods as gap methods.")
		}
		it.operations.forEach[op|
			if (op.delegateToAccessObject) {
				error(
					"With Deltaspike Data delegating to an access object in repository operation '" + op.name +
						"' in repository '" + op.repository.name + "' is not supported")
			} else if (!op.publicVisibility) {
				error(
					"With Deltaspike Data non-public visibility for repository operation '" + op.name + "' in repository '" +
						op.repository.name + "' is not supported")
			}]

		// If repository methods marked as gap method then we need the custom interface and the implementation class
		val custom = it.operations.filter[hasHint("gap")].size > 0
		'''
			«deltaspikeRepositoryBase(custom)»
			«IF custom»
				«it.deltaspikeRepositoryCustom»
			«ENDIF»
		'''
	}

	private def String deltaspikeRepositoryBase(Repository it, boolean custom) {
		val baseName = it.getRepositoryBaseName
		fileOutput(
			javaFileName(aggregateRoot.module.repositoryapiPackage + "." + name +
				(if (custom) "Base" else "") 
			),
			OutputSlot::TO_GEN_SRC,
			'''
			«javaHeader»
			package «aggregateRoot.module.repositoryapiPackage»;
			
			/// Sculptor code formatter imports ///
			
			«IF it.formatJavaDoc == ""»
				/**
				 * Generated «IF custom»base«ENDIF» abstract class for Deltaspike Data Repository of «baseName»
				 */
			«ELSE»
				«it.formatJavaDoc»
			«ENDIF»
			«IF !custom»
				@org.apache.deltaspike.data.api.Repository(forEntity = «baseName».class)
			«ELSE»
				 * <p>Make sure that abstract subclass defines the following annotations:
				 * <pre>
				     @org.apache.deltaspike.data.api.Repository(forEntity = «baseName».class)
				 * </pre>
				 *
			«ENDIF»
			public abstract class «name»«IF custom»Base«ENDIF» extends org.apache.deltaspike.data.api.AbstractEntityRepository<«baseName», «"IDTYPE".javaType»> {
				«it.operations.filter[isPublicVisibility && !hasHint("gap")].map[abstractRepositoryMethod].join»
			}
			'''
		)
	}
	
	def String abstractRepositoryMethod(RepositoryOperation it) {
		'''
		«IF name == "delete"»
			public «getTypeName()» «name»(«parameters.map[paramTypeAndName].join(",")») {
				remove(«parameters.map[name].join(",")»);
			}
		«ELSE»
			«formatJavaDoc»
			public abstract «getTypeName()» «name»(«parameters.map[paramTypeAndName].join(",")»);
			«findByNaturalKeysInterfaceRepositoryMethod»
		«ENDIF»
		'''
	}
	
	private def String deltaspikeRepositoryCustom(Repository it) {
		val baseName = it.getRepositoryBaseName
		fileOutput(
			javaFileName(aggregateRoot.module.repositoryapiPackage + "." + name),
			OutputSlot::TO_GEN_SRC,
			'''
			«javaHeader»
			package «aggregateRoot.module.getRepositoryapiPackage»;
			
			/// Sculptor code formatter imports ///
			
			«IF it.formatJavaDoc == ""»
				/**
				 * Generated custom abstract class for Deltaspike Data Repository of «baseName»
				 */
			«ELSE»
				«it.formatJavaDoc»
			«ENDIF»
			@org.apache.deltaspike.data.api.Repository(forEntity = «baseName».class)
			public abstract class «name» extends «aggregateRoot.module.getRepositoryapiPackage».«name»Base{
			
				«it.operations.filter[isPublicVisibility && hasHint("gap")].map[subclassRepositoryMethod(it)].join»
			}
			'''
		)
	}
}
