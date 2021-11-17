filein( getFilenamePath(getSourceFileName()) + "/Control/ControlId/ControlId.ms" )

filein( getFilenamePath(getSourceFileName()) + "/Control/ControlEvents/ControlEvents.ms" )

filein( getFilenamePath(getSourceFileName()) + "/Control/Params/Params.ms" ) 

filein( getFilenamePath(getSourceFileName()) + "/Control/CotrolValue/CotrolValue.ms" )

filein( getFilenamePath(getSourceFileName()) + "/Control/Control.ms" )

filein( getFilenamePath(getSourceFileName()) + "/ControlTypes/includes.ms" )

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
	Layout,
	
	/* properties of Groupbox */
	id,
	caption,
	add_to_controls = true, -- suspend creation of control used in E.G.: ControlCreator_v.createControl()
	
	Groupbox,

	Controls	= #(),
	
	/* dependency */
	Properties = Properties_v Parent_Control:this,

	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/ControlBoxControlTypes.ms"

		
	/** Add control to Controls
	 */
	function add _Control =
	(
		--print ("\nControlBox_v.add " + _Control.id.id as string )
		--format "\nControlBox_v.add %\n" _Control
		_Control.ControlBox = this
		
		append Controls _Control
	),

	/** Create Controls and add them to UI
     */
    function create =
    (
		Layout.newControlsBox()
		
		this._addControls()
		
		if (Groupbox != undefined ) then
			this._addGroupBoxToUi()
		--print ("ControlBox_v.create() END")
    ),

	/** Set any property for rollout 
	  * https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
	  *
	  * @property	mixed	name|title|open|scrollPos|height|width
     */
--    function property caption: pos: height: width: =
--    (
--		--format "ControlBox_v.property pos % \n" pos
--		Properties.getOrSet #( #caption, #pos, #height, #width ) #( caption, pos, height, width )
--	),
    function property key val =
    (
		--print ("ControlBox.property() " + id.id as string )
		Properties.getOrSet #( key ) #( val )
	),
	/** Get existing control
	  * @return	Control_v|undefined
	 */
	function get id =
	(
		control_exists = undefined
		
		for Control in Controls where ( matchPattern Control.id.id pattern:id) do
			control_exists = Control

		control_exists --return
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
		--print ("ControlBox.offsetGroupbox() " + new_pos as string )
		controlbox_pos = this.property #pos #get
		----format "controlbox_pos = % \n" controlbox_pos
		this.property #pos new_pos

	
		
		for Control in Controls do
		(
			control_pos    = Control._Parameters.getVal #pos
			--format "pos      = % \n" pos
			offset  = control_pos - controlbox_pos
			
			pos_new = new_pos + offset
			--format "pos_new	= % \n" pos_new
			Control.property #pos pos_new
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

	/** Set group box
     */
    function _setGroupBox =
    (
		if not( caption == unsupplied ) then
			Groupbox = Groupbox_v type:#Groupbox caption:caption id:id ControlBox:this
	
		--format "Groupbox = % \n" Groupbox
    ),

	/** Add each control to rollout
	  *
	  * @param	[Control_v]	Controls	Array of Control_v
	 */
	function _addControls =
	(
		--print ("------------\nControlBox_v._addControls()" )

		--format "Controls.count = % \n" Controls.count
		for Control in Controls do
			this._addControl Control
	),
	
	/** _add control
     *
	 */
    function _addControl Control =
    (
		--format "ControlBox._addControl %\n" (Control.Id.get()) as string 
		Layout.setControlDimensions Control
		
		this._addControlToUi Control
		
		Control.Events.addHandlers()
    ),

	/** Add id
	 */
	function _addGroupBoxToUi =
	(		
		--print ("ControlBox_v._addGroupBoxToUi()	"+ (this.getId()) )
		Layout.setGroupboxDimensions Groupbox

		this._addControlToUi Groupbox
	),

	/** Add each control to rollout
	 *
	 * @param	[Control_v]	Controls	Array of Control_v
	 */
	function _addControlToUi Control =
	(
		Control.addToUi()
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
		
		--this._setControlTypeMethods()
		
		Layout = Parent_roll.Layout
	)
)