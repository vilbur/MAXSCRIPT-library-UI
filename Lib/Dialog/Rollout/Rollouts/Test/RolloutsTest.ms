clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(getFilenameFile(getSourceFileName())) id:"rollout_test"

/* CREATE ROLLOUT */
_Rollout.createRollout()	-- create with default parameters

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )


Rollout_get = ROLLOUTS.get "rollout_test"

format "Rollout_get	= % \n" Rollout_get
