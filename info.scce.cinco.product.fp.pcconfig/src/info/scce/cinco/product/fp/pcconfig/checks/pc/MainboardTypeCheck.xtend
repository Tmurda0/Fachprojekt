package info.scce.cinco.product.fp.pcconfig.checks.pc

import info.scce.cinco.product.fp.pcconfig.pc.mgl.mcam.modules.checks.PCCheck
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PC
import info.scce.cinco.fp.compdsl.componentDsl.Case
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PCNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.Mainboard
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.MainboardNode

class MainboardTypeCheck extends PCCheck {
	/*
	 * Die Größe des Gehäuses muss zum Formfaktor des Mainboards passen
	 */
	
	override check(PC model) {
		try {
			val formFactorCase = (model.findThe(PCNode).PCcase as Case).formFactor.name
			val formFactorMainboard = ((model.findThe(PrimeMainboardNode).mainboardPrime as Mainboard).findThe(MainboardNode).mbprime as info.scce.cinco.fp.compdsl.componentDsl.Mainboard).formFactor.name
			if(!(formFactorCase.equals(formFactorMainboard))){
				model.addError("Case form factor does not match the mainboard form factor! [Case: " + formFactorCase + " vs Mainboard: " + formFactorMainboard + "]")
			}
		} catch (Exception e) {}
	}
}