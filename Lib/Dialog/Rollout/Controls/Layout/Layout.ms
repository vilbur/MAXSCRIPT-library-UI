filein( getFilenamePath(getSourceFileName()) + "/Bbox/Bbox.ms" )

/** Layout
 */
struct Layout_v
(
	Bbox,
		
	columns	= 12, -- columns width of rollout
	
	column_size = 24,
	padding	= 0,	-- padding between controls
	margin	= 0,
	
	--box_padding	= 16,

	pos_last,		                -- store origin of last added control 

	/** Set dimensions of control, add to Bounding box
	  * @param	Params	Params
	  * @param	int	columns	Width of control
	  *
	 */
	function setControlDimensions &Control =
	(
		print "Layout.setControlDimensions()"
		format "pos_last = % \n" pos_last

		_dimensions	= this._getControlDimensions Control
		format "_dimensions	= % \n" _dimensions

		Control.Props.setDimensions _dimensions
		
 		Bbox.add _dimensions
		
		pos_last = _dimensions[1]
		
		this._setNewControlPosition _dimensions[2]

		this._trySetNewControlsRow _dimensions[2]
	),

	/** Set init pos_last 
	 */
	function newControlsBox =
	(
		print "------------\nLayout.newControlsBox()"
		print(Bbox == undefined)
		--format "\npos_last = % " pos_last

		box_origin = if( Bbox == undefined )
			then 
				--[ margin*2, 4 ]
				pos_last = box_origin = [0,0]
			else 
				[ Bbox.origin.x, pos_last.y ]

		format "box_origin	= % \n" box_origin
	--	if( groupbox!=undefined ) then -- move controls in groupbox lower
			--pos_last.y += box_padding
	
		Bbox = Bbox_v origin:box_origin
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
	function getGroupboxDimensions =
	(
		print "------------\nLayout._getGroupboxDimensions()"
		format "\nBbox.origin	= % \n" Bbox.origin

		#(
			[Bbox.origin.x,  -- pos X
			 Bbox.origin.y], -- pos Y
		  
			Bbox.width  + margin,
			Bbox.height + margin
		)
	),

	private
	
	/** Get control dimensions defined by Layout, if not defined by user
	 */
	function _getControlDimensions Control =
	(
		pos     = Control.Props.get #pos
		width   = Control.Props.get #width
		height  = Control.Props.get #height
		columns = Control.Props.get #columns
		format "pos	= % \n" pos

		if( pos == undefined ) then
			pos = [ pos_last.x, pos_last.y  ]
			--pos = this._getLastControlPosition()
		
		if( width == undefined ) then
			width = columns * column_size
		
		if( height == undefined ) then
			height = this._getControlHeight()

		this._setFirstControlPosition pos

		#( pos, width, height ) --return
	),

	/** Set first
	 */
	function _setFirstControlPosition &pos =
	(
		print "------------\nLayout._setFirstControlPosition()"
		print Bbox.origin
		print pos_last
		print (pos_last==Bbox.origin)
		if( (pos_last==Bbox.origin) ) then
            pos.y += 16
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
		pos_last = [ pos_last.x + current_control_width, pos_last.y ]
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
		--this.newControlsBox()
	)
)
