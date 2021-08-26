clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../Dialog.ms" )


/* CREATE DIALOG */

Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))

Dialog.create()	-- create with default params




/* TEST METHODS */

Dialog.position 0 0


Dialog.width  1024
Dialog.height 256