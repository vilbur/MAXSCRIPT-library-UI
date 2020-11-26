/** Rollout properties
  * 
  * @method	propertySet	Set any property to rollout
  * 
 */
struct Properties_v
(
	__construct = #(#Parent_Control),
	
	/* reference */
	
	Parent_Control,
	
	keys	= #(),
	values	= #(),
	
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
		--format "Properties_v.getOrSet %\n" (Parent_Control.getId() + "." + keys_values.values[1] as string)

		if( Parent_Control == undefined ) then
			return false
		
		for key in keys_values.keys do
			this._replaceCurrentOrNewValue keys_values key
		
		keys_values.filter undefined test:false -- remove undefined items
			
		keys_values.getValues() -- return
	),
	
	/** _replace current or new value
	 */
	function _replaceCurrentOrNewValue &keys_values key =
	(
		value_curernt_or_new = this._getOrSetValue key (keys_values.getVal key)
		
		keys_values.setVal key value_curernt_or_new
	),
	
	/** _get or set value
	 */
	function _getOrSetValue key value =
	(
		if( value == #get ) then 
			this._getValue	key       -- return
		else
			this._setValue	key value -- return
	),	
	
	/** _get or set value
	 */
	function _getValue key =
	(
		--format "Properties_v._getValue (%)\n" key
		--List.setVal key 256 -- return
			
		if ( Parent_Control.exists() ) then
			this._getProperty key -- return
		else
			List.getVal key   -- return
	),
	
	/** _get or set value
	 */
	function _setValue key value =
	(
		--format "Properties_v._setValue (% %)\n" key value
		if ( Parent_Control.exists() ) then
			this._setProperty key value -- return
		else
			List.setVal key value -- return
	),	

	/** Join array
	 */
	function join =
	(
		print "Properties_v.join()"
		_params = ""
		
		for k=1 to List.keys.count do
			_params = _params + " " + List.keys[k] +":"+ List.values[k] as string
		
		format " _params	= % \n" _params
		_params --return
	),
	
	private

	/** Get property
	  *
	  * E.G.: execute("rollout_rollout_a.height")
     */
    function _getProperty key =
    (
		--format "Properties_v._getProperty (%)" key
		--format "Properties_v._setProperty() % \n" ( this._getPropertyString key + " = " + this._getValue key value )
		execute ( this._getPropertyString key )
    ),
	
	/** Set property
	  *
	  * E.G.: execute("rollout_rollout_a.height = 128")
     */
    function _setProperty key value =
    (
		--format "Properties_v._setProperty() % \n" ( this._getPropertyString key + " = " + this._getValue key value )
		execute ( this._getPropertyString key + " = " + this._getValueString key value )
    ),

	/** Get property string
	  *
	  * Return string element_id.property_name
	 */
	function _getPropertyString key =
	(
		--format "Properties_v._getPropertyString %" (Parent_Control.getId() + "." + key as string)
		Parent_Control.getId() + "." + key as string  --return
		--Parent_Control.id + "." + key as string  --return
	),
	/** Get value
	 */
	function _getValueString key value relative:false =
	(
		if( relative ) then 
			value += this._getProperty key
		
		if( classOf value == String ) then 
			value = "\"" + value + "\""
		
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
		this._checkConstctructProperties()
	)
)