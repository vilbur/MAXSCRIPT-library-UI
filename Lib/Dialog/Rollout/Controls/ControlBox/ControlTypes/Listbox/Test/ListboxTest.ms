clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))
_Controls	= _Rollout.controls.new groupbox:"Test Groupbox"

_Rollout.ini	(getFilenamePath(getSourceFileName()) + getFilenameFile(getSourceFileName()) + ".ini")



/* LISTBOX  */
Listbox_1 = _Controls.Listbox	"Listbox 1" items:#("item 1", "item 2")
Listbox_2 = _Controls.Listbox	"Listbox 2" items:#("item 1", "item 2", "selected") selection:3



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512


selected = Listbox_2.property #selection #get

format "selected	= % \n" selected
