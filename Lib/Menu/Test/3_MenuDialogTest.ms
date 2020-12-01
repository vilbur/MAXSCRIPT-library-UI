clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Dialog/Dialog.ms" )


Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))


/** CREATE MENU 
 */
Menu = Dialog.Menu 

_menu	= Menu.menu "Menu"


/*------ CREATE FLOATER DIALOG ------*/
Dialog.create()

/* CREATE DIALOG */
--CreateDialog ( _rollout.RolloutCreator.getDefinition() ) menu:(Menu.create "MainMenu")