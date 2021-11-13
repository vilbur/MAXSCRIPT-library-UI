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
		print "Dropdownlist_v._getControlHeightByType()"
		format "height	= % \n" height
		
		if( caption == "" ) then 
			20 --return
		else
			36 --return
	),
	
	/** Set dimensions
	  *
     */
    function _setParamteresPosWidthHeightByType Dimensions =
    (
		--print "Dropdownlist_v.setDimensionsByType()"
		_Parameters.setValues #( #pos, #width, #height ) #( Dimensions.pos, Dimensions.width, unsupplied )
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