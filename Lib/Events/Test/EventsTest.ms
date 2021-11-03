clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Dialog/Dialog.ms" )

/**
 * Test events on Dialog, Rollout and control at same time 
 *	
 */

/*------ CREATE FLOATER DIALOG ------*/
global Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))

Dialog.RolloutMain.ini (getFilenamePath(getSourceFileName()) + "2_DialogEventTest.ini")

/*------ CREATE ROLLOUTS ------*/
/** Add rollouts
 */
function addRollouts =
(

	Rollouts = Dialog.rollouts()
	global Rollout_A	= Rollouts.new "Rollout A"
	--Rollout_B	= Rollouts.new "Rollout B"

)

/** Add ntrol events
 */
function addDialogEvents =
(
	--Dialog.Events.setEvent #open	"format \"EventFired = % \n\" EventFired"
	--Dialog.Events.setEvent #close	"format \"EventFired = % \n\" EventFired"
	--Dialog.Events.setEvent #moved	"format \"EventFired = % \n\" EventFired"
	--Dialog.Events.setEvent #resized	"format \"EventFired = % \n\" EventFired"
	Dialog.Events.setEvent #oktoclose	"format \"EventFired = % \n\" EventFired"

	--Dialog.Events.setEvent #mbuttondown	"format \"EventFired = % \n\" EventFired"
)

/** Add ntrol events
 */
function addDRolloutsEvents =
(
	--Dialog.Events.setEvent #open	"format \"EventFired = % \n\" EventFired"
	--Dialog.Events.setEvent #close	"format \"EventFired = % \n\" EventFired"
	--Dialog.Events.setEvent #moved	"format \"EventFired = % \n\" EventFired"
	--Dialog.Events.setEvent #resized	"format \"EventFired = % \n\" EventFired"
	--Dialog.Events.setEvent #lbuttondown	"format \"EventFired = % \n\" EventFired"

	--Dialog.Events.setEvent #mbuttondown	"format \"EventFired = % \n\" EventFired"
)

/** Add ntrols
 */
function addControls =
(
	Controls_1 	= Rollout_A.controls.new groupbox:"Control types"

	Checkbox = Controls_1.Checkbox "Test"
	Checkbox.Events.setEvent #changed	"onCloseCallback(val)"	""
	Checkbox.Events.setEvent #changed	"onCloseCallback()"	""

)

global ENABLE_RESIZING = false

/*
	CHANGE DEFAULT EVENTS

Rollout_A.Events.Events.setDefaultEvent ( Event_v type:"onOpen"	code:	"messagebox \"Default Event onOpen\"" )
Rollout_A.Events.Events.setDefaultEvent ( Event_v type:"onClose"	code:	"messagebox \"Default Event onClose\"" )

*/

/** On dock test
 */
function onDockResizeDialogCallback val =
(
	--print "\n onDockResizeDialogCallback()"
	--
	--format "EventFired = % \n" EventFired
	--
	--format "ENABLE_RESIZING = % \n" ENABLE_RESIZING
	--format "STATE = % \n" (cui.getDockState ROLLOUT_2_dialogeventtest)

	if( ENABLE_RESIZING ) then
	(

		if( ( Dialog_global = DialogGlobals.get(EventFired.Control) )!= undefined ) then
		(
			Dialog_global.resizeSubrolloutsOfDockedDialog()
		)

	)

	--max_height	= this._getViewportHeight()
	--
	--this.RolloutMain.Layout.fitSubrollouts dialog_height:max_height -- resize subrollouts
	--
	--this.height max_height -- resize dialog

)

/** On close callback
 */
function onCloseCallback  val =
(
	print "onCloseCallback()"
	format "EventFired	= % \n" EventFired
)

/*
	SET CUSTOM EVENTS
*/

--Rollout_A.Events.setEvent #mbuttondown	"format \"EventFired = % \n\" EventFired"

--Dialog.Events.setEvent #resized "onresize val"

--Dialog.Events.setEvent #docked   "onDockResizeDialogCallback val"

--Dialog.Events.setEvent #resized  "onCloseCallback val"

--Dialog.Events.setEvent #close  "print \"Event close\""

--Dialog.Events.setEvent #docked  "print \"Custom Event\""
----_Rollout.Events.setEvent #docked  "print current_state as string"
--
--Rollout_A.Events.setEvent #open "format \"EventFired = % \n\" EventFired"
--Rollout_A.Events.setEvent #close "format \"EventFired = % \n\" EventFired"
--

addRollouts()

addDialogEvents()

/* CREATE DIALOG */
Dialog.create()

--format "Dialog._isRegistered()	= % \n" (Dialog._isRegistered())

--Dialog.dock #right

--format "Dialog._isRegistered()	= % \n" (Dialog._isRegistered())

--
--CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512
--
--_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts
--
--
--cui.RegisterDialogBar	ROLLOUT_2_dialogeventtest style:#(#cui_dock_left,#cui_dock_right,#cui_floatable,#cui_handles)
--
--
--cui.DockDialogBar     ROLLOUT_2_dialogeventtest #cui_dock_right
--

--sleep 3
--
--cui.DockDialogBar     ROLLOUT_2_dialogeventtest #cui_dock_left
