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
		format "Bbox.add() % " Dimensions

		pos	= Dimensions.pos

		bbox_width	= pos.x + Dimensions.width
		bbox_height	= pos.y + Dimensions.height

		if( bbox_width > width ) then
			width = bbox_width as integer
			
		if( bbox_height > height ) then
			height = bbox_height as integer
		--format "\norigin = % " origin
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
		print "Bbox.create()"
		this._checkConstctructProperties()
	)
)
