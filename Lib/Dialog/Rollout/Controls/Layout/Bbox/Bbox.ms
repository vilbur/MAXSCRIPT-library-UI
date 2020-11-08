/** Bbox store max positions of controls in ControlsBox
  *
  * Used for sizing of groupbox
 */
struct Bbox_v
(
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
		--print "Bbox.add()"
		pos	= dimensions[1]
		------_width	= Params.get #width
		bbox_width	= pos[1] + dimensions[2]
		bbox_height	= pos[2] + dimensions[3]
		--format "\nbbox_height = % " bbox_height
		if( bbox_width > width ) then
			width = bbox_width as integer
			
		if( bbox_height > height ) then
			height = bbox_height as integer
		
		--format "\n\nBbox.add()\ndimensions = % " dimensions
		--format "height = % \n" height
	),
	
	function test =
	(
		messagebox "Bbox.test()"
	)
)
