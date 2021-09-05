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
		--format "\nControlCreator_v.createControl = % \n" Macro
		_Control = ControlBox.get(Macro.getControlId())
		format "Macro.getParams() = % \n" (Macro.getParams()) 
		control_exists = ( _Control != undefined )
		
		 if ( control_exists==false ) then
			_Control = Control_v type:(Macro.getType()) id:(Macro.getControlId()) caption:Macro.buttontext ControlBox:ControlBox init_parameters:(Macro.getParams())
	
		event_type_index = if (control_exists==true) then 2 else 1

		event_type = _Control.Events.Events.event_types[event_type_index]

		this._setOnClickEvent event_type _Control
	),

	/** Set events which call macro
	 */
	function _setOnClickEvent event_type Control =
	(
		callback = "macros.run \""+Macro.category+"\" \""+Macro.macro_name+"\""

		Control.Events.setEvent event_type callback Macro.tooltip
	),

	private
	
	/**  
	 */
	on create do
	(
		this.createControl()
	)
	
)