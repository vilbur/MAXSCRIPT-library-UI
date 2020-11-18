filein( getFilenamePath(getSourceFileName()) + "/Bbox/Bbox.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Dimensions/Dimensions.ms" )

struct LayoutControls
(
	height_defined
	
)

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

	padding_groupbox = 16,
	
	Parent_roll,

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
		--format "------------\nLayout.setControlDimensions %\n" (Control.id.get())
		Dimensions	= this._getControlDimensions Control
		--format "Dimensions = %\n" Dimensions

		this._setNextControlPosition Dimensions.width

		Control.setDimensions Dimensions
		--format "Dimensions.pos =%\n" Dimensions.pos
		
 		Bbox.add Dimensions
	),

	/** Get params string of Controls box
	 */
	function setGroupboxDimensions &Groupbox =
	(
		--format "------------\nLayout._getGroupboxDimensions()"
		Groupbox.property pos:Bbox.origin width:(Bbox.width + margin) height:(Bbox.height + margin)
	),	
	
	/** Analyze layout
	 */
	function _getFixedSizes Controls_and_Rollouts =
	(
		height_fixed = #()
		
		for Control_or_Rollout in Controls_and_Rollouts do
			if ( (height = Control_or_Rollout.property height:#get) > 14 ) then 
				append height_fixed height

		height_fixed --return
	),

	/** If only single subrollouts
	 */
	function fitSubrollouts =
	(
		Controls_and_Rollouts = Parent_roll.Controls_and_Rollouts

		dialog_height     = (Parent_roll.property height:#get) as integer
		fixed_heights     = this._getFixedSizes Controls_and_Rollouts
		fixed_height      = 0; for val in fixed_heights do ( fixed_height += val )
		empty_space       = dialog_height - fixed_height
		
		subrollouts_count = Controls_and_Rollouts.count - fixed_heights.count
		
		slot_height       = if (subrollouts_count>0 )then (empty_space/subrollouts_count) as integer else empty_space
		offset            = 0
		
		--format "Layout.fitSubrollouts() % \n" Controls_and_Rollouts.count
		--format "dialog_height       = % \n" dialog_height
		--format "fixed_heights       = % \n" fixed_heights
		--format "fixed_heights.count = % \n" fixed_heights.count
		--format "fixed_height        = % \n" fixed_height
		--format "empty_space         = % \n" empty_space
		--format "subrollouts_count   = % \n" subrollouts_count
		--format "slot_height         = % \n" slot_height
		--format "offset              = % \n" offset
		
		if( offset == undefined ) then
			return false
			
		for Control_or_Rollout in Controls_and_Rollouts do
			if( this._getType Control_or_Rollout == "subrollouts" ) then
				offset = this._offsetSubrollouts Control_or_Rollout slot_height offset
			else
				offset = this._offsetGroubox Control_or_Rollout offset
	),
		/** _offset subrollouts
	 */
	function _offsetSubrollouts Subrollouts slot_height offset =
	(
		Subrollouts.property height:(slot_height - 4) pos:[0,offset]
		
		offset += slot_height --return
	),
	
	/** _offset groubox
	 */
	function _offsetGroubox Groupbox offset =
	(
		Groupbox.offsetGroupbox [0, offset] -- !!! TODO: ADD X POSITION TO OFFSET FUNCTION
		
		offset += (Groupbox.property height:#get)
	),
	
	/** Get type
	 */
	function _getType Object =
	(
		--print (toLower (( filterString( classof Object as string ) "_*(:" )[2]))
		toLower (( filterString( classof Object as string ) "_*(:" )[2])  --return
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
	  
	     TODO: REFRACT THIS METHOD
	 */
	function _getControlDimensions Control =
	(
		--print "Layout_v._getControlDimensions()"
		pos     = Control.property pos:   #get
		width   = Control.property width: #get
		height  = Control.property height:#get
		
		--format "column_size = % \n" column_size
		
		if( width == undefined ) then
			width = this._getControlWidth Control
		
		if( height == undefined ) then
			height = this._getControlHeight()
			
		if( pos == undefined ) then
			pos = this._getControlPosition width
			
		--format "pos    = % \n" pos
		--format "width  = % \n" width
		--format "height = % \n" height
		
		Dimensions_v pos:pos width:width height:height
	),

	/** Set first
	 */
	function _addFirstControlPadding =
	(
		--format "------------\nLayout._addFirstControlPadding()"
		if( pos_last == Bbox.origin ) then
		(
            pos_last.y  += padding_groupbox
            Bbox.height += padding_groupbox
		)
	),
	
	/** _get position of last control
	 */
	function _getControlPosition width =
	(
		--format "------------\nLayout._getControlPosition()"
		this._trySetNewControlsRow width

		[ pos_last.x, pos_last.y ] --return
	),
	
	/** Get height
	 */
	function _getControlWidth Control =
	(
		(Control.property columns:#get) * column_size --return
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
		--format "Layout_v._setNextControlPosition %\n" current_control_width
		pos_last.x += current_control_width
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
