
/** Events
  *
  * @property	array	event_types	Allowed types of events, E.G.: for button event_types = #("pressed", "changed")
  *
  *
 */
struct Events_v  
(
	Events	= List_v(),
	Events_default	= List_v(),
	event_types,
	
	/*---------------------------------------
		SET EVENTS TO LIST
	-----------------------------------------*/
	/** Set Event to Events
	 */
	function setDefaultEvent Event =
	(
		--print ( "_setDefaultEvent=" + Event as string )
		this.Events_default.setVal Event.type Event
	),
	/** Add Event to Events
	 */
	function add Event =
	(
		this.Events.setVal Event.type Event
	),
	
	/*---------------------------------------
		ADDING EVENT HANDLERS
	-----------------------------------------*/
	/**  
	 */
	function getEvents =
	(
		Events_merged	= #()
		--format "Events_v.event_types = % \n" event_types
		if(  event_types != undefined ) then
		for event_type in event_types do
			append Events_merged (this.getEvent event_type)
		
		for Event_merged in Events_merged where Event_merged!=undefined collect Event_merged --return
	),
	
	/*---------------------------------------
		MERGE EVENTS
	-----------------------------------------*/
	/** Get events
	  *
	  * @property	#name	event_type	#pressed|#rightclick|#changed etc.
	  *
	 */
	function getEvent event_type =
	(
		--print ( "Events_v._mergeEvent() " + event_type as string )
		Event_default	= Events_default.getVal	event_type
		Event	= Events.getVal	event_type
		
		if( Event_default != undefined or Event != undefined ) then
			this.mergeEvents Event_default Event
		else
			undefined
		
		--Event
		--print ( "Events_v._mergeEvent() " + event_type as string )
	),
	/** Merge events
	 */
	function mergeEvents Event_default Event =
	(
		Event_merged 	= Event_v type:(this._getEventProperty Event_default Event "type")
		
		Event_merged.params	= this._getEventProperty	Event_default Event "params"
		Event_merged.code	=(this._getCodeStr	Event_default ) + ";" + ( this._getCodeStr Event )
		Event_merged.tooltip	= this._getEventProperty	Event_default Event "tooltip"
		--print ( "Events_v.mergeEvents() Event_merged = " + Event_merged as string )
		Event_merged --return
	),
	/** Get property from one of defined evets
	 */
	function _getEventProperty Event_default Event property =
	(
		if( Event_default!=undefined ) then
			getProperty Event_default property --return
			
		else
			getProperty Event property --return
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
	
	/**  
	 *	
	 */
	on create do
	(

	)	
)
