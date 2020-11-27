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
		print ("ControlId.setId " + id as string )
		
		if ( this._isIdValid() ) then
		    this.id	= id
		else
			this.id	= this._getIdByConrolType()
			

		this._removeWhitespace()

		this._sanitizeId()
		
		format "id = % \n" this.id
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
		print ("ControlId._isIdValid " + (( id == unsupplied or id == undefined ) == false) as string )
		( id == unsupplied or id == undefined ) == false  --return
	),
	
	/** Use controls caption, if id is unsuplied
	 */
	function _getIdByConrolType =
	(
		print("ControlId._getIdByConrolType()")
		format "Parent_Control.caption = % \n" Parent_Control.caption
		Parent_Control.caption + "_" + Parent_Control.type as string
	),
	
	/** Set full id with rollout id
	 */
	function _setIdFull =
	(
		full	= Parent_Control.ControlBox.Parent_roll.id +"."+id -- make without Parent_roll
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
		
		this.setId id 
	)
)
