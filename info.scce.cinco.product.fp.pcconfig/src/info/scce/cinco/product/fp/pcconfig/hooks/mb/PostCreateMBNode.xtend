package info.scce.cinco.product.fp.pcconfig.hooks.mb
import info.scce.cinco.fp.compdsl.componentDsl.Mainboard
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.MainboardNode
import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PriceNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PowerNode

class PostCreateMBNode extends CincoPostCreateHook<MainboardNode> {
	override postCreate(MainboardNode mbNode) {
		mbNode.newCPUNodeContainer(210,210,180,180)
		
		val mb = mbNode.mbprime as Mainboard
		for(i : 0 ..< (mb.PCIe16Slots) ){
			mbNode.newGPUNodeContainer(10, 10+(i*97), 180, 90)
		}
		
		for(i : 0 ..< (mb.memorySlots) ){
			mbNode.newRAMNodeContainer(210, 10+(i*40), 180, 30)
		}
				
		val priceNodeView = mbNode.container.findThe(PriceNode).priceNodeView
		
		priceNodeView.price = Math.round((priceNodeView.price +  Double.parseDouble(mb.price)) * 100.0)/100.0
			
    	val powerNode = mbNode.container.findThe(PowerNode)
		powerNode.power = powerNode.power +  mb.power
	}
	
}

