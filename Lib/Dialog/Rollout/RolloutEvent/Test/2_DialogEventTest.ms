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


/** On dock test
 */
function onDockTest val =
(
	print "onDockTest()"
	max_height	= this._getViewportHeight()

	this.RolloutMain.Layout.fitSubrollouts dialog_height:max_height -- resize subrollouts
	
	this.height max_height -- resize dialog
	
)


/*
	SET CUSTOM EVENTS
*/
--_Rollout.Events.setEvent #open "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #close "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #moved "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #resized "format \"EventFired = % \n\" EventFired"
--_Rollout.Events.setEvent #resized "onresize val"
_Rollout.Events.setEvent #docked   "onDockTest val"


--_Rollout.Events.setEvent #docked  "print \"Custom Event\""
--_Rollout.Events.setEvent #docked  "print current_state as string"

Rollout_A.Events.setEvent #open "format \"EventFired = % \n\" EventFired"
Rollout_A.Events.setEvent #close "format \"EventFired = % \n\" EventFired"





/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

--clearListener()

cui.RegisterDialogBar	ROLLOUT_1_rollouteventtest style:#(#cui_dock_left,#cui_dock_right,#cui_floatable,#cui_handles)


--cui.DockDialogBar     ROLLOUT_1_rollouteventtest #cui_dock_right


--sleep 3
--
--cui.DockDialogBar     ROLLOUT_1_rollouteventtest #cui_dock_left
