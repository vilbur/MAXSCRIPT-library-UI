/** Dropdownlist 
 */
struct Dropdownlist_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"	-- "../../Control/ControlBase.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlAddToUi.ms"	-- "../../Control/ControlAddToUi.ms"
	
	/** _get control height
	  *
	  * height of dropdown is number of items dropdown menu when it is opened
	 */
	function _getControlHeightByType height =
	(
		--print "Dropdownlist_v._getControlHeightByType()"
		if( caption != "" ) then 
			36 --return
		else
			20 --return
	),
	
	/** Set dimensions
	  *
     */
    function _setParamteresPosWidthHeightByType Dimensions =
    (
		--print "Dropdownlist_v._setParamteresPosWidthHeightByType()"
		height_of_items = if( (height_by_user = this._Parameters.getVal #height) != undefined ) then height_by_user else unsupplied
		--format "height_of_items	= % \n" height_of_items
		_Parameters.setValues #( #pos, #width, #height ) #( Dimensions.pos, Dimensions.width, height_of_items )
    ),

	/**  
	 */
	on create do
	(
		print "Dropdownlist_v.onCreate()"

		name_of_value_param = #selection
		
		this.onCreate()
		
		if ( add_to_controls ) then
			this._addToControls()
	)
)