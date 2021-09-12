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
	Events	= Events_v event_types:#( #open, #close, #resized, #moved ),
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
		if( Parent_roll.ini == undefined ) then
			return false --return
		
		save_to_ini_method	= "setINISetting \""+Parent_roll.ini+"\" \""+Parent_roll.id+"\" \"rolledUp\" ((val==false) as string)"
		
		this.Events.setDefaultEvent ( Event_v type:#open	code:save_to_ini_method )
		this.Events.setDefaultEvent ( Event_v type:#close	code:save_to_ini_method )
	),
	
	/** Bind events handlers to rollout 
	 */
	function _addHandlers =
	(
		print ("RolloutEvent_v._addHandlers() " +Parent_roll.id)
		--format "Parent_roll._isSubrollout() = % \n" (Parent_roll._isSubrollout())
		handler_types	= Events.event_types
		
		append handler_types #rolledUp
		
		for type in handler_types do 
			this._addHandler type
	),
	/** _add handler
	 */
	function _addHandler type =
	(
		val = if( type == #open or type == #close ) then " " else " val "
		
		Parent_roll.RolloutCreator.addText ("on "+(Parent_roll.id)+" "+ type as string +val+" do (" + (this._getCallback type) + ")" )
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
		)else
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
			"" --return
	),
	
	on create do
	()
)
