filein( getFilenamePath(getSourceFileName()) + "/ControlBox/ControlBox.ms" )

/** Controls
  *
  * @property	obj	Parent_roll
  *
 */
struct Controls_v
(
	
	__construct = #( #Parent_roll ),

	/* required */
	/* dependency */
	/* reference */
	Parent_roll,
	/* properties */
	
	/** Get new groupbox of controls
	 *
	 * @param	string	[groupbox]	Title of group box
	 *
	 * @return [Controls](/ControlsBox/ControlsBox)
	 */
	function new groupbox: id: =
	(
		ControlBox 	= ControlBox_v Parent_roll:Parent_roll caption:groupbox id:id

		append Parent_roll.Controlboxes_and_Subrollouts ControlBox

		ControlBox --return
	),

	--/**  Add control of any type
	-- *  @param	string	type	Type of control
	-- *  @param	string	caption	Caption of control
	-- * 
	-- *  @return	[Control](../../Control)
	-- */
	--function control type caption id: add:true =
	--(
	--	this.newControl (Control_v type:type caption:caption id:id ) add:add
	--),
	--/** Add control to rollout
	-- */
	--function add &Control =
	--(
	--	append Controls Control
	--	
	--	Parent_roll.addControl Control
	--),
	--/** Get existing control
	--  * @return	false|Control_v
	-- */
	--function get id =
	--(
	--	control_exists = false
	--	
	--	for Control in Controls do
	--		if( Control.id == id ) then 
	--			control_exists = Control
	--
	--	control_exists --return
	--),
	--
	--/*---------------------------------------
	--
	--	CONTROLS TYPES
	--
	-------------------------------------------*/
	--
	--/** Add Button
	-- */
	--function button caption id: add:true =
	--(
	--	this.newControl (Button_v caption:caption ) id:id add:add
	--),
	--/** Add Check button
	-- */
	--function checkbutton caption id: add:true =
	--(
	--	this.newControl (Control_v type:#checkbutton caption:caption ) id:id add:add
	--),
	--/** Add Checkbox
	-- */
	--function checkbox caption id: checked: add:true =
	--(
	--	this.newControl (Checkbox_v caption:caption ) id:id add:add
	--),
	--/** Add Edit text control
	-- */
	--function edit caption id: value: add:true =
	--(
	--	this.newControl (EditText_v caption:caption value:value ) id:id add:add
	--),
	--/** Path
	-- */
	--function path =
	--(
	--	browse_button	= this.button "..."	add:false
	--	edit_text	= this.edit "test_edit" value:"Test"	add:false
	--
	--	initial_dir	= "C:\\"
	--
	--	browse_button.pressed ( "messagebox "+(edit_text.prop #text #path ) )
	--
	--	this.add browse_button
	--	this.add edit_text
	--),
	--
	--/*---------------------------------------
	--
	--	ADDING CONTROLS TO UI
	--
	-------------------------------------------*/
	--
	--/**  Add control of any type
	-- *  @param	string	type	Type of control
	-- *  @param	string	caption	Caption of control
	-- * 
	-- *  @return	[Control](../../Control)
	-- */
	--function newControl _Control add:true =
	--(
	--	print "------------\nControls.newControl()"
	--	format " _Control	= % \n" _Control
	--	
	--	--_Control.init id
	--
	--	if( add ) then
	--		this.add _Control
	--	
	--	_Control --return
	--),
	--

	/*------------------------------------------------------------------------------
		CONSTRUCT
	--------------------------------------------------------------------------------*/
	
	/** Check if required properties are defined when an instance of the struct is created.
	 *	
	 * @example __construct = #( #property_name ) 
	 */
	function _checkConstctructProperties =
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),
	/**  
	 */
	on create do
	(
		this._checkConstctructProperties()
	)

)


