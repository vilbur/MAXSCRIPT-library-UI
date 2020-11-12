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
	function add dimensions =
	(
		format "Bbox.add() % " dimensions
		--format "origin	= % " origin

		pos	= dimensions[1]
		------_width	= Params.get #width
		bbox_width	= pos.x + dimensions[2]
		bbox_height	= pos.y + dimensions[3]
		--format "bbox_height = % " bbox_height
		if( bbox_width > width ) then
			width = bbox_width as integer
			
		if( bbox_height > height ) then
			height = bbox_height as integer
		
		--width = 128
		--height = 128

		format "\norigin	= % " origin
		--format "height = % \n" height
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
