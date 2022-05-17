package info.scce.cinco.fp.compgen.generator

import info.scce.cinco.fp.prodserv.ProductService
import info.scce.cinco.fp.prodserv.descriptor.DriveDescriptor
import java.util.ArrayList

class DriveGenerator {
	
	ArrayList<DriveDescriptor> drives
	
	def run() {
		drives = ProductService.drives
		template.toString
	}
	
	// TODO: Implement this template
	def template() '''
		«class» not implemented, yet!
		---
		«drives.map[toString].join('\n')»
	'''
}