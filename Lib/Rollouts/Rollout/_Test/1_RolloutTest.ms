clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../Rollout.ms" )


/* ROLLOUT DEFINITION */
_rollout	= Rollout_v title:(getFilenameFile(getSourceFileName())) id:"optionable_id"

/* CREATE ROLLOUT */
_rollout.dialogCreate()	-- create with default parameters