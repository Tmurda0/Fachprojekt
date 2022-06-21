package info.scce.cinco.product.fp.pcconfig.hooks.pc

import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PCNode
import info.scce.cinco.fp.compdsl.componentDsl.Case

class PostCreatePCNode extends de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook<PCNode> {
	
	override postCreate(PCNode pcNode) {
		pcNode.newPrimeMainboardNodeContainer(10, 10, 180, 180)
		
		pcNode.newPSUNodeContainer(10, 300, 180, 90)
		
		val pcCase = pcNode.PCcase as Case
		
		for(i : 0 ..< pcCase.externalSlots) { //For all external drive Slots
			pcNode.newDriveNodeContainer(210, 10+(i*40), 180, 30)
		}
		
		for(i : 0 ..< pcCase.internalSlots) { //For all internal drive Slots
			pcNode.newDriveNodeContainer(210, 360-(i*40), 180, 30)
		}
		
		val priceNodeView = pcNode.container.priceNodes.get(0).priceNodeView
		priceNodeView.price = Math.round((priceNodeView.price +  Double.parseDouble((pcNode.PCcase as Case).price)) * 100.0)/100.0
	}
}