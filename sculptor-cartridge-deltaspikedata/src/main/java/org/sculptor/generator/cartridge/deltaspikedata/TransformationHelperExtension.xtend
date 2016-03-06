package org.sculptor.generator.cartridge.deltaspikedata

import org.sculptor.generator.chain.ChainOverride
import org.sculptor.generator.transform.TransformationHelper

@ChainOverride
class TransformationHelperExtension extends TransformationHelper {

	override boolean isModifyDynamicFindersEnabled() {
		false
	}

	override boolean isModifyPagingOperationsEnabled() {
		false
	}

}
