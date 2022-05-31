package info.scce.cinco.fp.compgen.generator

import info.scce.cinco.fp.prodserv.descriptor.CPUDescriptor
import info.scce.cinco.fp.prodserv.ProductService
import java.util.ArrayList
import java.util.HashSet

class CPUGenerator {
	
	ArrayList<CPUDescriptor> cpus
	HashSet<String> socketTypes
	
	def run() {
		cpus = ProductService.CPUs
		socketTypes = new HashSet
		for (CPUDescriptor cd : cpus) {
			socketTypes.add(cd.socket.toString)
		}
		template.toString
	}
	
	def template() '''
		«cpus.map[
			"CPU \"" + it.name + "\" {" + "\n" +
			"\tDisplayName: " + "\"" + it.name + " (" + it.type + ")" + "\"" + "\n" +
			"\tPrice: " + it.price + "€" + "\n" +
			"\tPowerUsage: " + it.powerConsumption + " W" +  "\n" +
			"\tSocketType: " + it.socket.toString + "\n" +
			"}"
		].join('\n')»
		«socketTypes.map[
			"SocketType " + it
		].join('\n')»
	'''
}