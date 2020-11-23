clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Dialog/Rollout/Rollout.ms" )


global _Rollout	  = Rollout_v title:(filenameFromPath(getSourceFileName()))
global Controls     = _Rollout.Controls.new groupbox:"Controls 1"
global btn_props    = Controls.button "Button Properties"
global btn_no_props = Controls.button "Button No Props"
global _spinner     = Controls.spinner "Spinner" scale:10

/*---------------------------------------
	ADD CONTROLS
-----------------------------------------*/

/** Set control properties
 */
function setPropertiesBeforeCretion =
(
	
	
	--btn_props.property width: 128
	--btn_props.property height:64
	--btn_props.property border:false
)

/** Add parameter to existing controls
 */
function addParameterToExistingControlsTest =
(
	btn_props.property    enabled:false
	btn_no_props.property visible:false
)


/** TEST 
 */
setPropertiesBeforeCretion()


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )

_Rollout.setRolloutWidth()


--messageBox "Right button will disapear" beep:false

/** TEST 
 */
addParameterToExistingControlsTest()


_spinner.property range:[0,100,10] 
