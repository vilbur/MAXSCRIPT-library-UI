clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Dialog/Dialog.ms" )


Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))


/** CREATE MENU 
 */
Menu_1 = Dialog.Menu.menu "Menu 1"

items	= Menu_1.item "Item 1" "messagebox \"Item 1\""

/*------ CREATE FLOATER DIALOG ------*/
Dialog.create()