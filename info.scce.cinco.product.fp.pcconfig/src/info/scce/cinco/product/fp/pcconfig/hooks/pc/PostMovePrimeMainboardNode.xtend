package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPostMoveHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode
import graphmodel.ModelElementContainer

class PostMovePrimeMainboardNode extends CincoPostMoveHook<PrimeMainboardNode> {
	override postMove(PrimeMainboardNode primeMainboardNode, ModelElementContainer arg1, ModelElementContainer arg2, int arg3, int arg4, int arg5, int arg6) {
		primeMainboardNode.x = 0
		primeMainboardNode.y = 0
	}
	
}