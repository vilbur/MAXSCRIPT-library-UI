clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollouts/Rollout/Rollout.ms" )


struct Control_mock(type = #button, id="", caption="Test button")


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))


_SubRollout = _Rollout.subrollout "Rollout 1"
controls_sub = _SubRollout.Controls.box groupbox:"_SubRollout Groupbox 1"


/* CONTROL TYPES */
controls_sub.button	"Button"
controls_sub.checkbutton	"Checkbutton"
controls_sub.checkbox	"Checkbox"

/* CREATE ROLLOUT */
_Rollout.dialogCreate()	-- create with default params
