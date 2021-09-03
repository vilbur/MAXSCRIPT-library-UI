clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )
/*---------------------------------------
	ROLLOUT DEFINITION
-----------------------------------------*/

/** Button test
 */
function buttonTest =
(
	print "Button pressed"
	
	format "EventFired = % \n" EventFired
)
/** Button test
 */
function spinnerTest val =
(
	print ("Spinner changed " + val as string )

	format "EventFired = % \n" EventFired
)


_Rollout = Rollout_v title:(getFilenameFile(getSourceFileName()))


Controls_1  = _Rollout.controls.new groupbox:"Control types"

Button1 = Controls_1.button "Test"
Spinner = Controls_1.spinner "Test"

Button1.Events.setEvent #pressed    "buttonTest()"      "tooltip for event"
Spinner.Events.setEvent #changed    "spinnerTest (val)" "tooltip for event"


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512