package info.scce.cinco.product.fp.pcconfig.generator

import de.jabc.cinco.meta.plugin.generator.runtime.IGenerator
import de.jabc.cinco.meta.runtime.CincoRuntimeBaseClass
import org.eclipse.core.runtime.IProgressMonitor
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PC
import org.eclipse.core.runtime.IPath
import de.jabc.cinco.meta.core.utils.EclipseFileUtils
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PCNode
import org.eclipse.emf.common.util.EList
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PSUNodeContainer
import info.scce.cinco.fp.compdsl.componentDsl.PSU
import info.scce.cinco.fp.compdsl.componentDsl.Case
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode
import info.scce.cinco.fp.compdsl.componentDsl.Mainboard
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNodeContainer
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNodeContainer
import info.scce.cinco.fp.compdsl.componentDsl.Drive

class Generator extends CincoRuntimeBaseClass implements IGenerator<PC> {
	
	String fileName
	double cost;
	
	override generate(PC model, IPath path, IProgressMonitor monitor) {
		val fullFileName = model.file.name
	    fileName = fullFileName.substring(0, fullFileName.lastIndexOf('.'))
	    val targetFile = workspaceRoot.getFileForLocation(path.append(fileName + ".html"))
	    cost = 0;
	    EclipseFileUtils.writeToFile(targetFile, template(model))
	}
	
	def template(PC model) {
		if(model.PCNodes.size==0){
			'''Select components to generate a componentlist!'''
		} else {
			val pc = model.PCNodes.get(0)
			'''
			 <html>
			 <head><meta charset="utf-8"/></head>
			 <title>Configuration «fileName»</title>
			 <body>
			 <h1>Configuration</h1>
			 <table>
			        «caseRow(pc.PCcase as Case)»
			        «psuRow(pc.PSUNodeContainers)»
			        «mainboardRow(pc.primeMainboardNodeContainers)»
			        «FOR driveContainer : pc.driveNodeContainers»
			        	«driveRow(driveContainer)»
			        «ENDFOR»
			 		<tr><td>-----------------------------------------------------</td><td>--------------</td></tr>
			 		<tr><td>Total Cost:</td> <td>«Math.round(cost * 100.0) / 100.0» €</td></tr>
			 </table>
			 </body>
			 </html>		 
			'''
		}
	}
	
	def driveRow(DriveNodeContainer driveCon) {
		if(driveCon.driveNodes.size > 0) {
			val drive = driveCon.driveNodes.get(0).drivePrime as Drive
			cost += Double.parseDouble(drive.price)
			'''<tr><td>«drive.displayName»</td> <td>«drive.price» €</td></tr>'''
		}
	}
	
	def psuRow(EList<PSUNodeContainer> psuConts) {
		if(psuConts.size > 0 && psuConts.get(0).PSUNodes.size > 0) {
			val psu = psuConts.get(0).PSUNodes.get(0).psuPrime as PSU
			cost += Double.parseDouble(psu.price)
			'''<tr><td>«psu.displayName»</td> <td>«psu.price» €</td></tr>'''
		}
	}
	def mainboardRow(EList<PrimeMainboardNodeContainer> mainboardConts) { //TODO implement search for components inside the mainboard
		if(mainboardConts.size > 0 && mainboardConts.get(0).primeMainboardNodes.size > 0) {
			val mainboard = mainboardConts.get(0).primeMainboardNodes.get(0).mainboardPrime as Mainboard
			cost += Double.parseDouble(mainboard.price)
			'''<tr><td>«mainboard.displayName»</td> <td>«mainboard.price» €</td></tr>'''
		}
	}
	def caseRow(Case pcCase) {
		if(pcCase !== null){
			cost += Double.parseDouble(pcCase.price)
			'''<tr><td>«pcCase.displayName»</td> <td>«pcCase.price» €</td></tr>'''
		}
	}
	
}