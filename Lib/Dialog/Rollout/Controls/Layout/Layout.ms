filein( getFilenamePath(getSourceFileName()) + "/Bbox/Bbox.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Dimensions/Dimensions.ms" )

/** Layout
 */
struct Layout_v
(
	Bbox,
		
	columns     = 12, -- columns width of rollout
	column_size = 24,
	
	padding	= 0,	-- padding between controls
	margin	= 0,
	
	pos_last = [0,0],    -- store origin of last added control 

	/** Set init pos_last 
	 */
	function newControlsBox =
	(
		print "------------\nLayout.newControlsBox()"
	--	if( groupbox!=undefined ) then -- move controls in groupbox lower
			--pos_last.y += box_padding
		--box_origin = pos_last
		box_origin = [0,0]
		
		if( Bbox != undefined ) then
			box_origin.x = Bbox.origin.x
		
		Bbox = Bbox_v origin:box_origin
		format "Bbox.origin	= % \n" Bbox.origin
		
		this._setFirstControlPosition()
		format "Bbox.origin	= % \n" Bbox.origin
	),
	
	/** Set dimensions of control, add to Bounding box
	  * @param	Params	Params
	  * @param	int	columns	Width of control
	  *
	 */
	function setControlDimensions &Control =
	(
		format "Layout.setControlDimensions() % \n" (Control.id.get())

		Dimensions	= this._getControlDimensions Control
		
		format "Control.Dimensions	= % \n" Dimensions
		
		Control.Props.setDimensions Dimensions
		
 		Bbox.add Dimensions

		--pos_last = Dimensions.pos
		
		this._setNewControlPosition Dimensions.width

		--this._trySetNewControlsRow Dimensions.width
	),

	/** Set next box position
	 */
	function nextControlsBox extra_margin:false =
	( 
		y = pos_last.y + column_size
		--y = pos_last.y + 16
	
		--if( extra_margin ) then -- Set offset of new box after groupbox
			--y += 8
	
		pos_last = [ Bbox.origin.x, y ]
	),

	/** Get params string of Controls box
	 */
	function setGroupboxDimensions &Groupbox =
	(
		print "------------\nLayout._getGroupboxDimensions()"
		--format "Bbox.origin	= % \n" Bbox.origin
		Dimensions = Dimensions_v pos:Bbox.origin width:(Bbox.width  + margin) height:(Bbox.height + margin)
		
		Groupbox.Props.setDimensions Dimensions
	),	

	private
	
	/** Get control dimensions defined by user
	  * If undefined then us Layout default values
	 */
	function _getControlDimensions Control =
	(
		pos     = Control.Props.get #pos
		width   = Control.Props.get #width
		height  = Control.Props.get #height
		columns = Control.Props.get #columns

		if( pos == undefined ) then
			pos = [ pos_last.x, pos_last.y  ]
			--pos = this._getLastControlPosition()
		
		if( width == undefined ) then
			width = columns * column_size
		
		if( height == undefined ) then
			height = this._getControlHeight()

		Dimensions_v pos:pos width:width height:height
	),

	/** Set first
	 */
	function _setFirstControlPosition =
	(
		--print "------------\nLayout._setFirstControlPosition()"
		if( pos_last == Bbox.origin ) then
            pos_last.y += 16
	),
	
	/** _get position of last control
	 */
	function _getLastControlPosition =
	(
		[ pos_last.x + padding, pos_last.y ] --return
	),
	
	/** Get height
	 */
	function _getControlHeight =
	(
		column_size - padding * 2 --return
	),
	

	/** Set new control position
	 */
	function _setNewControlPosition current_control_width =
	(
		pos_last.x += current_control_width
		--pos_last = [ pos_last.x + current_control_width, pos_last.y ]
	),

	/** Try set new controls row
	 */
	function _trySetNewControlsRow current_control_width =
	(
		--print "------------\nLayout._trySetNewControlsRow()"
		format "current_control_width	= % \n" current_control_width

		--if( this._controlIsOutOfRollout current_control_width ) then
			--pos_last = [ Bbox.origin.x, Bbox.height ]
			
			--pos_last = [ Bbox.origin.x, Bbox.height + margin ]
			------pos_last = [ Bbox.origin.x, pos_last.y + column_size ]
	),
	
	/** Control is out of rollout
     */
    function _controlIsOutOfRollout current_control_width =
    (
        (pos_last.x + current_control_width) > this._getRollWidth() --return
    ),
	
	/*---------------------------------------
		ROLLOUT
	-----------------------------------------*/
	/** _get roll width
	 */
	function _getRollWidth =
	(
		--print "------------\nLayout._getRollWidth()"
		width = (columns * column_size) + margin*4 + 14
		--format "width = % \n" width
		width --return
	),

	/** _get roll height
	 */
	function _getRollHeight =
	(
		Bbox.height + 48
	),

	on create do
	(
		--messagebox "Layout_v.test()"
	)
)
