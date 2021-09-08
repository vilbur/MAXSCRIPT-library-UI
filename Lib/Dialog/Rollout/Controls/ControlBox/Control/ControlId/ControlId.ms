/** Control id
 */
struct ControlId_v
(
	__construct = #( #Parent_Control, #id ),
	
	/* required properties */
	id,
	/* dependency */
	Parent_Control,

	/* properties */
	--full,
	
	/** Set
	  @return	string	
	 */
	function setId =
	(
		--print("ControlId.setId()")

		if not ( this._isIdValid() ) then
		(
			id	= this._getIdByConrolType()
			
			
			this._removeWhitespace()
			
			this._addPrefix()
			
		)
		--else
		this._sanitizeId()
		--format "id = % \n" id
		--this._setIdFull()
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
		--print ("ControlId._isIdValid " + (( id == unsupplied or id == undefined ) == false) as string )
		( id == unsupplied or id == undefined ) == false  --return
	),
	
	/** Use controls caption, if id is unsuplied
	 */
	function _getIdByConrolType =
	(
		--print("ControlId._getIdByConrolType()")
		Parent_Control.caption + "_" + Parent_Control.type as string
	),
	
	--/** Set full id with rollout id
	-- */
	--function _setIdFull =
	--(
	--	full	= Parent_Control.ControlBox.Parent_roll.id +"."+id -- make without Parent_roll
	--),
	
	/** Sanitize id
	 */
	function _sanitizeId =
	(
		--id = (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9_]+" ).Replace ( toLower(id) ) "") --return 
		id = ( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9_]+" ).Replace ( id ) ""  --return 
		id = ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_]+"           ).Replace ( id ) "_"  --return 
	),
		
	/** Replace whitespace with underscore
	 */
	function _removeWhitespace =
	(
		id = substituteString id " " "_" -- replace whitespace
	),
	
	/** _add prefix
	 */
	function _addPrefix =
	(
			--print ( toUpper Parent_Control.type as string )
		--if( Parent_Control != undefined ) then
		id = toUpper ( Parent_Control.type as string ) + "_" + id
		--id += "XXX"	
			--format "TEST_ID = % \n" TEST_ID
	),
	
	--/** Check if required properties are defined
	--  * Names of construct props are defined in __construct array E.g.: __construct = #( #prop_name ) 
	--  * @param	construct_properties this.properties required for initialization of struct
	-- */
	--function _checkConstctructProperties =
	--(
	--	for prop in __construct where getProperty this prop == undefined do
	--		messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	--),
	
	on create do
	(
		--print ("ControlId.onCreate " + id as string )
		--this._checkConstctructProperties()
		
		this.setId()
	)
)
