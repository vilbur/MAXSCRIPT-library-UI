clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Dialog/Rollout/Rollout.ms" )


global _Rollout	  = Rollout_v title:(filenameFromPath(getSourceFileName()))
global Controls     = _Rollout.Controls.new groupbox:"Controls 1"
global btn_no_props = Controls.button "Button No Properties"
--global btn_props    = Controls.button "Button Properties"

/*---------------------------------------
	ADD CONTROLS
-----------------------------------------*/

/** Set control properties
 */
function setPropertiesBeforeCretion =
(
	btn_props.Props.add #width  128
	btn_props.Props.add #height 64
	btn_props.Props.add #border false
)

/** Add parameter to existing controls
 */
function addParameterToExistingControlsTest =
(
	btn_props.property enabled:false
	
	--btn_no_props.Props.add #visible false
)


/** TEST 
 */
--setPropertiesBeforeCretion()


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )


/** TEST 
 */
--addParameterToExistingControlsTest()