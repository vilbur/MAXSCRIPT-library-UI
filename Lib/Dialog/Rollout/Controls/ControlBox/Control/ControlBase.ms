
	public
	
	/* required properties */
	__construct = #( #type ),
	type,
	caption,

	/* properties */ 
	name_of_value_param	= #value,
	init_parameters, -- 2D matrix of keys and values of parameters E.G.: #( #( #width, #height ), #( 64, 32 ) )
	Menu,
	
	/* dependency */
	Id,
	Events     = ControlEvents_v	Parent_Control:this,
	_Parameters = Params_v(),
	Properties = Properties_v	Parent_Control:this,
	

	/* reference */
	ControlBox,

	/* options */
	dimensions	= #(),	-- dimensions of control #( [xy] position, integer width, integer height )


	/** _set id
	 */
	function setId id =
	(
		this.Id.setId id
	),
	/** Get id
	 */
	function getId =
	(
		Id.full --return
	),

	/** Set Controls Common Properties
	  * 
	  * http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_3880D745_8496_4DFB_8B31_4DEAC152DBB3_htm
	  *
	  * @property	mixed	name|title|open|scrollPos|height|width
     */
    function property enabled: title: visible: pos: height: width: columns: border: range: scale: =
    (
		Properties.getOrSet #(#enabled, #title, #visible, #pos, #height, #width, #columns, #border, #range, #scale) #(enabled, title, visible, pos, height, width, columns, border, range, scale)
	),
	
	/** Set dimensions
     */
    function setDimensions Dimensions =
    (
		--format "HOTFIX ControlBase.ms.setDimensions() %\n" Dimensions
		_Parameters.getOrSet #( #pos, #width, #height ) #( Dimensions.pos, Dimensions.width, Dimensions.height )
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

	/** Init Control struct
	  * Shared with all control types
	 */
	function _init = 
	(
		--print "ControlOnCreate.ms _init()"
		this._setType()
		--format "id = % \n" id
		this.Events.setEventTypes()
	
		this._checkConstctructProperties()
		
		this._setCaption()
	
		Id = ControlId_v	Parent_Control:this id:id
		--format "init_parameters = % \n" init_parameters
		--this.params columns:4
		--this._setValue()
		
		_Parameters.getOrSet init_parameters[1] init_parameters[2]
		
		this.Events.setDefaultEvents()
		
		this._addToControls()
	),
	
	/** Add itself to Controls
	 */
	function _addToControls =
	(
		--print ("ControlBase.ms._addToControls() " + ControlBox.Groupbox.id.id as string )
		ControlBox.add this
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

	/** _set caption
	 */
	function _setCaption =
	(
		caption	= trimLeft ( trimRight caption "_" )  "_"
	),
	
	/** Add quotes to parameter if value is string
	  * Add value to params
	 */
	function _setValueParameter value =
	(
		--print "------------\nControlBase._setValueParameter()"
		_Parameters.getOrSet name_of_value_param (this._formatDatatypeValue value)
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


	/** Check if required properties are defined
	  * Names of construct props are defined in __construct array E.g.: __construct = #( #prop_name ) 
	  * @param	construct_properties this.properties required for initialization of struct
	 */
	function _checkConstctructProperties =
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),

	--/** Get value from ini
	-- */
	--function _getValueFromIni =
	--(
	--	print "------------\nControlBase._getValueFromIni()"
	--	print "HOTFIX"
	--	ini_path = ControlBox.Parent_roll.ini
	--	
	--	if( ini_path != undefined ) then
	--		value = ((Ini_v()).path ini_path ).load ControlBox.Parent_roll.id id --return
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
