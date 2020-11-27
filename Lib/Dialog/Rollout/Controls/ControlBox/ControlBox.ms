filein( getFilenamePath(getSourceFileName()) + "/Control/ControlId/ControlId.ms" )

filein( getFilenamePath(getSourceFileName()) + "/Control/ControlEvents/ControlEvents.ms" )

filein( getFilenamePath(getSourceFileName()) + "/Control/Params/Params.ms" ) 

filein( getFilenamePath(getSourceFileName()) + "/Control/Control.ms" )

filein( getFilenamePath(getSourceFileName()) + "/ControlTypes/Button/Button.ms" )
filein( getFilenamePath(getSourceFileName()) + "/ControlTypes/Checkbox/Checkbox.ms" )
filein( getFilenamePath(getSourceFileName()) + "/ControlTypes/Spinner/Spinner.ms" )


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
	Parent_roll,

	/* reference */
	Layout,     -- Parent_Roll.Layout
	
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
	function add _Control =
	(
		--print ("ControlBox_v.add ")
		--print ("\nControlBox_v.add " + _Control.id.id as string )
		format "\nControlBox_v.add %\n" _Control
		append Controls _Control
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
	
	/** 
	  *
	 */
	function exists =
	(
		Parent_roll.exists() --return
	),
	
	/** Offset Controls
	 */
	function offsetGroupbox new_pos =
	(
		--format "ControlBox_v.offsetGroupbox new_pos % \n" new_pos
		pos_box_current = this.property pos:#get

		this.property pos:new_pos

		for Control in Controls do
		(
			pos     = Control.property pos:#get 
			
			offset  = pos - pos_box_current
 
			pos_new = new_pos + offset

			Control.property pos:pos_new  --!!! PREDELAT Cotrol.Properties na Control.property()
		)
	),
	
	/** Get id
	 */
	function getId =
	(
		id = Parent_roll.getId()
	
		if (Groupbox != undefined ) then
			id += "." + Groupbox.id.id --return
		
		id --return
	),


	/** Create Controls and add them to UI
     */
    function create =
    (
		Layout.newControlsBox()
		
		this._addControls()
		
		if (Groupbox != undefined ) then
			this._addGroupBox()
    ),

	/** Set group box
     */
    function _setGroupBox =
    (
		format "HOTFIX ControlBox.ms _setGroupBox() columns parameter"
		if not( caption == unsupplied ) then
			Groupbox = this._newControl (Control_v type:#Groupbox caption:caption id:id)
	
		format "Groupbox = % \n" Groupbox
    ),

	/** Add each control to rollout
	  *
	  * @param	[Control_v]	Controls	Array of Control_v
	 */
	function _addControls =
	(
		print ("ControlBox_v._addControls()")

		format "\n***Controls = % \n" Controls
		for Control in Controls do
			--format "_Control = % \n" (_Control._Parameters)
			--format "_Control = % \n" (_Control.getId())
			this._addControl Control
	),
	
	/** _add control
     *
	 */
    function _addControl Control =
    (
		format "------------\nControlBox._addControl %\n" (Control.Id.get()) as string 
		Layout.setControlDimensions Control
		
		this._addControlToUi Control
		
		Control.Events.setDefaultEvents()
		
		Control.Events.addHandlers()
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
		format "\n------------\nControlBox._addControlToUi %\n" (Control.Id.get()) as string
		--format "Control = % \n" Control
		format "Control._Parameters.join() = % \n" (Control._Parameters.join())
		Parent_roll.RolloutCreator._rolloutCreator.addControl (Control.type) (Control.id.id) (Control.caption) paramStr:(Control._Parameters.join())
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
		
		this._setControlTypeMethods()
		
		Layout = Parent_roll.Layout
	)
	
)
