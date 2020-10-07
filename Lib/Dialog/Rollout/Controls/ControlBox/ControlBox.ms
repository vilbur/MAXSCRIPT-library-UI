filein( getFilenamePath(getSourceFileName()) + "/Control/ControlId/ControlId.ms" )

filein( getFilenamePath(getSourceFileName()) + "/Control/Control.ms" )

filein( getFilenamePath(getSourceFileName()) + "/ControlTypes/Button/Button.ms" )
--filein( getFilenamePath(getSourceFileName()) + "/ControlTypes/Checkbox/Checkbox.ms" )


/** Section of controls, can be groupbox if "ControlBox_v.groupbox" is definded
  *
  * Control types: http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_E421933F_958E_42FD_80A1_D66F2A2C0A06_htm
  *
  * @property	string	groupbox	Store name of [ groupbox ](http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_A8C801C7_BA79_448C_A1EE_28C40B16287C_htm)
  *
  *
  * Id of groupbox has suffix "_groupbox"
 */
struct ControlBox_v 
(
	/* required */
	/* dependency */
	/* reference */
	/* properties */
	groupbox,
	controls	= #(),
	

	/** Add control to rollout
	 */
	function add &Control =
	(
		append controls Control
	),
	
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/ControlTypes.ms"

	/**  Add control of any type
	 *  @param	string	type	Type of control
	 *  @param	string	caption	Caption of control
	 * 
	 *  @return	[Control](../../Control)
	 */
	function _newControl _Control add:true =
	(
		if( add ) then
			this.add _Control
		
		_Control --return
	),
	
	
	--Parent_roll,
	--id,
	--
	--/** Set parent roll
	-- */
	--function new _parent_roll _groupbox =
	--(
	--	Parent_roll	= _parent_roll
	--	groupbox	= _groupbox
	--	
	--	this --return 
	--),	
	--/** Add groupbox
	-- */
	--function addGroupBox =
	--(
	--	print "------------\nControlBox.addGroupBox()"
	--	----print ( "ControlBox_v.addGroupBox() = " + groupbox as string )
	--	--if( groupbox!=undefined ) then
	--	format " this._getGroupboxParams()	= % \n" (this._getGroupboxParams())
	--		--Parent_roll.roll.addControl #groupbox (this.getId()) groupbox paramStr:(this._getGroupboxParams())
	--	--Parent_roll.roll.addControl #groupbox (this.getId()) groupbox
	--	
	--	--format " groupbox	= % \n" groupbox
	--),
	--
	--/** Get id
	-- */
	--function getId =
	--(
	--	groupbox_suffix = "_groupbox"
	--	(( dotNetObject "System.Text.RegularExpressions.Regex" @"[\s-]+" ).Replace ( toLower groupbox ) "_" ) + groupbox_suffix--return
	--),
	--/** Exists
	-- */
	--function exists =
	--(
	--	false
	--),
	--/*------------------------------------------------------------------------------
	--	PRIVATE
	----------------------------------------------------------------------------------*/
	--/** _get groupbox params
	-- */
	--function _getGroupboxParams =
	--(
	--	--print "------------\nControlBox._getGroupboxParams()"
	--	dimensions	= Parent_roll.Layout._getGroupboxDimensions()
	--	--format " pos 	= % \n width	= % \n height	= % \n\n" dimensions[1] dimensions[2] dimensions[3]
	--	
	--	--Props	= Props_v Control:this
	--	--
	--	--Props.add #pos	dimensions[1]
	--	--Props.add #width	dimensions[2]
	--	--Props.add #height dimensions[3]
	--	--Props.add #height 48
	--	
	--	--Props.join() --return
	--	""
	--),
	
	function test =
	(
		messagebox "Control_v.test()"
	)
)
