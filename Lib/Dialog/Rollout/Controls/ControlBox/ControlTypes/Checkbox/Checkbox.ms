/** Checkbox
 */
struct Checkbox_v
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlAddToUi.ms"

	checked,

	/** Toggle checkbox
	 */
	function toggle =
	(
		--print "------------\nCheckbox.toggle()"
		current_state = this.prop.get #state
		--format " current_state	= % \n" current_state
		this.prop.add #state ( not current_state )
	),
	
	/**  
	 */
	on create do
	(
		--print "Checkbox.onCreate()"
		name_of_value_param = #checked

		this.setParam #columns 6
				
		this.onCreate()
				
		if ( add_to_controls ) then
			this._addToControls()		
	)
)
