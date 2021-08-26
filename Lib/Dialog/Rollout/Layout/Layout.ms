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
  *
  */
struct Layout_v
(
	Bbox,
	Parent_roll,
		
	width = 1024, 	
		
	columns = 12, -- columns _width of rollout
	grid    = 24, -- size of columns in pixels 
	
	padding	= 4,	-- padding between controls
	margin	= [padding, padding],
	
	_pos_last = [0,0],    -- store origin of last added control 

	_padding_corrention = 12,
	slot_padding = 32,

	include "Library/UI/Lib/Dialog/Rollout/Layout/LayoutControl.ms"
	include "Library/UI/Lib/Dialog/Rollout/Layout/LayoutGroupbox.ms"
	include "Library/UI/Lib/Dialog/Rollout/Layout/LayoutSubrollouts.ms"

	/** Fit subrollouts slots into dialog
	  *	1) get height of dialog
	  * 2) get occupied space by 
	  *
	 */
	function fitSubrollouts =
	(
		widths	= #()
		Controlboxes_and_Subrollouts = Parent_roll.Controlboxes_and_Subrollouts

		for Controlbox_or_Subrollouts in Controlboxes_and_Subrollouts do
		(
			
			if( this._getType Controlbox_or_Subrollouts == "controlbox" ) then
				--print ("### controlbox:"+ Controlbox_or_Subrollouts.id +" width = "+(Controlbox_or_Subrollouts.property width:#get)as string )
				append widths (Controlbox_or_Subrollouts.property width:#get)
				--append widths 256
			else
			--if( this._getType Controlbox_or_Subrollouts == "subrollouts" ) then
				--Controlbox_or_Subrollouts.resizeSobrolloutsSlot()
			append widths (Controlbox_or_Subrollouts.resizeSobrolloutsSlot())
			--format "widths = % \n" widths		
		)
		
		--dialog_height     = (Parent_roll.property height:#get) as integer
		--
		--occupied_heights  = this._getOccupiedHeights Controlboxes_and_Subrollouts
		--occupied_height   = 0; for val in occupied_heights do ( occupied_height += val )
		--
		--empty_space       = dialog_height - occupied_height
		--
		--subrollouts_count = Controlboxes_and_Subrollouts.count - occupied_heights.count
		--
		--slot_height       = if (subrollouts_count>0 )then (empty_space/subrollouts_count) as integer else empty_space
		--offset            = 0
		--
		format "widths = % \n" widths
		----format "Controlboxes_and_Subrollouts.count = % \n" Controlboxes_and_Subrollouts.count
		----format "dialog_height       = % \n" dialog_height
		----format "occupied_heights       = % \n" occupied_heights
		----format "occupied_heights.count = % \n" occupied_heights.count
		----format "occupied_height        = % \n" occupied_height
		----format "empty_space         = % \n" empty_space
		----format "subrollouts_count   = % \n" subrollouts_count
		----format "slot_height         = % \n" slot_height
		----format "offset              = % \n" offset
		
		
		--if( offset == undefined ) then
		--	return false
		--	
		--for Control_or_Rollout in Controlboxes_and_Subrollouts do
		--	if( this._isSubrollouts Control_or_Rollout ) then
		--		offset = this._offsetSubrollouts Control_or_Rollout slot_height offset
		--	else
		--		offset = this._offsetGroubox Control_or_Rollout offset
		
		 --amax widths --return
	),
	
	/** Collect heights of all elements which ARE NOT Subrollout with default height
	  *
	 */
	function _getOccupiedHeights Controlboxes_and_Subrollouts =
	(
		occupied_heights = #()
		
		for Control_or_Rollout in Controlboxes_and_Subrollouts do
		(
			height       = Control_or_Rollout.property height:#get
			control_type = this._getType Control_or_Rollout
			
			if( control_type != "subrollouts" or ( control_type == "subrollouts" and height != 32 ) ) then 
				append occupied_heights height
		)

		occupied_heights --return
	),
	
	
	/** Get rollout width
	 */
	function getRolloutWidth =
	(
		print "HOTFIX Layout_v.getRolloutWidth()"
		
		
		128 -- HOTFIX
	),
	
	/** Get setup from this
	 */
	function copySetup Layout =
	(
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
		--messagebox "Layout_v.test()"
	)
)
