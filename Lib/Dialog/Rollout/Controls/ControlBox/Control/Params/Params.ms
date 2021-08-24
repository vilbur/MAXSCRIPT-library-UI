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

	/** Set any property to rollout
	  * According to Rollout Properties: https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
	  *
	  * @property	#(#name)	keys	of properties
	  * @property	#("value", #get)	values	of properties, to get values set value to #get
	 */
	function getOrSet keys values =
	(
		keys_values = this._filterUnsuppliedParameters keys values
		--format "Params_v.getOrSet %\n" keys_values as string

		for key in keys_values.keys do
			this._replaceCurrentOrNewValue keys_values key
		--format "keys_values = % \n" keys_values
		keys_values.filter undefined test:false -- remove undefined items
			
		keys_values.getValues() -- return
	),
	
	/** _replace current or new value
	 */
	function _replaceCurrentOrNewValue &keys_values key =
	(
		--format "Params_v._replaceCurrentOrNewValue %\n" key as string
		--format "keys_values.getVal key = % \n" (keys_values.getVal key)
		value_curernt_or_new = this._getOrSetValue key (keys_values.getVal key)
		--value_curernt_or_new = keys_values.getVal key
		--format "value_curernt_or_new = % \n" value_curernt_or_new
		keys_values.setVal key value_curernt_or_new
	),
	
	/** _get or set value
	 */
	function _getOrSetValue key value =
	(
		--format "Params_v._getOrSetValue % %\n" (key as string) (value)
		if( value == #get ) then 
			List.getVal key   -- return
		else
			List.setVal key value -- return
	),
		
	/** Set val
	 */
	function setVal key value =
	(
		List.setVal key value -- return
		--format "Params_v.setVal values = % \n" values as string
	),
	
	/** Get val
	 */
	function getVal key =
	(
		--format "Params_v.getVal key = % \n" key as string
		--format "values = % \n" values
		--format "Params_v.getVal key = % \n" (List.getVal key)
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
		--print "HOTFIX Params_v.join()"
		_params = ""
		
		for k=1 to List.keys.count do
			_params = _params + " " + List.keys[k] +":"+ this._getFormat List.values[k]
		
		--format "Params_v.join %\n" _params
		--format "keys   = % \n" keys
		--format "values = % \n" values
		_params --return
	),
	
	/** Get format of value to string
	  *
	  * Add "#" prefix to name
	 */
	function _getFormat value =
	(
		if( classOf value == name ) then
			value = "#" + value as string --return
		
		value as string --return
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