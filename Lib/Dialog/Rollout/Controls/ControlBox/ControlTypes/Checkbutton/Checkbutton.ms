/** Checkbutton control
 */
struct Checkbutton_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlAddToUi.ms"
	
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
	--/** Get/set value of property 
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
	
	--/** Test method
	-- */
	--function testMethod =
	--(
	--	messageBox "testMethod" beep:false
	--),
	
	--/** Construct
	-- */
	--function _construct =
	--(
	--	--print "------------\nButton._construct()"
	--	type	= #button
	--),
	/**  
	 */
	on create do
	(
		this.onCreate()
		
		if ( add_to_controls ) then
			this._addToControls()
	)
	
)