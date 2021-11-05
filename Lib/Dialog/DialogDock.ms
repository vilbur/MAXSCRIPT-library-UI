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
	--print "dock.undock()"
	if( findItem #( #left, #right, #top, #bottom ) ( side as name ) > 0 ) then 
		dock_state = ("cui_dock_" + side as string) as name
	else
		dock_state = #cui_floatable

	if ( dock_state != #cui_floatable ) then 
	(
		this._resizeDialogBeforeDocking()
		
		this.register() -- must be after resize
	)
	
	cui.DockDialogBar Dialog dock_state
),

/** Undock dialog
 */
function undock =
(
	--print "Dialog.undock()"
	if ( this._isRegistered() and this._isDocked() ) then 
		this.dock "" --return
	
	this.unregister()
),

/** Get dock state
 */
function getDockState =
(
	if ( this._isRegistered() ) then
		cui.getDockState Dialog --return
),

/** Dock on init
*/
function dockOnInit =
(   
   dock_state = _Ini.load (RolloutMain.id) #dock_state default:#cui_floatable --return

	if ( dock_state != #cui_floatable ) then 
		this.register()
   
   cui.DockDialogBar Dialog ( dock_state as name )
),
	
/** Is floatable
 */
function _isFloatable =
(
	--print "Dialog._isFloatable()"
	--ENABLE_RESIZING = false
	
	if ( this._isRegistered() and cui.getDockState Dialog == #cui_floatable ) then true else false --return;
),
/** _is docked
 */
function _isDocked =
(
	if ( matchPattern ((cui.getDockState Dialog) as string ) pattern:@"_dock_" ) then true else false --return
),


/** Resize dialog before docking
 */
function _resizeDialogBeforeDocking =
(
	max_height	= this._getViewportHeight()
	this.RolloutMain.Layout.fitSubrollouts dialog_height:max_height -- resize subrollouts
	this.height max_height -- resize dialog
),



-- /** Resize subrollouts
--  */
-- function resizeSubrolloutsOfDockedDialog =
-- (
--	print "Dialog.resizeSubrolloutsOfDockedDialog()"
--	 --this._isFloatable()
--	--if not( this._isFloatable() ) then -- resize before docking
--	(
--		max_height	= this._getViewportHeight()
--		
--		ENABLE_RESIZING = false
--	
--		dock_state = cui.getDockState Dialog
--		
--		try(cui.UnRegisterDialogBar Dialog)catch() --try to unregister if already registered
--
--		this.RolloutMain.Layout.fitSubrollouts dialog_height:max_height -- resize subrollouts
--		this.height max_height -- resize dialog
--		
--		cui.RegisterDialogBar	Dialog style:#(#cui_dock_left,#cui_dock_right,#cui_floatable,#cui_handles)
--
--
--		cui.DockDialogBar Dialog dock_state
--		
--		ENABLE_RESIZING = true
--
--	)
--	
--),

  
    
/** Get height of maximized viewport to find out height of docked dialog
 */
function _getViewportHeight =
(
	is_maximized = viewport.numViews == 1

	height_of_ui = 0 -- Add heigh

	--if( trackbar.visible ) then 
	--	height_of_ui	+= 27
	--
	--if( timeSlider.isVisible() ) then 
	--	height_of_ui	+= 18
	

	if not( is_maximized ) then 
		actionMan.executeAction 0 "50026"  -- Tools: Maximize Viewport Toggle
	
	viewport_area_size = getViewSize()
	
	if not( is_maximized ) then 
		actionMan.executeAction 0 "50026"  -- Tools: Maximize Viewport Toggle
	
	(viewport_area_size[2] as integer) + height_of_ui --return
),
