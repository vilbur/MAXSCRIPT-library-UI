clearListener()

filein ( getFilenamePath(getSourceFileName()) + "/../Menu.ms" );

/** CREATE MENU 
 */

/* DEFINE MAIN MENU */
Menu = Menu_v() 

/* DEFINE MENU */
items	= Menu.menu "Item"
items_2	= Menu.menu "Item 2"


/** MENU ITEMS 
 */
items.item "Menu Item 1" "messagebox \"Item 1\"" id:"test_item1"


/* DEFINE SUBMENU */
submenu = items.menu "Submenu"
submenu.item "Submenu Item 1"  "messagebox \"Submenu Item 1\""


/** MENU ITEMS 2
 */
items_2.item "Menu Item 2" "messagebox \"Item 2\""
items_2.separator()
items_2.item "Menu Item 3" "messagebox \"Item 3\""


/* define rollout for menu */
rollout roll_main "Menu Test"
(
)

/** CREATE ROLLOUT 
 *	
 */
CreateDialog roll_main menu:(Menu.create "MainMenu")