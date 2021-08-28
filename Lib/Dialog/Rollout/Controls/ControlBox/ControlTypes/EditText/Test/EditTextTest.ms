clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))
_Rollout.ini	= getFilenamePath(getSourceFileName()) + "ControlTest.ini"
_controls_1	= _Rollout.controls.new groupbox:"Test Groupbox"


/** Layout setup
 */
--_Rollout.Layout.columns  = 16
--_Rollout.Layout.grid     = 48

--_Rollout.Layout.padding  = 0
--_Rollout.Layout.margin.x = 0
--_Rollout.Layout.margin.y = 0


/* CONTROL TYPES */

Edittext = _controls_1.edittext	"Edit Text" text:"XXX"

--_controls_1.edittext	"Edit Text Auto Field Width" 
--_controls_1.edittext	"Edit Text Custom Width" fieldwidth:32

----_controls_1.edittext	"Edit Text Custom Width" fieldwidth:32
format "Edittext = % \n" Edittext

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts



--Edittext.Properties._setValue #text "X"
