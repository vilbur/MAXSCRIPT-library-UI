clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Dialog/Rollout/Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(getFilenameFile(getSourceFileName()))

/* DEFINE SLOTS FOR ROLLOUTS */ 
Rollouts_1 = _Rollout.subrollouts()
--Rollouts_2 = _Rollout.subrollouts()


/* DEFINE ROLLOUTS */ 
Rollout_A	= Rollouts_1.new "Rollout A"

/* DEFINE SUBROLLOUTS */ 
Subrollouts_A = Rollout_A.subrollouts()

SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"

/* CREATE ROLLOUT */
_Rollout.createRollout()	-- create with default parameters

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )
_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts



/*
	TEST PROPERTIES
*/ 
_Rollout.property	#height 512
Rollouts_1.property	#height 500
Rollout_A.property	#height 400
Subrollouts_A.property	#height 300


SubRollout_A1.property #title	"Renamed"
SubRollout_A1.property #open	false