clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../Dialog.ms" )


Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))

Rollouts = Dialog.rollouts()

rollout_A	= Rollouts.new "Rollout A"
rollout_B	= Rollouts.new "Rollout B"

/*------ CREATE FLOATER DIALOG ------*/
Dialog.create()