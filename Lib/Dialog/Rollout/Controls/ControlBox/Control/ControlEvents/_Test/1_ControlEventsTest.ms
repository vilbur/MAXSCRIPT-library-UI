clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )
/*---------------------------------------
	ROLLOUT DEFINITION
-----------------------------------------*/

_Rollout 	= Rollout_v title:(getFilenameFile(getSourceFileName()))
Controls_1 	= _Rollout.controls.new groupbox:"Control types"


/** Button test
 */
function CallbackNoParam =
(
	print "CallbackNoParam"

	format "EventFired.control 	= % \nEventFired.type 	= % \n\n" EventFired.control EventFired.type
)
/** on value changed
 */
function CallbackWithValue val =
(
	print "CallbackWithValue"
	
	format "EventFired.control 	= % \nEventFired.type 	= % \n" EventFired.control EventFired.type
	
	format "val 	= % \n" val
	
	format "EventFired 	= % \n\n" EventFired
)


/** on value changed
 */
function CallbackWith2Params arg_1 arg_2 =
(
	print "SpinnerEnteredTest"
	
	format "EventFired.control 	= % \nEventFired.type 	= % \n" EventFired.control EventFired.type

	format "arg_1 	= % \narg_2  	= % \n" arg_1 arg_2

	format "EventFired 	= % \n\n" EventFired
)



Button1 = Controls_1.button "Test"
Button1.Events.setEvent #pressed	"CallbackNoParam"	""
Button1.Events.setEvent #rightclick	"CallbackNoParam()"	""


Checkbox = Controls_1.checkbox "Test"
Checkbox.Events.setEvent #changed	"CallbackWithValue(val)"	""
Checkbox.Events.setEvent #rightclick	"CallbackNoParam()"	""


Spinner = Controls_1.spinner "Test"
Spinner.Events.setEvent #changed	"CallbackWith2Params"	""
Spinner.Events.setEvent #entered	"CallbackWith2Params"	""
Spinner.Events.setEvent #buttondown	"CallbackNoParam"	""
Spinner.Events.setEvent #buttonup	"CallbackWithValue"	""


--BrowsePath = Controls_1.browsePath "Test"
--BrowsePath.Events.setEvent #changed    "CallbackWithValue (val)" ""



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512


clearListener()

