/** Struct present single macrosript in ".mcr" file
  *
  * This macro is able to add self calling button to UI
  * Macro is called with left click
  * Right click macro for button is added with another macroscript with same button name stored in "buttontext:"
  *
  */
struct MacroScript_Content_v
(
	name,
	category,
	buttontext,
	tooltip,
	icon,
	--_macroScript, -- IS THIS USED ?
	
	Controls_added	= #(),

	/** Set name
	 */
	function setName _string =
	(
		name	= trimLeft (trimRight (substring _string 13 -1))
		name	= ( dotnetObject "System.Text.RegularExpressions.Regex" "[\"]*" ).Replace name ""
		
		this --return
	),
	
	/** Set property
	 */
	function setProp props =
	(
		key	= trimLeft (trimRight (trimLeft props[1]))
		value	= ( dotnetObject "System.Text.RegularExpressions.Regex" "\"" ).Replace ( trimLeft ( trimRight props[2] )  ) ""
		--print ( key +" = " + value as string )
		if( hasProperty this key ) then
			setProperty this key value

		this --return
	),
	
	/*---------------------------------------
		PRIVATE
	-----------------------------------------*/
	/** Insert Macro as button to UI
	  *
	  * Button runs macro on preesed
	 */
	function _addControls _Controls =
	(
		print "\n\n------------\nHOTFIX MacroScript._addControls()"
		----format " _macroScript	= % \n" _macroScript
		control_id	=  this.getControlId()
		--format " control_id	= % \n" control_id
		_button_exists	= _Controls.get ( control_id )
		--format "_button_exists = % \n" _button_exists
		----format " _button	= % \n" _button
		if( _button_exists == false ) then
		(
			_button	= _Controls.button ( buttontext as string ) id:control_id
			_button = this._setOnClickEvent #left _button 
		--	_controls.add _button
		)
		else
			_button = this._setOnClickEvent #right _button_exists 
	),
	
	/** Get control id
	 */
	function getControlId =
	(
		category as string + "_"+ (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-_]" ).Replace ( toLower buttontext ) "") --return
	),
	
	/** Set leftClick
	 */
	function _setOnClickEvent _mbutton Control =
	(
		print "------------\nHOTFIX MacroScript._setOnClickEvent()"
		--callback = "macros.run @"+category+"@ @"+name+"@"
		callback = "macros.run \""+category+"\" \""+name+"\""
		format "callback = % \n" callback
		--Control.Events.setEvent #pressed ("print (\"Pressed\")") "tooltip"
		--Control.Events.setEvent #pressed callback "tooltip"
		
		if( _mbutton==#left ) then
			Control.Events.setEvent #pressed callback "tooltip"
		else
		
			Control.Events.setEvent #rightclick  callback "tooltip"
		
		Control --return
	),

	on create do
	(
		print "MacroScript_Content_v.onCreate()"

	)
)