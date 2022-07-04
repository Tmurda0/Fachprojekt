package info.scce.cinco.product.fp.pcconfig.checks.pc

import info.scce.cinco.product.fp.pcconfig.pc.mgl.mcam.modules.checks.PCCheck
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PC
import info.scce.cinco.fp.compdsl.componentDsl.PSU
import info.scce.cinco.fp.compdsl.componentDsl.Drive
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PSUNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode

class PowerCheck extends PCCheck {
	/*
	 * Die Leistung des Netzteils muss die benötigte Gesamtleistung der Komponenten übersteigen (inklusive 25% Puffer)
	 */
	
	override check(PC model) {
		var power = 0
		var powerNeeded = 0 
		
		if(model.PCNodes.size > 0) {
			val PsuNode = model.findThe(PSUNode)
			if(PsuNode != null){
				power += (PsuNode.psuPrime as PSU).power
			}
			
			for (driveNode : model.find(DriveNode)) {
				powerNeeded += (driveNode.drivePrime as Drive).power
			}
			
			val mainboardNode = model.findThe(PrimeMainboardNode)
			if(mainboardNode != null){
				powerNeeded += 150 //TODO add mainboard power
			}
		}
		
		val powerBufer = (powerNeeded * 0.25) as int
		
		if(power != 0 || powerNeeded != 0) {
			if(powerNeeded > power) {
				model.addError("Not enough power available! [" + powerNeeded + " / " + power + "]")
			} else if(powerBufer+powerNeeded > power) {
				model.addWarning("It is recommendet to plan with a 25% power buffer! [" + powerNeeded + " + " + powerBufer + "(Buffer) / " + power + "]")
			}
		}
	}
}