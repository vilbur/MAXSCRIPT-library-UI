clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../Dialog.ms" )


_Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))

Rollouts = _Dialog.rollouts()

rollout_A	= Rollouts.new "Rollout A"
--rollout_B	= Rollouts.new "Rollout B"


Subrollouts_A = rollout_A.subrollouts()

SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"
--SubRollout_A2 = Subrollouts_A.new   "Subrollout A2"
--
--
--SubSubRollouts_A = SubRollout_A1.subrollouts()
--SubSubRollout_A1 = SubSubRollouts_A.new   "SubSubrollout A"


--Subrollouts_B = _Rollout.subrollouts()
--SubRollout_B1 = Subrollouts_B.new   "Subrollout B1"



/*------ CREATE FLOATER DIALOG ------*/
_Dialog.create()