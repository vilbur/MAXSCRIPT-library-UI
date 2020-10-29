clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../Dialog.ms" )


_Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))

Rollouts = _Dialog.rollouts()

rollout_A	= Rollouts.new "Rollout A"
rollout_B	= Rollouts.new "Rollout B"

/*------ CREATE FLOATER DIALOG ------*/
_Dialog.create()