/** Bbox store max positions of controls in ControlsBox
  *
  * Used for sizing of groupbox
 */
struct Bbox_v
(
	/* required properties */
	origin = [0,0],
	
	_construct = #( #origin ),
	
	
	/* properties */
	width	= 0,
	height	= 0,
	
	
	/** Add dimensions of control to boungingBox
	  *
	  * Add width and height add to position to reach out max width and height of box
	  *
	  * @property	#( position, width, height )	dimensions
	  *
	  */
	function add Dimensions =
	(
		control_max_x	= Dimensions.pos.x + Dimensions.width
		control_max_y	= Dimensions.pos.y + Dimensions.height

		if( control_max_x > (this.getMax #x) ) then
			width += Dimensions.width as integer
			
		if( control_max_y > (this.getMax #y) ) then
			height += Dimensions.height as integer
		
		--format "\nthis.height =%\n" this.height
	),
	
	/** Max
	 */
	function getMax axis =
	(
		if( axis == #x ) then
			origin.x + width --return
		else
			origin.y + height --return
	),
	
	
	/*------------------------------------------------------------------------------
		CONSTRUCT
	--------------------------------------------------------------------------------*/
	
	/** Check if required properties are defined when an instance of the struct is created.
	 *	
	 * @example _construct = #( #property_name ) 
	 */
	function _checkConstctructProperties =
	(
		for prop in _construct where getProperty this prop == undefined do
			messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),
	/**  
	 */
	on create do
	(
		this._checkConstctructProperties()
	)
)
