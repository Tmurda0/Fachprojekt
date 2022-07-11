package info.scce.cinco.product.fp.pcconfig.hooks.mb

import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.Mainboard

class PostCreateMain extends CincoPostCreateHook<Mainboard> {
	
	override postCreate(Mainboard mb) {
		mb.newPriceNode(0,0)
		mb.newPowerNode(0,30)
	}
	
}