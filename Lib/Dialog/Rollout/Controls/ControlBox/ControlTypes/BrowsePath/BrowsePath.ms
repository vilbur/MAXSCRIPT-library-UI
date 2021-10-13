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
		format "fieldwidth = % \n" fieldwidth
		
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
		browse_button_id = id.id+"_button"
		
		ControlBox.Parent_roll.RolloutCreator.addControl #button browse_button_id caption (this._getButtonParameters())
	),
	 
	 /** _add browse button event
	  */
	 function _addBrowseButtonEvent =
	 (
		Event = Event_v type:#pressed
		
		get_dir_fn	= "local dir = getSavePath caption:@Test path...@ initialDir:@"+initial_dir+"@ "
		if_dir_defined	= "if (dir != undefined) "
		set_edit_text	= id.id+".text = dir "
		set_button_tooltip	= browse_button_id+".toolTip = dir"
		
		Event.code = get_dir_fn +"\n"+ if_dir_defined + " then ( "+set_edit_text+"\n"+set_button_tooltip+" )"
		
		ControlBox.Parent_roll.RolloutCreator.addhandler browse_button_id Event
	 ),
	 
	/** Add Edit text field http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_FC73C160_735C_4F65_A71D_722D63BBB591_htm
	 */
	function _addTextField =
	(
		print("BrowsePath._addTextField() " + id.id)

		ControlBox.Parent_roll.RolloutCreator.addControl #edittext id.id "" (this._getEditTextParameters())
	),
	
	/** _get edit text parameters
	 */
	function _getEditTextParameters =
	(
		pos    = "pos:"  + (this._getEditTextPosition())    as string 
		width  = "width:"+ (_Parameters.getVal #fieldwidth) as string
		params = (_Parameters.join())
		
		pos + " " + width + " " + params --return 
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