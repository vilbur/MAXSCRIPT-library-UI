/** Control creator
 */
struct ControlCreator_v
(
	__construct = #(  ),
	
	/* required */
	ControlBox,
	Macro,
	
	/* dependency */
	/* reference */
	/* properties */
	/** Create Control in Controls
	  *
	  * 
	 */
	function createControl =
	(
		format "\nControlCreator_v.createControl = % \n" Macro
		
		--control_id	= this.getControlId()
		--_Control	= ControlBox.get ( control_id )
		--
		--
		--Control_type = if( Macro.params.getVal #type != undefined ) then
		--(
		--	Control_type = (Macro.params.getVal #type) as name
		--	Macro.params.delete Control_type
		--	Control_type
		--)
		-- else
		--	#button
		--
		--format "Macro.params = % \n" Macro.params
		--
		--
		
		Control_type = Macro.getType()
		Macro.getId()
		Macro.getParams()
		
		_Control = Control_v type:(Macro.getType()) id:(Macro.getId()) caption:Macro.buttontext ControlBox:ControlBox init_parameters:(Macro.getParams())
		format "_Control = % \n" _Control
		
		--if( tooltip != undefined ) then 
		--	_Control.tooltip = ""
		--	
		--if( _Control == undefined ) then
		--(
		--	_Control	= ControlBox.button ( Macro.buttontext as string ) id:control_id
		--	this._setOnClickEvent #left _Control 
		--)
		--else
		--	this._setOnClickEvent #right _Control
			
	),

	/** Set leftClick
	 */
	function _setOnClickEvent mouse_button Control =
	(
		callback = "macros.run \""+Macro.category+"\" \""+name+"\""

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
		--this._checkConstctructProperties()
		--format "ControlCreator_v.onCreate() % \nMacroScriptParsed = % \n\n" ControlBox Macro
		
		this.createControl()
	)
	
)
