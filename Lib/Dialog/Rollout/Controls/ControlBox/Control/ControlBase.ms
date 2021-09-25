
	public
	
	/* required properties */
	__construct = #( #type ),
	type,
	caption,

	/* properties */ 
	name_of_value_param,
	init_parameters     = #( #(), #() ), -- 2D matrix of keys and values of parameters E.G.: #( #( #width, #height ), #( 64, 32 ) )
	add_to_controls		= true, -- add control to UI on creation, false for example when generating controls in ControlCreator_v.createControl()
	
	/* dependency */
	Menu,
	Id,

	--CotrolValue = CotrolValue_v   Parent_Control:this,
	Events      = ControlEvents_v	Parent_Control:this,
	Properties  = Properties_v	Parent_Control:this,
	_Parameters = Params_v(),
	
	/* reference */
	ControlBox,

	/* options */
	dimensions	= #(),	-- dimensions of control #( [xy] position, integer width, integer height )

	/** Value
	 */
	function value _value =
	(
		print "ControlBase.ms value()"
		format "_value = % \n" _value
		--_Parameters.setVal name_of_value_param _value
	),

	/** Set param
	 */
	function setParam key _value =
	(
		_Parameters.setVal key _value
	),

	/** Set Controls Common Properties
	  * 
	  * http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_3880D745_8496_4DFB_8B31_4DEAC152DBB3_htm
	  *
	  * @property	mixed	name|title|open|scrollPos|height|width
     */
    function property enabled: title: visible: pos: height: width: columns: border: range: scale: =
    (
		Properties.setVal #(#enabled, #title, #visible, #pos, #height, #width, #columns, #border, #range, #scale) #(enabled, title, visible, pos, height, width, columns, border, range, scale)
	),
	
	/** Set dimensions
     */
    function setDimensions Dimensions =
    (
		--format "HOTFIX ControlBase.ms.setDimensions() %\n" Dimensions
		_Parameters.setValues #( #pos, #width, #height ) #( Dimensions.pos, Dimensions.width, Dimensions.height )
    ),

	/** Find if control is rendered in ui already
	  *
	  * When rollout is rendered, then control is rendered immediately
	 */
	function exists =
	(
		control_exists	= false 

		--if( ControlBox.Parent_roll != undefined and ControlBox.Parent_roll.exists() ) then
		try(
			control_exists = (execute Id.full) != undefined
		)catch()

		--format "ControlBase.exists() % exists = %\n" (this.getId()) control_exists
		control_exists --return
	),

	/** Set menu
	 */
	function setMenu Menu event:#rightclick =
	(
		Menu.Create()
		
		this.Events.setEvent event ("popUpMenu "+Menu.name+" rollout:"+ControlBox.Parent_roll.id ) ("Menu "+Menu.name)
	),
	
	private

	/** Add self to Controls
	 */
	function _addToControls =
	(
		--print ("ControlBase.ms._addToControls() " + ControlBox.Groupbox.id.id as string )
		ControlBox.add this
	),

	/** _set caption
	 */
	function _setCaption =
	(
		caption	= trimLeft ( trimRight caption "_" )  "_"
	),

	/** Set type of control by class name of control
	  *
	  * Get 1st part of struct name until underscore "_" E.G.: Get #button from "struct button_optionable_namespace()"
	 */
	function _setType =
	(
		if( type == undefined ) then
			type = ( toLower (( filterString( classof this as string ) "_*(:" )[2]) ) as name
		--format "ControlOnCreate._setType %\n" type
	),
	
	/** _get value from ini
	 */
	function _getValueFromIni =
	(
		--print "ControlBase.ms _getValueFromIni()"
		if( (ControlBox.Parent_roll._Ini.isDefined()) and name_of_value_param != undefined ) then 
		(
			val = ControlBox.Parent_roll._Ini.load (ControlBox.Parent_roll.id) (id.id)
			--format "type = % \n" type
			if( type == #spinner ) then
				val   = this. _setValueTopoint3 val

			_Parameters.setVal name_of_value_param val
		)
	),
	
	/** _set value topoint3
	 */
	function _setValueTopoint3 val =
	(
		range = _Parameters.getVal #range
		--format "!!! range = % \n" range
		[ range[1], range[2], val ]
	),
	
	/** Check if required properties are defined
	  * Names of construct props are defined in __construct array E.g.: __construct = #( #prop_name ) 
	  * @param	construct_properties this.properties required for initialization of struct
	 */
	function _checkConstctructProperties =
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ( (filenameFromPath(getSourceFileName())) "+\nUndefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),

	public

	/** Init Control struct
	  * Shared with all control types
	 */
	function onCreate = 
	(
		--print "ControlBase.ms onCreate()"
		this._setType()

		this._checkConstctructProperties()
	
		this.Events.setEventTypes()
		
		this._setCaption()
		
		Id = ControlId_v	Parent_Control:this id:id
		
		_Parameters.setValues init_parameters[1] init_parameters[2]

		this._getValueFromIni() -- get values after setting of parameters, ini values then overwrite given values
	),
	