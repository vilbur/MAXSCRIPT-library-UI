global DIALOG_PREVIOUS_STATE = undefined -- this should be in struct


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
	Events	= Events_v(),
	Parent_roll,
	
	events_rollout = #( #(#rolledUp, "val"), #(#rolledDown, "val") ),
	
	events_dialog  = #( #open, #close,  #(#resized, "val"), #(#moved, "val"), #docked, #oktoclose, #(#lbuttondown, "val")  ), -- https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_816D257C_CD2D_4753_A792_6E7AEFAFA6A7_htm
	
	/** Set event types for Main rollout (Dialog) or subrollouts
	 */
	function setEventTypes =
	(
		print ("RolloutEvent_v.setEventTypes()")
		--format "Parent_roll._isParentRoll()	= % \n" (Parent_roll._isParentRoll())
		--this.Events.setEventTypes events_dialog
		if( Parent_roll._isParentRoll() ) then 
			this.Events.setEventTypes events_dialog
		
		else
			this.Events.setEventTypes events_rollout
	),
	
	/** Set event
	 */
	function setEvent type callback params:"" =
	(
		print ("RolloutEvent_v.setEvent()")

		if not( this.Events._isEventExists(type) ) then 
			this._exception(type)
			
		this.Events._setCallbackParamters &params type
		this.Events._addFunctionBrackets  &callback params
		
		--format "type	= % \n" type
		--format "callback	= % \n" callback
		--format "params	= % \n" params
		
		--callback = (this.Events.getEventFired type:type id:Parent_roll.id) + callback
		--format "callback	= % \n" callback

		this.Events.add (Event_v type:type code:callback params:params)
	),
	
	/** Add default callback for event
	  * Default callback function is added in "Rollout_v._addSaveIniFunction()"
	  *
	 */
	function setSaveToIniEvents =
	(
		--print ("RolloutEvent_v.setSaveToIniEvents() " +Parent_roll.id)
		--format "Parent_roll._isParentRoll()	= % \n" (Parent_roll./*_isParentRoll*/())
		--if( Parent_roll.ini == undefined ) then
			--return false --return
		
		--this.setSaveIniDefaultEvent #open  "rolledUp" "(val == false)"
		--this.setSaveIniDefaultEvent #close "rolledUp" "(val == false)"
		--this.setSaveIniDefaultEvent #moved "docked"   ("(try(cui.getDockState "+Parent_roll.id+")catch(false))")
		
		
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
		print ("RolloutEvent_v._addHandlers() " +Parent_roll.id)
		--format "Parent_roll._isSubrollout() = % \n" (Parent_roll._isSubrollout())
		
		--handler_types	= #( #open, #close, #rolledUp, #resized, #moved, #lbuttondown )
		--_Events = this.Events.getEvents()
		--format "_Events	= % \n" _Events
		
		if( Parent_roll._isParentRoll() ) then
		(
			for event_type in Events.event_types do
				this._addHandler event_type
		)
		else
			this._addHandler #rolledUp

	),
	
	/** _add handler
	 */
	function _addHandler event_type =
	(
		print "\n"
		print ("RolloutEvent_v._addHandler()")
		format "event_type	= % \n" event_type
		--params = if( event_type == #open or event_type == #close or event_type == #oktoclose ) then "" else "val"
		params = this.Events._getEventParameters event_type
		
		callback = this._getCallback event_type
		--format "callback = % \n" callback
		
		
		--handler = "on "+(Parent_roll.id)+" "+ type as string + " "+val+"do (" +callback+ ")" 
		handler = "on "+(Parent_roll.id)+" "+ event_type as string + " "+params+" do (" +callback+ ")" 
		format "handler	= % \n" handler
		
		if( callback != "" ) then 
			Parent_roll.RolloutCreator.addText(handler)
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
		callback_rolledown	= this._getEventCode #rolledDown
		callback_rolledup	= this._getEventCode #rolledUp
		
		"if( val == true ) then (" +callback_rolledown+ ")else(" +callback_rolledup+ ")" --return
	),
	
	/** Bind to moved handler
	  *
	  *	Event #docked is bind to #moved handler
	  * If dialog is docked then callback of #docked is called
	  *
	  * #moved Event is fired many times, global variable DIALOG_PREVIOUS_STATE is used to find out if dialog gets just docket
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
		previous_state_definded = " (DIALOG_PREVIOUS_STATE != false) "
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

	--/** _is event exists
	-- */
	--function _isEventExists type =
	--(
	--	findItem Events.event_types type > 0 --return
	--),
	
	/** Exception
	 */
	function _exception type =
	(
		messageBox ("WARNING\n\nUnknown Event Type: #" +type+ "\n\nControl: " + Parent_roll.id )
	),
	
	on create do
	(
		--this.setEventTypes()
		
	)
)