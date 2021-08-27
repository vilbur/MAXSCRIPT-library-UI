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
)
/** Button test
 */
function spinnerTest val =
(
	print ("Spinner changed " + val as string )
)


_Rollout = Rollout_v title:(getFilenameFile(getSourceFileName()))


Controls_1  = _Rollout.controls.new groupbox:"Control types"

Button_1 = Controls_1.button "Test"
Spinner  = Controls_1.spinner "Test"

Button_1.Events.setEvent #pressed "buttonTest()" "tooltip"
Spinner.Events.setEvent  #changed "spinnerTest val" "tooltip"


--cretateControlWithPropertiesTest()

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512