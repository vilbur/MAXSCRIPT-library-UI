filein( getFilenamePath(getSourceFileName()) + "/../../../../../../Events/Events.ms" )
filein( getFilenamePath(getSourceFileName()) + "/EventFired/EventFired.ms" )

global STARTUP_EVENTS = #() -- run callbacks of controls like checkbox, checkbutton on UI start

/** ControlEvents_v 
 *
 * DEFAULT CALLBACKS:
 *		1) Fire global variable EventFired = EventFired_v
 * 		2) Save value of control to ini file if is defined
 * 		
 * 		
 * 		
 *	!!!!!!!!! NOTES FOR ADDING NEW TYPE OF CONTROL !!!
 * 		
 *		Edit arrays: control_types, event_params
 */
struct ControlEvents_v 
(
	/* dependency */
	Events	= Events_v(),

	Parent_Control,
	
	/* Properties */ 
	save_to_ini_events = #( #changed, #selected ), -- this events fires default save to ini callback

	
	/* Keys for event_params array
	*/ 
	control_types	= #( #label, #button, #checkbox, #checkbutton, #spinner, #edittext, #listbox, #multilistbox, #dropdownlist, #browsePath  ),
	
	
	/* If event is array then it has "val" param
	*
	* Other items in array defines additional params for event.
	*/ 
	event_params = #(
		#( ),				-- #label	
		#( #pressed,	#rightclick ),			-- #button	
		#( #(#changed,  "val"),	#rightclick ),			-- #checkbox	https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_D23A42EA_7B69_4DEF_9D6E_C6C85F884268_htm
		#( #(#changed,  "val"),	#rightclick ),			-- #checkbutton	
		#( #(#changed,  "val inSpin"),	#(#entered, "inSpin inCancel"),	#(#buttonup, "inCancel"),	#buttondown ),	-- #spinner	
		#( #(#changed,  "val"),	#(#entered, "val") ),			-- #edittext	https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_FC73C160_735C_4F65_A71D_722D63BBB591_htm
		#( #(#selected, "val"),	#(#doubleClicked, "val"),	#(#rightClick, "val")),		-- #listbox	https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_7C37748B_C682_4834_B5A6_74185C8C661A_htm
		#( #(#selected, "val"),	#(#doubleClicked, "val"),	#rightClick,	#selectionEnd ),	-- #multilistbox	
		#( #(#selected, "val"),	#rightClick ),			-- #dropdownlist	
		
		/* Custom compounded controls */
		#( #(#changed,  "val"),	#(#entered, "val") )	-- #browsePath	
	),
	
	
	/** Set event types available for each type of control
	 */
	function setEventTypes =
	(	
		events_of_control = event_params[findItem control_types Parent_Control.type]
		
		
		this.Events.setEventTypes events_of_control
		
		Events.event_types = for event_type in events_of_control collect
			if( classOf event_type == Array ) then event_type[1] else event_type
		
		Events.event_params = for event_type in events_of_control where classOf event_type == Array collect event_type

		--format "Events.event_types	= % \n" Events.event_types
		--format "Events.event_params	= % \n" Events.event_params
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
		--print ( "ControlEvent_v.setEvent()" )

		--format "type:% callback:\"%\" tooltip:\"%\" params:%\n" type callback tooltip params
		--format "Events.event_types	= % \n" Events.event_types
		
		if not( this.Events._isEventExists(type) ) then 
			this._exception(type)
		
		this.Events._setCallbackParamters &params type
		this.Events._addFunctionBrackets  &callback params
		--format "callback	= % \n" callback
		--format "params	= % \n" params

		_EventFired = this.Events.getEventFired type:type id:(Parent_Control.getId())
		  
		
		this.Events.add (Event_v type:type code:(_EventFired + callback) tooltip:tooltip params:params)
		
		--this._addToStartupEvents type callback -- IMPORTANT FIX THIS !!!!!! 
		
		Parent_Control --return
	),
	
	/** Add handlers
	  * http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_5FC5036F_E2D7_46C9_9AFA_7B3550B9F254_htm
	 */
	function addHandlers =
	(
		--print ( "ControlEvent_v._addHandlers" )
		_Events = this.Events.getEvents()
		--format "_Events	= % \n" _Events
		for _Event in _Events do
			Parent_Control.ControlBox.Parent_roll.RolloutCreator.addhandler Parent_Control.id.id _Event
	),
	
	--/** Add function brackets E.g.: "fooCallback" return "fooCallback()|fooCallback(val)"
	-- */
	--function _addFunctionBrackets &callback params =
	--(
	--	--print "ControlEvents_v._addFunctionBrackets()"
	--	--format "params	= % \n" params
	--	if( params == "" ) then 
	--		params = "()"
	--	
	--	if not( matchPattern callback pattern:"macros.run*" ) then 
	--		if not( matchPattern callback pattern:("*(*)") ) then
	--			callback += " " + params
	--			--callback += "("+params+")"
	--),
	--
	--/** Get parameters of callback defined in event_params
	-- */
	--function _setCallbackParamters &params type =
	--(
	--	print "ControlEvents._setCallbackParamters()"
	--	--format "params	= % \n" params
	--	
	--	if( ( event_params = this._getEventParameters type ) != undefined and params == "" ) then
	--		params = event_params
	--	
	--	params --return
	--),
	--
	--/** If event in Events.event_types is Array, then it has parameter
	-- */
	--function _getEventParameters type =
	--(
	--	--format "ControlEvents_v._getEventParameters	= % \n" type
	--
	--	param = ""
	--	
	--	for event_param in Events.event_params where event_param[1] == type do
	--		param = event_param[2]
	--		
	--	param --return
	--),
	
	/** Set default event, save to ini if ini is defined in rollout
	 */
	function setDefaultEvents =
	(
		--format "------------\nControlEvents.setDefaultEvents() % %\n" Parent_Control.id.id Parent_Control.type
		if( Parent_Control.ControlBox.Parent_roll._Ini.isDefined() ) then
			this.setSaveToIniCallback()
	),
	
	/** Set save to ini callback
	  *
	  * If control has callback which is changing value of control
	 */
	function setSaveToIniCallback =
	(
		--format "ControlEvents.setSaveToIniCallback() % %\n" Parent_Control.id.id Parent_Control.type
		
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

	--/** _is event exists
	-- */
	--function _isEventExists type =
	--(
	--	findItem Events.event_types type > 0 --return
	--),
	--
	/** Exception
	 */
	function _exception type =
	(
		messageBox ("WARNING\n\nUnknown Event Type: #"+ type + "\n\nControl: "+ (Parent_Control.Id.get() ))
	),

	
	on create do
	(
	)
)