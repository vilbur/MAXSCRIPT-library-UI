clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../MacroScriptParser/MacroScriptParser.ms" )



MacroScripts = (MacroScriptParser_v path:(getFilenamePath(getSourceFileName()) + "MacroFileTest.mcr";)).MacroScripts


for _MacroScript in MacroScripts do 
	format "_MacroScript = % \n" _MacroScript