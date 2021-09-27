
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
	event_types,
	
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

		if(  event_types != undefined ) then
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
	
	/** Set event fired
	  *
	  * @return	string	
	 */
	function setEventFired type id val:"val" =
	(
		local EventFired = "EventFired.control=\""+(id)+"\";"
		
		EventFired    += "EventFired.type=#"+type+";"
		
		EventFired    += "EventFired.value="+val as string +";"
		
		EventFired --return
	),
	
	/**  
	 *	
	 */
	on create do
	(
		--format "Events_v.onCreate() % \n" event_types
	)	
)