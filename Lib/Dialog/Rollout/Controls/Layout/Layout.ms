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

	_padding_groupbox = 16,
	
	/** Set init pos_last 
	 */
	function newControlsBox =
	(
		--format "\n------------\nLayout.newControlsBox()"
		Bbox = Bbox_v origin:(this._getBboxOrigin())

		pos_last = copy Bbox.origin

		this._addFirstControlPadding()
	),
	
	/** Set dimensions of control, add to Bounding box
	  * @param	Params	Params
	  * @param	int	columns	Width of control
	  *
	 */
	function setControlDimensions &Control =
	(
		format "------------\nLayout.setControlDimensions %\n" (Control.id.get())
		Dimensions	= this._getControlDimensions Control

		this._setNextControlPosition Dimensions.width

		Control.Props.setDimensions Dimensions
		format "Dimensions.pos =%\n" Dimensions.pos
		
 		Bbox.add Dimensions
	),

	/** Get params string of Controls box
	 */
	function setGroupboxDimensions &Groupbox =
	(
		--format "------------\nLayout._getGroupboxDimensions()"
		Dimensions = Dimensions_v pos:Bbox.origin width:(Bbox.width + margin) height:(Bbox.height + margin)
		
		Groupbox.Props.setDimensions Dimensions
	),	

	private
	
	/** _get bbox origin
	 */
	function _getBboxOrigin =
	(
		 --box_origin = pos_last = [Bbox.origin.x, pos_last.y+32] --return
		box_origin = [0,0]
		
		if( Bbox != undefined ) then
			box_origin.y = Bbox.getMax #y

		 box_origin
	),

	/** Get control dimensions defined by user
	  * If undefined then us Layout default values0
	 */
	function _getControlDimensions Control =
	(
		pos     = Control.Props.get #pos
		width   = Control.Props.get #width
		height  = Control.Props.get #height

		
		if( width == undefined ) then
			width = (Control.Props.get #columns) * column_size
		
		if( height == undefined ) then
			height = this._getControlHeight()
			
		if( pos == undefined ) then
			pos = this._getControlPosition width
		
		Dimensions_v pos:pos width:width height:height
	),

	/** Set first
	 */
	function _addFirstControlPadding =
	(
		--format "------------\nLayout._addFirstControlPadding()"
		if( pos_last == Bbox.origin ) then
		(
            pos_last.y  += _padding_groupbox
            Bbox.height += _padding_groupbox
		)
	),
	
	/** _get position of last control
	 */
	function _getControlPosition current_control_width =
	(
		--format "------------\nLayout._getControlPosition()"
		this._trySetNewControlsRow current_control_width

		[ pos_last.x, pos_last.y ] --return
	),
	
	/** Get height
	 */
	function _getControlHeight =
	(
		column_size - padding * 2 --return
	),
	

	/** Set new control position
	 */
	function _setNextControlPosition current_control_width =
	(
		pos_last.x += current_control_width
		--pos_last = [ pos_last.x + current_control_width, pos_last.y ]
	),

	/** Try set new controls row
	 */
	function _trySetNewControlsRow current_control_width =
	(
		if not ( this._controlFitIntoRollout current_control_width ) then
			pos_last = [ Bbox.origin.x, Bbox.getMax #y ]
	),
	
	/** Control is out of rollout
     */
    function _controlFitIntoRollout current_control_width =
    (
        (pos_last.x + current_control_width) < this._getRollWidth() --return
    ),
	
	/*---------------------------------------
		ROLLOUT
	-----------------------------------------*/
	/** _get roll width
	 */
	function _getRollWidth =
	(
		--format "------------\nLayout._getRollWidth()"
		width = (columns * column_size) + margin*4 + 14
		--width = (columns * column_size)
		--format " width = % \n" width
		width --return
	),

	--/** _get roll height
	-- */
	--function _getRollHeight =
	--(
	--	Bbox.height + 48
	--),

	on create do
	(
		--messagebox "Layout_v.test()"
	)
)
