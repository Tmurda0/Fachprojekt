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
		"\t" + "\"" + it.name + " (" + it.type.toString + ")" + "\"" + "\n" +
		"\t" + it.price + "€" + "\n" +
		"\t" + it.powerConsumption + " W" +  "\n" +
		"\t" + it.type.toString + "\n" +
		"\t" + it.capacity + "\n" +
		"}"
	].join('\n')»
	«ramTypes.map[
		"RamType " + it
	].join('\n')»
	'''
}