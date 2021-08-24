clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout/Rollout.ms" )


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))

/* DEFINE SLOTS FOR ROLLOUTS */ 
Rollouts_1 = _Rollout.subrollouts()
Rollouts_1.height = 256

--format "Rollouts_1 = % \n" Rollouts_1
--Rollouts_2 = _Rollout.subrollouts()



/* DEFINE ROLLOUTS */ 
Rollout_A	= Rollouts_1.new "Rollout A"

Rollout_B	= Rollouts_1.new "Rollout B"


--/* DEFINE SUBROLLOUTS */ 
Subrollouts_A = Rollout_A.subrollouts()

SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"
SubRollout_A2 = Subrollouts_A.new   "Subrollout A2"


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) height:512 

/* ADD SUBROLLOUTS */ 
_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts