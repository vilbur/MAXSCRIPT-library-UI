clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../Rollout.ms" )


struct Control_mock(type = #button, id="", caption="Test button")


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))
_Rollout.ini	= getFilenamePath(getSourceFileName()) + "ControlTest.ini"
_controls_1	= _Rollout.controls.new groupbox:"Test Groupbox"


--_SubRollout = _Rollout.subrollout "Rollout 1"
--_controls_1 = _SubRollout.Controls.box groupbox:"_SubRollout Groupbox 1"


/* CONTROL TYPES */
_controls_1.button	"Button"
_controls_1.checkbutton	"Checkbutton"
_controls_1.checkbox	"Checkbox"


--for i = 1 to 5 do
	--_controls_1.add (Control_mock id:("Button_subrollout" + i as string ) caption:("Button subrollout " + i as string))




/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

--SubRollouts.property height:256