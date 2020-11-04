
	public
	
	/* required properties */
	type,
	caption,
	__construct = #( #type, #caption ),
	
	/* dependency */
	Id      	= ControlId_v	Parent_control:this,
	--Events	= ControlEvents_v	Parent_control:this,
	Props	    = Props_v	Control:this,

	/* reference */
	Parent_roll,

	/* properties */ 
	name_of_value_param	= #value,
	value,
	
	/* options */
	_col 	= 4,
	dimensions	= #(),	-- dimensions of control #( [xy] position, integer width, integer height )
	
	/*------ EXTENDED EVENTS ------*/
	--pressed	 = Events.pressed,
	--changed	 = Events.changed,
	--rightclick = Events.rightclick,

	/** _set id
	 */
	function setId id =
	(
		this.Id.setId id
	),
		
	--/** Set parameters for control
	--  * @param	string	params_string	String of params E.G.: "enabled: false, border: false"
	-- */
	--function params =
	--(
	--	--string_split	= filterString params_string ","
	--	--
	--	--for key_value_string in string_split do
	--	--(
	--	--	key_value	= filterString key_value_string ":"
	--	--	Props.add key_value[1] key_value[2]
	--	--)
	--	--this --return
	--	
	--	"" --return
	--),
	
	--/** Param
	-- */
	--function param key value =
	--(
	--	Props.add ( key as string ) value
	--
	--	this --return
	--),
	
	--/** Set width of control in columns 
	--  * @param	integer	columns	Number of columns
	--  * @return	self
	-- */
	--function col columns =
	--(
	--	_col = columns
	--
	--	this --return
	--),
	
	/** Find if control is rendered in ui already
	  *
	  * When rollout is rendered, then control is rendered immediately
	 */
	function exists =
	(
		--print "------------\nControlBase.exists()"

		control_exists	= false 

		if( Parent_roll.exists() ) then
			try(
				control_exists = (execute Id.full) != undefined
			)catch()

		control_exists --return
	),

	/** _set caption
	 */
	function _setCaption =
	(
		caption	= trimLeft ( trimRight caption "_" )  "_"
	),

	--private
	
	/** Add quotes to parameter if value is string
	  * Add value to params
	 */
	function _setValueParameter value =
	(
		--print "------------\nControlExtends._setValueParameter()"
		this.param name_of_value_param (this._formatDatatypeValue value)
	),
	/** Format datatype of value
	  * Put quotes around string value
	 */
	function _formatDatatypeValue value =
	(
		if( classOf value == String and this._isValueBooleanString value == false ) then 
			"\""+value+"\"" --return
		else
			value --return 
	),
	/** Is value boolean string E.G.: "true" OR "false"
	 */
	function _isValueBooleanString value =
	(
		matchPattern value pattern:"true" or matchPattern value pattern:"false" 
	),
	
	/** _set dimensions
	 */
	function _setDimensions =
	(
		--print "------------\nControlExtends._setDimensions()"
		dimensions = Parent_roll.Layout.setControlDimensions _col (Props.get #pos) (Props.get #width) (Props.get #height)
		--format " Props.get #width = % \n" (Props.get #width)
		--format " pos 	= % \n width	= % \n height	= % \n\n" dimensions[1] dimensions[2] dimensions[3]

		Props.add #pos    dimensions[1] force:true
		Props.add #width  dimensions[2] force:true
		Props.add #height dimensions[3] force:true
	),


	/** Get parameters
	 */
	function _getParameters =
	(
		--this._setDimensions()

		Props.join() + this._getTooltip() --return
		--this._getTooltip() --return
	),

	/** Get tooltip, if button then get tooltips from eventsz
		Set prefixes "Leftclick:" & "\nRightclick:"
	 */
	function _getTooltip =
	(
		tooltip =	""
		
		if( type == #button ) then
		(
			Event_pressed	= Events.Events.getEvent "pressed"
			Event_rightclick	= Events.Events.getEvent "rightclick" 
			--print ( "Event_pressed = " + Event_pressed as string )
			--print ( "Event_rightclick = " + Event_rightclick as string )
			
			if( Event_pressed != undefined  and Event_rightclick != undefined ) then
				tooltip = "Leftclick:    " + Event_pressed.tooltip + "\nRightclick: " + Event_rightclick.tooltip

			else if( Event_pressed != undefined ) then
				tooltip = Event_pressed.tooltip
		)
		
		if( tooltip!=undefined ) then ( " tooltip:\""+tooltip+"\"" ) else "" --return
	),

	/** Check if required properties are defined
	  * Names of construct props are defined in __construct array E.g.: __construct = #( #prop_name ) 
	  * @param	construct_properties this.properties required for initialization of struct
	 */
	function _checkConstctructProperties =
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),
	
	/** Set type of control by class name of control
	  *
	  * Get 1st part of struct name until underscore "_" E.G.: Get #button from "struct button_optionable_namespace()"
	 */
	function _setType =
	(
		if( type == undefined ) then
			type = toLower (( filterString( classof this as string ) "_*(:" )[2])
	),

	--/** Get value from ini
	-- */
	--function _getValueFromIni =
	--(
	--	print "------------\nControlExtends._getValueFromIni()"
	--	print "HOTFIX"
	--	ini_path = Parent_roll.ini
	--	
	--	if( ini_path != undefined ) then
	--		value = ((Ini_v()).path ini_path ).load Parent_roll.id id --return
	--	
	--	value --return
	--),	
	--
	--/** Get Name of value parameter by type of control E.G.: CKECBOX = #checked | EDITTEXT = #text | DEFAULT = #value
	--  * 
	--  * Return value name_of_value_param property if defined, else return #value
	--  * 
	--  * @return	name 
	-- */
	--function _getNameOfValueParameter =
	--(
	--	if( hasProperty this "name_of_value_param" ) then name_of_value_param else name_of_value_param_extend --return
	--),
	
	--/** _set value
	-- */
	--function _setValue =
	--(
	--	if( value==undefined ) then
	--		this._getValueFromIni()
	--
	--	if( value!=undefined and value!=""  ) then
	--		this._setValueParameter value
	--	----else
	--		----this._getValueFromIni()
	--),
