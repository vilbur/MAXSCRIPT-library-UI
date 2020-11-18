filein( getFilenamePath(getSourceFileName()) + "/Control/ControlId/ControlId.ms" )

filein( getFilenamePath(getSourceFileName()) + "/Control/Control.ms" )

filein( getFilenamePath(getSourceFileName()) + "/ControlTypes/Button/Button.ms" )
--filein( getFilenamePath(getSourceFileName()) + "/ControlTypes/Checkbox/Checkbox.ms" )


/** Section of Controls, can be id if "ControlBox_v.id" is definded
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
	/* reference */
	Parent_roll,
	Layout,
	/* properties of Groupbox */
	id,
	caption,
	
	Groupbox,

	Controls	= #(),
	
	/* dependency */
	Properties = Properties_v Parent_Control:this,

	
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/ControlBoxControlTypes.ms"

		
	/** Add control to rollout
	 */
	function add &Control =
	(
		append Controls Control
	),

	/** Set any property for rollout 
	  * https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
	  *
	  * @property	mixed	name|title|open|scrollPos|height|width
     */
    function property caption: pos: height: width: =
    (
		--format "ControlBox_v.property pos % \n" pos
		Properties.getOrSet #( #caption, #pos, #height, #width ) #( caption, pos, height, width )
	),
	
	/** Offset Controls
	 */
	function offsetGroupbox offset =
	(
		this.property pos:offset
		
		offset.y += Parent_roll.Layout.padding_groupbox
		
		for Control in Controls do
		(
			--offset.x += Control.Properties.get #pos
			--Control.Properties.add #pos offset  --!!! PREDELAT Cotrol.Properties na Control.property()
			
		)
	),
	
	/** Get id
	 */
	function getId =
	(
		Parent_roll.getId() + "." + Groupbox.id.id --return
	),
	
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
		_Control.property columns:4
		--format "ControlBox_v._newControl %\n" (_Control.getId() )
		
		if( add ) then
			this.add _Control
		
		_Control --return
	),

	/** Set group box
     */
    function _setGroupBox =
    (
		if not( caption == unsupplied ) then
			Groupbox = this._newControl (Control_v type:#Groupbox caption:caption ) id:id add:false
    ),

	/** Create Controls and add them to UI
     */
    function _create =
    (
		Layout.newControlsBox()

		this._addControls()
		
		if (Groupbox != unsupplied ) then
			this._addGroupBox()
    ),

	/** Add each control to rollout
	  *
	  * @param	[Control_v]	Controls	Array of Control_v
	 */
	function _addControls =
	(
		for Control in Controls do
			this._addControl Control
	),
	
	/** _add control
     */
    function _addControl Control =
    (
		print "ControlBox._addControl()"
		Layout.setControlDimensions Control
		
		this._addControlToUi Control
    ),

	/** Add id
	 */
	function _addGroupBox =
	(		
		Layout.setGroupboxDimensions Groupbox

		this._addControlToUi Groupbox
	),

	/** Add each control to rollout
	 *
	 * @param	[Control_v]	Controls	Array of Control_v
	 */
	function _addControlToUi Control =
	(
		--format "\n------------\nControlBox._addControlToUi %\n" (Control.Id.get()) as string 
		Parent_roll.RolloutCreator._rolloutCreator.addControl (Control.type) (Control.id.id) (Control.caption) paramStr:(Control.Properties.join())
		--Parent_roll.RolloutCreator._rolloutCreator.addControl (Control.type) (Control.id.id) (Control.caption)
	),

	/*------------------------------------------------------------------------------
		CONSTRUCT
	--------------------------------------------------------------------------------*/

	/**  
	 */
	on create do
	(
		--this._checkConstctructProperties()
		this._setGroupBox()
		
		Layout = Parent_roll.Layout
	)
	
)
