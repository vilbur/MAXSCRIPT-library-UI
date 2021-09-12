 /** RolloutEvent
  *		
  *		
  */
struct RolloutEvent_v 
(
	--event_types	= #( #onOpen, #onClose ),
	
	/* dependency */
	Events	= Events_v event_types:#( #onOpen, #onClose ),
	Parent_roll,

	
	/** Set event
	 */
	function setEvent type callback params:"" =
	(
		callback = (this._setEventFired type) + callback

		this.Events.add (Event_v type:type code:callback params:"val")
	),
	
	/** Set event fired
	 */
	function _setEventFired type =
	(
		local EventFired = "EventFired.control=\""+(Parent_roll.id)+"\";"
		
		EventFired += "EventFired.type=#"+type+";"
		
		EventFired += "EventFired.value=val;"
		
		EventFired --return
	),
	
	/*---------------------------------------
		PRIVATE 
	-----------------------------------------*/
	/** Add default callback for event
	  * Default callback function is added in "Rollout_v._addSaveIniFunction()"
	  *
	 */
	function setSaveToIniEvents =
	(
		if( Parent_roll.ini == undefined ) then
			return false --return
		
		save_to_ini_method	= "setINISetting \""+Parent_roll.ini+"\" \""+Parent_roll.id+"\" \"rolledUp\" ((val==false) as string)"
		
		this.Events.setDefaultEvent ( Event_v type:#onOpen	code:save_to_ini_method )
		this.Events.setDefaultEvent ( Event_v type:#onClose	code:save_to_ini_method )
	),
	
	/** Bind events handlers to rollout 
	 */
	function _addHandlers =
	(
		--print ("RolloutEvent_v._addHandlers()")
		Parent_roll.RolloutCreator.addText ("on "+(Parent_roll.id)+" rolledUp val do (" + this._getCallback() + ")" )
	),
	
	/** Get callback on rollout open\close
	 */
	function _getCallback =
	(
		callback_open	= this._getEventCode #onOpen
		callback_close	= this._getEventCode #onClose
				
		"if( val==true ) then (" +callback_open+ ")else(" +callback_close+ ")" --return
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
