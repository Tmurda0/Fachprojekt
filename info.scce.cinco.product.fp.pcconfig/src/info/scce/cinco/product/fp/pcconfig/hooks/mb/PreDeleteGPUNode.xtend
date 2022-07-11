package info.scce.cinco.product.fp.pcconfig.hooks.mb

import de.jabc.cinco.meta.runtime.hook.CincoPreDeleteHook
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.GPUNode
import info.scce.cinco.fp.compdsl.componentDsl.GPU
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PriceNode

class PreDeleteGPUNode extends CincoPreDeleteHook<GPUNode> {
	
	override preDelete(GPUNode gpuN) {
		val gpuP = gpuN.GPUPrime as GPU
		val priceNodeView = gpuN.container.container.container.findThe(PriceNode).priceNodeView
		priceNodeView.price = Math.round((priceNodeView.price -  Double.parseDouble(gpuP.price)) * 100.0)/100.0
	}
	
}
