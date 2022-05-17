package info.scce.cinco.fp.compgen.generator

import info.scce.cinco.fp.prodserv.ProductService
import info.scce.cinco.fp.prodserv.descriptor.MainboardDescriptor
import java.util.ArrayList

class MainboardGenerator {
	
	ArrayList<MainboardDescriptor> mainboards
	
	def run() {
		mainboards = ProductService.mainboards
		template.toString
	}
	
	// TODO: Implement this template
	def template() '''
		«class» not implemented, yet!
		---
		«mainboards.map[toString].join('\n')»
	'''
}