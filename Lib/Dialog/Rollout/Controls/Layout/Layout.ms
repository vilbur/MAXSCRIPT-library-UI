filein( getFilenamePath(getSourceFileName()) + "/Bbox/Bbox.ms" )

/** Layout
 */
struct Layout_v
(
	Bbox,
	--Bbox = Bbox_v(),
		
	columns	= 12, -- columns width of rollout
	
	column_width = 24,
	padding	= 2,	-- padding between controls
	margin	= 2,
	
	box_padding	= 16,

	box_origin	= [ margin*2, 4 ],	-- store origin of controls box
	pos_last,		        -- store origin of last added control 

	
	/** Set dimensions of control, add to Bounding box
	  * @param	Params	Params
	  * @param	int	col	Width of control
	  *
	 */
	function setControlDimensions col pos width height =
	(
		print "Layout.setControlDimensions()"
		--format " col	= % \n pos 	 = % \n width  = % \n height = % \n\n" col pos width height
		
		width_raw	= this._getControlWidth col width
		--format " width_raw	= % \n" width_raw
		this._trySetNewControlsRow width_raw
		
		position = if( pos    == undefined ) then [ pos_last[1] + padding, pos_last[2] ] else pos    as integer 
		height   = if( height == undefined ) then column_width - padding * 2                    else height as integer 
		width    =  width_raw - padding * 2
		format " this	= % \n" this 
		
		dimensions	= #( position, width, height )
		format " dimensions	= % \n" dimensions 
		--format "dimensions:\n pos 	= % \n width	= % \n height	= % \n\n" dimensions[1] dimensions[2] dimensions[3]

		Bbox.add dimensions
		
		this._setNewControlPosition width_raw
		 
		dimensions --return
		--#( [0,50], 128, 64 )
	),
	
	/** Set init pos_last 
	 */
	function newControlsBox =
	(
		print "------------\nLayout.newControlsBox()"
		--if( pos_last == undefined ) then -- first control box in rollout
			pos_last = box_origin
		
	--	else
	--		pos_last = box_origin = [ box_origin[1], pos_last[2] ] -- any other control box in rollout
	--
	--	if( groupbox!=undefined ) then -- move controls in groupbox lower
	--		pos_last[2] += box_padding
	
		Bbox = Bbox_v()
	),
	
	--/** Set next box position
	-- */
	--function nextControlsBox groupbox =
	--( 
	--	y = pos_last[2] + column_width
	--	--y = pos_last[2] + 16
	--
	--	if( groupbox!=undefined ) then -- Set offset of new box after groupbox
	--		y += 8
	--
	--	pos_last = [ box_origin[1], y ]
	--),

	/** Get params string of Controls box
	 */
	function _getGroupboxDimensions =
	(
		print "------------\nLayout._getGroupboxDimensions()"
		format " this	= % \n" this
		format " box_origin	= % \n" box_origin
		-- TADY JE BUG !!!!
		--#(
		--	[ box_origin[1] - margin, box_origin[2] - box_padding ],
		--	( Bbox.width + margin ),

		--	( Bbox.height + margin )
		--	--( pos_last[2] - box_origin[2] + column_width + box_padding )		
		--)
		#()
	),

	/** Try set new controls row
	 */
	function _trySetNewControlsRow with_current =
	(
		print "------------\nLayout._trySetNewControlsRow()"
		--format " pos_last	= % \n box_origin	= % \n\n" pos_last box_origin
		format " Bbox	= % \n" Bbox 
		if( this._controlIsOutOfRollout with_current ) then
			pos_last = [ box_origin[1], Bbox.height + margin ]
			------pos_last = [ box_origin[1], pos_last[2] + column_width ]
	),
	
	/** Control is out of rollout
     */
    function _controlIsOutOfRollout with_current =
    (
        (pos_last[1] + with_current) > this._getRollWidth() --return
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
	
	/** Set new control position
	 */
	function _setNewControlPosition with_current =
	(
		pos_last	= [ pos_last[1] + with_current, pos_last[2] ]
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
		this.newControlsBox()
	)
)
