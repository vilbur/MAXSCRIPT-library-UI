clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))
_Rollout.ini	(getFilenamePath(getSourceFileName()) + "ControlTest.ini")
_controls_1	= _Rollout.controls.new groupbox:"Test Groupbox"


/* CONTROL TYPES */

Edittext = _controls_1.edittext	"Edit Text" text:"XXX"

_controls_1.edittext	"Field Width By This Label Length" columns:12
_controls_1.edittext	"Custom Width"           fieldwidth:96


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts



/** Change value in control 
 */
Edittext.Properties._setValue #text "Changed value"