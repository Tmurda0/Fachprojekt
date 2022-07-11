package info.scce.cinco.product.fp.pcconfig.checks.pc

import info.scce.cinco.product.fp.pcconfig.pc.mgl.mcam.modules.checks.PCCheck
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PC
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.Mainboard
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.MainboardNode

class MainboardSataAmountCheck extends PCCheck {
	/*
	 * Die Anzahl der Laufwerke darf die Anzahl der Anschlüsse des Mainboards nicht übersteigen.
	 */
	 
	override check(PC model) {
		val sataAmountNeeded = model.find(DriveNode).size
		var sataAmountAvailable = 0
		
		val mainboardPrime = model.findThe(PrimeMainboardNode)
		if(mainboardPrime !== null){
			val dslMainboard = (mainboardPrime.mainboardPrime as Mainboard).findThe(MainboardNode)
			if(dslMainboard !== null) {
			sataAmountAvailable = (dslMainboard.mbprime as info.scce.cinco.fp.compdsl.componentDsl.Mainboard).sataSlots
			}
		}
		
		if(sataAmountAvailable < sataAmountNeeded){
			model.addError("Not enough SATA ports on the mainboard! [" + sataAmountNeeded + " / " + sataAmountAvailable +"]")
		}
	}
	
}