package info.scce.cinco.product.fp.pcconfig.hooks.pc

import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode
import de.jabc.cinco.meta.runtime.hook.CincoPostMoveHook
import graphmodel.ModelElementContainer

class PostMoveDriveNode extends CincoPostMoveHook<DriveNode> {
	
	override postMove(DriveNode driveNode, ModelElementContainer arg1, ModelElementContainer arg2, int arg3, int arg4, int arg5, int arg6) {
		driveNode.x = 0
		driveNode.y = 0
	}
	
}