clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../MacroScriptParser/MacroScriptParser.ms" )

path_ =getFilenamePath(getSourceFileName()) + "MacroFileTest.mcr";


MacroScripts = (MacroScriptParser_v path:path_).MacroScripts


for _MacroScript in MacroScripts do 
	format "_MacroScript = % \n" _MacroScript