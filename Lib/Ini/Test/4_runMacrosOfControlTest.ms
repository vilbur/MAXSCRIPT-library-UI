clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Dialog/Rollout/Rollout.ms" )


/** CREATE ROLLOUTS 
 *	
 */
_Rollout     = Rollout_v title:(getFilenameFile(getSourceFileName())) id:"rollout_main"
_Rollout.ini (getFilenamePath(getSourceFileName()) + getFilenameFile(getSourceFileName()) + ".ini")

SubRollouts = _Rollout.subrollouts()

Rollout_A    = SubRollouts.new "Subrollout A"

_Controls = Rollout_A.Controls.new groupbox:"test"


/* NO VALUE CONTROLS  */
--Button_A1 = _Controls.button "Test 1" 

/* VALUE CONTROLS  */
--_Checkbox = _Controls.checkbox	"Checkbox" checked:true


_Controls.spinner	"Test Spinner1" range:[0,9,99]
--_Controls.spinner	"Test Spinner2" range:[0,99,99]
--_Controls.spinner	"Test Spinner3" range:[0,999,999]
--_Controls.spinner	"Test Spinner"  range:[0,999,999.0] type:#float

--_Controls.spinner	"Test Spinner" 

--_Controls.checkbutton	"Checkbutton"

--_Controls.edittext	"Edit Text" 

----BrowsePath = _Controls.BrowsePath	"Browse"

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

--SubRollouts.property height:256this.
