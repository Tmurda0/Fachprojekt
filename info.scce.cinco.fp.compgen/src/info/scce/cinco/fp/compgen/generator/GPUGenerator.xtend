package info.scce.cinco.fp.compgen.generator

import info.scce.cinco.fp.prodserv.ProductService
import java.util.ArrayList
import info.scce.cinco.fp.prodserv.descriptor.GPUDescriptor

class GPUGenerator {
	
	ArrayList<GPUDescriptor> gpus
	
	def run() {
		gpus = ProductService.GPUs
		template.toString
	}
	
	def template() '''
		«gpus.map[
			"GPU \"" + it.name + "\" {" + "\n" +
			"\tDisplayName: " + "\"" + it.name + " (" + it.chip + ")" + "\"" + "\n" +
			"\tPrice: " + it.price + "\n" +
			"\tPowerUsage: " + it.powerConsumption + "\n" +
			"\tChip: " + "\"" + it.chip + "\"" + "\n" +
			"\tMemory: " + it.memory + "\n" +
			"}"
		].join('\n')»
	'''
}