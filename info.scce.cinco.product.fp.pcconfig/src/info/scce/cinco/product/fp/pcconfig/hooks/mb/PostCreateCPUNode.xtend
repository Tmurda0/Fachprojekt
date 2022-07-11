package info.scce.cinco.product.fp.pcconfig.hooks.mb

import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.CPUNode
import info.scce.cinco.fp.compdsl.componentDsl.CPU
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PriceNode
import info.scce.cinco.fp.compdsl.componentDsl.Mainboard

class PostCreateCPUNode extends CincoPostCreateHook<CPUNode> {
	
	override postCreate(CPUNode cpuN) {
		if ((cpuN.container.container.mbprime as Mainboard).socketType.name.equals((cpuN.cpuprime as CPU).socketType.name)) {
       		cpuN.x=0
      		cpuN.y=0
      		
	    	val cpuP = cpuN.cpuprime as CPU
	    	val priceNodeView = cpuN.container.container.container.findThe(PriceNode).priceNodeView
			priceNodeView.price = Math.round((priceNodeView.price +  Double.parseDouble(cpuP.price)) * 100.0)/100.0 
       	} else {
       		cpuN.delete
       	}
     }
}
   

	
