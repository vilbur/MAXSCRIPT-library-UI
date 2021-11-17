/** Path
  *
  * TODO: add other dialog tyes http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_D4B43A33_8342_4BC9_80AB_91460861D37C_htm
  *
 */
struct BrowsePath_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/ControlTypes/BrowsePath/BrowsePathButton.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/ControlTypes/BrowsePath/BrowsePathEditText.ms"
	
	public
	 
	button_default_width = 64,
	--initial_dir          = getDir #Scene,
	initial_dir          = "C:/",
	
	browse_button_id,
	
	_Button,
	_EditText,
	
	/** Add to ui
	*/
	function addToUi =
	(
		--format "BrowsePath_v.ms.addToUi() % %\n" type id.full
		this._setDefaultFiledWidth()
		this._setInitialdir()
		
		this._addBrowseButton()
		this._addTextField()
		
		--format "_Button	= % \n" _Button
		--format "_EditText	= % \n" _EditText
		
		this._addBrowseButtonEvent()
	),

	/** _set filed width
	 */
	function _setDefaultFiledWidth =
	(
		fieldwidth = _Parameters.getVal #fieldwidth
		--format "fieldwidth = % \n" fieldwidth
		
		if( fieldwidth == undefined ) then
			--_Parameters.setVal #fieldwidth (_Parameters.getVal #width - button_default_width)
			_Parameters.setVal #fieldwidth 64
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
	/**  
	 */
	on create do
	(
		name_of_value_param = #text
		
		this.setParam #columns 16
		
		this.setParam #initialDir maxFilePath

		this.onCreate()


		if ( add_to_controls ) then
			this._addToControls()
	)	
)