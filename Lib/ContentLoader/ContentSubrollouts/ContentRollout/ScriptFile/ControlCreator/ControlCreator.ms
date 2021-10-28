
global CONTROLBOX_CONTROL_CREATOR = undefined

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
		--format "ControlCreator_v.createControl Macro	= % \n" Macro
		--format "Macro.tooltip	= % \n" Macro.toolTip
		CONTROLBOX_CONTROL_CREATOR = ControlBox

		ControlBox.add_to_controls = false
		
		params = substituteString (Macro.getParams())  "'" "\""
		
		
		_Control =  execute ( "CONTROLBOX_CONTROL_CREATOR." +(Macro.getType())+" \""+Macro.buttontext+"\" id:#" +(Macro.getControlId())+" "+params+"  add_to_controls:false" )
		
		_Control_Exist = ControlBox.get(_Control.id.id)
		
		if( _Control_Exist != undefined ) then
			_Control = _Control_Exist -- update existing control
		
		_Control = this._setControlEvent _Control _Control_Exist

		
		if not( _Control == _Control_Exist ) then -- add only new control
			ControlBox.add _Control
	),

	private
	
	/** Set control event
	  *
	  * @return	#event_type	E.G.: #pressed|#righclick|#selected
	 */
	function _setControlEvent _Control _Control_Exist =
	(
		--format "ControlCreator_v._setControlEvent _Control	= % \n" _Control
		--format "ControlCreator_v._setControlEvent _Control_Exist	= % \n" _Control_Exist

		event_type = Macro.getParam "event"

		if( event_type == undefined ) then
		(
			event_type_index = if (_Control == _Control_Exist) then 2 else 1
			--format "event_type_index	= % \n" event_type_index
			--format "_Control.Events.Events.event_types	= % \n" _Control.Events.Events.event_types
			event_type = _Control.Events.Events.event_types[event_type_index]
		)
		--format "event_type	= % \n"( event_type as name)
		--format "classOf event_type	= % \n" (classOf event_type)
		this._setOnClickEvent (event_type as name) _Control
		
		_Control --return
	),
	
	/** Set events which call macro
	 */
	function _setOnClickEvent event_type Control =
	(
		--format "ControlCreator_v._setOnClickEvent event_type	= % \n" event_type
		callback = "macros.run \""+Macro.category+"\" \""+Macro.macro_name+"\""

		Control.Events.setEvent event_type callback Macro.toolTip
	),

	/**  
	 */
	on create do
	(
		this.createControl()
	)
	
)


