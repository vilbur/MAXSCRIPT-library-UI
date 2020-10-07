
/** Button
 */
struct EditText_v 
(
	include "Lib/Controls/Control/ControlExtends.ms"
	
	/** Value as tooltip
	 */
	function valueAsTooltip toggle =
	(
		print "------------\nEditText.valueAsTooltip()"
		if( toggle != true ) then
			return ()
		
		
		--format " Events	= % \n" Events
		format " Events	= % \n" Events.Events.getEvent #changed
		
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
	--	--print "------------\nButton._construct()"
	--	type	= #edittext
	--	name_of_value_param	= #text
	--
	--),
	--
	--__construct = this._construct()
	/** Test
	 */
	function test =
	(
		
	)
	
)
