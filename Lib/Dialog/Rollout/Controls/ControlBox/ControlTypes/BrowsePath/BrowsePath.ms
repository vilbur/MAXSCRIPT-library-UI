/** Path
  *
  * TODO: add other dialog tyes http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_D4B43A33_8342_4BC9_80AB_91460861D37C_htm
  *
 */
struct BrowsePath_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	
	public
	
	button_default_width = 64,
	initial_dir          = getDir #Scene,
	
	browse_button_id,
	
	/** Add to ui
	*/
	function addToUi =
	(
		this._setDefaultFiledWidth()
		this._setInitialdir()
		
		this._addBrowseButton()
		this._addTextField()
		this._addBrowseButtonEvent()
	),

	/** _set filed width
	 */
	function _setDefaultFiledWidth =
	(
		fieldwidth = _Parameters.getVal #fieldwidth
		--format "fieldwidth = % \n" fieldwidth
		
		if( fieldwidth == undefined ) then
			_Parameters.setVal #fieldwidth (_Parameters.getVal #width - button_default_width)
	),
	
	/** _set initialdir
	 */
	function _setInitialdir =
	(
		initial_dir_param = _Parameters.getVal #initialDir
		--format "initial_dir_param	= % \n" initial_dir_param
		_Parameters.delete #initialDir
		
		if( initial_dir_param != undefined and initial_dir_param != "" ) then
			initial_dir =  ( trimRight initial_dir_param "\\")
	),
	
	/** _add browse button
	 */
	function _addBrowseButton =
	(
		browse_button_id = id.id + "_BUTTON" 
		--format "browse_button_id	= % \n" browse_button_id
		ControlBox.Parent_roll.RolloutCreator.addControl #button browse_button_id caption (this._getButtonParameters())
	),
	  
	 /** _add browse button event
	  */
	 function _addBrowseButtonEvent =
	 (
		Event = Event_v type:#pressed
		
		_rollout	= ControlBox.Parent_roll
		ini_path	= _rollout.ini #get
		edit_text_id	= _rollout.id +"."+ id.id
		
		
		
		get_dir_fn	= "local browsed_dir = getSavePath caption:@Browse path...@ initialDir:@"+initial_dir+"@ "
		if_dir_defined	= "if (  browsed_dir != undefined) "
		--set_edit_text	= edit_text_id+".text = browsed_dir "
		set_edit_text	= edit_text_id+".text = browsed_dir "

		set_button_tooltip	= browse_button_id+".toolTip = browsed_dir"
				
		save_to_ini = if( ini_path != undefined ) then  "setINISetting \"" + ini_path + "\" \"" + _rollout.id + "\" \"" + id.id  + "\" browsed_dir"  else ""
				
		Event.code = get_dir_fn +"\n"+ if_dir_defined + " then ( "+set_edit_text+"\n"+set_button_tooltip+"\n"+save_to_ini+" )"
		
		ControlBox.Parent_roll.RolloutCreator.addhandler browse_button_id Event
	 ),
	 
	 
	 
	 
	 
	/** Add Edit text field http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_FC73C160_735C_4F65_A71D_722D63BBB591_htm
	 */
	function _addTextField =
	(
		--print("BrowsePath._addTextField() " + id.id)
		--print ("ControlBox.EditText " + (this._getEditTextParameters()))
		
		global ControlBoxEditText = ControlBox
			
		EditText = execute ("ControlBoxEditText.EditText \"\" " + (this._getEditTextParameters()))
		
		ControlBoxEditText = undefined
		
		--format "EditText	= % \n" EditText
	),
	
	/** _get edit text parameters
	 */
	function _getEditTextParameters =
	(
		_id    = "id:"   +	"\""+id.id+"\""
		pos    = "pos:"  +	(this._getEditTextPosition())    as string 
		width  = "width:"+	(_Parameters.getVal #fieldwidth) as string
		params = (_Parameters.join())
		
		_id + " " +pos + " " + width + " " + params --return 
	),
	
	/** Get edit text position 
	 */
	function _getEditTextPosition =
	(
		pos = _Parameters.getVal #pos

		pos.x += this._getButtonWidth()
		
		pos --return
	),	

	
	/** Get edit text parameters
	 */
	function _getButtonParameters =
	(
		width  = "width:" + this._getButtonWidth() as string
		params = (_Parameters.join())
		--format "params	= % \n" params
		width + " " + params --return 
	),	

	/** Get button width
	  * @return	integer button width	
	 */
	function _getButtonWidth =
	(
		( _Parameters.getVal #width - _Parameters.getVal #fieldwidth ) --return
	),
	
	/**  
	 */
	on create do
	(
		name_of_value_param = #text
		
		this.setParam #columns 8
		
		this.setParam #initialDir maxFilePath

		this.onCreate()


		if ( add_to_controls ) then
			this._addToControls()
	)	
)