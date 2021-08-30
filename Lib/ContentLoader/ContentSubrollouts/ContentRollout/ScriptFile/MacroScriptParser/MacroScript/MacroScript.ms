
/** Struct present single macrosript in ".mcr" file
  *
  * This macro is able to add self calling button to UI
  * Macro is called with left click
  * Right click macro for button is added with another macroscript with same button name stored in "buttontext:"
  *
  */
struct MacroScript_Content_v
(
	/* required properties */
	name,
	
	/* properties */
	category,
	buttontext,
	tooltip,
	icon,
	
	/* store */
	--Controls_added	= #(),
	
	/** Set property
	  * 
	  * @property	#(key, value)	key_value
	 */
	function setProp key_value =
	(
		--if( key_value[2]==undefined ) then 
			--key_value[2] = ""
		
		--format "MacroScript_Content_v.setProp % \n" key_value
		if( hasProperty this  key_value[1] ) then
			setProperty this key_value[1] key_value[2]
	),
	
	/** Create Control in Controls
	  *
	  * 
	 */
	function createControl ControlBox =
	(
		print "MacroScript.createControl()"
		--format "ControlBox = % \n" ControlBox
		format "tooltip = % \n" tooltip
		
		
		control_id	=  this.getControlId()
		--format " control_id	= % \n" control_id
		_button_exists	= ControlBox.get ( control_id )

		if( tooltip == undefined ) then 
			tooltip = ""
			--format "_button_exists = % \n" _button_exists
			
		if( _button_exists == false ) then
		(
			_button	= ControlBox.button ( buttontext as string ) id:control_id
			this._setOnClickEvent #left _button 
		)
		else
			this._setOnClickEvent #right _button_exists
			
			
		--format "_button.events = % \n" _button.events
	),
	
	/** Get control id
	 */
	function getControlId =
	(
		category as string + "_"+ (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-_]" ).Replace ( toLower buttontext ) "") --return
	),
	
	/** Set leftClick
	 */
	function _setOnClickEvent mouse_button Control =
	(
		--format "\n"
		print "HOTFIX MacroScript._setOnClickEvent()"
		--callback = "macros.run @"+category+"@ @"+name+"@"
		callback = "macros.run \""+category+"\" \""+name+"\""
		format "mouse_button = % \n" mouse_button
		--format "callback = % \n" callback
		--Control.Events.setEvent #pressed ("print (\"Pressed\")") "tooltip"
		--Control.Events.setEvent #pressed callback "tooltip"
		
		if( mouse_button == #left ) then
			Control.Events.setEvent #pressed callback tooltip
		else
		
			Control.Events.setEvent #rightclick  callback tooltip
		
		Control --return
	),

	on create do
	(
		--print "MacroScript_Content_v.onCreate()"
	)
)