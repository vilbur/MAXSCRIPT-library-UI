clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Dialog/Dialog.ms" )


Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))


/** CREATE MENU 
 */
Menu = Dialog.Menu 

Menu.menu "Menu"

/*------ CREATE FLOATER DIALOG ------*/
Dialog.create()