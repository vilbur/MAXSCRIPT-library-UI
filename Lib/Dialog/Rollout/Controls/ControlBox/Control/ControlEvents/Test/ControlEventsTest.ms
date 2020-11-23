clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

/*---------------------------------------
	ROLLOUT DEFINITION
-----------------------------------------*/

global _Rollout = Rollout_v title:(getFilenameFile(getSourceFileName())) id:"optionable_id"
_Rollout.ini	= getFilenamePath(getSourceFileName()) + "ControlTest.ini"




/*---------------------------------------
	ADD CONTROLS
-----------------------------------------*/

/** Set control properties
 */
function cretateControlWithPropertiesTest =
(
	_controls_1	= _Rollout.controls.new groupbox:"Test Groupbox"
	_btn_prop	= _controls_1.button   "Props test"
	_checkbox 	= _controls_1.checkbox "Checkbox test"
	
	_btn_prop.Events.pressed	"messagebox \"Pressed\""	tooltip:"Pressed tooltip"
	_btn_prop.Events.rightclick 	"messagebox \"Rightclick\""	tooltip:"Rightclick tooltip"
)

/** Set control properties
 */
function remoteCheckbox =
(
	_controls_2	= _Rollout.controls groupbox:"Toggle Test"

	_btn_toggle	= _controls_2.button "Toggle checkbox" 
	global _checkbox_toggle 	= _controls_2.checkbox "Toggle Test" -- declare controls variable as global, so it can be revoked in callback of button

	_btn_toggle.pressed	"(_checkbox_toggle.toggle())"	tooltip:"Pressed tooltip"

)

cretateControlWithPropertiesTest()

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

----SubRollouts.property height:256