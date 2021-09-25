filein( getFilenamePath(getSourceFileName()) + "/../../../../../../Events/Events.ms" )
filein( getFilenamePath(getSourceFileName()) + "/EventFired/EventFired.ms" )

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
		--event_types.setVal #spinner     #(#changed)
		
		Events.event_types = (event_types.getVal Parent_Control.type)
	),
	
	/** Set event by type
	  * 
	  * @property	#name	type	of callback
	  * @param	string	callback	code executed on event
	  * @param	string	tooltip	tooltip for control
	  * @property	string	params	for callback
	  * 
	  * @return	object Control	
	 */
	function setEvent type callback tooltip params:"" =
	(
		--format "ControlEvents_v.setEvent type:% callback:% tooltip:%\n" type callback tooltip
		if( (type == #changed or type == #entered or type == #buttonup  or type == #buttondown   ) and params == "" ) then 
			params = callback_value_name
		
		callback = (this.Events.setEventFired type (Parent_Control.id.getIdFull())) + callback

		this.Events.add (Event_v type:type code:callback tooltip:tooltip params:params)
		
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

		dynamic_types = #( #changed, #entered, #buttondown, #buttonup )

		if( this._iniFileIsDefined() and Events.event_types != undefined ) then
			for event_type in Events.event_types where findItem dynamic_types event_type > 0 do
				this.Events.setDefaultEvent(Event_v type:event_type code:("setINISetting \""+(Parent_Control.ControlBox.Parent_roll.ini #get)+"\" \""+Parent_Control.ControlBox.Parent_roll.id+"\" \""+Parent_Control.id.id+"\" (val as string)") params:"val")
	),

	/** _add handlers
	  * http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_5FC5036F_E2D7_46C9_9AFA_7B3550B9F254_htm
	 */
	function addHandlers =
	(
		--print ( "ControlEvent_v._addHandlers=" + this.Events.getEvents() as string )
		_Events = this.Events.getEvents()
		
		for _Event in _Events do
			Parent_Control.ControlBox.Parent_roll.RolloutCreator.addhandler Parent_Control.id.id _Event
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
