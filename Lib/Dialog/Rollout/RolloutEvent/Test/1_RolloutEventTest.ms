clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/** CREATE ROLLOUTS 
 *	
 */
_Rollout = Rollout_v title:(getFilenameFile(getSourceFileName())) ini:(getFilenamePath(getSourceFileName()) + "1_RolloutEventTest.ini")

SubRollouts = _Rollout.subrollouts()

Rollout_A    = SubRollouts.new "Subrollout A"

--format "Rollout_A = % \n" Rollout_A
--/* CONTROLS  */
--Controls_1    = Rollout_A.Controls.new groupbox:"Groupbox 2"
--Button_A1	  = Controls_1.button "Test 1" 


/*
	CHANGE DEFAULT EVENTS

Rollout_A.Events.Events.setDefaultEvent ( Event_v type:"onOpen"	code:	"messagebox \"Default Event onOpen\"" )
Rollout_A.Events.Events.setDefaultEvent ( Event_v type:"onClose"	code:	"messagebox \"Default Event onClose\"" )

*/


/*
	SET CUSTOM EVENTS
*/
Rollout_A.Events.setEvent #onOpen  "format \"EventFired = % \n\" EventFired"
Rollout_A.Events.setEvent #onClose "format \"EventFired = % \n\" EventFired"



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts