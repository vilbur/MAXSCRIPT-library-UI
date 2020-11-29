/** 
 */
struct Groupbox_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlAddToUi.ms"

	/**  
	 */
	on create do
	(
		type = #groupbox
		
		this._setCaption()
	
		Id = ControlId_v	Parent_Control:this id:id
	
		--this.params columns:4
		
	)	
)