clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

try( destroyDialog ROLLOUT_listboxtestms )catch()


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))
_Rollout.ini	(getFilenamePath(getSourceFileName()) + getFilenameFile(getSourceFileName()) + ".ini")

global _Controls	= _Rollout.controls.new groupbox:"Test Groupbox"

_Rollout.Layout.padding  = 0

/* ITEMS FOR LISTBOX  */ 
items = for i = 1 to 99 collect (i as string+ " item")


/** Listbox in group box
 */
function testDifferentHeights =
(
	for i = 1 to 9 do
	(
		control_type = "Listbox"
		
		i_string = i as string
		
		_label =  control_type + " "+i_string
		
		execute ("global _Controls"+i_string+"	= _Rollout.controls.new groupbox:\"Groupbox "+i_string+"\"")
		execute ("_Controls"+i_string+"."+control_type+" \"" + _label+"\" height:"+i_string ) -- execute this kind of code "_Buttons.button ("Button "+i as string )"
	)
	
)


--testDifferentHeights()

/* LISTBOX  */
Listbox_1 = _Controls.Listbox	""          items:items height:50

Listbox_2 = _Controls.Listbox	"Colums"          height:3 colums:7

Listbox_3 = _Controls.Listbox	"Width"          height:3 width:256

Listbox_4 = _Controls.Listbox	"Listbox 2" items:items height:99 selection:3



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 


selected = Listbox_4.property #selection #get

format "selected	= % \n" selected
