package info.scce.cinco.fp.compgen.generator

import info.scce.cinco.fp.prodserv.ProductService
import info.scce.cinco.fp.prodserv.descriptor.CaseDescriptor
import java.util.ArrayList
import java.util.HashSet

class CaseGenerator {
	
	ArrayList<CaseDescriptor> cases
	HashSet<String> formFactors
	
	def run() {
		cases = ProductService.cases
		formFactors = new HashSet
		for (CaseDescriptor cd : cases) {
			formFactors.add(cd.formFactor.toString)
		}
		template.toString
	}
	
	def template() '''
		«cases.map[
			"Case \"" + it.name + "\" {" + "\n" +
			"\tDisplayName: " + "\"" + it.name + " (" + it.formFactor.toString + ")" + "\"" + "\n" +
			"\tPrice: " + it.price + "\n" +
			"\tFormFactor: " + it.formFactor + "\n" +
			"\tExternalDriveSlots: " + it.externalSlots + "\n" +
			"\tInternalDriveSlots: " + it.internalSlots + "\n" +
			"}"
		].join('\n')»
		«formFactors.map[
			"FormFactor " + it
		].join('\n')»
	'''
}