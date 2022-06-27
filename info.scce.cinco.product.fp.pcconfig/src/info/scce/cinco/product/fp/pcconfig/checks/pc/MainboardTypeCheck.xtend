package info.scce.cinco.product.fp.pcconfig.checks.pc

import info.scce.cinco.product.fp.pcconfig.pc.mgl.mcam.modules.checks.PCCheck
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PC
import info.scce.cinco.fp.compdsl.componentDsl.Case

class MainboardTypeCheck extends PCCheck {
	/*
	 * Die Größe des Gehäuses muss zum Formfaktor des Mainboards passen
	 */
	
	override check(PC model) {
		try {
			if(!(model.PCNodes.get(0).PCcase as Case).formFactor.name.equals("ATX")){ //TODO get Prime mainboard and compare with case type in equals: (model.PCNodes.get(0).primeMainboardNodeContainers.get(0).primeMainboardNodes.get(0).mainboardPrime as Mainboard).formFactor.name 
				model.addError("Case form factor does not match the mainboard form factor!")
			}
		} catch (Exception e) {}
	}
}