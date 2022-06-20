package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PSUNode

class PostCreatePSUNode extends CincoPostCreateHook<PSUNode> {
	
	override postCreate(PSUNode psuNode) {
		psuNode.x = 0
		psuNode.y = 0
	}
	
}