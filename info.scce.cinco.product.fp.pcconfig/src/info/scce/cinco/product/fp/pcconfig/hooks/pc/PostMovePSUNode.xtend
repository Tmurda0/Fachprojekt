package info.scce.cinco.product.fp.pcconfig.hooks.pc

import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PSUNode
import de.jabc.cinco.meta.runtime.hook.CincoPostMoveHook
import graphmodel.ModelElementContainer

class PostMovePSUNode extends CincoPostMoveHook<PSUNode> {
	override postMove(PSUNode psuNode, ModelElementContainer arg1, ModelElementContainer arg2, int arg3, int arg4, int arg5, int arg6) {
		psuNode.x = 0
		psuNode.y = 0
	}
	
}