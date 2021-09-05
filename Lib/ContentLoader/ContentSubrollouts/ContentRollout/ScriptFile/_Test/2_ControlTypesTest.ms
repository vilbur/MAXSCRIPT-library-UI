clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Dialog/Rollout/Rollout.ms" )

filein( getFilenamePath(getSourceFileName()) + "/../MacroScriptFileParser/MacroScriptFileParser.ms" )

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Dialog/Rollout/Controls/ControlBox/Control/Control.ms" )

filein( getFilenamePath(getSourceFileName()) + "/../ControlCreator/ControlCreator.ms" )

filein (getFilenamePath(getSourceFileName()) + "ControlTypesTest.mcr")


MacroScripts = (MacroScriptFileParser_v path:( getFilenamePath(getSourceFileName()) + "ControlTypesTest.mcr")).MacroScripts
_Rollout     = Rollout_v title:(getFilenameFile(getSourceFileName()))
ControlBox   = _Rollout.controls.new groupbox:"Control types"






/*---------------------------------------
	CREATE CONTROLS FROM MACRO
-----------------------------------------*/
for Macro in MacroScripts do 

	ControlCreator_v Macro:Macro ControlBox:ControlBox




--

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) height:512 width:320