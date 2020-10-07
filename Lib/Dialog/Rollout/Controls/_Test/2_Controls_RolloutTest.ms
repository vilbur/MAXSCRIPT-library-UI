clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/* ROLLOUT DEFINITION */
struct Control_mock(type = #button, id="", caption="Test button")

_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))

controls_1 = _Rollout.Controls.new "Groupbox 1"
controls_1.button "Button before subrollout 1"



--_SubRollout = _Rollout.subrollout "Subrollout 1"
--controls_sub = _SubRollout.Controls.box groupbox:"_SubRollout Groupbox 1"
--
--for i = 1 to 5 do
--	controls_sub.add (Control_mock id:("Button_subrollout" + i as string ) caption:("Button subrollout " + i as string))



/* CREATE ROLLOUT */
_Rollout.createRollout()	-- create with default parameters

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )