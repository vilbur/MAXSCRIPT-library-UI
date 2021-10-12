filein( getFilenamePath(getSourceFileName()) + "/../../../../../../Events/Events.ms" )
filein( getFilenamePath(getSourceFileName()) + "/EventFired/EventFired.ms" )

global STARTUP_EVENTS = #() -- run callbacks of controls like checkbox, checkbutton on UI start

/** ControlEvents_v
 *
 * DEFAULT CALLBACKS:
 *		1) Fire global variable EventFired = EventFired_v
 * 		2) Save ctrl value to ini if ini file is defined
 * 		
 *
 */
struct ControlEvents_v 
(
	/* dependency */
	Events	= Events_v(),

	Parent_Control,
	
	callback_value_name = "val", -- literal name of value passed to callback e.g.: callbackfn(value)

	/** Set event types available for each type of control
	 */
	function setEventTypes =
	(
		--format "ControlEvents_v.setEventTypes %\n" Parent_Control.type
		event_types = List_v()
		
		event_types.setVal #label       #( )
		event_types.setVal #button      #( #pressed, #rightclick )
		event_types.setVal #checkbox    #( #changed, #rightclick )
		event_types.setVal #checkbutton #( #changed, #rightclick )
		event_types.setVal #spinner     #( #changed, #entered, #buttondown, #buttonup )
		event_types.setVal #edittext    #( #changed )
		
		Events.event_types = (event_types.getVal Parent_Control.type)
	),
	
	/** Set event by type
	  * 
	  * @property	#name	type	of callback #pressed|#rightclick|#changed|#entered|#buttondown|#buttonup 
	  * @param	string	callback	code executed on event
	  * @param	string	tooltip	tooltip for control
	  * @property	string	params	for callback
	  * 
	  * @return	object Control	
	 */
	function setEvent type callback tooltip params:"" =
	(
		--format "\nControlEvents_v.setEvent type:% callback:% tooltip:%\n" type callback tooltip
		if( (type == #changed or type == #entered or type == #buttonup  or type == #buttondown   ) and params == "" ) then 
			params = callback_value_name
		
		_EventFired = this.Events.setEventFired type (Parent_Control.getId())
		--format "tooltip	= % \n" tooltip
		this.Events.add (Event_v type:type code:(_EventFired + callback) tooltip:tooltip params:params)
		
		this._addToStartupEvents type callback
		
		Parent_Control --return
	),
	
	/** Set default event, save to ini if ini is defined in rollout
	 */
	function setDefaultEvents =
	(
		--format "------------\nControlEvents.setDefaultEvents() % %\n" Parent_Control.id.id Parent_Control.type
		if( Parent_Control.ControlBox.Parent_roll.ini != undefined ) then
			this.setSaveToIniCallback()
	),
	
	/** Set save to ini callback
	 */
	function setSaveToIniCallback =
	(
		--format "ControlEvents.setSaveToIniCallback() % %\n" Parent_Control.id.id Parent_Control.type
		if( this._iniFileIsDefined() and Events.event_types != undefined ) then
			this.Events.setDefaultEvent(Event_v type:#changed code:("( setINISetting \""+(Parent_Control.ControlBox.Parent_roll.ini #get)+"\" \""+Parent_Control.ControlBox.Parent_roll.id+"\" \""+Parent_Control.id.id+"\" (val as string) )") params:"val")
	),

	/** Add handlers
	  * http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_5FC5036F_E2D7_46C9_9AFA_7B3550B9F254_htm
	 */
	function addHandlers =
	(
		--print ( "ControlEvent_v._addHandlers=" + this.Events.getEvents() as string )
		_Events = this.Events.getEvents()
		
		for _Event in _Events do
			Parent_Control.ControlBox.Parent_roll.RolloutCreator.addhandler Parent_Control.id.id _Event
	),
	
	/** Get callback
	 */
	function _addToStartupEvents type callback =
	(
		if( Parent_Control._Parameters.getVal #checked == true ) then
		(
			EventFired_true = this.Events.setEventFired type (Parent_Control.id.getIdFull()) val:true -- simulate event fired

			appendIfUnique STARTUP_EVENTS (EventFired_true+callback)
		)
	),
	
	private

	/** _ini is defined
	 */
	function _iniFileIsDefined =
	(
		Parent_Control.ControlBox.Parent_roll._Ini.isDefined() --return
	),
	
	
	on create do
	(
	)
)