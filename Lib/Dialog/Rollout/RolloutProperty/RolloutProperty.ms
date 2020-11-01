

/** Rollout properties
  * https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
  *
 */
struct RolloutProperty_v
(
	__construct = #(),
	
	/* reference */
	Parent_roll,
	
	
	/** Height
	 */
	function title value =
	(
		--print ( "!!! TEST !!!" as String )
		this._setProperty #title value
	),
	
	
	--property_keys	=  #(#width, #height, #pos),
	--include "Library/_UI/Lib/Property/PropertyMethods.ms"
	
	--private

	--/** _call setters
	-- */
	--function _callProperty property value relative =
	--(
	--	--print ("------------\nDialogProperty._callProperty #" + property as string)
	--	Parent_roll.setProp	property value relative 
	--),
	
	--public

	--private

	/** Set property
	  *
	  * @property	name	key	of property E.G.: #height
	  * @property	mixed	value	of property
	 */
	function _setProperty key value =
	(
		--print ("------------\nRolloutProperty._setProperty() " + key as string )
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
