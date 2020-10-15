clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout/Rollout.ms" )


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))



controls_1    = _Rollout.Controls.new "Groupbox 1"

Subrollouts_A = _Rollout.subrollouts()

_SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"
_SubRollout_A2 = Subrollouts_A.new   "Subrollout A2"


Subrollouts_B = _Rollout.subrollouts()
_SubRollout_B1 = Subrollouts_B.new   "Subrollout B1"

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )

_Rollout.addSubRollouts()