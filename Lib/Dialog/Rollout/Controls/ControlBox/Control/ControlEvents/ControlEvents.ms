filein( getFilenamePath(getSourceFileName()) + "/../../../../../../Events/Events.ms" )
/** Control
 *
 *	====================================================================
 *
 *		!!!!!! IMPORTANT !!!!!!
 *
 *		Add New EVENT Type:
 *			1) Create method in this file
 *			2) Extend this method in struct Control_v
 *		
 *	====================================================================
 *		
 */
struct ControlEvents_v 
(
	/* dependency */
	Events	= Events_v(),

	Parent_Control,

	/** Set event types available for each type of control
	 */
	function setEventTypes =
	(
		format "ControlEvents_v.setEventTypes %\n" Parent_Control.type
		event_types = List_v()
		
		event_types.setVal #button      #( #rightclick, #pressed )
		event_types.setVal #checkbox    #( #rightclick, #changed )
		event_types.setVal #checkbutton #( #rightclick, #changed )
		event_types.setVal #spinner     #(              #changed, #entered, #buttondown, #buttonup )
		--event_types.setVal #spinner     #(#changed)
		
		Events.event_types = (event_types.getVal Parent_Control.type)
	),
	
	/*---------------------------------------
		BIND EVENT BY TYPE
		
		Common parameters:
			@param	string	callback	Code executed on event
			@param	callback	tooltip	Tooltip for control
	-----------------------------------------*/
	/** Bind pressed event
	 */
	function pressed callback tooltip:"" =
	(
		this.setEvent #pressed callback tooltip
	),

	/** Bind changed event
	  * Value of control is passed to control as variable "val" 
	  */
	function changed callback tooltip:"" =
	(
		this.setEvent #changed callback tooltip
	),

	/** Bind rightclick event
	  */
	function rightclick callback tooltip:"" =
	(
		this.setEvent #rightclick callback tooltip
	),
	
	/** Set event
	 */
	function setEvent type callback tooltip params:"" =
	(
		if( (type == #changed or type == #buttonup  ) and params == "" ) then 
			params = "val"
		
		this.Events.add (Event_v type:type code:callback tooltip:tooltip params:params)
		
		Parent_Control --return
	),

	/** Set default event, save to ini if ini is defined in rollout
	 */
	function setDefaultEvents =
	(
		if( Parent_Control.ControlBox.Parent_roll.ini != undefined ) then
			this.setSaveToIniCallback()
	),
	
	/** Set save to ini callback
	 */
	function setSaveToIniCallback =
	(
		format "------------\nControlEvents.setSaveToIniCallback() % %\n" Parent_Control.id.id Parent_Control.type
		--format " Parent_Control	= % \n" Parent_Control
		--format " Parent_Control.path	= % \n" Parent_Control.id.id
		--section_key	= filterString Parent_Control.id.id "."
		
		dynamic_types = #(#changed)

		format "Events.event_types = % \n" Events.event_types
		
		for event_type in Events.event_types where findItem dynamic_types event_type > 0 do
			this.Events.setDefaultEvent(Event_v type:#changed code:("setINISetting \""+Parent_Control.ControlBox.Parent_roll.ini+"\" \""+Parent_Control.ControlBox.Parent_roll.id+"\" \""+Parent_Control.id.id+"\" (val as string)") params:"val")
	),

	/** _add handlers
	  *http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_5FC5036F_E2D7_46C9_9AFA_7B3550B9F254_htm
	 */
	function addHandlers =
	(
		--print ( "ControlEvent_v._addHandlers=" + this.Events.getEvents() as string )
		_Events = this.Events.getEvents()
		
		for _Event in _Events do
			Parent_Control.ControlBox.Parent_roll.RolloutCreator.addhandler Parent_Control.id.id _Event
	),
	
	private

	on create do
	(
	)
)
