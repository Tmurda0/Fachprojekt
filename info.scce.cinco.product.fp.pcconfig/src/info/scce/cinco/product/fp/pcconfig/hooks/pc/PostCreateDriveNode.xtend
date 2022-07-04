package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode
import info.scce.cinco.fp.compdsl.componentDsl.Drive
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PowerNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PriceNode

class PostCreateDriveNode extends CincoPostCreateHook<DriveNode> {
	
	override postCreate(DriveNode driveNode) {
		driveNode.x = 0
		driveNode.y = 0
		
		val drivePrime = driveNode.drivePrime as Drive
		
		val priceNodeView = driveNode.container.container.container.findThe(PriceNode).priceNodeView
		priceNodeView.price = Math.round((priceNodeView.price +  Double.parseDouble(drivePrime.price)) * 100.0)/100.0
		
		val powerNode = driveNode.container.container.container.findThe(PowerNode)
		powerNode.power = powerNode.power -  drivePrime.power
	}
	
}