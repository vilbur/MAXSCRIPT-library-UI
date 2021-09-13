/** Dock\Undock sidebar to window
  * 
  * Subrollouts and dialog are resized BEFORE docking
  *
  * @param	string	side	"left|top|right|bottom" or #left|#top|#right|#bottom, otherwise undock
  *
  * @example dock "right"	// dock dialog right
  * @example dock #left	// dock dialog left
  * @example dock ""	// undock dialog
 */
function dock side =
(
	if( findItem #( #left, #right, #top, #bottom ) ( side as name ) > 0 ) then 
		dock_state = ("cui_dock_" + side as string) as name
	else
		dock_state = #cui_floatable
	
		
	--format "this._getViewportHeight() = % \n" (this._getViewportHeight())
	if( dock_state != #cui_floatable ) then -- resize before docking
	(
		max_height	= this._getViewportHeight()
	
		this.RolloutMain.Layout.fitSubrollouts dialog_height:max_height -- resize subrollouts
		
		this.height max_height -- resize dialog
	)
		
	this._register() -- must be after resize

	cui.DockDialogBar Dialog dock_state
),

/** Undock dialog
 */
function undock =
(
	if ( this._isRegistered() and this._isDocked() ) then 
		this.dock "" --return
	
	this._unregister()
),

/** Is floatable
 */
function _isFloatable =
(
	if ( this._isRegistered() and cui.getDockState Dialog == #cui_floatable ) then true else false --return;
),
/** _is docked
 */
function _isDocked =
(
	if ( matchPattern ((cui.getDockState Dialog) as string ) pattern:@"_dock_" ) then true else false --return
),
    
/** Get height of maximized viewport to find out height of docked dialog
 */
function _getViewportHeight =
(
	is_maximized = viewport.numViews == 1

	height_of_ui = 0 -- Add heigh

	if( trackbar.visible ) then 
		height_of_ui	+= 27

	if( timeSlider.isVisible() ) then 
		height_of_ui	+= 18
	

	if not( is_maximized ) then 
		actionMan.executeAction 0 "50026"  -- Tools: Maximize Viewport Toggle
	
	viewport_area_size = getViewSize()
	
	if not( is_maximized ) then 
		actionMan.executeAction 0 "50026"  -- Tools: Maximize Viewport Toggle
	
	(viewport_area_size[2] as integer) + height_of_ui --return
),
