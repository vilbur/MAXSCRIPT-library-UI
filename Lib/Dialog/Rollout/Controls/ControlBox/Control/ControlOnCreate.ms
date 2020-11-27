/** Check if required properties are defined
  * Names of construct props are defined in __construct array E.g.: __construct = #( #prop_name ) 
  * @param	construct_properties this.properties required for initialization of struct
 */
function _checkConstctructProperties =
(
	for prop in __construct where getProperty this prop == undefined do
		messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
),

/** Set type of control by class name of control
  *
  * Get 1st part of struct name until underscore "_" E.G.: Get #button from "struct button_optionable_namespace()"
 */
function _setType =
(
	if( type == undefined ) then
		type = (toLower (( filterString( classof this as string ) "_*(:" )[2])) as name
	--format "ControlOnCreate._setType %\n" type
),

/** _add to controls
 */
function _addToControls =
(
	print ("ControlBox_v._addToControls()")

	ControlBox.add this
),

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