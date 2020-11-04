/** Rollout properties
  * 
  * @method	propertySet	Set any property to rollout
  * 
 */
struct RolloutProperty_v
(
	__construct = #(),
	
	/* reference */
	Parent_roll,

	/** Set any property to rollout
	  * According to Rollout Properties: https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
	  *
	  * @property	#(#name)	keys	of properties
	  * @property	#("value")	values	of properties
	 */
	function propertySet keys values =
	(
		params_keys_and_values = this._filterUnsuppliedParameters keys values
		
		for i = 1 to params_keys_and_values[1].count do
            this._executeProperty params_keys_and_values[1][i] params_keys_and_values[2][i]
	),
	
	private
	
	/** Filter unsupplied parameters
	  * Return only supplied parameters
	  *
	  * @param	array _parameters_names array of keys
	  * @param	array _parameters_names array of values
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
    function _filterUnsuppliedParameters _parameters_names _parameters =
    (
		result = #(#(), #())
		
		for i = 1 to _parameters.count  where not ( _parameters[i] == unsupplied ) do
		(
			append result[1] _parameters_names[i]
			append result[2] _parameters[i]
		)
		result --return
    ),
	
	/** Execute property
     */
    function _executeProperty key value =
    (
		execute ( this._getPropertyString key + " = " + this._getValue key value )
    ),
	
	/** Get property string
	  *
	  * Return string element_id.property_name
	 */
	function _getPropertyString key =
	(
		--Parent_roll.getId() + "." + key as string  --return
		Parent_roll.id + "." + key as string  --return
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
	/** Get property
	 */
	function _getProperty key =
	(
		execute ( this._getPropertyString key ) --return
	),
	
	/** Get\set value of property 
	  * @param	string|name key	Name  of property E.G.: "foo_key" OR #foo_key 
	  * @param	string|#get value	Value of property
	  *
	  * @return	string|self Value or self
	  *
	  * @example this._getSetProp "foo" "bar" -- SET "bar" to property "foo"
	  * @example this._getSetProp #foo  #get  -- GET value of property "foo"
	  */
	--function _getSetProp key value =
	--(
	--	if( value != #get ) then
	--	(
	--		if( value != undefined ) then
	--			setProperty  this ( key as string ) value
	--		this --return
	--	) else
	--		getProperty this ( key as string ) --return
	--),
	
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
		--print "------------\nRolloutProperty.create()"
		
		--format "Parent_roll.getId()	= % \n" (Parent_roll.getId())
		
		this._checkConstctructProperties()
	)
	
	
)
