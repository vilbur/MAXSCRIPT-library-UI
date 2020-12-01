
/** Path
 */
struct BrowsePath_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	
	public 
	
	button_width = 64,

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
	
	/** _add browse button
	 */
	function _addBrowseButton =
	(
		ControlBox.Parent_roll.RolloutCreator.addControl #button "browse_button_id" caption (this._getButtonParameters())
		
		Event = Event_v code:"getSavePath caption:\"Test path...\""
		
		--if (dir != undefined) do ( edt_test.text = dir )
		
		ControlBox.Parent_roll.RolloutCreator.addhandler "browse_button_id" Event
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

	
	/** Get edit text parameters
	 */
	function _getButtonParameters =
	(
		width  = "width:" + button_width as string
		params = (_Parameters.join())

		width + " " + params --return 
	),	

	/**  
	 */
	on create do
	(
		_Parameters.setVal #columns 8

		
		this._init()
	)	
	
)