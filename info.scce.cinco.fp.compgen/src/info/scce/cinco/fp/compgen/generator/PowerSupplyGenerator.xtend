package info.scce.cinco.fp.compgen.generator

import info.scce.cinco.fp.prodserv.ProductService
import info.scce.cinco.fp.prodserv.descriptor.PowerSupplyDescriptor
import java.util.ArrayList

class PowerSupplyGenerator {
	
	ArrayList<PowerSupplyDescriptor> supplies
	
	def run() {
		supplies = ProductService.powerSupplies
		template.toString
	}
	
	// TODO: Implement this template
	def template() '''
		«class» not implemented, yet!
		---
		«supplies.map[toString].join('\n')»
	'''
}