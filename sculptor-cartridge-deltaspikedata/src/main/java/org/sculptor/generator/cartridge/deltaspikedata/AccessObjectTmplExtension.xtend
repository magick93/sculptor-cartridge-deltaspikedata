package org.sculptor.generator.cartridge.deltaspikedata

import org.sculptor.generator.chain.ChainOverride
import org.sculptor.generator.template.repository.AccessObjectTmpl
import sculptormetamodel.RepositoryOperation

@ChainOverride
class AccessObjectTmplExtension extends AccessObjectTmpl {

	override String command(RepositoryOperation it) {
	}

}
