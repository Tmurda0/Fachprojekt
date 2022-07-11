package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPreDeleteHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.Mainboard
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PriceNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PowerNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.MainboardNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.CPUNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.GPUNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.RAMNode
import info.scce.cinco.fp.compdsl.componentDsl.CPU
import info.scce.cinco.fp.compdsl.componentDsl.GPU
import info.scce.cinco.fp.compdsl.componentDsl.RAM

class PreDeletePrimeMainboardNode extends CincoPreDeleteHook<PrimeMainboardNode> {
	override preDelete(PrimeMainboardNode mainboardNode) {
		val priceNodeView = mainboardNode.container.container.container.findThe(PriceNode).priceNodeView
		val powerNode = mainboardNode.container.container.container.findThe(PowerNode)
		val mainboardPrime = mainboardNode.mainboardPrime as Mainboard
		val mb = mainboardPrime.findThe(MainboardNode)?.mbprime as info.scce.cinco.fp.compdsl.componentDsl.Mainboard
		
		priceNodeView.price = Math.round((priceNodeView.price -  mainboardPrime.findThe(info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PriceNode).price) * 100.0)/100.0
		
		if(mb !== null){
			powerNode.power = powerNode.power + mb.power
			
			val cpu = mainboardPrime.findThe(CPUNode)?.cpuprime as CPU
			if(cpu !== null){
				powerNode.power = powerNode.power + cpu.power
			}
			
			
			val gpus = mainboardPrime.find(GPUNode)
			for (gpuNode:gpus) {
				val gpu = gpuNode.GPUPrime as GPU
				powerNode.power = powerNode.power + gpu.power
			}
			
			val rams = mainboardPrime.find(RAMNode)
			for (ramNode:rams) {
				val ram = ramNode.ramPrime as RAM
				powerNode.power = powerNode.power + ram.power
			}
		}
	}
}