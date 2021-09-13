global DIALOG_PREVIOUS_STATE = undefined


/** RolloutEvent https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
  *	
  *	Default events of rollout on open|close|rolledUp are merged
  *	
  *	Merged types are #open|#close
  * 		On Dialog  level they substitute on open|close
  * 		On Rollout level they substitute on rolledUp
  * 
  * 
  *	
  */
struct RolloutEvent_v 
(
	/* dependency */
	Events	= Events_v event_types:#( #open, #close, #resized, #moved, #docked ),
	Parent_roll,

	
	/** Set event
	 */
	function setEvent type callback params:"" =
	(
		callback = (this.Events.setEventFired type Parent_roll.id) + callback

		this.Events.add (Event_v type:type code:callback params:"val")
	),
	
	/** Add default callback for event
	  * Default callback function is added in "Rollout_v._addSaveIniFunction()"
	  *
	 */
	function setSaveToIniEvents =
	(
		--if( Parent_roll.ini == undefined ) then
			--return false --return
		
		this.setSaveIniDefaultEvent #open  "rolledUp" "(val==false)"
		this.setSaveIniDefaultEvent #close "rolledUp" "(val==false)"
		this.setSaveIniDefaultEvent #moved "docked"   ("(try(cui.getDockState "+Parent_roll.id+")catch(false))")
		
	),
	
	/** Set save ini default event
	 */
	function setSaveIniDefaultEvent type key _value =
	(
		save_to_ini_method	= "setINISetting \""+Parent_roll.ini+"\" \""+Parent_roll.id+"\" \""+key+"\" ("+_value+" as string)"
		
		this.Events.setDefaultEvent ( Event_v type:type	code:save_to_ini_method )
	),
	
	/** Bind events handlers to rollout 
	 */
	function _addHandlers =
	(
		--print ("RolloutEvent_v._addHandlers() " +Parent_roll.id)
		--format "Parent_roll._isSubrollout() = % \n" (Parent_roll._isSubrollout())
		
		handler_types	= #( #open, #close, #rolledUp, #resized, #moved )
				
		for type in handler_types do 
			this._addHandler type
	),
	/** _add handler
	 */
	function _addHandler type =
	(
		val = if( type == #open or type == #close ) then " " else " val "
		
		callback = this._getCallback type
		--format "callback = % \n" callback
		
		if( callback != "" ) then 
			Parent_roll.RolloutCreator.addText ("on "+(Parent_roll.id)+" "+ type as string +val+"do (" + callback + ")" )
	),
	/** Get callback on rollout open\close
	 */
	function _getCallback type =
	(
		if( type == #rolledUp ) then
		(
			callback_open	= this._getEventCode #open
			callback_close	= this._getEventCode #close
			
			"if( val==true ) then (" +callback_open+ ")else(" +callback_close+ ")" --return
		)
		else if( type == #moved ) then
		(
			callback_moved	= this._getEventCode #moved
			callback_docked	= this._getEventCode #docked
			
			_format = "format \"TEST DIALOG_PREVIOUS_STATE %\n\" DIALOG_PREVIOUS_STATE"
			
			if( callback_docked != "" ) then -- on move, if dialog is docked and change its state then call #docked callback
				callback_moved += "\n"+	"if ((current_state = try(cui.getDockState "+Parent_roll.id+")catch(false)) != DIALOG_PREVIOUS_STATE and matchPattern (current_state as string) pattern:\"cui_dock*\") then (DIALOG_PREVIOUS_STATE = current_state\n"+_format + callback_docked + ")"
			
			callback_moved --return
		) else
			this._getEventCode type
				
	),

	/** _get event code
	 */
	function _getEventCode event_type =
	(
		_Event	= this.Events.getEvent event_type
		
		if( _Event!=undefined ) then
			_Event.code --return
		else
			--"print \"shit\"" --return
			"" --return
	),
	
	on create do
	()
)
