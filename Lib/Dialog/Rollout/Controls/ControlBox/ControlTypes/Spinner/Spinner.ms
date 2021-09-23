/** Spinner http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_411DB273_7B74_4FD7_89E9_B74B9CED102B_htm
 */
struct Spinner_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	
	/** _set filed width
	 */
	function _setFiledWidth =
	(
		fieldwidth = _Parameters.getVal #fieldwidth
		
		if( fieldwidth == undefined ) then
			_Parameters.setVal #fieldwidth (fieldwidth = 32)
	),
	
	public 
	/** Add to ui
	*/
	function addToUi =
	(
		this._setFiledWidth()
		
		ControlBox.Parent_roll.RolloutCreator.addControl type id.id caption (_Parameters.join())
	),

		/**  
	 */
	on create do
	(
		name_of_value_param = #range

		this.onCreate()
		
		
		if ( add_to_controls ) then
			this._addToControls()
	)
	
	
	
)