clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout/Rollout.ms" )


Rollout_main = Rollout_v title:(getFilenameFile(getSourceFileName()))
Rollout_A    = Rollout_main.subrollout "Subrollout A"
Rollout_B    = Rollout_main.subrollout "Subrollout B"


/* CREATE ROLLOUT */
 Rollout_main.dialogCreate()