package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPreDeleteHook
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PriceNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PowerNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PCNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PSUNode
import info.scce.cinco.fp.compdsl.componentDsl.PSU
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode
import info.scce.cinco.fp.compdsl.componentDsl.Drive
import info.scce.cinco.fp.compdsl.componentDsl.Case

class PreDeletePrimeMainboardNode extends CincoPreDeleteHook<PrimeMainboardNode> {
	override preDelete(PrimeMainboardNode mainboardNode) {
		val priceNodeView = mainboardNode.container.container.container.findThe(PriceNode).priceNodeView
		val powerNode = mainboardNode.container.container.container.findThe(PowerNode)
		
		var newPrice = 0.0
		var newPower = 0
		
		val pcNode = mainboardNode.container.container as PCNode
		
		val casePrime = pcNode.PCcase as Case
		if(casePrime !== null){
			newPrice += Double.parseDouble(casePrime.price)
		}
		
		val psuPrime = pcNode.findThe(PSUNode)?.psuPrime as PSU
		if(psuPrime !== null){
			newPrice += Double.parseDouble(psuPrime.price)
			newPower += psuPrime.power
		}
		
		val drives = pcNode.find(DriveNode)
		for(driveNode:drives){
			val drivePrime = driveNode.drivePrime as Drive
			newPrice += Double.parseDouble(drivePrime.price)
			newPower -= drivePrime.power
		}
		
		priceNodeView.price = Math.round(newPrice * 100.0)/100.0
		powerNode.power = newPower
	}
}