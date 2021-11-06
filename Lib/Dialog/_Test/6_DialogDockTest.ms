clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../Dialog.ms" )


Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))


/* ROLLOUT DEFINITION */

Rollouts_1 = Dialog.rollouts()

Rollout_A	= Rollouts_1.new "Subrollout A"


/* CREATE DIALOG */
Dialog.create()	-- create with default params



/* DOCKING DIALOG */

--Dialog.dock #right

--messageBox "Dialog is docked right" beep:false
--
--
--Dialog.dock #left
--
--messageBox "Dialog is docked left" beep:false
format "%" "\n"
format "%" "\n"

--Dialog.undock()

--messageBox "Dialog is undocked" beep:false

--messageBox "Dialog is docked left" beep:false
--Dialog.destroy()	