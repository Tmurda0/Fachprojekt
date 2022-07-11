package info.scce.cinco.product.fp.pcconfig.hooks.mb

import de.jabc.cinco.meta.runtime.hook.CincoPostMoveHook
import graphmodel.ModelElementContainer
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.RAMNode

class PostMoveRAMNode extends CincoPostMoveHook<RAMNode> {
	
	override postMove(RAMNode ramNode, ModelElementContainer arg1, ModelElementContainer arg2, int arg3, int arg4, int arg5, int arg6) {
		ramNode.x = 0
		ramNode.y = 0
	}
	
}
