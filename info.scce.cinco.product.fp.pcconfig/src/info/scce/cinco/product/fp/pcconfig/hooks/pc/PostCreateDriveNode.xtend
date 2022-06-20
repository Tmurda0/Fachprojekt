package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode

class PostCreateDriveNode extends CincoPostCreateHook<DriveNode> {
	
	override postCreate(DriveNode driveNode) {
		driveNode.x = 0
		driveNode.y = 0
	}
	
}