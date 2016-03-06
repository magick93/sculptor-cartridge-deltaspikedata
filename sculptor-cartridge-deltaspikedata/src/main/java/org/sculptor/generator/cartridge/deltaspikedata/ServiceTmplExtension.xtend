package org.sculptor.generator.cartridge.deltaspikedata

import org.sculptor.generator.template.service.ServiceTmpl
import org.sculptor.generator.chain.ChainOverride
import sculptormetamodel.Service
import javax.inject.Inject
import org.sculptor.generator.util.HelperBase
import org.sculptor.generator.ext.Helper

@ChainOverride
class ServiceTmplExtension extends ServiceTmpl {
		
	@Inject extension Helper helper
	@Inject extension HelperBase helperBase
	
	override String delegateRepositories(Service it) {
		'''
		«FOR delegateRepository : it.getDelegateRepositories()»
			@javax.inject.Inject
			private «getRepositoryapiPackage(delegateRepository.aggregateRoot.module)».«delegateRepository.name» «delegateRepository.name.toFirstLower()»;

			protected «getRepositoryapiPackage(delegateRepository.aggregateRoot.module)».«delegateRepository.name» get«delegateRepository.name»() {
				return «delegateRepository.name.toFirstLower()»;
			}
		«ENDFOR»
		'''
	}
}