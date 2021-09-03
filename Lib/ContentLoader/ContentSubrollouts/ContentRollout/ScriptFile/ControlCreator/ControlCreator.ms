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
		format "\nControlCreator_v.createControl = % \n" Macro

		if ((_Control = ControlBox.get(Macro.getId())) == undefined ) then
			_Control = Control_v type:(Macro.getType()) id:(Macro.getId()) caption:Macro.buttontext ControlBox:ControlBox init_parameters:(Macro.getParams())

		--if( Macro.tooltip != undefined ) then 
		--	_Control.setParam #tooltip Macro.tooltip
			

		--this._setOnClickEvent #left _Control 
		--this._setOnClickEvent #right _Control
		
		event_type = _Control.Events.Events.event_types[1]
		format "event_type = % \n" event_type
		this._setOnClickEvent event_type _Control
		
	),

	/** Set events which call macro
	 */
	function _setOnClickEvent event_type Control =
	(
		callback = "macros.run \""+Macro.category+"\" \""+Macro.macro_name+"\""
		format "callback = % \n" callback
		--if( event_type == #left ) then
			Control.Events.setEvent event_type callback Macro.tooltip
		--else
		--
		--	Control.Events.setEvent #rightclick  callback Macro.tooltip
		
		Control --return
	),

	private
	
	/**  
	 */
	on create do
	(
		this.createControl()
	)
	
)