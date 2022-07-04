package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PSUNode
import info.scce.cinco.fp.compdsl.componentDsl.PSU
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PriceNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PowerNode

class PostCreatePSUNode extends CincoPostCreateHook<PSUNode> {
	
	override postCreate(PSUNode psuNode) {
		psuNode.x = 0
		psuNode.y = 0
		
		val psuPrime = psuNode.psuPrime as PSU
		
		val priceNodeView = psuNode.container.container.container.findThe(PriceNode).priceNodeView
		priceNodeView.price = Math.round((priceNodeView.price +  Double.parseDouble(psuPrime.price)) * 100.0)/100.0
		
		val powerNode = psuNode.container.container.container.findThe(PowerNode)
		powerNode.power = powerNode.power +  psuPrime.power
	}
	
}