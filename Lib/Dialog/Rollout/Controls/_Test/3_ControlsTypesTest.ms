clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )


struct Control_mock(type = #button, id="", caption="Test button")


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))


_SubRollout = _Rollout.subrollout "Rollout 1"
controls_sub = _SubRollout.Controls.box groupbox:"_SubRollout Groupbox 1"


/* CONTROL TYPES */
controls_sub.button	"Button"
controls_sub.checkbutton	"Checkbutton"
controls_sub.checkbox	"Checkbox"


--for i = 1 to 5 do
	--controls_sub.add (Control_mock id:("Button_subrollout" + i as string ) caption:("Button subrollout " + i as string))



/* CREATE ROLLOUT */
_Rollout.dialogCreate()	-- create with default params
