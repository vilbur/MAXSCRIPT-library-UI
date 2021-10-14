clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )


/** Test callback
 */
function testCallback =
(
	print ("testCallback() #" + EventFired.type)
	--format "EventFired = % \n" EventFired
)
/** Test callback
 */
function testCallbackWithValue val =
(
	print ("testCallbackWithValue() #" + EventFired.type)
	format "val	= % \n" val
)

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))
_Controls	= _Rollout.controls.new groupbox:"Test Groupbox"

--_Rollout.ini	(getFilenamePath(getSourceFileName()) + getFilenameFile(getSourceFileName()) + ".ini")



/* LISTBOX  */
Multilistbox_1 = _Controls.Multilistbox	"Multilistbox 1" items:#("item 1", "item 2", "item 3")


/* events WITH VALUE
*/ 
Multilistbox_1.Events.setEvent #selected	"testCallbackWithValue(val)"	"tooltip"
Multilistbox_1.Events.setEvent #doubleClicked	"testCallbackWithValue"	"tooltip"


/* events WITHOUT VALUE
*/ 
Multilistbox_1.Events.setEvent #rightClick 	"testCallback()" ""
Multilistbox_1.Events.setEvent #selectionEnd	"testCallback" ""




/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512