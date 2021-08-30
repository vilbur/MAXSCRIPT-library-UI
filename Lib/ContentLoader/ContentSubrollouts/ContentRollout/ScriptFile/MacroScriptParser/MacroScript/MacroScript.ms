
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
	
	/** Set property
	  * 
	  * @property	#(key, value)	key_value
	 */
	function setProp key_value =
	(
		if( hasProperty this  key_value[1] ) then
			setProperty this key_value[1] key_value[2]
	),
	
	/** Create Control in Controls
	  *
	  * 
	 */
	function createControl ControlBox =
	(
		--print "MacroScript.createControl()"
		control_id	=  this.getControlId()
		_Button	= ControlBox.get ( control_id )

		
		if( tooltip == undefined ) then 
			tooltip = ""
			
		if( _Button == false ) then
		(
			_Button	= ControlBox.button ( buttontext as string ) id:control_id
			this._setOnClickEvent #left _Button 
		)
		else
			this._setOnClickEvent #right _Button
			
		this._setRcMenu _Button
	),
	
	/** _set rc menu
	 */
	function _setRcMenu _Button =
	(
		format "MacroScript_Content_v._setRcMenu tooltip = % \n" tooltip
		--test =  matchPattern tooltip pattern:"Menu|*" ignoreCase:true
		--format "test = % \n" test
		if( matchPattern tooltip pattern:"Menu|*"ignoreCase:true ) then
		(
			tooltipmenu_split = filterString tooltip "|"

			_Button.setMenu (execute(tooltipmenu_split[2]) )
		)
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
		callback = "macros.run \""+category+"\" \""+name+"\""

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