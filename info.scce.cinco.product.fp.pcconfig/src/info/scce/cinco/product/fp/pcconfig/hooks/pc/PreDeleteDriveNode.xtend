package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPreDeleteHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode
import info.scce.cinco.fp.compdsl.componentDsl.Drive

class PreDeleteDriveNode extends CincoPreDeleteHook<DriveNode> {
	override preDelete(DriveNode driveNode) {
		val priceNodeView = driveNode.container.container.container.priceNodes.get(0).priceNodeView
		priceNodeView.price = Math.round((priceNodeView.price -  Double.parseDouble((driveNode.drivePrime as Drive).price)) * 100.0)/100.0
		
		val powerNode = driveNode.container.container.container.powerNodes.get(0)
		powerNode.power = powerNode.power +  (driveNode.drivePrime as Drive).power
	}
}