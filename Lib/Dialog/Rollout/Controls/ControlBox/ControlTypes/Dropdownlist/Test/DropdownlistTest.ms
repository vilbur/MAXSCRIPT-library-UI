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

_Rollout.ini	(getFilenamePath(getSourceFileName()) + getFilenameFile(getSourceFileName()) + ".ini")


/* ITEMS FOR DROPDOWN  */ 
items = for i = 1 to 99 collect (i as string+ " item")

/* DROPDOWN  */
_Dropdownlist_1 = _Controls.Dropdownlist	"" -- dropdown without label

_Dropdownlist_2 = _Controls.Dropdownlist	"Height 99 Items "           height:100 -- dropdown height is 99 items + 1 selected item

_Dropdownlist_3 = _Controls.Dropdownlist	"Show all items" items:items height:100

_Dropdownlist_4 = _Controls.Dropdownlist	"Auto height"    items:items


/* events WITH VALUE
*/ 
_Dropdownlist_4.Events.setEvent #selected	"testCallbackWithValue(val)"	"tooltip"


/* events WITHOUT VALUE
*/ 
_Dropdownlist_4.Events.setEvent #rightClick 	"testCallback()" ""


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512