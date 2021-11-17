filein( getFilenamePath(getSourceFileName()) + "/Bbox/Bbox.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Dimensions/Dimensions.ms" )

/** Layout
  * @property	int	columns	_width of groupbox
  * @property	int	grid    size of column in pixels
  *
  * @property	int	padding	of groupbox
  * @property	Point2	margin	between controls
  *
  */
struct Layout_v
(
	Bbox,
	Parent_roll,
	
	/* properties */ 
	columns = 16, -- columns _width of rollout
	grid    = 16, -- size of columns in pixels 
		
	width = 1024, 	
	
	padding	= 4,	-- padding between controls
	margin	= [padding, padding],
	
	slot_padding = 32,

	_pos_last = [0,0], -- store origin of last added control 
	
	include "Library/UI/Lib/Dialog/Rollout/Layout/LayoutControl.ms"
	include "Library/UI/Lib/Dialog/Rollout/Layout/LayoutGroupbox.ms"
	include "Library/UI/Lib/Dialog/Rollout/Layout/LayoutSubrollouts.ms"

	/** Fit subrollouts slots into dialog
	  *	1) get height of dialog
	  * 2) get occupied space by 
	  *
	 */
	function fitSubrollouts dialog_height: =
	(
		--print "Layout.fitSubrollouts()"
		Controlboxes_and_Subrollouts = Parent_roll.Controlboxes_and_Subrollouts
		
		if( dialog_height == unsupplied ) then
			dialog_height     = (Parent_roll.property #height #get) as integer
		
		fixed_heights     = this._getOccupiedHeights Controlboxes_and_Subrollouts
		fixed_height      = 0; for val in fixed_heights do ( fixed_height += val )
		empty_space       = dialog_height - fixed_height
		
		subrollouts_count = Controlboxes_and_Subrollouts.count - fixed_heights.count
		
		slot_height       = if (subrollouts_count>0 )then (empty_space/subrollouts_count) as integer else empty_space
		offset            = 0
		
		format "dialog_height       = % \n" dialog_height
		format "fixed_heights       = % \n" fixed_heights
		format "fixed_heights.count = % \n" fixed_heights.count
		format "fixed_height        = % \n" fixed_height
		format "empty_space         = % \n" empty_space
		format "subrollouts_count   = % \n" subrollouts_count
		format "slot_height         = % \n" slot_height
		format "offset              = % \n" offset
		
		if( offset == undefined ) then -- offset can be returned undefined in nested loop of fitSubrollouts()
			return false
			
		for Control_or_Rollout in Controlboxes_and_Subrollouts do
		(
			format "this._getType Control_or_Rollout	= % \n" (this._getType Control_or_Rollout)
			if( this._getType Control_or_Rollout == "subrollouts" ) then
				offset = this._offsetSubrollouts Control_or_Rollout slot_height offset
			else
				offset = this._offsetGroubox Control_or_Rollout offset
			format "offset                          = % \n" offset 
		)
	),
	
	/** Collect heights of all elements which ARE NOT Subrollout with default height
	  *
	 */
	function _getOccupiedHeights Controlboxes_and_Subrollouts =
	(
		--print "Layout._getOccupiedHeights()"
		occupied_heights = #()
		
		for Control_or_Rollout in Controlboxes_and_Subrollouts do
			if( this._getType Control_or_Rollout == "controlbox" ) then 
				append occupied_heights ( Control_or_Rollout.property #height #get)

		occupied_heights --return
	),

	--
	/** Get setup from this
	 */
	function copySetup Layout =
	(
		--print "Layout.copySetup()"
		Layout.columns = columns
		Layout.grid    = grid
		Layout.padding = padding
		Layout.margin  = margin

		Layout --return
	),
	
	/** _is subrollouts
	 */
	function _isSubrollouts Control_or_Rollout =
	(
		this._getType Control_or_Rollout == "subrollouts" --return
	),
	
	on create do
	(

	)
)
