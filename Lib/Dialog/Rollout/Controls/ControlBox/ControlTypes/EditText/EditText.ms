
/** EditText http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_FC73C160_735C_4F65_A71D_722D63BBB591_htm
 */
struct EditText_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	
	public 
	/** Add to ui
	*/
	function addToUi =
	(
		this._setFiledWidth()
		
		ControlBox.Parent_roll.RolloutCreator.addControl type id.id caption (_Parameters.join())
	),

	private
	
	/** Value as tooltip
	 */
	function _valueAsTooltip toggle =
	(
		print "------------\nEditText.valueAsTooltip()"
		--if( toggle != true ) then
			--return ()
	),

	
	/** _set filed width
	 */
	function _setFiledWidth =
	(
		fieldwidth = _Parameters.getVal #fieldwidth
		format "fieldwidth = % \n" fieldwidth
		
		if( fieldwidth != undefined ) then
			_Parameters.delete #width 
	),

	/**  
	 */
	on create do
	(
		_Parameters.setVal #columns 8

		this.onCreate()
		
		this._addToControls()
	)
)
