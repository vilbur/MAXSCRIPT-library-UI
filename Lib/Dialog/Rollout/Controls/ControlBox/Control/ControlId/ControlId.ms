/** Control id
 */
struct ControlId_v
(
	__construct = #( #Parent_Control ),
	/* dependency */

	/* properties */
	Parent_Control,
	id,
	full,
	
	/** Set
	  @return	string	
	 */
	function setId id =
	(
		this.id	= id
		
		if not( this._isIdValid() ) then
			this._setIdByConrolType()

		this._removeWhitespace()

		this._sanitizeId()
		
		this._setIdFull()
	),
	
	/** Get
	 */
	function get =
	(
		id --return
	),

	private
	
	/** Is id valid
	 */
	function _isIdValid =
	(
		( id == unsupplied or id == undefined ) == false  --return
	),
	
	/** Use controls caption, if id is unsuplied
	 */
	function _setIdByConrolType =
	(
		id = Parent_Control.caption + "_" + Parent_Control.type as string
	),
	
	/** Set full id with rollout id
	 */
	function _setIdFull =
	(
		full	= Parent_Control.Parent_roll.id +"."+id -- make without Parent_roll
	),
	
	/** Sanitize id
	 */
	function _sanitizeId =
	(
		id = (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9_]+" ).Replace ( toLower(id) ) "") --return 
	),
		
	/** Replace whitespace with underscore
	 */
	function _removeWhitespace =
	(
		id = substituteString id " " "_" -- replace whitespace
	),

	/** Check if required properties are defined
	  * Names of construct props are defined in __construct array E.g.: __construct = #( #prop_name ) 
	  * @param	construct_properties this.properties required for initialization of struct
	 */
	function _checkConstctructProperties =
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),
	
	on create do
	(
		this._checkConstctructProperties()
	)
)
