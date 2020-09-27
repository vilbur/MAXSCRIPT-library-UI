clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../Dialog.ms" )


Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))


rollout_A	= Dialog.roll "Subrollout A"
rollout_B	= Dialog.roll "Subrollout B"

/*------ CREATE FLOATER DIALOG ------*/
Dialog.create()