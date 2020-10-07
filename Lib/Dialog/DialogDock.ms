/** Dock\Undock sidebar to window
  * @param	string	side	"left|top|right|bottom" or #left|#top|#right|#bottom, otherwise undock
  *
  * @example dock "right"	// dock dialog right
  * @example dock #left	// dock dialog left
  * @example dock ""	// undock dialog
 */
function dock side =
(
	this._register()

	if( findItem #( #left, #right, #top, #bottom ) (side as name) > 0 ) then 
		_dock = ("cui_dock_" + side as string) as name
	else
		_dock = #cui_floatable
	
	cui.DockDialogBar Dialog _dock
),
/** Undock dialog
 */
function undock =
(
	print "------------\nDialog.undock()"

	if ( this._isRegistered() and this._isDocked() ) then 
		this.dock "" --return
	
	--format " cui.getDockState Dialog	= % \n" (cui.getDockState Dialog)
	
	this._unregister()
),


/** Is floatable
 */
function _isFloatable =
(
	if ( this._isRegistered() and cui.getDockState Dialog == #cui_floatable ) then true else false --return
),
/** _is docked
 */
function _isDocked =
(
	if ( matchPattern ((cui.getDockState Dialog) as string ) pattern:@"_dock_" ) then true else false --return
),
    