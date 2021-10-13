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
	
	/* Properties */ 
	callback_value_name = "val", -- literal name of value passed to callback e.g.: callbackfn(value)
	
	event_types = List_v(),

	save_to_ini_events = #( #changed, #selected ),

	control_types	= #( #label, #button, #checkbox, #checkbutton, #spinner, #edittext, #listbox ),
	
	control_types_events = #(
		#( ),
		#( #pressed, #rightclick ),
		#( #changed, #rightclick ),
		#( #changed, #rightclick ),
		#( #changed, #entered, #buttondown, #buttonup ),
		#( #changed ),
		#( #selected, #doubleClicked, #rightClick )),

	
	/** Set event types available for each type of control
	 */
	function setEventTypes =
	(
		event_types.keys	= control_types
		event_types.values	= control_types_events
		
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
		if( ( this._eventHasValue type ) and params == "" ) then 
			params = callback_value_name
		
		_EventFired = this.Events.setEventFired type (Parent_Control.getId())

		this.Events.add (Event_v type:type code:(_EventFired + callback) tooltip:tooltip params:params)
		
		this._addToStartupEvents type callback
		
		Parent_Control --return
	),
	
	/** Test if callback has value
	 */
	function _eventHasValue type =
	(
		type == #changed or type == #entered or type == #buttonup  or type == #buttondown  or type == #selected or type == #doubleClicked --return
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
	  *
	  * If control has callback which is changing value of control
	 */
	function setSaveToIniCallback =
	(
		--format "ControlEvents.setSaveToIniCallback() % %\n" Parent_Control.id.id Parent_Control.type

		if( this._iniFileIsDefined() ) then
			for dynamic_event_type in (this._getSaveiniEventType()) do 
				this.Events.setDefaultEvent(Event_v type:dynamic_event_type code:("( setINISetting \""+(Parent_Control.ControlBox.Parent_roll.ini #get)+"\" \""+Parent_Control.ControlBox.Parent_roll.id+"\" \""+Parent_Control.id.id+"\" (val as string) )") params:"val")
	),
	
	/** Get saveini event type
	 */
	function _getSaveiniEventType =
	(
		for event_type in Events.event_types where findItem save_to_ini_events event_type > 0 collect event_type 
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
			EventFired_true = this.Events.setEventFired type Parent_Control.id.full val:true -- simulate event fired

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