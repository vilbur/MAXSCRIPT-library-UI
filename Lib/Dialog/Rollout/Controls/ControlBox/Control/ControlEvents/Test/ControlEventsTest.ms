clearListener()


filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))



controls_1    = _Rollout.Controls.new groupbox:"Groupbox 1"

Subrollouts_A = _Rollout.subrollouts()

_SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"
_SubRollout_A2 = Subrollouts_A.new   "Subrollout A2"

controls_2    = _Rollout.Controls.new groupbox:"Groupbox 2"

Subrollouts_B = _Rollout.subrollouts()
_SubRollout_B1 = Subrollouts_B.new   "Subrollout B1"
_SubRollout_B1_controls = _SubRollout_B1.Controls.new groupbox:"SubRollout A1 controls"



controls_1.button "Button before subrollouts A"
controls_2.button "Button after subrollouts B"
_SubRollout_B1_controls.button "Button in subrollout 2"



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )

_Rollout.addSubRollouts()




--/*---------------------------------------
--	ROLLOUT DEFINITION
-------------------------------------------*/
--_rollout	= (Rollout_v()).new "Events Test"
--_rollout.ini	= getFilenamePath(getSourceFileName()) + "ControlTest.ini"
--
--
--
--/*---------------------------------------
--	ADD CONTROLS
-------------------------------------------*/
--
--/** Set control properties
-- */
--function cretateControlWithPropertiesTest =
--(
--	_controls_1	= _rollout.controls groupbox:"Test Groupbox"
--	_btn_prop	= _controls_1.button "Props test"
--	_checkbox 	= _controls_1.checkbox "Checkbox test"
--	
--	--_btn_prop.col 6
--	_btn_prop.pressed	"messagebox \"Pressed\""	tooltip:"Pressed tooltip"
--	_btn_prop.rightclick 	"messagebox \"Rightclick\""	tooltip:"Rightclick tooltip"
--)
--
--/** Set control properties
-- */
--function remoteCheckbox =
--(
--	_controls_2	= _rollout.controls groupbox:"Toggle Test"
--
--	_btn_toggle	= _controls_2.button "Toggle checkbox" 
--	global _checkbox_toggle 	= _controls_2.checkbox "Toggle Test" -- declare controls variable as global, so it can be revoked in callback of button
--
--	_btn_toggle.pressed	"(_checkbox_toggle.toggle())"	tooltip:"Pressed tooltip"
--
--)
--
--
--
--/*---------------------------------------
--	RUN TESTS
-------------------------------------------*/
--
--cretateControlWithPropertiesTest()
--remoteCheckbox()
--
--
--/* CREATE DIALOG  */
--_rollout.CreateRollDialog()
--
--
--
