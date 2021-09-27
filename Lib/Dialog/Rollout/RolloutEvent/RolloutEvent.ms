global DIALOG_PREVIOUS_STATE = undefined


/** RolloutEvent https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
  * 
  *		1) Available events for dialog|rollout are #open, #close, #resized, #moved, #docked 
  *	
  *		2) Events #open, #close and #docked fires save to ini callback before user defined callback, if ini file is defined then
  *
  *		3) Each event fires global variable EventFired
  *	
  *	
  *	------------------------------------------------------------------------------------------------------------
  *	
  * #OPEN and #CLOSE:
  *		Dialog  #open and #close fires when dialog is  opened or closed
  *		Rollout #open and #close fires when subrollout is roll up or down
  *	
  *	
  *	#DOCKED
  *		If fired each time dialog change its docked state, on dock or undock
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
		
		this.setSaveIniDefaultEvent #open  "rolledUp" "(val == false)"
		this.setSaveIniDefaultEvent #close "rolledUp" "(val == false)"
		this.setSaveIniDefaultEvent #moved "docked"   ("(try(cui.getDockState "+Parent_roll.id+")catch(false))")
	),
	
	/** Set save to ini default event
	 */
	function setSaveIniDefaultEvent type key val =
	(
		if_val_not_undefined	= "if( val != undefined ) then" -- on subrollout creation is "rolledUp" fired with undefined value
		
		save_to_ini	= "( setINISetting \""+(Parent_roll.ini #get)+"\" \""+Parent_roll.id+"\" \""+key+"\" ("+val+" as string) )"
		
		this.Events.setDefaultEvent ( Event_v type:type	code:(if_val_not_undefined + save_to_ini) )
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
			this._bindToRolledUpHandler() --return
		
		else if( type == #moved ) then
			this._bindToMovedHandler()
		
		else
			this._getEventCode type
				
	),
	
	/** Bind to rolled up handler
	  *
	  * Events #open, #close are bind to #rolledUp handler
	  *
	 */
	function _bindToRolledUpHandler =
	(
		callback_open	= this._getEventCode #open
		callback_close	= this._getEventCode #close
		
		"if( val==true ) then (" +callback_open+ ")else(" +callback_close+ ")" --return
	),
	
	/** Bind to moved handler
	  *
	  *	Event #docked is bind to #moved handler
	  * If dialog is docked then callback of #docked is called
	  *
	  * #moved Event is fired many times, gloabl variable DIALOG_PREVIOUS_STATE is used to find out if dialog gets just docket
	  *
	 */
	function _bindToMovedHandler =
	(
		callback_moved	= this._getEventCode #moved
		callback_docked	= this._getEventCode #docked
		
		--_format = "\nformat \"TEST DIALOG_PREVIOUS_STATE %\" DIALOG_PREVIOUS_STATE \n"
		_format = ""
		
		if_resizing_enabled     =	""
		--if_resizing_enabled     =	" if(ENABLE_RESIZING != false) then\n" -- this is MUST WRAP ALL STRINGS BELOW IN ()
		previous_state_definded =	" (DIALOG_PREVIOUS_STATE != false) "
		current_state_changed   = " (dialog_current_state = try(cui.getDockState "+Parent_roll.id+")catch(false)) != DIALOG_PREVIOUS_STATE "
		state_match_cui         = " matchPattern (dialog_current_state as string) pattern:\"cui_*\" "
		set_previous_state      = " DIALOG_PREVIOUS_STATE = dialog_current_state "
		
		if( callback_docked != "" ) then -- on move, if dialog is docked and change its state then call #docked callback
			callback_moved += if_resizing_enabled +"\n"+"if ( "+previous_state_definded+" and  "+current_state_changed+" and "+state_match_cui+") then (" + callback_docked + ")\n" + set_previous_state
		
		callback_moved --return
	),
	

	/** _get event code
	 */
	function _getEventCode event_type =
	(
		_Event	= this.Events.getMergedEvent event_type
		
		if( _Event!=undefined ) then
			_Event.code --return
		else
			"" --return
	),
	
	on create do
	()
)
