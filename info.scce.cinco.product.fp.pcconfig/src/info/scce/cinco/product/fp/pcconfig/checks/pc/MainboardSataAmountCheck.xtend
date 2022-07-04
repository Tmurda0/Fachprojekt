package info.scce.cinco.product.fp.pcconfig.checks.pc

import info.scce.cinco.product.fp.pcconfig.pc.mgl.mcam.modules.checks.PCCheck
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PC
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.Mainboard
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode

class MainboardSataAmountCheck extends PCCheck {
	/*
	 * Die Anzahl der Laufwerke darf die Anzahl der Anschlüsse des Mainboards nicht übersteigen.
	 */
	 
	override check(PC model) {
		val sataAmountNeeded = model.find(DriveNode).size
		var sataAmountAvailable = 0
		
		val mainboardPrime = model.findThe(PrimeMainboardNode)
		if(mainboardPrime !== null){
			sataAmountAvailable = 5 //(mainboardPrime.mainboardPrime as Mainboard) TODO add Mainboard support
		}
		
		if(sataAmountAvailable < sataAmountNeeded){
			model.addError("Not enough SATA ports on the mainboard! [" + sataAmountNeeded + " / " + sataAmountAvailable +"]")
		}
	}
	
}