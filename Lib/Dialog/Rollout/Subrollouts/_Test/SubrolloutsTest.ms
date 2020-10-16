clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout/Rollout.ms" )


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))



Subrollouts_A = _Rollout.subrollouts()

SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"
SubRollout_A2 = Subrollouts_A.new   "Subrollout A2"


SubSubRollouts_A = SubRollout_A1.subrollouts()
SubSubRollout_A1 = SubSubRollouts_A.new   "SubSubrollout A"


Subrollouts_B = _Rollout.subrollouts()
SubRollout_B1 = Subrollouts_B.new   "Subrollout B1"

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )


_Rollout.addSubRollouts()

SubRollout_A1.addSubRollouts()