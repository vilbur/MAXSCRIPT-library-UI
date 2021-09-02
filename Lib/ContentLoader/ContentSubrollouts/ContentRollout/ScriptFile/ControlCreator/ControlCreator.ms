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
		format "\nControlCreator_v.createControl = % \n" Macro.category
		
		--print "MacroScript.createControl()"
		control_id	= this.getControlId()
		_Control	= ControlBox.get ( control_id )
		
		
		Control_type = if( Macro.params.getVal #type != undefined ) then
		(
			Control_type = (Macro.params.getVal #type) as name
			Macro.params.delete Control_type
			Control_type
		)
		 else
			#button
	
		format "Macro.params = % \n" Macro.params
		
		_Control = Control_v type:Control_type id:control_id caption:Macro.buttontext ControlBox:ControlBox init_parameters:#( Macro.params.keys, Macro.params.values )
		format "_Control = % \n" _Control
		
		--if( tooltip == undefined ) then 
		--	tooltip = ""
		--	
		--if( _Control == undefined ) then
		--(
		--	_Control	= ControlBox.button ( Macro.buttontext as string ) id:control_id
		--	this._setOnClickEvent #left _Control 
		--)
		--else
		--	this._setOnClickEvent #right _Control
			
	),
	
	/** Get control id
	 */
	function getControlId =
	(
		Macro.category as string + "_"+ (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-_]" ).Replace ( toLower Macro.buttontext ) "") --return
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
