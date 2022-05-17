package info.scce.cinco.fp.compgen.generator

import info.scce.cinco.fp.prodserv.ProductService
import info.scce.cinco.fp.prodserv.descriptor.CaseDescriptor
import java.util.ArrayList

class CaseGenerator {
	
	ArrayList<CaseDescriptor> cases
	
	def run() {
		cases = ProductService.cases
		template.toString
	}
	
	// TODO: Implement this template
	def template() '''
		«class» not implemented, yet!
		---
		«cases.map[toString].join('\n')»
	'''
}