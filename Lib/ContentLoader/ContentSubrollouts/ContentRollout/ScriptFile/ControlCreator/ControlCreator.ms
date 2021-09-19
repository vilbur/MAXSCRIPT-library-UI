
global CONTROLBOX_CONTROL_TYPES = undefined

/** Control creator
 */
struct ControlCreator_v
(
	__construct = #(  ),
	
	/* required */
	ControlBox,
	Macro,
	
	/** Create Control in Controls
	  *
	  * 
	 */
	function createControl =
	(
		CONTROLBOX_CONTROL_TYPES = ControlBox

		ControlBox.add_to_controls = false

		_Control =  execute ( "CONTROLBOX_CONTROL_TYPES." +(Macro.getType())+" \""+Macro.buttontext+"\" id:#" +(Macro.getControlId())+" "+Macro.getParams()+"  add_to_controls:false" )
		
		_Control_Exist = ControlBox.get(_Control.id.id)

		if( _Control_Exist != undefined ) then
			_Control = _Control_Exist -- update existing control

		this._setControlEvents _Control _Control_Exist 
		
		if not( _Control == _Control_Exist ) then -- add only new control
			ControlBox.add _Control
	),

	/** Set events which call macro
	 */
	function _setOnClickEvent event_type Control =
	(
		callback = "macros.run \""+Macro.category+"\" \""+Macro.macro_name+"\""

		Control.Events.setEvent event_type callback Macro.tooltip
	),

	private
	
	/** Set control events
	 */
	function _setControlEvents _Control _Control_Exist =
	(
		event_type_index = if (_Control == _Control_Exist) then 2 else 1
		
		event_type = _Control.Events.Events.event_types[event_type_index]
		
		this._setOnClickEvent event_type _Control
	),
	
	
	/**  
	 */
	on create do
	(
		this.createControl()
	)
	
)

