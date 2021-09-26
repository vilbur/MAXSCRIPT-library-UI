/** 
 */
struct Groupbox_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlBase.ms"
	
	/** Add to ui
	*/
	function addToUi =
	(
		--format "\nControlAddToUi.ms.addToUi() % %\n" type id.id
		--this._setFiledWidth()
		
		ControlBox.Parent_roll.RolloutCreator.addControl type id.id caption (_Parameters.join())
	),
	
	/**  
	 */
	on create do
	(
		type = #groupbox
		
		this._setCaption()
	
		Id = ControlId_v	Parent_Control:this id:id
	)	
)