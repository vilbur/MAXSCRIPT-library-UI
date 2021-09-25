/** Spinner http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_411DB273_7B74_4FD7_89E9_B74B9CED102B_htm
 */
struct Spinner_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	
	public 
	/** Add to ui
	*/
	function addToUi =
	(
		this._setFiledWidth()
		
		this.Events.setDefaultEvents()
		
		ControlBox.Parent_roll.RolloutCreator.addControl type id.id caption (_Parameters.join())
	),
	
	/** _set filed width
	 */
	function _setFiledWidth =
	(
		fieldwidth = _Parameters.getVal #fieldwidth
		
		if( fieldwidth == undefined ) then
			_Parameters.setVal #fieldwidth (this._getFieldWidthByCaption())
	),
	
	/** _set field width by caption
	 */
	function _getFieldWidthByCaption =
	(

		--format "\n_Parameters.getVal #range = % \n" ((_Parameters.getVal #range)[2])
		filed_width =  this._getStringLengthOfMaxValue() --return
		
		filed_width --return
	),
	
	/** _get string length of max value
	 */
	function _getStringLengthOfMaxValue =
	(
		spinner_type = _Parameters.getVal #type

		width_per_caracter   = 6
		arrow_controls_width = 10
		
		max_value_of_spinner = (_Parameters.getVal #range)[2]
		
		if( spinner_type == #integer ) then
			max_value_of_spinner = max_value_of_spinner as integer
		
	 	filed_width = ( max_value_of_spinner as string ).count * width_per_caracter + arrow_controls_width
		
		if( spinner_type == #float ) then -- correct
			filed_width -= 2
		
		filed_width
	),
	
	/**  
	 */
	on create do
	(
		name_of_value_param = #range

		this.setParam #type #integer

		this.setParam #range [0,999,99] -- default value, used in "ControlBase.ms _getValueFromIni()"
		
		this.setParam #columns 6
		
		this.onCreate()
		
		if ( add_to_controls ) then
			this._addToControls()
	)
)