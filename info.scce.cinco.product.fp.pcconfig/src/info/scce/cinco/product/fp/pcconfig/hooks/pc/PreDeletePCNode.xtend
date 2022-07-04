package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPreDeleteHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PCNode
import info.scce.cinco.fp.compdsl.componentDsl.Case
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PriceNode

class PreDeletePCNode extends CincoPreDeleteHook<PCNode> {
	override preDelete(PCNode pcNode) {
		val priceNodeView = pcNode.container.findThe(PriceNode).priceNodeView
		priceNodeView.price = Math.round((priceNodeView.price -  Double.parseDouble((pcNode.PCcase as Case).price)) * 100.0)/100.0
	}
}