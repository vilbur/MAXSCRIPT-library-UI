clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Dialog/Rollout/Rollout.ms" )

filein( getFilenamePath(getSourceFileName()) + "/../MacroScriptFileParser/MacroScriptFileParser.ms" )

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Dialog/Rollout/Controls/ControlBox/Control/Control.ms" )

filein( getFilenamePath(getSourceFileName()) + "/../ControlCreator/ControlCreator.ms" )

filein (getFilenamePath(getSourceFileName()) + "ControlTypesTest.mcr")


MacroScripts = (MacroScriptFileParser_v path:( getFilenamePath(getSourceFileName()) + "ControlTypesTest.mcr")).MacroScripts


/*---------------------------------------
	ROLLOUT DEFINITION
-----------------------------------------*/


_Rollout = Rollout_v title:(getFilenameFile(getSourceFileName()))


ControlBox  = _Rollout.controls.new groupbox:"Control types"


for Macro in MacroScripts do 
	ControlCreator 	= ControlCreator_v Macro:Macro ControlBox:ControlBox



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) height:512

--
--
--fn regexGetMatches source pattern =
--(
--    results = #()
--	rx          = dotNetClass "System.Text.RegularExpressions.RegEx"
--	rx_options	= dotNetClass "System.Text.RegularExpressions.RegexOptions"
--	
--	matches = rx.matches source pattern rx_options.IgnoreCase
--	
--	for matchIdx = 0 to matches.count-1 do
--	(
--		currentMatch = 
--		for groupIdx = 0 to matches.item[matchIdx].groups.count-1 do ( append results matches.item[matchIdx].groups.item[groupIdx].value )			 
--	)
--
--   results	
--)
--
-- 
-- rxtest_resutl = regexGetMatches "type:checkbox|checked:true|border:false" "Type:(.*?)\|" 
-- 
-- format "rxtest_resutl = % \n" rxtest_resutl
