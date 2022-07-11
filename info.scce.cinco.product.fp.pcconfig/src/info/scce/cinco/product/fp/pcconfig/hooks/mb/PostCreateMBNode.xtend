package info.scce.cinco.product.fp.pcconfig.hooks.mb
import info.scce.cinco.fp.compdsl.componentDsl.Mainboard
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.MainboardNode
import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PriceNode

class PostCreateMBNode extends CincoPostCreateHook<MainboardNode> {
	override postCreate(MainboardNode mbNode) {
		
	
	mbNode.newCPUNodeContainer(210,200,180,90)
	mbNode.newGPUNodeContainer(10,50,180,90)
	val mb = mbNode.mbprime as Mainboard
	
	for(i : 0 ..< (mb.memorySlots) ){ //For all external drive Slot
			mbNode.newRAMNodeContainer(210, 10+(i*40), 180, 30)
			}
	val priceNodeView = mbNode.container.findThe(PriceNode).priceNodeView
	priceNodeView.price = Math.round((priceNodeView.price +  Double.parseDouble(mb.price)) * 100.0)/100.0 
		
	}
	
}

