clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

/* ROLLOUT DEFINITION */
global _Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))

--_Rollout.ini (getFilenamePath(getSourceFileName()) + "ControlTest.ini")

_controls_1	= _Rollout.controls.new groupbox:"Test Groupbox"



--/** Add extra rollout
-- */
--function addButtons controls_count:4 =
--(
--	_Buttons	= _Rollout.Controls.new groupbox:"Buttons"
--	
--	for i = 1 to controls_count do
--		_Buttons.button ("Button "+i as string )
--)
--
--addButtons()




/* CONTROL TYPES */

Edittext = _controls_1.BrowsePath	"Edit Text"
--Edittext = _controls_1.edittext	"Edit Text"

--_controls_1.BrowsePath	"Field Width By This Label Length" columns:12
--_controls_1.BrowsePath	"Custom Width"           fieldwidth:96





/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts



/** Change value in control 
 */
--Edittext.Properties._setValue #text "Changed value"