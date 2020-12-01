
/** Path
 */
struct BrowsePath_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	
	public 
	
	button_width = 64,
	
	/** _set filed width
	 */
	function _setFiledWidth =
	(
		fieldwidth = _Parameters.getVal #fieldwidth
		format "fieldwidth = % \n" fieldwidth
		
		if( fieldwidth != undefined ) then
			_Parameters.delete #width 
			
		format "_Parameters.getVal #fieldwidth = % \n" (_Parameters.getVal #fieldwidth)
	),

	/** _add text field
	 */
	function _addTextField =
	(
		--ControlBox.Parent_roll.RolloutCreator.addControl #edittext id.id "" (_Parameters.join())
		--format "this._getEditTextParameters() = % \n" (this._getEditTextParameters())
		ControlBox.Parent_roll.RolloutCreator.addControl #edittext id.id "" (this._getEditTextParameters())
	),
	
	/** _get edit text parameters
	 */
	function _getEditTextParameters =
	(
		pos    = "pos:"  + (this._getEditTextPosition())
		width  = "width:"+ ((_Parameters.getVal #width) - button_width) as string
		params = (_Parameters.join())
		
		pos + " " + width + " " + params --return 
	),
	
	/** Get edit text position
	 */
	function _getEditTextPosition =
	(
		pos = _Parameters.getVal #pos

		pos.x += button_width
		
		pos as string --return
	),	
	
	/** _add browse button
	 */
	function _addBrowseButton =
	(
		ControlBox.Parent_roll.RolloutCreator.addControl #button "browse_button" caption (this._getButtonParameters())
	),
	
	/** Get edit text parameters
	 */
	function _getButtonParameters =
	(
		width  = "width:" + button_width as string
		params = (_Parameters.join())

		width + " " + params --return 
	),	

	/** Add to ui
	*/
	function addToUi =
	(
		--this._setFiledWidth()
		-- https://forums.cgsociety.org/t/browse-directory-button/1176877/2
		

		this._addBrowseButton()
		this._addTextField()
		
		
		--this.property pos:[64,0]
		--this.Properties._setProperty #pos [64,128]
		--this.Properties._setProperty #height 64
		--format "this.property width:#get = % \n" (this.property width:#get)
	),

	/**  
	 */
	on create do
	(
		_Parameters.setVal #columns 8

		
		this._init()
	)	
	
)