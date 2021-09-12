clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )
/*---------------------------------------
	ROLLOUT DEFINITION
-----------------------------------------*/

global _Rollout = Rollout_v title:(getFilenameFile(getSourceFileName()))
_Rollout.ini	= getFilenamePath(getSourceFileName()) + "ControlTest.ini"




/*---------------------------------------
	ADD CONTROLS
-----------------------------------------*/

/** Set control properties
 */
function cretateControlWithPropertiesTest =
(
	global _controls_1  = _Rollout.controls.new groupbox:"Control types"
	
	--control_types	= #( #button, #checkbutton, #checkbox, #spinner )
	--control_types	= #( #button, #checkbox, #spinner )
	control_types	= #( #button, #checkbox, #spinner )
	--control_types	= #( #button )
	
	for control_type in control_types do
	(
		--execute("global _Control = (_controls_1."+control_type as string +" \"Props "+control_type+"\")")
		execute("_Control = (_controls_1."+control_type as string +" \"Props "+control_type+"\")")
		--format "_Control.Events.Events.event_types = % \n" _Control.Events.Events.event_types
		
		for event_type in _Control.Events.Events.event_types do
			_Control.Events.setEvent event_type ("print (\""+event_type+" \"+ val as string )") "tooltip"
		
	)
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