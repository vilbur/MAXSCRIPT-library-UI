/** [ Wrapper for RolloutCreator ](http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_5FC5036F_E2D7_46C9_9AFA_7B3550B9F254_htm)
 *
 */
struct RolloutCreator_v
(
	__construct = #( #id, #title ),
	/* required */
	id,
	title,

	/* options */
	
	_rolloutCreator,
	
	definition = " ", -- used in "rolloutCreator.addText( definition )", !!! NOTE: empty string must has whitespace, otherwise is threated as undefined 

	public	
	/** Add subrollout slot
	 */
	function addSubrolloutSlot slot_string =
	(
		--format "RolloutCreator_v.addSubrolloutSlot %\n" slot_string
		_rolloutCreator.addText( slot_string )
	),
	
	/** Add control
	 */
	function addControl type id caption paramStr =
	(
		_rolloutCreator.addControl type id caption paramStr:paramStr
	),
	
	/** Add text
	 */
	function addText text =
	(
		--format "RolloutCreator_v.addText %\n" text
		_rolloutCreator.addText( text )
	),
	
	/** Add Event handlers
	 */
	function addhandler control_id Event =
	(
		_rolloutCreator.addhandler control_id Event.type codeStr:Event.code  paramStr:Event.params
	),
	
	/** 
	 */
    function getDefinition =
	(
		format "_rolloutCreator = % \n" _rolloutCreator
		_rolloutCreator.def --return
	),

	/** 
	 */
	function end =
	(
		--format "RolloutCreator_v.end %\n" id
		_rolloutCreator.end()
	),

	
	/*------------------------------------------------------------------------------
		CONSTRUCT
	--------------------------------------------------------------------------------*/
	private
	
	/** Check if properties in __construct are defined when an instance of the struct is created.
	  * @example __construct = #( #property_name ) 
	 */
	function _checkConstctructProperties =
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),
	/**  
	 */
	on create do
	(
		this._checkConstctructProperties()
		
		_rolloutCreator = rolloutCreator id title
		
		_rolloutCreator.begin()
	)

)