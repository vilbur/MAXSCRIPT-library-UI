clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/** CREATE ROLLOUTS 
 *	
 */
_Rollout = Rollout_v title:(getFilenameFile(getSourceFileName())) ini:(getFilenamePath(getSourceFileName()) + "1_RolloutEventTest.ini")

SubRollouts = _Rollout.subrollouts()

Rollout_A    = SubRollouts.new "Subrollout A"


/* CONTROLS  */
controls_A1 = Rollout_A.Controls.new groupbox:"test"
Button_A1	  = controls_A1.button "Test 1" 



/*
	CHANGE DEFAULT EVENTS

Rollout_A.RolloutEvent.Events.setDefaultEvent ( Event_v type:"onOpen"	code:	"messagebox \"Default Event onOpen\"" )
Rollout_A.RolloutEvent.Events.setDefaultEvent ( Event_v type:"onClose"	code:	"messagebox \"Default Event onClose\"" )

*/


/*
	SET CUSTOM EVENTS
*/
Rollout_A.RolloutEvent.onOpen  "messagebox \"Custom Event onOpen\""
Rollout_A.RolloutEvent.onClose "messagebox \"Custom Event onClose\""


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

SubRollouts.property height:256