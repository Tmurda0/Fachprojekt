package info.scce.cinco.fp.compgen.generator

import info.scce.cinco.fp.prodserv.ProductService
import info.scce.cinco.fp.prodserv.descriptor.DriveDescriptor
import java.util.ArrayList
import java.util.HashSet

class DriveGenerator {
	
	ArrayList<DriveDescriptor> drives
	HashSet<String> driveTypes
	
	def run() {
		drives = ProductService.drives
		driveTypes = new HashSet
		for (DriveDescriptor dd : drives) {
			driveTypes.add(dd.type.toString)
		}
		template.toString
	}
	
	def template() '''
		«drives.map[
			"Drive \"" + it.name + "\" {" + "\n" +
			"\tDisplayName: " + "\"" + it.name + "\"" + "\n" +
			"\tPrice: " + it.price + "€" + "\n" +
			"\tPowerUsage: " + it.powerConsumption + " W" +  "\n" +
			"\tDescription: " + "\"" + it.description + "\"" + "\n" +
			"\tDriveType: " + it.type.toString + "\n" +
			"}"
		].join('\n')»
		«driveTypes.map[
			"DriveType " + it
		].join('\n')»
	'''
}