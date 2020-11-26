
	public
	
	/* required properties */
	__construct = #( #type ),
	type,
	caption,
	
	/* dependency */
	Id         = ControlId_v	Parent_Control:this,
	Events     = ControlEvents_v	Parent_Control:this,
	Properties = Properties_v	Parent_Control:this,
	--ControlTypes = ControlTypes_v	Parent_Control:this,
	_Parameters = Params_v(),

	/* reference */
	Parent_roll,
	ControlBox,

	/* properties */ 
	name_of_value_param	= #value,
	value,
	
	/* options */
	--_col 	= 4,
	dimensions	= #(),	-- dimensions of control #( [xy] position, integer width, integer height )
	
	--newControl = ControlTypes.newControl,
	
	/** New control
	  *
	  *
	  *
	  * @return	this Control itself	
	 */
	function newControl caption id: add:true include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/Includes/ControlParams.ms" =
	(
		format "------------\nControlTypes_v.newControl \n"
		format "type = % \n" type
		--format "ControlTypes = % \n" ControlTypes
		_Parameters.getOrSet include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/Includes/ControlParamsArray.ms"

		this.caption = caption
		
		this.setId id
		
		if( type != #groupbox ) then 
		ControlBox.add this
		
		this
	),

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
	
	/** Set Controls Common Parameters
	 */
	function params include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/Includes/ControlParams.ms" =
    (
		_Parameters.getOrSet include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/Includes/ControlParamsArray.ms"
	),
	
	--/** Set Controls Common Parameters 
	-- */
	--function params pos: height: width: align: offset: across: -- [Common] (http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_EA37E7DB_1E74_4377_B3D8_EDAE19CE27E7_htm)
	--			 images: border:                            -- [Button] (http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_E03EED5F_E21F_4C2F_AFA9_BA16A6602ACA_htm)
	--             toolTip: =
	--(
	--	_Parameters.setParams #( #pos, #height, #width, #align, #offset, #acros, #images ,#toolTip ,#border ) #( pos, height, width, align, offset, across, images, toolTip, border )
	--	
	--	
	--	
	--),
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
		this.params pos:Dimensions.pos width:Dimensions.width height:Dimensions.height
    ),

	/** Find if control is rendered in ui already
	  *
	  * When rollout is rendered, then control is rendered immediately
	 */
	function exists =
	(
		control_exists	= false 

		if( Parent_roll != undefined and Parent_roll.exists() ) then
			try(
				control_exists = (execute Id.full) != undefined
			)catch()

		--format "ControlBase.exists() % exists = %\n" (this.getId()) control_exists
		control_exists --return
	),

	private

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

	--/** Get parameters
	-- */
	--function _getParameters =
	--(
	--	--this._setDimensions()
	--
	--	Properties.join() + this._getTooltip() --return
	--	--this._getTooltip() --return
	--),

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


	--/** Get value from ini
	-- */
	--function _getValueFromIni =
	--(
	--	print "------------\nControlBase._getValueFromIni()"
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
