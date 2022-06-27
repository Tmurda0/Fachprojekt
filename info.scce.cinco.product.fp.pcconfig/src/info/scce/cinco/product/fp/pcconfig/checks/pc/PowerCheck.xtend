package info.scce.cinco.product.fp.pcconfig.checks.pc

import info.scce.cinco.product.fp.pcconfig.pc.mgl.mcam.modules.checks.PCCheck
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PC
import info.scce.cinco.fp.compdsl.componentDsl.PSU
import info.scce.cinco.fp.compdsl.componentDsl.Drive

class PowerCheck extends PCCheck {
	/*
	 * Die Leistung des Netzteils muss die benötigte Gesamtleistung der Komponenten übersteigen (inklusive 25% Puffer)
	 */
	
	override check(PC model) {
		var power = 0
		try {
			power = (model.PCNodes.get(0)?.PSUNodeContainers.get(0).PSUNodes.get(0)?.psuPrime as PSU).power
		} catch (Exception e) {}
		
		var powerNeeded = 300 //TODO add mainboard power
		if(model.PCNodes.size > 0) {
			for (dnc : model.PCNodes.get(0).driveNodeContainers) {
				try {
					powerNeeded += (dnc.driveNodes.get(0)?.drivePrime as Drive).power
				} catch(Exception e){}
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