clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout/Rollout.ms" )


Rollout_main = Rollout_v title:(getFilenameFile(getSourceFileName()))
Rollout_A    = Rollout_main.subrollout "Subrollout A"
Rollout_B    = Rollout_main.subrollout "Subrollout B"


/* CREATE ROLLOUT */
Rollout_main.createRollout()	-- create with default parameters

/* CREATE DIALOG */
CreateDialog ( Rollout_main.RolloutCreator.getDefinition() ) height:256

/* ADD SUBROILLOUTS */
Rollout_main.Subrollouts.addSubRollouts (Rollout_main.id)