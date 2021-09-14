clearListener()


filein( getFilenamePath(getSourceFileName()) + "/../../../Dialog.ms" )

/** CREATE ROLLOUTS 
 *	
 */
Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))
--_Rollout = Rollout_v title:(getFilenameFile(getSourceFileName())) ini:(getFilenamePath(getSourceFileName()) + "1_RolloutEventTest.ini")

/*------ CREATE FLOATER DIALOG ------*/

Rollouts = Dialog.rollouts()
rollout_A	= Rollouts.new "Rollout A"
rollout_B	= Rollouts.new "Rollout B"


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
	print "\n onDockResizeDialogCallback()"
	
	format "EventFired = % \n" EventFired
	
	format "ENABLE_RESIZING = % \n" ENABLE_RESIZING
	format "STATE = % \n" (cui.getDockState ROLLOUT_2_dialogeventtest)

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

--format "DIALOG_PREVIOUS_STATE = % \n" DIALOG_PREVIOUS_STATE
/*
	SET CUSTOM EVENTS
*/
--Dialog.RolloutMain.Events.setEvent #open "format \"EventFired = % \n\" EventFired"
--Dialog.RolloutMain.Events.setEvent #close "format \"EventFired = % \n\" EventFired"
--Dialog.RolloutMain.Events.setEvent #moved "format \"EventFired = % \n\" EventFired"
--Dialog.RolloutMain.Events.setEvent #resized "format \"EventFired = % \n\" EventFired"
--Dialog.RolloutMain.Events.setEvent #resized "onresize val"
Dialog.RolloutMain.Events.setEvent #docked   "onDockResizeDialogCallback val"
--
--
--Dialog.RolloutMain.Events.setEvent #docked  "print \"Custom Event\""
----_Rollout.Events.setEvent #docked  "print current_state as string"
--
--Rollout_A.Events.setEvent #open "format \"EventFired = % \n\" EventFired"
--Rollout_A.Events.setEvent #close "format \"EventFired = % \n\" EventFired"
--





/* CREATE DIALOG */
Dialog.create()

--clearListener()

Dialog.dock #right
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
