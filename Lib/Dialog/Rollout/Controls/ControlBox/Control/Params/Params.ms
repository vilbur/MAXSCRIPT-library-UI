/** Control Params http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_EA37E7DB_1E74_4377_B3D8_EDAE19CE27E7_htm
  * 
  * Params_v is for store, get and set parameters of control
  * 
 */
struct Params_v
(
	--__construct = #(#Parent_Control),
	
	/* reference */
	keys	= #(), -- array used in List_v
	values	= #(), -- array used in List_v
	
	List	= List_v keys:keys values:values,

	/** Set values
	 */
	function setValues _keys _values =
	(
		keys_values = this._filterUnsuppliedParameters _keys _values

		for key in keys_values.keys do
			this.setVal key (keys_values.getVal key)
	),
		
	/** Set parameter to rollout
	  * According to Rollout Properties: https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
	  
	 */
	function setVal key val =
	(
		--format "Params_v.setVal % %\n" (key as string) (val)
		List.setVal key val -- return
	),
	
	/** Get val
	 */
	function getVal key =
	(
		List.getVal key   -- return
	),
	
	/** Delete
	 */
	function delete key =
	(
		List.delete key   -- return
	),
	
	/** Join array
	 */
	function join =
	(
		--print "\nHOTFIX Params_v.join()"
		_params = ""
		
		for k=1 to List.keys.count do
			_params = _params + " " + List.keys[k] +":"+ this._getFormat List.values[k]

		_params --return
	),
	
	/** Format value to string
	  *
	  * @return	string	
	 */
	function _getFormat val =
	(
		--print ("Params_v._getFormat() " + val as string)
		if( classOf val == name ) then
			val = "#" + val as string -- Add "#" prefix to name
		
		else if( classOf val == string ) then
			val = "\"" + val +"\"" -- Wrap string to escaped qoutes \"\"
		
		val as string --return
	),
	
	/** Filter unsupplied parameters
	  * Return only supplied parameters
	  *
	  * @param	array keys array of keys
	  * @param	array keys array of values
	  *
	  * @return	matrix #( #(parameter_names), #(parameter_values ))		
	  *
	  * @example
	  *		param_name_and_value = this._filterUnsuppliedParameters #(#param_1, #param_2) #(unsupplied, "value_2") 
	  *		-- return #( #(#param_2), #("value_2") )
     */
    function _filterUnsuppliedParameters keys values =
    (
		keys_values = List_v()
		
		for i = 1 to values.count  where not ( values[i] == unsupplied ) do
			keys_values.setVal keys[i] values[i]

		keys_values --return
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
		--this._checkConstctructProperties()
		--format "Params_v.onCreate()"
	)
)