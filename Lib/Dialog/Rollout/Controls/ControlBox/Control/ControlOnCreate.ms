
/**  
 */
on create do
(
	format "HOTFIX ControlOnCreate.ms on create()\n"
	this._setType()
	
	this.Events.setEventTypes()

	this._checkConstctructProperties()
	
	this._setCaption()

	Id = ControlId_v	Parent_Control:this id:id

	this.params columns:4
	--this._setValue()
	
	--this.Events.setDefaultEvents()
	
	if( type != #groupbox ) then 
		this._addToControls()
	
)