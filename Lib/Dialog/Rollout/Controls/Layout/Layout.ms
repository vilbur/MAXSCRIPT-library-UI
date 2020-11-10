filein( getFilenamePath(getSourceFileName()) + "/Bbox/Bbox.ms" )

/** Layout
 */
struct Layout_v
(
	Bbox,
		
	columns	= 12, -- columns width of rollout
	
	column_width = 24,
	padding	= 2,	-- padding between controls
	margin	= 8,
	
	box_padding	= 16,

	pos_last,		                -- store origin of last added control 

	
	/** Set dimensions of control, add to Bounding box
	  * @param	Params	Params
	  * @param	int	col	Width of control
	  *
	 */
	function getControlDimensions col pos width height =
	(
		--print "Layout.setControlDimensions()"
		
		width_raw	= this._getControlWidth col width

		this._trySetNewControlsRow width_raw
		
		position = if( pos    == undefined ) then [ pos_last.x + padding, pos_last.y ] else pos
		height   = if( height == undefined ) then column_width - padding * 2             else height as integer 
		width    =  width_raw - padding * 2
		--format " this	= % \n" this 
		
		position = this._setFirstControlPosition position

		--Bbox.add #( position, width, height )
		dimensions	= #( position, width, height )
		--format " dimensions	= % \n" dimensions 

		Bbox.add dimensions
		
		this._setNewControlPosition width_raw
		 
		dimensions --return
	),
	
	/** Set init pos_last 
	 */
	function newControlsBox =
	(
		--print "------------\nLayout.newControlsBox()"
		--format "\npos_last	= % " pos_last
		--format "\nbox_origin	= % \n" box_origin

		box_origin	= if( Bbox == undefined )
			then 
				[ margin*2, 4 ]
			else 
				[ Bbox.origin.x, pos_last.y ]
					
		pos_last = box_origin
		
	--	if( groupbox!=undefined ) then -- move controls in groupbox lower
			--pos_last.y += box_padding
	
		Bbox = Bbox_v origin:box_origin
	),
	
	/** Set next box position
	 */
	function nextControlsBox extra_margin:false =
	( 
		y = pos_last.y + column_width
		--y = pos_last.y + 16
	
		--if( extra_margin ) then -- Set offset of new box after groupbox
			--y += 8
	
		pos_last = [ Bbox.origin.x, y ]
		
		
	),

	/** Get params string of Controls box
	 */
	function _getGroupboxDimensions =
	(
		--print "------------\nLayout._getGroupboxDimensions()"
		
		--	[ pos_box[1] - margin, pos_box[2] - padding_box ],
		--	( Bbox.width + margin ),
		--	( Bbox.height + margin )
		--	--( pos[2] - pos_box[2] + _grid + padding_box )		
		
		#(
			[Bbox.origin.x,  -- pos X
			 Bbox.origin.y], -- pos Y
		  
			Bbox.width  + margin,
			Bbox.height + margin
		)
		--#( [0,50], 256, 64 )
	),

	/** Try set new controls row
	 */
	function _trySetNewControlsRow with_current =
	(
		--print "------------\nLayout._trySetNewControlsRow()"
		--format " pos_last	= % \n box_origin	= % \n\n" pos_last box_origin
		--format " Bbox	= % \n" Bbox 
		if( this._controlIsOutOfRollout with_current ) then
			pos_last = [ Bbox.origin.x, Bbox.height + margin ]
			------pos_last = [ Bbox.origin.x, pos_last.y + column_width ]
	),
	
	/** Control is out of rollout
     */
    function _controlIsOutOfRollout with_current =
    (
        (pos_last.x + with_current) > this._getRollWidth() --return
    ),
	
	/** Get base width of control
	  *
	  * Number of columns * width of column = auto width of control
	  *
     */
    function _getControlWidth col width =
    (
		--format " col	= % \n" col
		--format " column_width	= % \n" column_width
		if( width == undefined ) then
			col * column_width --return
		else
			width as integer --return
    ),
	
	/** Set first
	 */
	function _setFirstControlPosition position =
	(
		position.y += box_padding
		
		position --return
	),

	/** Set new control position
	 */
	function _setNewControlPosition with_current =
	(
		pos_last	= [ pos_last.x + with_current, pos_last.y ]
	),

	/*---------------------------------------
		ROLLOUT
	-----------------------------------------*/
	/** _get roll width
	 */
	function _getRollWidth =
	(
		--print "------------\nLayout._getRollWidth()"
		width = (columns * column_width) + margin*4 + 14
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
