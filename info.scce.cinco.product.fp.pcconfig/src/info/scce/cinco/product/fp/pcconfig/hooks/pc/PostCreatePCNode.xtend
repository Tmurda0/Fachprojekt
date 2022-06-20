package info.scce.cinco.product.fp.pcconfig.hooks.pc

import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PCNode

class PostCreatePCNode extends de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook<PCNode> {
	
	override postCreate(PCNode pcNode) {
		pcNode.newPrimeMainboardNodeContainer(10, 10, 180, 180)
		
		pcNode.newPSUNodeContainer(10, 300, 180, 90)
		
		/*
		for(i : 0 ..< pcNode.PCcase.) { //For all drive Slots
			//val driveNode = cont.driveNodes.get(0)
			//driveNode.drivePrime
			
			pcNode.newDriveNodeContainer(210, 10+(i*40), 180, 30)
		}
		*/
		
		
		pcNode.newDriveNodeContainer(210, 10, 180, 30)
		pcNode.newDriveNodeContainer(210, 50, 180, 30)
		pcNode.newDriveNodeContainer(210, 90, 180, 30)
		pcNode.newDriveNodeContainer(210, 130, 180, 30)
	}
}