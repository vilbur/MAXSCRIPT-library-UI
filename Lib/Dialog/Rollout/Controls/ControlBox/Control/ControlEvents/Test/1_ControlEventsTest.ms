clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )
/*---------------------------------------
	ROLLOUT DEFINITION
-----------------------------------------*/

/** Button test
 */
function buttonTest =
(
	print "Yesssss"
	format "EventFired = % \n" EventFired

)
/** Button test
 */
function spinnerTest val =
(
	print ("Spinner changed " + val as string )
	--format "EventFired = % \n" val_callback
	format "EventFired = % \n" EventFired
)


_Rollout = Rollout_v title:(getFilenameFile(getSourceFileName()))


Controls_1  = _Rollout.controls.new groupbox:"Control types"

Button_1 = Controls_1.button "Test"
Spinner  = Controls_1.spinner "Test"
Spinner2  = Controls_1.spinner "Test 2"

Button_1.Events.setEvent #pressed "buttonTest()" "tooltip"
Spinner.Events.setEvent  #changed "spinnerTest (val)" "tooltip"
Spinner2.Events.setEvent  #changed "spinnerTest (val)" "tooltip"


--cretateControlWithPropertiesTest()

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512