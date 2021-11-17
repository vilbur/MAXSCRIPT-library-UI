	button_columns = 4,
	
	/** _add browse button
	 */
	function _addBrowseButton =
	(
		--print("BrowsePath-Button._addBrowseButton()")

		--browse_button_id = id.id + "_BUTTON" 
		--format "browse_button_id	= % \n" browse_button_id
		--ControlBox.Parent_roll.RolloutCreator.addControl #button browse_button_id caption (this._getButtonParameters())
		--ControlBox.Parent_roll.RolloutCreator.addControl #button browse_button_id caption (this._getButtonParameters())
		global ControlBoxEditText = ControlBox

		this._Button = execute ("ControlBoxEditText.Button \""+caption+"\" " + (this._getButtonParameters()))

		ControlBoxEditText = undefined
		
	),

	  
	 /** _add browse button event
	  */
	 function _addBrowseButtonEvent =
	 (
		Event = Event_v type:#pressed
		
		_Rollout	= ControlBox.Parent_roll
		ini_path	= _Rollout.ini #get
		edit_text_id	= _Rollout.id +"."+ id.id
		
		--format "initial_dir	= % \n" this.initial_dir
		
		get_dir_fn	= "local browsed_dir = getSavePath caption:@Browse path...@ initialDir:@"+this.initial_dir+"@ "
		set_edit_text	= edit_text_id+".text = browsed_dir "
		if_dir_defined	= "if (  browsed_dir != undefined) "

		set_button_tooltip	= this._Button.id.full+".toolTip = browsed_dir"
				
		save_to_ini = if( ini_path != undefined ) then  "setINISetting \"" + ini_path + "\" \"" + _Rollout.id + "\" \"" + id.id  + "\" browsed_dir"  else ""
				
		Event.code = get_dir_fn +"\n"+ if_dir_defined + " then ( "+set_edit_text+"\n"+set_button_tooltip+"\n"+save_to_ini+" )"
		
		
		this._Button.Events.Events.add Event
	 ),
	 
	
	
	/** Get edit text parameters
	 */
	function _getButtonParameters =
	(
		--_params_ = #( #id, #columns, #params )
		_params_ = #( #id, #columns, #pos )
			
			
		values =  for param in _params_ collect
			case param of
			(
				#id:	"\""+id.id + "_BUTTON"+"\""
				#columns:	button_columns as string
				#pos:	(_Parameters.getVal #pos) as string

			)
		 
		--format "values	= % \n" values
		

		
		
		--width  = "width:" + this._getButtonWidth() as string
		--columns  = "columns:" + this._getButtonWidth() as string
		--params = (_Parameters.join())
		
		this._getParamsString _params_ values --return
	),	
	
	/** _get params string
	 */
	function _getParamsString keys values =
	(
		params_string = ""
		
		for i = 1 to keys.count do
		--format "values[i]	= % \n" values[i]
			params_string += " " + keys[i] as string + ":" + values[i]
	
		--format "params_string	= % \n" params_string
		params_string --return
	),
	

	/** Get button width
	  * @return	integer button width	
	 */
	function _getButtonWidth =
	(
		--( _Parameters.getVal #width - _Parameters.getVal #fieldwidth ) --return
		4 --return
	),