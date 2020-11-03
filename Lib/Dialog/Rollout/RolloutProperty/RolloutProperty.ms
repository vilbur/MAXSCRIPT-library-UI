/** Rollout properties
  * https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
  * 
  * @method	voidself	methodName( @par )	
  * 
  * 
  * 
  * 
 */
struct RolloutProperty_v
(
	__construct = #(),
	
	/* reference */
	Parent_roll,

	/** Set property
	  *
	  * @property	name	key	of property E.G.: #height
	  * @property	mixed	value	of property
	 */
	function _setProperty nanes values =
	(
	  param_name_and_value = this.findSuppliedParameters nanes values
	  
	  key   = param_name_and_value[1]
	  value = param_name_and_value[2]

		--print ("------------\nRolloutProperty.setProperty() " + key as string )
		execute ( this._getPropertyString key + " = " + this._getValue key value )
	),	
	
	/** Set name of rollout
	 */
	function name value =
	(
		--print ( "!!! TEST !!!" as String )
		this.setProperty #name value
	),
		
	/** Set title of rollout
	 */
	function title value =
	(
		--print ( "!!! TEST !!!" as String )
		this.setProperty #title value
	),
	
	
	/** Find supplied parameters
	  *
	  * @param	array _parameters_names array of keys
	  * @param	array _parameters_names array of values
	  *
	  * @return	array #( parameter_name, parameter_value )		
	  *
	  * @example
	  *     function foo param_1: param_2: =
	  *		(
	  *			param_name_and_value = this.findSuppliedParameters #(#param_1, #param_2) #(unsupplied, "value_2") 
	  *			-- return (#param_2, "value_2")
	  * 	)
     */
    function findSuppliedParameters _parameters_names _parameters =
    (
		for i = 1 to _parameters.count  where not ( _parameters[i] == unsupplied ) do
			return #( _parameters_names[i], _parameters[i] )
    ),
	--private


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
