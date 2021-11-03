clearListener()

try(cui.UnRegisterDialogBar ROLLOUT_1_rollouteventtest)catch() --try to unregister if already registered
try(DestroyDialog  ROLLOUT_1_rollouteventtest)catch() --try to unregister if already registered

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/** CREATE ROLLOUTS 
 *	
 */
_Rollout = Rollout_v title:(getFilenameFile(getSourceFileName()))

_Rollout.ini (getFilenamePath(getSourceFileName()) + "1_RolloutEventTest.ini")


SubRollouts = _Rollout.subrollouts()

Rollout_A    = SubRollouts.new "Subrollout A"


/*
	CHANGE DEFAULT EVENTS

Rollout_A.Events.Events.setDefaultEvent ( Event_v type:"onOpen"	code:	"messagebox \"Default Event onOpen\"" )
Rollout_A.Events.Events.setDefaultEvent ( Event_v type:"onClose"	code:	"messagebox \"Default Event onClose\"" )

*/


/*
	SET CUSTOM EVENTS
*/
--_Rollout.Events.setEvent #open "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #close "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #moved "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #resized "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #resized "onresize val"


_Rollout.Events.setEvent #open    "print \"#open\""
_Rollout.Events.setEvent #close   "print \"#close\""



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

--cui.RegisterDialogBar	ROLLOUT_1_rollouteventtest style:#(#cui_dock_left,#cui_dock_right,#cui_floatable,#cui_handles)