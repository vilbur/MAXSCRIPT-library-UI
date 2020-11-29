
/** Path
 */
struct BrowsePath_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"

	
	/** _set filed width
	 */
	function _setFiledWidth =
	(
		fieldwidth = _Parameters.getVal #fieldwidth
		format "fieldwidth = % \n" fieldwidth
		
		if( fieldwidth != undefined ) then
		(
			--fieldwidth = _Parameters.getVal #fieldwidth
			_Parameters.delete #width 

		)
			--_Parameters.setVal #fieldwidth 128

			
		--_Parameters.setVal #fieldwidth 32
			
		format "_Parameters.getVal #fieldwidth = % \n" (_Parameters.getVal #fieldwidth)
	),
	
	public 
	/** Add to ui
	*/
	function addToUi RolloutCreator =
	(
		--this._setFiledWidth()
		-- https://forums.cgsociety.org/t/browse-directory-button/1176877/2
		
		RolloutCreator.addControl #edittext id.id "" paramStr:(_Parameters.join())

		RolloutCreator.addControl #button "browe_button" caption paramStr:""
		
		
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
