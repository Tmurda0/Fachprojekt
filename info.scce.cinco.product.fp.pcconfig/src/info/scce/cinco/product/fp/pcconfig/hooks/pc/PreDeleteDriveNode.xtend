package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPreDeleteHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode
import info.scce.cinco.fp.compdsl.componentDsl.Drive
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PriceNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PowerNode

class PreDeleteDriveNode extends CincoPreDeleteHook<DriveNode> {
	override preDelete(DriveNode driveNode) {
		val drivePrime = driveNode.drivePrime as Drive
		
		val priceNodeView = driveNode.container.container.container.findThe(PriceNode).priceNodeView
		priceNodeView.price = Math.round((priceNodeView.price -  Double.parseDouble(drivePrime.price)) * 100.0)/100.0
		
		val powerNode = driveNode.container.container.container.findThe(PowerNode)
		powerNode.power = powerNode.power +  drivePrime.power
	}
}