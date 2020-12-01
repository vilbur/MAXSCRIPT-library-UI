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
		_menu =  Menu_v name:_name type:"submenu"
		
		this._addItem _menu
		
		return _menu
	),
	/** Add item to menu
	  * @param	string	title	Title of item
	  * @param	string	command	Command of item
	  * @param	string	[id]	Id of item, if empoty, then sanitized title is used
	 */
	function item title command id:"" =
	(
		_item =  MenuItem_v title:title command:command id:id
		this._addItem _item
	),
	/** Set separator item
	 */
	function separator =
	(
		this.item "separator" ""
	),
	/** Create
	  * @param	string|name	_name	Name of main menu, empty if submenu is created
	  * @return	RcMenu class|string	Return RcMenu for 'CreateDialog menu:RcMenu' or definition of submenu
	 */
	function create _name =
	(
		this.setName _name as string
		
		subitems	= this._getDefinitionsOfMenuItems()
		commands	= this._getAllCommandsDefinitions()
		definition 	= this._menuDefinition() + "\n(\n" + subitems + commands + "\n)"
		
		if( type=="RCmenu" ) then
			return (execute definition)
		else
			return definition
	),
	/** Set name
	 */
	function setName _name =
	(
		if( _name!="" ) then
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
	function _menuDefinition =
	(
		if( type=="submenu" ) then
			return "\nsubMenu \"" + name + "\""
		else
			return "RcMenu " + name
	),
	
	/** Get definitions of items
	 */
	function _getDefinitionsOfMenuItems =
	(
		definition	= ""
		
		for item in items do
			definition += item.create ""
			
		return definition
	),
	/** Get all commands definitions in RcMenu
	 */
	function _getAllCommandsDefinitions =
	(
		commands	= ""
		
		if( type!="submenu" ) then
			commands	= this._getCommandDefinition()
		
		return commands
	),
	/** Get commands definition of items in menu
	 */
	function _getCommandDefinition =
	(
		commands	= ""
	
		for item in items do
			commands += item._getCommandDefinition()
			
		return commands
	),

	function test =
	(
		messagebox "Menu.test()"
	)

)
