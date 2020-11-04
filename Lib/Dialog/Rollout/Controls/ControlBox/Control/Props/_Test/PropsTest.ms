clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )
--dialog_name = (getFilenameFile(getSourceFileName()))
--filein ( getFilenamePath(getSourceFileName()) + "/../../../Test/inlcudes/ControlsIncludeTest.ms" )


_Rollout	  = Rollout_v title:(filenameFromPath(getSourceFileName()))
global Controls      = _Rollout.Controls.new "Controls 1"
global btn_prop_global = Controls.button "Props test"

/*---------------------------------------
	ADD CONTROLS
-----------------------------------------*/

/** Set control properties
 */
function cretateControlWithPropertiesTest =
(
	btn_prop	= Controls.button "Props test dimensions"
	
	btn_prop.Props.add #width  128
	btn_prop.Props.add #height 64
	--btn_prop.Props.add #border false
)

/** Create control with parameters
 */
function cretateControlWithParameters =
(
	btn_param	= Controls.button "Param test"
	 
	btn_param.params "width:144, height:48"
)

/** Add parameter to existing controls
 */
function addParameterToExistingControlsTest =
(
	--btn_prop_global.Props.add #visible false
	btn_prop_global.Props.add #enabled false
	--btn_prop_global.Props.add #width   256
)

/*---------------------------------------
	RUN TESTS
-----------------------------------------*/

cretateControlWithPropertiesTest()
--cretateControlWithParameters()



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )


addParameterToExistingControlsTest()