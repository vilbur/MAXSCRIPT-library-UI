clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../Dialog.ms" )


_Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))

/* DEFINE SLOTS FOR ROLLOUTS */ 
Rollouts_1 = _Dialog.rollouts()
Rollouts_2 = _Dialog.rollouts()


/* DEFINE ROLLOUTS */ 
Rollout_A	= Rollouts_1.new "Rollout A"
Rollout_B	= Rollouts_1.new "Rollout B"
Rollout_C	= Rollouts_2.new "Rollout C"


/* DEFINE SUBROLLOUTS */ 
Subrollouts_A = Rollout_A.subrollouts()

SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"
SubRollout_A2 = Subrollouts_A.new   "Subrollout A2"


/*------ CREATE FLOATER DIALOG ------*/
_Dialog.create()