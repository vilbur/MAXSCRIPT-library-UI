/** Listbox 
 */
struct Listbox_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlAddToUi.ms"
	
	/** _get control height
	 */
	function _getControlHeightByType height =
	(
		--print "Listbox_v._getControlHeight()"
		items_count = if( height != undefined ) then height else 10
			
		height = (items_count * 13) 
		
		height += if( this.caption != "" ) then 24 else 8
		
		height --return
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
		name_of_value_param = #selection
		
		this.onCreate()
		
		if ( add_to_controls ) then
			this._addToControls()
	)
	
)