clearListener()

try(cui.UnRegisterDialogBar ROLLOUT_1_rollouteventtest)catch() --try to unregister if already registered
try(DestroyDialog  ROLLOUT_1_rollouteventtest)catch() --try to unregister if already registered

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/** CREATE ROLLOUTS 
 *	
 */
_Rollout = Rollout_v title:(getFilenameFile(getSourceFileName())) ini:(getFilenamePath(getSourceFileName()) + "1_RolloutEventTest.ini")

SubRollouts = _Rollout.subrollouts()

Rollout_A    = SubRollouts.new "Subrollout A"


/*
	CHANGE DEFAULT EVENTS

Rollout_A.Events.Events.setDefaultEvent ( Event_v type:"onOpen"	code:	"messagebox \"Default Event onOpen\"" )
Rollout_A.Events.Events.setDefaultEvent ( Event_v type:"onClose"	code:	"messagebox \"Default Event onClose\"" )

*/

global DIALOG_PREVIOUS_STATE

/** _is registered
 */
function _isRegistered =
(
	try(cui.getDockState ROLLOUT_1_rollouteventtest)catch(false)
)

/** `On resize`
 */
function onDialogIsDocked new_size =
(
	
	format "\nEventFired = % \n" EventFired
	current_state = try(cui.getDockState ROLLOUT_1_rollouteventtest)catch(false)
	format "current_state         = % \n" current_state
	format "DIALOG_PREVIOUS_STATE = % \n" DIALOG_PREVIOUS_STATE
	if( current_state != DIALOG_PREVIOUS_STATE and matchPattern (current_state as string) pattern:"cui_dock*") then 
		(print  ("DOCKED " + current_state);DIALOG_PREVIOUS_STATE = current_state)
)

/*
	SET CUSTOM EVENTS
*/
--_Rollout.Events.setEvent #open "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #close "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #moved "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #resized "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #resized "onresize val"
--_Rollout.Events.setEvent #moved   "onresize val"


_Rollout.Events.setEvent #docked  "print \"YESS\""

Rollout_A.Events.setEvent #open "format \"EventFired = % \n\" EventFired"
Rollout_A.Events.setEvent #close "format \"EventFired = % \n\" EventFired"





/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

--clearListener()

cui.RegisterDialogBar	ROLLOUT_1_rollouteventtest style:#(#cui_dock_left,#cui_dock_right,#cui_floatable,#cui_handles)


cui.DockDialogBar     ROLLOUT_1_rollouteventtest #cui_dock_right


--sleep 3
--
--cui.DockDialogBar     ROLLOUT_1_rollouteventtest #cui_dock_left
