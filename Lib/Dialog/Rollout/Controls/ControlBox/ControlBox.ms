filein( getFilenamePath(getSourceFileName()) + "/Control/ControlId/ControlId.ms" )

filein( getFilenamePath(getSourceFileName()) + "/Control/Control.ms" )

filein( getFilenamePath(getSourceFileName()) + "/ControlTypes/Button/Button.ms" )
--filein( getFilenamePath(getSourceFileName()) + "/ControlTypes/Checkbox/Checkbox.ms" )


/** Section of controls, can be id if "ControlBox_v.id" is definded
  * [ GroupBox UI Control ] (http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_A8C801C7_BA79_448C_A1EE_28C40B16287C_htm)
  * Control types: http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_E421933F_958E_42FD_80A1_D66F2A2C0A06_htm
  *
  * @property	string	id	Store name of [ id ](http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_A8C801C7_BA79_448C_A1EE_28C40B16287C_htm)
  *
  *
  * Id of id has suffix "_groupbox"
 */
struct ControlBox_v 
(
	/* required */
	/* dependency */
	/* reference */
	Parent_roll,
	/* properties */
	id,
	groupbox,
	
	controls	= #(),
	
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/ControlBoxControlTypes.ms"

	/**  Add control of any type
	 *  @param	string	type	Type of control
	 *  @param	string	caption	Caption of control
	 * 
	 *  @return	[Control](../../Control)
	 */
	function _newControl _Control id: add:true =
	(
		_Control.Parent_roll = Parent_roll
		_Control.setId id
		
		if( add ) then
			this.add _Control
		
		_Control --return
	),
	
	/** Add control to rollout
	 */
	function add &Control =
	(
		append controls Control
	),
	
	/** Create controls and add them to UI
     */
    function _create =
    (
		this._addGroupBoxToUi()
		
		for Control in controls do
			this._addControlToUi Control	
    ),
	
	--/** Add each control to rollout
	--  *
	--  * @param	[Control_v]	controls	Array of Control_v
	-- */
	--function _addControls controls =
	--(
	--	--format "controls = % \n" controls
	--	for Control in controls do
	--		this._addControlToUi Control
	--),


	/** Set group box
     */
    function _setGroupBox =
    (
		if not( groupbox == unsupplied ) then
			groupbox = this._newControl (Control_v type:#groupbox caption:groupbox ) id:id add:false
    ),

	/** Add id
	 */
	function _addGroupBoxToUi =
	(
		if ( groupbox == unsupplied ) then
			return false
			
		this._addControlToUi groupbox
	),
	
	/** Add each control to rollout
	 *
	 * @param	[Control_v]	controls	Array of Control_v
	 */
	function _addControlToUi Control =
	(
		print ("------------\nControlBox._addControlToUi "+(Control.Id.get()) as string )
		
		
		Control.setLayoutCoordinates()
		
		Parent_roll.RolloutCreator._rolloutCreator.addControl Control.type Control.id.id Control.caption paramStr:(Control.Props.join())
	),

	--/** Get id
	-- */
	--function getId =
	--(
	--	groupbox_suffix = "_groupbox"
	--	(( dotNetObject "System.Text.RegularExpressions.Regex" @"[\s-]+" ).Replace ( toLower id ) "_" ) + groupbox_suffix--return
	--),
	--/** Exists
	-- */
	--function exists =
	--(
	--	false
	--),
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	/** _get id params
	 */
	--function _getGroupboxParams =
	--(
		--print "------------\nControlBox._getGroupboxParams()"
		--dimensions	= Parent_roll.Layout._getGroupboxDimensions()
		--format " pos 	= % \n width	= % \n height	= % \n\n" dimensions[1] dimensions[2] dimensions[3]
		
		--Props	= Props_v Control:this
		--
		--Props.add #pos	dimensions[1]
		--Props.add #width	dimensions[2]
		--Props.add #height dimensions[3]
		--Props.add #height 48
		
		--Props.join() --return
		--""
	--),
	

	/*------------------------------------------------------------------------------
		CONSTRUCT
	--------------------------------------------------------------------------------*/
	
	--/** Check if required properties are defined when an instance of the struct is created.
	-- *	
	-- * @example __construct = #( #property_name ) 
	-- */
	--function _checkConstctructProperties =
	--(
	--	for prop in __construct where getProperty this prop == undefined do
	--		messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	--),
	/**  
	 */
	on create do
	(
		--this._checkConstctructProperties()
		this._setGroupBox()
	)
	
)
