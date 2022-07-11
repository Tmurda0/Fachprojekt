package info.scce.cinco.product.fp.pcconfig.hooks.pc

import de.jabc.cinco.meta.runtime.hook.CincoPostSelectHook
import info.scce.cinco.fp.compdsl.componentDsl.Drive
import info.scce.cinco.fp.compdsl.componentDsl.PSU
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PC
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PSUNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PowerNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PriceNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.Mainboard
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PCNode
import info.scce.cinco.fp.compdsl.componentDsl.Case

class PostSelectPrimeMainboardNode extends CincoPostSelectHook<PrimeMainboardNode> {
	
	override postSelect(PrimeMainboardNode primeMainboard) {
		var pc = primeMainboard.container.container.container as PC
		val priceNodeView = pc.findThe(PriceNode).priceNodeView
		val powerNode = pc.findThe(PowerNode)
		
		var newPrice = 0.0
		var newPower = 0
		
		val casePrime = pc.findThe(PCNode)?.PCcase as Case
		if(casePrime !== null){
			newPrice += Double.parseDouble(casePrime.price)
		}
		
		val psuPrime = pc.findThe(PSUNode)?.psuPrime as PSU
		if(psuPrime !== null){
			newPrice += Double.parseDouble(psuPrime.price)
			newPower += psuPrime.power
		}
		
		val drives = pc.find(DriveNode)
		for(driveNode:drives){
			val drivePrime = driveNode.drivePrime as Drive
			newPrice += Double.parseDouble(drivePrime.price)
			newPower -= drivePrime.power
		}
		
		newPrice += (pc.findThe(PrimeMainboardNode)?.mainboardPrime as Mainboard).findThe(info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PriceNode).price
		newPower -= (pc.findThe(PrimeMainboardNode)?.mainboardPrime as Mainboard).findThe(info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.PowerNode).power
		
		priceNodeView.price = Math.round(newPrice * 100.0)/100.0
		powerNode.power = newPower
	}
	
}