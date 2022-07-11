package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPostCreateHook
import info.scce.cinco.fp.compdsl.componentDsl.CPU
import info.scce.cinco.fp.compdsl.componentDsl.GPU
import info.scce.cinco.fp.compdsl.componentDsl.RAM
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.CPUNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.GPUNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.Mainboard
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.MainboardNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.RAMNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PowerNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PriceNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode

class PostCreatePrimeMainboardNode extends CincoPostCreateHook<PrimeMainboardNode> {
	
	override postCreate(PrimeMainboardNode mainboardNode) {
		mainboardNode.x = 0
		mainboardNode.y = 0
		
		val priceNodeView = mainboardNode.container.container.container.findThe(PriceNode).priceNodeView
		val powerNode = mainboardNode.container.container.container.findThe(PowerNode)
		val mainboardPrime = mainboardNode.mainboardPrime as Mainboard
		
		//TODO adjust to real price from price node
		priceNodeView.price = Math.round((priceNodeView.price +  Double.parseDouble("100.11")) * 100.0)/100.0
		
		//TODO changes in mainboard.mgl do not cut through to the PC / Async values in preDelete - postCreate
		val mb = mainboardPrime.findThe(MainboardNode)?.mbprime as info.scce.cinco.fp.compdsl.componentDsl.Mainboard
		if(mb !== null){
			powerNode.power = powerNode.power - mb.power
			
			val cpu = mainboardPrime.findThe(CPUNode)?.cpuprime as CPU
			if(cpu !== null){
				powerNode.power = powerNode.power - cpu.power
			}
			
			val gpu = mainboardPrime.findThe(GPUNode)?.GPUPrime as GPU
			if(gpu !== null){
				powerNode.power = powerNode.power - gpu.power
			}
			
			val rams = mainboardPrime.find(RAMNode)
			for (ramNode:rams) {
				val ram = ramNode.ramPrime as RAM
				powerNode.power = powerNode.power - ram.power
			}
		}
	}
	
}