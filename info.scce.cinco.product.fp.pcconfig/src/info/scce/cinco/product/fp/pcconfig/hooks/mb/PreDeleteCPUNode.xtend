package info.scce.cinco.product.fp.pcconfig.hooks.mb

import de.jabc.cinco.meta.runtime.hook.CincoPreDeleteHook
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.CPUNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PriceNode
import info.scce.cinco.fp.compdsl.componentDsl.CPU
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PowerNode

class PreDeleteCPUNode extends CincoPreDeleteHook<CPUNode>{
	
	override preDelete(CPUNode cpuN) {
		val cpuP = cpuN.cpuprime as CPU
		val priceNodeView = cpuN.container.container.container.findThe(PriceNode).priceNodeView
		priceNodeView.price = Math.round((priceNodeView.price -  Double.parseDouble(cpuP.price)) * 100.0)/100.0
			
		val powerNode = cpuN.container.container.container.findThe(PowerNode)
		powerNode.power = powerNode.power - cpuP.power
	}
	
}

