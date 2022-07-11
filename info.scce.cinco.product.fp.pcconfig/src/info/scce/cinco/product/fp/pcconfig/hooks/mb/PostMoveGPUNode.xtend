package info.scce.cinco.product.fp.pcconfig.hooks.mb

import de.jabc.cinco.meta.runtime.hook.CincoPostMoveHook
import graphmodel.ModelElementContainer
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.GPUNode

class PostMoveGPUNode extends CincoPostMoveHook<GPUNode> {
	
	override postMove(GPUNode gpuNode, ModelElementContainer arg1, ModelElementContainer arg2, int arg3, int arg4, int arg5, int arg6) {
		gpuNode.x = 0
		gpuNode.y = 0
	}
	
}
