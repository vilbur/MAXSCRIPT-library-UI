filein( getFilenamePath(getSourceFileName()) + "/Bbox/Bbox.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Dimensions/Dimensions.ms" )

struct LayoutControls
(
	height_defined
)

/** Layout
  * @property	int	columns	_width of groupbox
  * @property	int	grid    size of column in pixels
  *
  * @property	int	padding	of groupbox
  * @property	Point2	margin	between controls
  * @p
  *
  */
struct Layout_v
(
	Bbox,
	Parent_roll,
		
	width = 1024, 	
		
	columns = 16, -- columns _width of rollout
	grid    = 24,
	
	padding	= 4,	-- padding between controls
	margin	= [padding,padding],
	
	_pos_last = [0,0],    -- store origin of last added control 

	_padding_corrention = 16,
	
	include "Library/UI/Lib/Dialog/Rollout/Controls/Layout/LayoutControl.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/Layout/LayoutGroupbox.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/Layout/LayoutSubrollouts.ms"

	/** If only single subrollouts
	 */
	function fitSubrollouts =
	(
		Controlboxes_and_Subrollouts = Parent_roll.Controlboxes_and_Subrollouts

		dialog_height     = (Parent_roll.property height:#get) as integer
		fixed_heights     = this._getFixedSizes Controlboxes_and_Subrollouts
		fixed_height      = 0; for val in fixed_heights do ( fixed_height += val )
		empty_space       = dialog_height - fixed_height
		
		subrollouts_count = Controlboxes_and_Subrollouts.count - fixed_heights.count
		
		slot_height       = if (subrollouts_count>0 )then (empty_space/subrollouts_count) as integer else empty_space
		offset            = 0
		
		
		
		--format "Layout.fitSubrollouts() % \n" Controlboxes_and_Subrollouts.count
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
			
		for Control_or_Rollout in Controlboxes_and_Subrollouts do
			if( this._getType Control_or_Rollout == "subrollouts" ) then
				offset = this._offsetSubrollouts Control_or_Rollout slot_height offset
			else
				offset = this._offsetGroubox Control_or_Rollout offset
	),

	/** Get rollout width
	 */
	function getRolloutWidth =
	(
		512
	),

	on create do
	(
		--messagebox "Layout_v.test()"
	)
)
