

button,
checkbox,

/** _set control type methods
 */
function _setControlTypeMethods =
(
	print "------------\n ControlBox._setControlTypeMethods()"
	
	global groupbox_current = this
	
	control_types	= #( #button, #checkbox )
	
	
	param_all          = #(#columns,#pos,#height,#width,#align,#offset,#across,#images,#toolTip,#border )  
	
	params_array_replaced = (( dotNetObject "System.Text.RegularExpressions.Regex" @"[#\(\)]+" ).Replace ( param_all as string ) "") --return 

	params_array          = (( dotNetObject "System.Text.RegularExpressions.Regex" @",|$" ).Replace ( params_array_replaced ) ":") --return 

	--this.button = execute ("fn button caption "+params_array+" = ( groupbox_current.add (Button_v caption:caption ControlBox:groupbox_current) )")
	--this.button = execute ("fn button caption "+params_array+" = ( Button_v caption:caption ControlBox:groupbox_current )")
	--this.button = execute ("fn button caption "+params_array+" = ( "+control_types[1] as string +"_v caption:caption ControlBox:groupbox_current )")
	
	for control_type in control_types do 
	execute ("groupbox_current."+control_type as string +" = fn button caption "+params_array+" = ( "+control_type as string +"_v caption:caption ControlBox:groupbox_current )")
	
	
),


/**  Add control of any type http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_E421933F_958E_42FD_80A1_D66F2A2C0A06_htm 
 * 
 *  @param	string	type	Type of control
 *  @param	string	caption	Caption of control
 * 
 *  @return	[Control](../../Control)
 */
function _newControl _Control =
(
	print "------------\nControlBox._newControl()"

),



--/** Add Button
-- */
--function button caption id: columns: pos: height: width: align: offset: across: images: border: toolTip: =
--(
--	--print "------------\nControlBox.button()"
--	--this._newControl (Button_v Parent_roll:Parent_roll caption:caption id:id )
--	
--	--new_Control = (Button_v caption:caption )
--	
--	--new_Control.params border:border
--	
--	--this._newControl new_Control id:id add:add
--	--ControlTypes.newControl #button caption 
--	
--),
-- 


--/**  Add control of any type http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_E421933F_958E_42FD_80A1_D66F2A2C0A06_htm 
-- * 
-- *  @param	string	type	Type of control
-- *  @param	string	caption	Caption of control
-- * 
-- *  @return	[Control](../../Control)
-- */
--function _newControl Control id: =
--(
--	format "HOTFIX ControlBoxControlTypes.ms _newControl() Adding of groupbox need this\n"
--	--Control.Parent_roll = Parent_roll
--	
--	Control.setId id
--	Control.params columns:4
--	--format "ControlBox_v._newControl %\n" (Control.getId() )
--		--if( columns == unsupplied ) then
--		--	columns = 4
--		--
--
--		
--	if( Control.type != #groupbox ) then
--		this.add Control
--	
--	Control --return
--),


--/** Add Check button
-- */
--function checkbutton caption id: add: =
--(
--	this._newControl (Control_v type:#checkbutton caption:caption ) id:id add:add
--),
--
--/** Add Checkbox
-- */
--function checkbox caption id: checked: add: =
--(
--	this._newControl (Checkbox_v caption:caption ) id:id add:add
--),
--
--/** Add Spinner http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_411DB273_7B74_4FD7_89E9_B74B9CED102B_htm
-- */
--function spinner caption id: range: type: scale: add: =
--(
--	--this._newControl (Checkbox_v caption:caption ) id:id add:add
--	new_Control = (Spinner_v type:#spinner caption:caption )
--	
--	new_Control.params scale:scale
--	
--	this._newControl new_Control id:id add:add
--),
--
--
--
--
--
--
--/** Add Edit text control
-- */
--function edit caption id: value: add: =
--(
--	this._newControl (EditText_v caption:caption value:value ) id:id add:add
--),
--
--/** Browse Path control
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