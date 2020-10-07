clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../Dialog.ms" )


Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))

/* ROLLOUT DEFINITION */
Rollout_A	= Dialog.roll "Subrollout A"


/* CREATE DIALOG */
Dialog.create()	-- create with default params


/* DOCKING DIALOG */
Dialog.dock #right

messageBox "Dialog is docked right" beep:false

Dialog.dock #left

messageBox "Dialog is docked left" beep:false

Dialog.undock()

messageBox "Dialog is undocked" beep:false