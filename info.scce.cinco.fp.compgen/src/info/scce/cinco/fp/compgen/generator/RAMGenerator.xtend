package info.scce.cinco.fp.compgen.generator

import info.scce.cinco.fp.prodserv.ProductService
import info.scce.cinco.fp.prodserv.descriptor.RAMDescriptor
import java.util.ArrayList
import java.util.HashSet

class RAMGenerator {
	
	ArrayList<RAMDescriptor> rams
	HashSet<String> ramTypes
	
	def run() {
		rams = ProductService.RAMs
		ramTypes = new HashSet
		for (RAMDescriptor rd : rams) {
			ramTypes.add(rd.type.toString)
		}
		template.toString
	}
	
	def template() '''
	«rams.map[
		"RAM \"" + it.name + "\" {" + "\n" +
		"\tDisplayName: " + "\"" + it.name + " (" + it.type.toString + ")" + "\"" + "\n" +
		"\tPrice: " + it.price + "€" + "\n" +
		"\tPowerUsage: " + it.powerConsumption + " W" +  "\n" +
		"\tRamType: " + it.type.toString + "\n" +
		"\tMemory: " + it.capacity + " GB" + "\n" +
		"}"
	].join('\n')»
	«ramTypes.map[
		"RamType " + it
	].join('\n')»
	'''
}