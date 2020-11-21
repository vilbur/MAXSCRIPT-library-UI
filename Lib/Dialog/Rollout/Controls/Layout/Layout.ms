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
		
	columns = 12, -- columns _width of rollout
	grid    = 24,
	
	padding	= 4,	-- padding between controls
	margin	= [padding,padding],
	
	_pos_last = [0,0],    -- store origin of last added control 

	_padding_corrention = 16,
	
	include "Library/UI/Lib/Dialog/Rollout/Controls/Layout/LayoutControl.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/Layout/LayoutGroupbox.ms"
	include "Library/UI/Lib/Dialog/Rollout/Controls/Layout/LayoutSubrollouts.ms"


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
