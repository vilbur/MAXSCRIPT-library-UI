/** Checkbox
 */
struct Checkbox_v
(
	include "Library/_UI/Lib/Controls/Control/ControlExtends.ms"

	checked,

	/** Toggle checkbox
	 */
	function toggle =
	(
		--print "------------\nCheckbox.toggle()"
		current_state = this.prop.get #state
		--format " current_state	= % \n" current_state
		this.prop.add #state ( not current_state )
	),
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	--/** Sanitize parameters by specific control type
	--  *
	--  * This method must be in all structs which include "ControlExtends.ms"
	-- */
	--function _sanitizeParametersByControlType =
	--(
	--	
	--),
	
	--/** Get\set value of property 
	--  * @param	string|name key	Name  of property E.G.: "foo_key" OR #foo_key 
	--  * @param	string|#get value	Value of property
	--  *
	--  * @return	string|self Value or self
	--  *
	--  * @example this._getSetProp "foo" "bar" -- SET "bar" to property "foo"
	--  * @example this._getSetProp #foo  #get  -- GET value of property "foo"
	--  *
	--  */
	--function _getSetProp key value =
	--(
	--	if( value != #get ) then
	--	(
	--		setProperty  this ( key as string ) value
	--		this --return
	--	) else
	--		getProperty this ( key as string ) --return
	--),
	--/** Construct
	-- */
	--function _construct =
	--(
	--	--print "------------\nCheckbox._construct()"
	--	type	= #checkbox
	--	name_of_value_param	= #checked
	--),
	
	--__construct = this._construct()
	/** Test
	 */
	function test =
	(
		
	)
	
)
