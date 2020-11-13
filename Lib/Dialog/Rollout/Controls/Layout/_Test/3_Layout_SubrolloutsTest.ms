clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout.ms" )


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))

/* DEFINE SLOTS FOR ROLLOUTS */ 
Rollouts_1 = _Rollout.subrollouts()
--Rollouts_2 = _Rollout.subrollouts()


/* DEFINE ROLLOUTS */ 
Rollout_A	= Rollouts_1.new "Rollout A"
Rollout_B	= Rollouts_1.new "Rollout B"


/* DEFINE SUBROLLOUTS */ 
--Subrollouts_A = Rollout_A.subrollouts()

--SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"
--SubRollout_A2 = Subrollouts_A.new   "Subrollout A2"


/** Add extra rollout
 */
function addRolloutByCodeTest Rollouts =
(
	
	for _Rollout in Rollouts do 
		for g = 1 to 3 do
		(
			Controls    = _Rollout.Controls.new groupbox:("Groupbox " + g as string)
			
			for i = 1 to 4 do
				Controls.button ("Button "+g as string +"."+i as string )
		)
		
)

addRolloutByCodeTest #(Rollout_A, Rollout_B)


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:512 height:512

/* ADD SUBROLLOUTS */ 
_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

_Rollout.fitSubrollouts()