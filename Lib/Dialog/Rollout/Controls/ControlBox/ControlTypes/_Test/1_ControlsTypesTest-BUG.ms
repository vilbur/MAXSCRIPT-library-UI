clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../Rollout.ms" )


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))
_Rollout.ini	= (getFilenamePath(getSourceFileName()) + getFilenameFile(getSourceFileName()) + ".ini")
_controls_1	= _Rollout.controls.new groupbox:"Test Groupbox"



/* CONTROL TYPES */

_controls_1.edittext	"Edit Text"


/** BUG -  Edit text field is out of groupbox
 *	
 */
_controls_1.edittext	"Edit Text Custom Width" fieldwidth:32 -- !!! BUG


_controls_1.edittext	"Edit Text Auto Field Width" 



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts