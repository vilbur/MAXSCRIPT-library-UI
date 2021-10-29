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
	--callback_value_name = "val", -- literal name of value passed to callback e.g.: callbackfn(value)
	
	--event_types = List_v(),

	save_to_ini_events = #( #changed, #selected ), -- this events fires default save to ini callback

	--events_with_val_param = #( #changed, #entered, #buttonup, #doubleClicked, #selected ), -- events with "val" parameter
	
	control_types	= #( #label, #button, #checkbox, #checkbutton, #spinner, #edittext, #browsePath, #listbox, #multilistbox  ),
	
	
	/* If event is array then it has "val" param
	*
	* Other items in array defines additional params for event
	*
	*/ 
	control_types_events = #(
		#( ),			-- #label	
		#( #pressed,	#rightclick ),		-- #button	
		#( #(#changed, "val"),	#rightclick  ),		-- #checkbox	https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_D23A42EA_7B69_4DEF_9D6E_C6C85F884268_htm
		#( #(#changed),	#rightclick ),		-- #checkbutton	
		#( #(#changed, "val inSpin_arg"),	#entered, #buttondown, #buttonup ),		-- #spinner	
		#( #(#changed),	#entered ),		-- #edittext	
		#( #(#changed),	#entered ),		-- #browsePath	
		#( #selected,	#doubleClicked, #rightClick ),		-- #listbox	https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_7C37748B_C682_4834_B5A6_74185C8C661A_htm
		#( #selected,	#doubleClicked, #rightClick, #selectionEnd ) ),		-- #multilistbox	

	
	
	/** Set event types available for each type of control
	 */
	function setEventTypes =
	(		
		events_of_control = control_types_events[findItem control_types Parent_Control.type]
		
		--for event_type in events_of_control do
		--	append Events.event_types ( if( classOf event_type == Array ) then event_type[1] else event_type )
		
		Events.event_types = for event_type in events_of_control collect
			if( classOf event_type == Array ) then event_type[1] else event_type

		
		Events.event_params = for event_type in events_of_control where classOf event_type == Array collect event_type

		--for i = 1 to Events.event_params.count where classOf Events.event_params[i] == Array do
		--	format "Events.event_params[i]	= % \n" Events.event_params[i]
		--	--Events.event_types[i] = Events.event_params[i][1]
		--
		format "Events.event_types	= % \n" Events.event_types
		format "Events.event_params	= % \n" Events.event_params
		
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
		format "\nControlEvents_v.setEvent type:% callback:\"%\" tooltip:\"%\" params:%\n" type callback tooltip params
		--format "Events.event_types	= % \n" Events.event_types
		
		--if( findItem Events.event_types type == 0 ) then 
			--this._exception()
		
		this._setCallbackParamter &params type
		this._addFunctionBrackets &callback params
		format "callback	= % \n" callback

		--_EventFired = this.Events.setEventFired type (Parent_Control.getId())
		format "params	= % \n" params
		--this.Events.add (Event_v type:type code:(_EventFired + callback) tooltip:tooltip params:params)
		this.Events.add (Event_v type:type code:callback tooltip:tooltip params:params)
		
		--this._addToStartupEvents type callback
		
		Parent_Control --return
	),
	
	/** Add handlers
	  * http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_5FC5036F_E2D7_46C9_9AFA_7B3550B9F254_htm
	 */
	function addHandlers =
	(
		print ( "ControlEvent_v._addHandlers" )
		_Events = this.Events.getEvents()
		format "_Events	= % \n" _Events
		for _Event in _Events do
			Parent_Control.ControlBox.Parent_roll.RolloutCreator.addhandler Parent_Control.id.id _Event
	),
	
	/** Add function brackets E.g.: "fooCallback" return "fooCallback()|fooCallback(val)"
	 */
	function _addFunctionBrackets &callback params =
	(
		--format "ControlEvents_v._addFunctionBrackets	= % \n" callback
		
		if not( matchPattern callback pattern:"macros.run*" ) then 
			if not( matchPattern callback pattern:("*(*)") ) then
				callback += " " + params
				--callback += "("+params+")"
	),
	
	/** Get parameters of callback defined in control_types_events
	 */
	function _setCallbackParamter &params type =
	(
		print "ControlEvents._setCallbackParamter()"
		format "params	= % \n" params
		
		if( ( event_params = this._eventHasParameter type ) != undefined and params == "" ) then
			params = event_params
		
		params --return
	),
	
	/** If event in Events.event_types is Array, then it has parameter
	 */
	function _eventHasParameter type =
	(
		format "ControlEvents_v._eventHasParameter	= % \n" type

		param
		
		for event_param in Events.event_params where event_param[1] == type do
			param = event_param[2]
			
		param --return
	),
	
	--/** _get event type
	-- */
	--function _getEventType type =
	--(
	--	for event_type in Events.event_types where classOf event_type == Array and event_type[1] == type do return event_type
	--),
	
	/** Set default event, save to ini if ini is defined in rollout
	 */
	function setDefaultEvents =
	(
		format "------------\nControlEvents.setDefaultEvents() % %\n" Parent_Control.id.id Parent_Control.type
		if( Parent_Control.ControlBox.Parent_roll.ini != undefined ) then
			this.setSaveToIniCallback()
	),
	
	/** Set save to ini callback
	  *
	  * If control has callback which is changing value of control
	 */
	function setSaveToIniCallback =
	(
		format "ControlEvents.setSaveToIniCallback() % %\n" Parent_Control.id.id Parent_Control.type

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

	
	/** If checkbox has value true, then fire up checkbox`s callback when UI starts
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

	/** Exception
	 */
	function _exception =
	(
		messageBox ("WARNING !\n\nControlEvents_v.setEvent()\n\nUNKNOWN event type: #"+ type + "\n\nControl: "+ (Parent_Control.Id.get() ))
	),
	
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