package info.scce.cinco.product.fp.pcconfig.hooks.mb

import de.jabc.cinco.meta.runtime.hook.CincoPreDeleteHook

import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PriceNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.MainboardNode
import info.scce.cinco.fp.compdsl.componentDsl.Mainboard
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PowerNode

class PreDeleteMBNode extends CincoPreDeleteHook<MainboardNode> {
	
	override preDelete(MainboardNode mbN) {
		val mbP = mbN.mbprime as Mainboard
		val priceNodeView = mbN.container.findThe(PriceNode).priceNodeView
		priceNodeView.price = Math.round((priceNodeView.price -  Double.parseDouble(mbP.price)) * 100.0)/100.0
			
		val powerNode = mbN.container.findThe(PowerNode)
		powerNode.power = powerNode.power - mbP.power
	}
	
}