/** Register dialog bar
 */
function register =
(
	--ENABLE_RESIZING = false
	--print "Dialog._register()"
	if not( this._isRegistered() ) then 
		cui.RegisterDialogBar	Dialog style:#( #cui_dock_all, #cui_floatable, #cui_handles )
		--minSize:size_init maxSize:size_init
	--ENABLE_RESIZING = true
),

/** Unregister dialog bar
 */
function unregister =
(
	--print "Dialog._unregister()"
	try(cui.UnRegisterDialogBar Dialog)catch() --try to unregister if already registered
),

/** Close
 */
function _unregisterOldDialog =
(
	--print "Dialog._unregisterOldDialog()"

	if( ( Dialog_global = DialogGlobals.get(RolloutMain.id) )!= undefined ) then
		Dialog_global.unregister()
),

/** _is registered
 */
function _isRegistered =
(
	try(
		cui.getDockState Dialog
		true --return 
	)catch(
		false --return 
	)
),