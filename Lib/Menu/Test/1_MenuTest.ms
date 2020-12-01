clearListener()

filein ( getFilenamePath(getSourceFileName()) + "/../Menu.ms" );

/** CREATE MENU 
 */
function menuTest =
(
	/* DEFINE MAIN MENU */
	Menu = Menu_v() 
	
	/* DEFINE MENU */
	_menu	= Menu.menu "Menu"
	_menu_2	= Menu.menu "Menu 2"
	
	_menu.item "Test Item 1" "messagebox \"Item 1\"" id:"test_item1"
	_menu.separator()
	_menu.item "Test Item 2" "messagebox \"Item 2\""
	_menu.separator()
	
	/* DEFINE SUBMENU */
	submenu = _menu.menu "Submenu"
	submenu.item "Submenu Item 1"  "messagebox \"Submenu Item 1\""
	
	/* define rollout for menu */
	rollout roll_main "Menu Test"
	(
	)

	CreateDialog roll_main menu:(Menu.create "MainMenu")
)


/*---------------------------------------
	RUN TEST
-----------------------------------------*/
menuTest()
