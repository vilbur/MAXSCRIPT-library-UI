/** Control
 */
struct Control_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlAddToUi.ms"
		
	/**  
	 */
	on create do
	(
		this.onCreate()
	)
	
)
