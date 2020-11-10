clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))


/* DEFINE LAYOUT OF CONTROLS & ROLLOUTS */ 

/* DEFINE GROUPBOXES */ 
--controls_1    = _Rollout.Controls.new()
--controls_2    = _Rollout.Controls.new id:"Groupbox_Test"
--controls_3    = _Rollout.Controls.new groupbox:"Groupbox Test"
--
--GroupBoxes = #()

/* DEFINE CONTROLS */ 
--Controls_1.button "No Groupbox"


/** Add extra rollout
 */
function addRolloutByCodeTest =
(

	for g = 1 to 3 do
	(
		Controls    = _Rollout.Controls.new groupbox:("Groupbox " + g as string)
		
		for i = 1 to 4 do
			Controls.button ("Button A "+g as string +i as string )
	)
	
)

/*---------------------------------------
	RUN TEST
-----------------------------------------*/


addRolloutByCodeTest()


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:312

_Rollout.addSubRollouts()