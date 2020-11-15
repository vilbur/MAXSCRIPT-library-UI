/** Rollout properties
  * 
  * @method	propertySet	Set any property to rollout
  * 
 */
struct RolloutProperty_v
(
	__construct = #(#Parent_roll),
	
	/* reference */
	Parent_roll,

	/** Set any property to rollout
	  * According to Rollout Properties: https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
	  *
	  * @property	#(#name)	keys	of properties
	  * @property	#("value")	values	of properties
	 */
	function getOrSet keys values =
	(
		keys_values = this._filterUnsuppliedParameters keys values
		--format "keys_values = % \n" keys_values
		
		if( Parent_roll == undefined ) then
			return false
		
		for i=1 to keys_values.keys.count do
			if( keys_values.values[i] == #get ) then 
				keys_values.setVal (keys_values.keys[i]) (this.getProp keys_values.keys[i])
			else
				this._executeProperty keys_values.keys[i] keys_values.values[i]
				
		this._removeList keys_values --return
	),

	/** Get property
	 */
	function getProp key =
	(
		execute ( this._getPropertyString key ) --return
	),
	
	private
	
	/** Return just value if list has only 1 member
	 */
	function _removeList list =
	(
		if( list.values.count == 1 ) then 
			list.values[1] --return
		else
			list --return
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
	  *     function foo param_1: param_2: =
	  *		(
	  *			param_name_and_value = this._filterUnsuppliedParameters #(#param_1, #param_2) #(unsupplied, "value_2") 
	  *			-- return #( #(#param_2), #("value_2") )
	  * 	)
     */
    function _filterUnsuppliedParameters keys values =
    (
		keys_values = List_v()
		
		for i = 1 to values.count  where not ( values[i] == unsupplied ) do
			keys_values.setVal keys[i] values[i]

		keys_values --return
    ),
	
	/** Execute property
	  *
	  * E.G.: execute("rollout_rollout_a.height = 128")
     */
    function _executeProperty key value =
    (
		--format "RolloutProperty_v._executeProperty() % \n" ( this._getPropertyString key + " = " + this._getValue key value )
		execute ( this._getPropertyString key + " = " + this._getValue key value )
    ),
	
	/** Get property string
	  *
	  * Return string element_id.property_name
	 */
	function _getPropertyString key =
	(
		Parent_roll.getId() + "." + key as string  --return
		--Parent_roll.id + "." + key as string  --return
	),
	/** Get value
	 */
	function _getValue key value relative:false =
	(
		if( relative ) then 
			value += this._getProperty key
		
		if( classOf value == String ) then 
			value = "\"" + value + "\""
		
		value as string --return
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