clearListener()
filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(getFilenameFile(getSourceFileName()))

/* DEFINE SLOTS FOR ROLLOUTS */ 
Rollouts_1 = _Rollout.subrollouts()
--Rollouts_2 = _Rollout.subrollouts()


/* DEFINE ROLLOUTS */ 
Rollout_A	= Rollouts_1.new "Rollout A"
--Rollout_B	= Rollouts_1.new "Rollout B"


/* DEFINE SUBROLLOUTS */ 
--Subrollouts_A = Rollout_A.subrollouts()

--SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"
--SubRollout_A2 = Subrollouts_A.new   "Subrollout A2"

/* CREATE ROLLOUT */
_Rollout.createRollout()	-- create with default parameters

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )
_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts


--format "_Rollout = % \n" _Rollout.id
--format "Subrollouts_A = % \n" Subrollouts_A.id
--format "Subrollouts_A.Parent_roll = % \n" Subrollouts_A.Parent_roll.id


_Rollout.property	height:512
Rollouts_1.property	height:320

print(Rollouts_1.getId())


/* TEST PROPERTIES */ 
--Rollout_A.property title:"Property Test" open:false height:128

--rollout_rolloutpropertytest.subrollouts_slot_1.height = 320
