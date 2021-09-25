clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" ) 

/** CREATE ROLLOUTS 
 *	
 */
_Rollout     = Rollout_v title:(getFilenameFile(getSourceFileName())) id:"rollout_main"

SubRollouts = _Rollout.subrollouts()

Rollout_A    = SubRollouts.new "Subrollout A"

_Controls = Rollout_A.Controls.new groupbox:"test"

_Controls.button "Columns test"  columns:12

_Controls.spinner	"Spinner 1" range:[0,9,99]
_Controls.spinner	"Spinner 2" range:[0,99,99]
_Controls.spinner	"Spinner 3" range:[0,999,999]
_Controls.spinner	"Spinner 4" range:[0,9,9]	type:#float
_Controls.spinner	"Spinner 5" range:[0,99,99.0]	type:#float
_Controls.spinner	"Spinner 6" range:[0,999,999.0]	type:#float
_Controls.spinner	"Spinner 8" range:[0,999999,999999]	fieldwidth:64
_Controls.spinner	"Spinner 9" range:[0,999999,999999]	fieldwidth:64 columns:12

/**  Set ini path 
 *	
 */
--Rollout_A.ini	= (getFilenamePath(getSourceFileName()) + getFilenameFile(getSourceFileName()) + ".ini")
--Rollout_A.setDefaultEvents()


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

_Rollout.Layout.fitSubrollouts()
