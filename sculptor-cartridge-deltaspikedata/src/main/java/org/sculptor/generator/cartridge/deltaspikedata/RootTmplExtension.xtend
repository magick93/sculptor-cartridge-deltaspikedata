package org.sculptor.generator.cartridge.deltaspikedata

import org.sculptor.generator.template.RootTmpl
import org.sculptor.generator.chain.ChainOverride
import sculptormetamodel.Application
import org.sculptor.generator.ext.Helper
import javax.inject.Inject
import org.sculptor.generator.util.OutputSlot
import org.sculptor.generator.util.HelperBase
import org.sculptor.generator.ext.Properties
import sculptormetamodel.Module

@ChainOverride
class RootTmplExtension extends RootTmpl {
	
	@Inject extension Helper helper
	@Inject extension HelperBase helperBase
	@Inject extension Properties properties
	
	override String root(Application it) {
		'''
		«IF isRepositoryToBeGenerated»
			«getAllRepositories(false).map[module].toSet.forEach[cdiConfigClass]»
		«ENDIF»
		«next.root(it)»
		'''
	}

	private def String cdiConfigClass(Module it) {
		fileOutput(
			javaFileName(getBasePackage(it) + ".EntityManagerProducer"),
			OutputSlot::TO_GEN_SRC,
			'''
			«javaHeader»
			package «getBasePackage(it)»;

			/// Sculptor code formatter imports ///

			/**
			 * This class is needed to expose EntityManager to CDI
			 */
			public class EntityManagerProducer {
			
			    @javax.enterprise.inject.Produces
			    @javax.enterprise.context.Dependent
			    @javax.persistence.PersistenceContext(unitName = "«
			    	IF persistenceUnit != "null"»«persistenceUnit»«ENDIF»")
			    public javax.persistence.EntityManager entityManager;
			}
			'''
		)
	}
}