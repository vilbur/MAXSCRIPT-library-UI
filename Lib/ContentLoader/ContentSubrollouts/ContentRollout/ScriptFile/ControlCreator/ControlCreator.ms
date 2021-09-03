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
			

		this._setOnClickEvent #left _Control 
		this._setOnClickEvent #right _Control
		
	),

	/** Set events which call macro
	 */
	function _setOnClickEvent mouse_button Control =
	(
		callback = "macros.run \""+Macro.category+"\" \""+Macro.macro_name+"\""
		format "callback = % \n" callback
		if( mouse_button == #left ) then
			Control.Events.setEvent #pressed callback Macro.tooltip
		else
		
			Control.Events.setEvent #rightclick  callback Macro.tooltip
		
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