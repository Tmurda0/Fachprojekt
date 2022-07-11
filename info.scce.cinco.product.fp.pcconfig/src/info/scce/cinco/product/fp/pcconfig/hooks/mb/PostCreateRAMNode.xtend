package info.scce.cinco.product.fp.pcconfig.hooks.mb

import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.RAMNode
import info.scce.cinco.fp.compdsl.componentDsl.Mainboard
import info.scce.cinco.fp.compdsl.componentDsl.RAM
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PriceNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PowerNode

class PostCreateRAMNode extends CincoPostCreateHook<RAMNode> {

    override postCreate(RAMNode ramNode) {
		if ((ramNode.container.container.mbprime as Mainboard).ramType.name.equals((ramNode.ramPrime as RAM).ramType.name)) {
			ramNode.x = 0
			ramNode.y=0
			
			val ramP = ramNode.ramPrime as RAM
			val priceNodeView = ramNode.container.container.container.findThe(PriceNode).priceNodeView
			priceNodeView.price = Math.round((priceNodeView.price +  Double.parseDouble(ramP.price)) * 100.0)/100.0
			
			val powerNode = ramNode.container.container.container.findThe(PowerNode)
			powerNode.power = powerNode.power + ramP.power
		} else {
			ramNode.delete
		}   	
    }
	 
}
