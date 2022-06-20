package info.scce.cinco.product.fp.pcconfig.generator

import de.jabc.cinco.meta.plugin.generator.runtime.IGenerator
import de.jabc.cinco.meta.runtime.CincoRuntimeBaseClass
import org.eclipse.core.runtime.IProgressMonitor
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PC
import org.eclipse.core.runtime.IPath
import de.jabc.cinco.meta.core.utils.EclipseFileUtils
import info.scce.cinco.product.fp.pcconfig.pc.mgl.pc.PCNode

class Generator extends CincoRuntimeBaseClass implements IGenerator<PC> {
	
	String fileName
	double cost;
	
	override generate(PC model, IPath path, IProgressMonitor monitor) {
		val fullFileName = model.file.name
	    fileName = fullFileName.substring(0, fullFileName.lastIndexOf('.'))
	    val targetFile = workspaceRoot.getFileForLocation(path.append(fileName + ".html"))
	    cost = 0; //Set to case cost
	    EclipseFileUtils.writeToFile(targetFile, template(model. PCNodes.get(0)))
	}
	
	// Sowas in die Richtung hier halt
	def template(PCNode pc) '''
	 <html>
	      <head><meta charset="utf-8"/></head>
	      <title>Configuration «fileName»</title>
	      <body>
	        <h1>Configuration</h1>
	        <table>
	          <tr><td>«pc.PSUNodeContainers.get(0).PSUNodes.get(0).psuPrime.toString»</td></tr>
	          «FOR node : pc.driveNodeContainers»
	            <tr> 
	            <td>A</td>
	            <td>Drive</td>
	            </tr>
	          «ENDFOR»
	        </table>
	 	--------------------------------------
	 	Total Cost: «cost» €
	 </body>
	 </html>

	'''
	
}