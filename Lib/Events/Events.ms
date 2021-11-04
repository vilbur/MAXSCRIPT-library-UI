
/** Custom
  *
  * @property	array	event_types	Allowed types of events, E.G.: for button event_types = #("pressed", "changed")
  *
  *
 */
struct Events_v  
(
	Custom	= List_v(),
	Defaults	= List_v(),
	
	event_types,  -- #( #changed, #rightclick  )
	event_params, -- #( #(#changed, "val inSpin_arg"), #rightclick  )
	
	/** Set event types available for each type of control
	 */
	function setEventTypes _event_params =
	(
		--print ( "Events_v.setEventTypes()")
		event_types = for event_type in _event_params collect
			if( classOf event_type == Array ) then event_type[1] else event_type
		
		event_params = for event_type in _event_params where classOf event_type == Array collect event_type

		--format "event_types	= % \n" event_types
		--format "event_params	= % \n" event_params
	),
	/** Set Event to Custom
	 */
	function setDefaultEvent Event =
	(
		--print ( "Events_v._setDefaultEvent " + Event as string )
		this.Defaults.setVal Event.type Event
	),
	
	/** Add Event to Custom
	 */
	function add Event =
	(
		--print ( "Events_v.add()")
		this.Custom.setVal Event.type Event
	),
	
	--/** Add Event to Custom
	-- */
	--function addCodeToDefaultEvent type code =
	--(
	--	Event = this.Defaults.getVal type
	--	
	--	Event.code += "\n"+code
	--),
	
	/**  
	 */
	function getEvents =
	(
		--print ( "Events_v.getEvents() " + event_types as string )
		events_merged	= #()

		if( event_types != undefined ) then
			for event_type in event_types do
				append events_merged (this.getMergedEvent event_type)
		
			
		for Event_merged in events_merged where Event_merged != undefined collect Event_merged --return
	),

	/** Get events
	  *
	  * @property	#name	event_type	#pressed|#rightclick|#changed etc.
	  *
	 */
	function getMergedEvent event_type =
	(
		--print ( "Events_v.getMergedEvent() " + event_type as string )
		Event_default	= Defaults.getVal	event_type
		Event	= Custom.getVal	event_type
		
		if( Event_default != undefined or Event != undefined ) then
			this.mergeEvents Event_default Event --return
		else
			undefined --return 
	),
	
	/** Merge default event with user defined event
	  *
	 */
	function mergeEvents Event_default Event =
	(
		Event_merged 	= Event_v type:(this._getEventProperty Event_default Event #type )
		
		Event_merged.params	= this._getEventProperty	Event_default Event #params
		Event_merged.tooltip	= this._getEventProperty	Event_default Event #tooltip
		Event_merged.code	=(this._getCodeStr	Event_default ) + "\n" + ( this._getCodeStr Event )

		Event_merged --return
	),
	
	/** Get property from one of defined evets
	 */
	function _getEventProperty Event_default Event key =
	(
		if( Event_default!=undefined ) then
			getProperty Event_default key --return
			
		else
			getProperty Event key --return
	),
	
	/** Get code str
	 */
	function _getCodeStr Event =
	(
		if( Event!=undefined ) then
			Event.code
		else
			""
	),
	
	/** Code below fills global variable EventFired with event`s data when event is fired
	  *
	  * @return	string	
	 */
	function getEventFired type: id: params:#() val:"val" =
	(
		--print "Events_v.getEventFired()"
		--format "params	= % \n" params
		params = (filterString (this._getEventParameters type) " ")
		
		_EventFired = "EventFired.control=\""+(id)+"\";"
		
		_EventFired    += "EventFired.type=#"+type+";"
		
		for param in params do 
			_EventFired += "EventFired."+param+"="+param+";"
		
		_EventFired --return
	),
	
	
	/** Add function brackets E.g.: "fooCallback" return "fooCallback()|fooCallback(val)"
	 */
	function _addFunctionBrackets &callback params =
	(
		--print "Events_v._addFunctionBrackets()"
		--format "params	= % \n" params
		if( params == "" ) then 
			params = "()"
		
		if not( matchPattern callback pattern:"* *" ) then 
			if not( matchPattern callback pattern:("*(*)") ) then
				callback += " " + params
				--callback += "("+params+")"
	),
		
	/** Get parameters of callback defined in event_params
	 */
	function _setCallbackParamters &params type =
	(
		--print "Events_v._setCallbackParamters()"
		--format "type	= % \n" type
		--format "params	= % \n" params
		
		if( ( _event_params = this._getEventParameters type ) != undefined and params == "" ) then
			params = _event_params
		
		params --return
	),
	
	/** If event in Events.event_types is Array, then it has parameter
	 */
	function _getEventParameters type =
	(
		--print "Events_v._getEventParameters()"
		--format "type	= % \n" type
		--format "event_params	= % \n" event_params
		
		----event_params	= #( "val" ) 

		
		params = ""
		
		for event_param in event_params where event_param[1] == type do
			params = event_param[2]
		
		
		--format "params	= % \n" params
		params --return
	),
	
	
	/** _is event exists
	 */
	function _isEventExists type =
	(
		--print "Events_v._isEventExists()"
		--format "event_types	= % \n" event_types
		findItem event_types type > 0 --return
	),
	
	
	
	
	
	/**  
	 *	
	 */
	on create do
	(
		--format "Events_v.onCreate() % \n" event_types
	)	
)