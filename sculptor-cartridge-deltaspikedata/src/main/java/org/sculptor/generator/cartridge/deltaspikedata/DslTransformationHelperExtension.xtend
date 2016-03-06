package org.sculptor.generator.cartridge.deltaspikedata

import org.sculptor.dsl.sculptordsl.DslRepository
import org.sculptor.generator.chain.ChainOverride
import org.sculptor.generator.transform.DslTransformationHelper

@ChainOverride
class DslTransformationHelperExtension extends DslTransformationHelper {

	override boolean hasGapOperations(DslRepository dslRepository) {
		false
	}

}
