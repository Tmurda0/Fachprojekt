package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPreDeleteHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PSUNode
import info.scce.cinco.fp.compdsl.componentDsl.PSU

class PreDeletePSUNode extends CincoPreDeleteHook<PSUNode> {
	override preDelete(PSUNode psuNode) {
		val priceNodeView = psuNode.container.container.container.priceNodes.get(0).priceNodeView
		priceNodeView.price = Math.round((priceNodeView.price -  Double.parseDouble((psuNode.psuPrime as PSU).price)) * 100.0)/100.0
		
		val powerNode = psuNode.container.container.container.powerNodes.get(0)
		powerNode.power = powerNode.power -  (psuNode.psuPrime as PSU).power
	}
}