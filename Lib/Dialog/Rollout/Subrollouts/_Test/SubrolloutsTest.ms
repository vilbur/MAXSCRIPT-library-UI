clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout/Rollout.ms" )


_Rollout = Rollout_v title:(getFilenameFile(getSourceFileName()))
Rollout_A    = _Rollout.subrollout "Subrollout A"
Rollout_B    = _Rollout.subrollout "Subrollout B"


/* CREATE ROLLOUT */
_Rollout.createRollout()	-- create with default parameters

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )

/* ADD SUBROILLOUTS */
_Rollout.addSubRollouts()