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



/* DROPDOWN  */
_Dropdownlist_1 = _Controls.Dropdownlist	"" -- dropdown without label

_Dropdownlist_2 = _Controls.Dropdownlist	"Height Test" height:100 -- dropdown height is 99 items + 1 selected item

_Dropdownlist_3 = _Controls.Dropdownlist	"Dropdownlist 1" items:#("item 1", "item 2", "item 3")  height:100 


--/* events WITH VALUE
--*/ 
--_Dropdownlist_3.Events.setEvent #selected	"testCallbackWithValue(val)"	"tooltip"
--
--
--/* events WITHOUT VALUE
--*/ 
--_Dropdownlist_3.Events.setEvent #rightClick 	"testCallback()" ""


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512