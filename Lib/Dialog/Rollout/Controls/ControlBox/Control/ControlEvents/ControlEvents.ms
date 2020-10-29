filein( getFilenamePath(getSourceFileName()) + "/../../../Events/Events.ms" )

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
	Events	= Events_v event_types:#("pressed", "rightclick", "changed"),

	Parent_control,

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
		this._setEvent "pressed" callback tooltip
	),
	/** Bind changed event
	  * Value of control is passed to control as variable "val" 
	  */
	function changed callback tooltip:"" =
	(
		this._setEventWithValue "changed" callback tooltip
	),
	/** Bind rightclick event
	  */
	function rightclick callback tooltip:"" =
	(
		this._setEvent "rightclick" callback tooltip
	),

	/** Set default event, save to ini if ini is defined in rollout
	 */
	function setDefaultEvents =
	(
		if( Parent_control.parent_roll.ini != undefined ) then
			this.setSaveToIniCallback()
	),
	
	/** Set save to ini callback
	 */
	function setSaveToIniCallback =
	(
		--print "------------\nControlEvents.setSaveToIniCallback()"
		--format " Parent_control	= % \n" Parent_control
		--format " Parent_control.path	= % \n" Parent_control.id.id
		--section_key	= filterString Parent_control.id.id "."
		
		rollout_id	= Parent_control.Parent_roll.id
		save_to_ini = rollout_id + ".saveIni @"+rollout_id+"@ @"+Parent_control.id.id+"@ (val as string )"
		
		this.Events.setDefaultEvent(Event_v type:"changed" code:save_to_ini params:"val")
	),
	
	
	/*---------------------------------------
		PRIVATE 
	-----------------------------------------*/
	/** Set event
	 */
	function _setEvent type callback tooltip =
	(
		this.Events.add (Event_v type:type code:callback tooltip:tooltip)
		
		Parent_control --return
	),
	/** Set event with parameter in callback, E.G.: for checkbox
	  *	placeholder for variable of value is "val"
	 */
	function _setEventWithValue type callback tooltip =
	(
		this.Events.add (Event_v type:type code:callback tooltip:tooltip params:"val")
		
		Parent_control --return
	),
	/** _add handlers
	 */
	function _addHandlers =
	(
		--print ( "ControlEvent_v._addHandlers=" + this.Events.getEvents() as string )
		_Events = this.Events.getEvents()
		
		for _Event in _Events do
			Parent_control.parent_roll.roll.addhandler  Parent_control.id.id _Event.type codeStr:_Event.code  paramStr:_Event.params 
	),
	

	function test =
	(
		messagebox "Control_v.test()"
	)
)
