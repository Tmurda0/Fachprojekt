package info.scce.cinco.product.fp.pcconfig.generator

import de.jabc.cinco.meta.plugin.generator.runtime.IGenerator
import de.jabc.cinco.meta.runtime.CincoRuntimeBaseClass
import org.eclipse.core.runtime.IProgressMonitor
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PC
import org.eclipse.core.runtime.IPath
import de.jabc.cinco.meta.core.utils.EclipseFileUtils
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PCNode
import info.scce.cinco.fp.compdsl.componentDsl.PSU
import info.scce.cinco.fp.compdsl.componentDsl.Case
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PrimeMainboardNode
import info.scce.cinco.fp.compdsl.componentDsl.Mainboard
import info.scce.cinco.fp.compdsl.componentDsl.Drive
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PSUNode
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.DriveNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.MainboardNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.CPUNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.RAMNode
import info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.GPUNode
import info.scce.cinco.fp.compdsl.componentDsl.CPU
import info.scce.cinco.fp.compdsl.componentDsl.GPU
import info.scce.cinco.fp.compdsl.componentDsl.RAM

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
			        «mainboardRows(pc.findThe(PrimeMainboardNode))»
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
			handleRow(pcCase.displayName, pcCase.price)
		}
	}
	def psuRow(PSUNode psuNode) {
		if(psuNode !== null){
			val psuPrime = psuNode.psuPrime as PSU
			handleRow(psuPrime.displayName, psuPrime.price)
		}
	}
	def mainboardRows(PrimeMainboardNode primeMainboardNode) {
		if(primeMainboardNode !== null){
			val mainboardMgl = primeMainboardNode.mainboardPrime as info.scce.cinco.product.fp.pcconfig.mb.mgl.mainboard.Mainboard
			
			val mainboardPrime = mainboardMgl.findThe(MainboardNode)?.mbprime as Mainboard
			val cpuPrime = mainboardMgl.findThe(CPUNode)?.cpuprime as CPU
			val rams = mainboardMgl.find(RAMNode)
			val gpu = mainboardMgl.findThe(GPUNode)?.GPUPrime as GPU
			
			var result = ''''''
			
			if(mainboardPrime !== null){
				result += handleRow(mainboardPrime.displayName, mainboardPrime.price)
			}
			if(cpuPrime !== null){
				result += handleRow(cpuPrime.displayName, cpuPrime.price)
			}
			if(gpu !== null){
				result += handleRow(gpu.displayName, gpu.price)
			}
			for(ramNode : rams) {
				val ramPrime = ramNode.ramPrime as RAM
				result += handleRow(ramPrime.displayName, ramPrime.price)
			}
			return result
		}
	}
	def driveRow(DriveNode driveNode) {
		val drive = driveNode.drivePrime as Drive
		handleRow(drive.displayName, drive.price)
	}
	
	def handleRow(String name, String price) {
		cost += Double.parseDouble(price)
		'''<tr><td>«name»</td> <td>«price» €</td></tr>'''
	}
	
}