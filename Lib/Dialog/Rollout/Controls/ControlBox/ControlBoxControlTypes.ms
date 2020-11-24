/**  Add control of any type http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_E421933F_958E_42FD_80A1_D66F2A2C0A06_htm 
 * 
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

/** Add Button
 */
function button caption id: border:  add:true =
(
	--print "------------\nControlBox.button()"
	--this._newControl (Button_v caption:caption ) id:id add:add
	
	new_Control = (Button_v caption:caption )
	
	new_Control.params border:border
	
	this._newControl new_Control id:id add:add
	
	
),

/** Add Check button
 */
function checkbutton caption id: add:true =
(
	this._newControl (Control_v type:#checkbutton caption:caption ) id:id add:add
),

/** Add Checkbox
 */
function checkbox caption id: checked: add:true =
(
	this._newControl (Checkbox_v caption:caption ) id:id add:add
),

/** Add Spinner http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_411DB273_7B74_4FD7_89E9_B74B9CED102B_htm
 */
function spinner caption id: range: type: scale: add:true =
(
	--this._newControl (Checkbox_v caption:caption ) id:id add:add
	new_Control = (Spinner_v type:#spinner caption:caption )
	
	new_Control.params scale:scale
	
	this._newControl new_Control id:id add:add
),






/** Add Edit text control
 */
function edit caption id: value: add:true =
(
	this._newControl (EditText_v caption:caption value:value ) id:id add:add
),

/** Browse Path control
 */
function path =
(
	browse_button	= this.button "..."	add:false
	edit_text	= this.edit "test_edit" value:"Test"	add:false

	initial_dir	= "C:\\"

	browse_button.pressed ( "messagebox "+(edit_text.prop #text #path ) )

	this.add browse_button
	this.add edit_text
),