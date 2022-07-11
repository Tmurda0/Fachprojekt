package info.scce.cinco.product.fp.pcconfig.hooks.mb

import de.jabc.cinco.meta.runtime.hook.CincoPreDeleteHook
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.RAMNode
import info.scce.cinco.fp.compdsl.componentDsl.RAM
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PriceNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PowerNode

class PreDeleteRAMNode extends CincoPreDeleteHook<RAMNode> {
	
	override preDelete(RAMNode ramN) {
		val ramP = ramN.ramPrime as RAM
		val priceNodeView = ramN.container.container.container.findThe(PriceNode).priceNodeView
		priceNodeView.price = Math.round((priceNodeView.price -  Double.parseDouble(ramP.price)) * 100.0)/100.0
			
		val powerNode = ramN.container.container.container.findThe(PowerNode)
		powerNode.power = powerNode.power - ramP.power
	}
	
	
}