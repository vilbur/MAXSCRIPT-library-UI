/** Listbox 
 */
struct Listbox_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlAddToUi.ms"
	

	/**  
	 */
	on create do
	(
		this.onCreate()
		
		if ( add_to_controls ) then
			this._addToControls()
	)
	
)