
/** Menu item_v
 */
struct MenuItem_v
(
	id,
	title,
	command,
	
	/** Create
	  * @param	string	void	Empty parameter, must be present because method definition should match with Menu_v.create
	  * @return string Definition of menu item
	 */
	function create void =
	(
		this.setId()
		
		if( title=="separator" ) then 
			return "\n	separator sep"+( (random 1 1000000000) as string )
		
		return "\n	menuItem " + id + " \"" + title + "\""
	),
	/** Get command definition 
	 */
	function _getCommandDefinition =
	(
		if( title=="separator" or command=="" ) then 
			return ""
		
		return "\n	on "+id+" picked do " + command  
	),
	/** Get id
	 */
	function setId =
	(
		if( id=="" ) then
			id = ( dotnetObject "System.Text.RegularExpressions.Regex" @"\s+" ).Replace ( toLower title ) "_";
	),
	function test =
	(
		messagebox "MenuItem_v.test()"
	)
)