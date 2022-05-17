package info.scce.cinco.fp.compgen.generator

import info.scce.cinco.fp.prodserv.ProductService
import info.scce.cinco.fp.prodserv.descriptor.RAMDescriptor
import java.util.ArrayList

class RAMGenerator {
	
	ArrayList<RAMDescriptor> rams
	
	def run() {
		rams = ProductService.RAMs
		template.toString
	}
	
	// TODO: Implement this template
	def template() '''
		«class» not implemented, yet!
		---
		«rams.map[toString].join('\n')»
	'''
}