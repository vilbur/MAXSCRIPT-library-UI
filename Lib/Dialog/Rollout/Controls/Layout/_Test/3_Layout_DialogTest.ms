clearListener()

--filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout.ms" )
filein( getFilenamePath(getSourceFileName()) + "/../../../../Dialog.ms" )

Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))

Rollouts = Dialog.rollouts()

rollout_A	= Rollouts.new "Rollout A"
rollout_B	= Rollouts.new "Rollout B"
Controls_A	= rollout_A.controls.new groupbox:"Rollout Controls A"

Controls_A.button "Test"


/*------ CREATE FLOATER DIALOG ------*/
Dialog.create()