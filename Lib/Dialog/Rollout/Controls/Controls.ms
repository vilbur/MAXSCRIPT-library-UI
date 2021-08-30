filein( getFilenamePath(getSourceFileName()) + "/ControlBox/ControlBox.ms" )

/** Controls
  *
  * @property	obj	Parent_roll
  *
 */
struct Controls_v
(
	
	__construct = #( #Parent_roll ),

	/* required */
	/* dependency */
	/* reference */
	Parent_roll,
	/* properties */
	
	/** Get new groupbox of controls
	 *
	 * @param	string	[groupbox]	Title of group box
	 *
	 * @return [Controls](/ControlsBox/ControlsBox)
	 */
	function new groupbox: id: =
	(
		ControlBox 	= ControlBox_v Parent_roll:Parent_roll Layout:Parent_roll.Layout caption:groupbox id:id 
	
		append groupbox_global ControlBox
		
		append Parent_roll.Controlboxes_and_Subrollouts ControlBox

		ControlBox --return
	),

	/*------------------------------------------------------------------------------
		CONSTRUCT
	--------------------------------------------------------------------------------*/
	
	/** Check if required properties are defined when an instance of the struct is created.
	 *	
	 * @example __construct = #( #property_name ) 
	 */
	function _checkConstctructProperties =
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),
	/**  
	 */
	on create do
	(
		this._checkConstctructProperties()
	)

)


