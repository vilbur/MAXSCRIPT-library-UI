clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Dialog/Dialog.ms" )



/** CREATE MENU 
 */

/* DEFINE MAIN MENU */
global Menu = Menu_v name:"ButtonRcMenu"

/* DEFINE MENU */
menu_1	= Menu.menu "Menu 1"
menu_2	= Menu.menu "Menu 2"


/** MENU ITEMS 
 */
menu_1.item "Item 1" "messagebox \"Item 1\"" id:"test_item1"


/* DEFINE SUBMENU */
submenu = menu_1.menu "Submenu"
submenu.item "Submenu Item 1"  "messagebox \"Submenu Item 1\""

/** MENU ITEMS 2
 */
menu_2.item "Item 2" "messagebox \"Item 2\""
menu_2.separator()
menu_2.item "Item 3" "messagebox \"Item 3\""


/* define rollout for menu */
rollout roll_main "Menu Test"
(
 	button bnMenu "Click here for the menu..." width:150
 	
 	on bnMenu pressed do (
 		-- use the popUpMenu command to display the RC Menu we defined earlier...
 		popUpMenu ButtonRcMenu pos:(bnMenu.pos + [145,0]) rollout:roll_main align:#align_topleft
 	)
 	
 	 --on rollout open we call the createMenu fn to define the local RCMenu
 	on roll_main open do 
	(
		Menu.create()
	)
)

/** CREATE ROLLOUT 
 *	
 */
CreateDialog roll_main