clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../../Rollout/Rollout.ms" )

--dialog_name = (getFilenameFile(getSourceFileName()))
--filein ( getFilenamePath(getSourceFileName()) + "/../../../Test/inlcudes/ControlsIncludeTest.ms" )


_Rollout	  = Rollout_v title:(filenameFromPath(getSourceFileName()))
Controls      = _Rollout.Controls.new "Groupbox 1"
global btn_prop = Controls.button "Props test"

/*---------------------------------------
	ADD CONTROLS
-----------------------------------------*/

/** Set control properties
 */
function cretateControlWithPropertiesTest =
(
	global btn_prop	= Controls.button "Props test"
	
	btn_prop.Props.add #width 144
	btn_prop.Props.add #height 48
	btn_prop.Props.add #border false
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
	btn_prop.Props.add #enabled false
)

/*---------------------------------------
	RUN TESTS
-----------------------------------------*/

--cretateControlWithPropertiesTest()
--cretateControlWithParameters()



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )

--_Rollout.addSubRollouts()





--addParameterToExistingControlsTest()