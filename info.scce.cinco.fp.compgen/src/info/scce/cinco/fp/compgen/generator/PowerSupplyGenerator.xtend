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
	
	def template() '''
		«supplies.map[
			"PSU \"" + it.name + "\" {" + "\n" +
			"\tDisplayName: " + "\"" + it.name + "\"" + "\n" +
			"\tPrice: " + it.price + "\n" +
			"\tPowerSupplied: " + it.power +  "\n" +
			"}"
		].join('\n')»
	'''
}