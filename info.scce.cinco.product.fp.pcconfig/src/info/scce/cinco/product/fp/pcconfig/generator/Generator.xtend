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
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PSUNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode

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
			val pc = model.findThe(PCNode)
			'''
			 <html>
			 <head><meta charset="utf-8"/></head>
			 <title>Configuration «fileName»</title>
			 <body>
			 <h1>Configuration</h1>
			 <table>
			        «caseRow(pc.PCcase as Case)»
			        «psuRow(pc.findThe(PSUNode))»
			        «mainboardRow(pc.findThe(PrimeMainboardNode))»
			        «FOR driveNode : pc.find(DriveNode)»
			        	«driveRow(driveNode)»
			        «ENDFOR»
			 		<tr><td>-----------------------------------------------------</td><td>--------------</td></tr>
			 		<tr><td>Total Cost:</td> <td>«Math.round(cost * 100.0) / 100.0» €</td></tr>
			 </table>
			 </body>
			 </html>		 
			'''
		}
	}
	
	def caseRow(Case pcCase) {
		if(pcCase !== null){
			cost += Double.parseDouble(pcCase.price)
			'''<tr><td>«pcCase.displayName»</td> <td>«pcCase.price» €</td></tr>'''
		}
	}
	def psuRow(PSUNode psuNode) {
		if(psuNode !== null){
			val psuPrime = psuNode.psuPrime as PSU
			cost += Double.parseDouble(psuPrime.price)
			'''<tr><td>«psuPrime.displayName»</td> <td>«psuPrime.price» €</td></tr>'''
		}
	}
	def mainboardRow(PrimeMainboardNode primeMainboardNode) { //TODO implement search for components inside the mainboard
		if(primeMainboardNode !== null){
			val mainboardPrime = primeMainboardNode.mainboardPrime as info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.Mainboard
			cost += Double.parseDouble("100.11")
			'''<tr><td>«"Mainboard"»</td> <td>«"100.11"» €</td></tr>'''
		}
	}
	def driveRow(DriveNode driveNode) {
		val drive = driveNode.drivePrime as Drive
		cost += Double.parseDouble(drive.price)
		'''<tr><td>«drive.displayName»</td> <td>«drive.price» €</td></tr>'''
	}
	
}