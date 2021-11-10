/** Dropdownlist 
 */
struct Dropdownlist_v 
(

	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"	-- "../../Control/ControlBase.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlAddToUi.ms"	-- "../../Control/ControlAddToUi.ms"
	

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