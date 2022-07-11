package info.scce.cinco.product.fp.pcconfig.hooks.mb

import de.jabc.cinco.meta.runtime.hook.CincoPostMoveHook
import graphmodel.ModelElementContainer
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.CPUNode

class PostMoveCPUNode extends CincoPostMoveHook<CPUNode> {
	
	override postMove(CPUNode cpuNode, ModelElementContainer arg1, ModelElementContainer arg2, int arg3, int arg4, int arg5, int arg6) {
		cpuNode.x = 0
		cpuNode.y = 0
	}
	
}
