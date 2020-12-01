filein( getFilenamePath(getSourceFileName()) + "/MenuItem.ms" )

/** Menu
 */
struct Menu_v
(
	self	= this,
	type	= "RCmenu",
	name,
	items	= #(),
	
	/** Submenu
	 */
	function menu _name =
	(
		local _menu =  Menu_v name:_name type:"submenu"
		
		this._addItem _menu
		
		_menu --return 
	),

	/** Add item to menu
	  *
	  * @param	string	title	Title of item
	  * @param	string	command	Command of item
	  * @param	string	[id]	Id of item, if empoty, then sanitized title is used
	 */
	function item title command id:"" =
	(
		this._addItem (MenuItem_v title:title command:command id:id)
	),

	/** Set separator item
	 */
	function separator =
	(
		this.item "separator" ""
	),

	/** Create
	  *
	  * @param	string|name	_name	Name of main menu, empty if submenu is created
	  * @return	RcMenu class|string	Return RcMenu for 'CreateDialog menu:RcMenu' or definition of submenu
	 */
	function create _name =
	(
		--format "Menu_v.create()\n"
		this.setName _name as string
		
		menu_def	= this._getMenuDefinition()
		subitems	= this._getDefinitionsOfMenuItems()
		commands	= this._getAllCommandsDefinitions()
		
		definition = menu_def + "\n(\n" + subitems + commands + "\n)"
		
		if( type == "RCmenu" ) then
			(execute definition) -- return if menu
		else
			definition -- return if submenu
	),
	
	/** Set name
	 */
	function setName _name =
	(
		if( _name != "" ) then
			name	= _name
	),

	/** Add item
	 */
	function _addItem item =
	(
		append items item
	),

	/** Get menu definition
	 */
	function _getMenuDefinition =
	(
		if( type == "submenu" ) then
			"\nsubMenu \"" + name + "\"" -- return
		else
			"RcMenu " + name -- return
	),
	
	/** Get definitions of items
	 */
	function _getDefinitionsOfMenuItems =
	(
		_definition	= ""
		format "items.count = % \n" items.count
		for item in items do
			_definition += item.create ""
			
		_definition -- return
	),

	/** Get all commands definitions in RcMenu
	 */
	function _getAllCommandsDefinitions =
	(
		commands	= ""
		
		if( type != "submenu" ) then
			commands	= this._getCommandDefinition()
		
		commands -- return
	),

	/** Get commands definition of items in menu
	 */
	function _getCommandDefinition =
	(
		commands	= ""
	
		for item in items do
			commands += item._getCommandDefinition()
			
		commands --return 
	)

)
