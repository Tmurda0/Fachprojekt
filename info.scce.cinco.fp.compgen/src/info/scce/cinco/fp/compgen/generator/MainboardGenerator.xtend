package info.scce.cinco.fp.compgen.generator

import info.scce.cinco.fp.prodserv.ProductService
import info.scce.cinco.fp.prodserv.descriptor.MainboardDescriptor
import java.util.ArrayList
import java.util.HashSet

class MainboardGenerator {
	
	ArrayList<MainboardDescriptor> mainboards
	HashSet<String> ramTypes
	HashSet<String> socketTypes
	HashSet<String> formFactors
	
	def run() {
		mainboards = ProductService.mainboards
		ramTypes = new HashSet
		socketTypes = new HashSet
		formFactors = new HashSet
		for (MainboardDescriptor md : mainboards) {
			ramTypes.add(md.typeMemorySlots.toString)
			socketTypes.add(md.socket.toString)
			formFactors.add(md.formFactor.toString)
		}
		
		template.toString
	}
	
	def template() '''
		«mainboards.map[
			"Mainboard \"" + it.name + "\" {" + "\n" +
			"\tDisplayName: " + "\"" + it.name + " (" + it.formFactor.toString + ")" + "\"" + "\n" +
			"\tPrice: " + it.price + "€" + "\n" +
			"\tPowerUsage: " + it.powerConsumption + " W" +  "\n" +
			"\tChipset: " + "\"" + it.chipset + "\"" + "\n" +
			"\tMemorySlots: " + it.numMemorySlots + "\n" +
			"\tPCIe16Slots: " + it.numPCIe16Slots + "\n" +
			"\tSataSlots: " + it.numSataPorts + "\n" +
			"\tSocketType: " + it.socket.toString + "\n" +
			"\tRamType: " + it.typeMemorySlots.toString + "\n" +
			"\tFormFactor: " + it.formFactor.toString + "\n" +
			"}"
		].join('\n')»
		«ramTypes.map[
			"RamType " + it
		].join('\n')»
		«socketTypes.map[
			"SocketType " + it
		].join('\n')»
		«formFactors.map[
			"FormFactor " + it
		].join('\n')»
	'''
}