clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../../Dialog/Rollout/Rollout.ms" )
filein( getFilenamePath(getSourceFileName()) + "/../MacroScriptParser.ms" )



_Rollout = Rollout_v title:(getFilenameFile(getSourceFileName()))


ControlBox  = _Rollout.controls.new groupbox:"Control types"


MacroScripts = (MacroScriptParser_v path:(getFilenamePath(getSourceFileName()) + "MacroFileTest.mcr";)).MacroScripts

for _MacroScript in MacroScripts do 
	_MacroScript.createControl ControlBox



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) height:512




--for _MacroScript in MacroScripts do 
--	format "_MacroScript = % \n" _MacroScript