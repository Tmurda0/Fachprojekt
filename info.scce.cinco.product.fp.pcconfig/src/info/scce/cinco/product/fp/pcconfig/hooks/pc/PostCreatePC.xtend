package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PC

class PostCreatePC extends CincoPostCreateHook<PC> {
	override postCreate(PC pc) {
		pc.newPriceNode(0,0)
		pc.newPowerNode(0,30)
	}
	
}