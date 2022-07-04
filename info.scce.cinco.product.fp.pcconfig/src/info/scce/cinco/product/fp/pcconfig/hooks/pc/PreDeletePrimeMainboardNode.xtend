package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPreDeleteHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.Mainboard
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PriceNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PowerNode

class PreDeletePrimeMainboardNode extends CincoPreDeleteHook<PrimeMainboardNode> {
	override preDelete(PrimeMainboardNode mainboardNode) {
		val priceNodeView = mainboardNode.container.container.container.findThe(PriceNode).priceNodeView
		val powerNode = mainboardNode.container.container.container.findThe(PowerNode)
		val mainboardPrime = mainboardNode.mainboardPrime as Mainboard
		
		//TODO adjust to real values
		priceNodeView.price = Math.round((priceNodeView.price -  Double.parseDouble("100.11")) * 100.0)/100.0
		powerNode.power = powerNode.power +  150
	}
}