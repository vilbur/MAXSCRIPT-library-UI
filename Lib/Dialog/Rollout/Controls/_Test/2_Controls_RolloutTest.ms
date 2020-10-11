clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/* ROLLOUT DEFINITION */
--struct Control_mock(type = #button, id="", caption="Test button")

_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))




controls_1 = _Rollout.Controls.new "Groupbox 1"
controls_1.button "Button before subrollout 1"



_SubRollout  = _Rollout.subrollout "Subrollout 1"
--controls_sub = _SubRollout.Controls.new "_SubRollout Groupbox 1"
--controls_sub.button "Button in subrollout"


controls_2 = _Rollout.Controls.new "Groupbox 2"
controls_2.button "Button after subrollout 2"


_SubRollout_2  = _Rollout.subrollout "Subrollout 2"


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )

execute add_subrollouts