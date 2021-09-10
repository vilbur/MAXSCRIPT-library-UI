/** Label https://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_986FEC5A_A002_4101_948C_66BDE49CD28C_htm
 */
struct Label_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlAddToUi.ms"

	/**  
	 */
	on create do
	(
		this.onCreate()
		
		this._addToControls()
	)
	
)