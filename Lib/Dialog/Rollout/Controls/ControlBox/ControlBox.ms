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
	/* dependency */
	/* reference */
	Parent_roll,
	Layout,
	/* properties of Groupbox */
	id,
	caption,
	
	Groupbox,

	Controls	= #(),
	
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
		_Control.Props.add #columns 4
		
		if( add ) then
			this.add _Control
		
		_Control --return
	),
	
	/** Add control to rollout
	 */
	function add &Control =
	(
		append Controls Control
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
		for Control in controls do
			this._addControl Control
	),
	
	/** _add control
     */
    function _addControl Control =
    (
		Layout.setControlDimensions Control
		--Control.setLayoutCoordinates()
		
		this._addControlToUi Control
    ),

	/** Add id
	 */
	function _addGroupBox =
	(		
		Layout.setGroupboxDimensions Groupbox

		--Layout.nextControlsBox()

		this._addControlToUi Groupbox
	),

	/** Add each control to rollout
	 *
	 * @param	[Control_v]	Controls	Array of Control_v
	 */
	function _addControlToUi Control =
	(
		--format "\n------------\nControlBox._addControlToUi %\n" (Control.Id.get()) as string 
		Parent_roll.RolloutCreator._rolloutCreator.addControl (Control.type) (Control.id.id) (Control.caption) paramStr:(Control.Props.join())
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
