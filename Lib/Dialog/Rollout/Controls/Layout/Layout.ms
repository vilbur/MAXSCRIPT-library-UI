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
		format "------------\nLayout.setControlDimensions %\n" (Control.id.get())
		Dimensions	= this._getControlDimensions Control
		format "Dimensions = %\n" Dimensions

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
		--Dimensions = Dimensions_v pos:Bbox.origin width:(Bbox.width + margin) height:(Bbox.height + margin)
		
		--Groupbox.Props.setDimensions Dimensions

		Groupbox.property pos:Bbox.origin width:(Bbox.width + margin) height:(Bbox.height + margin)

	),	

	
	
	/** Analyze layout
	 */
	function analyze &Controls_and_Rollouts =
	(
		_subrollouts = #()
		_controls    = #()
		
		for Control_or_Rollout in Controls_and_Rollouts do
			if( this._getType Control_or_Rollout == "subrollouts" ) then 
				append _subrollouts Control_or_Rollout
			else
				append _controls Control_or_Rollout
			--Control_or_Rollout._create()
		--format "_subrollouts.count = % \n" _subrollouts.count
		--format "_controls.count = % \n" _controls.count
		_subrollouts --return
	),

	/** If only single subrollouts
	 */
	function fitSubrollouts =
	(
		Controls_and_Rollouts = Parent_roll.Controls_and_Rollouts
		
		dialog_height = (Parent_roll.property height:#get) as integer
		--format "dialog_height = % \n" dialog_height
		subrollouts_count = Controls_and_Rollouts.count
		--format "Controls_and_Rollouts.count = % \n" Controls_and_Rollouts.count

		rollout_height = (dialog_height/subrollouts_count) as integer
		--format "dialog_height = % \n" dialog_height
		--format "rollout_height = % \n" rollout_height
		offset = - rollout_height
		--format "offset = % \n" offset
		
		for Control_or_Rollout in Controls_and_Rollouts do
			if( this._getType Control_or_Rollout == "subrollouts" ) then 
				Control_or_Rollout.property height:(rollout_height - 4) pos:[0,(offset+=rollout_height)]
			else
				Control_or_Rollout.offsetGroupbox [0, (offset+=rollout_height)] -- !!! TODO: ADD X POSITION TO OFFSET FUNCTION
	),
	
	/** Get type
	 */
	function _getType Object =
	(
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
		print "Layout_v._getControlDimensions()"
		pos     = Control.property pos:   #get
		width   = Control.property width: #get
		height  = Control.property height:#get
		
		format "column_size = % \n" column_size
		
		if( width == undefined ) then
			width = this._getControlWidth Control
		
		if( height == undefined ) then
			height = this._getControlHeight()
			
		if( pos == undefined ) then
			pos = this._getControlPosition width
			
		format "pos    = % \n" pos
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
		format "Layout_v._setNextControlPosition %\n" current_control_width
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
