/** Register dialog bar
 */
function _register =
(
	if not( this._isRegistered() ) then 
		cui.RegisterDialogBar	Dialog style:#(#cui_dock_left,#cui_dock_right,#cui_floatable,#cui_handles)
		--minSize:size_init maxSize:size_init
),

/** Unregister dialog bar
 */
function _unregister =
(
	try(cui.UnRegisterDialogBar Dialog)catch() --try to unregister if already registered
),

/** Close
 */
function _unregisterOldDialog =
(

	if( ( Dialog_global = DialogsGlobal.get(RolloutMain.id) )!= undefined ) then
		Dialog_global._unregister()
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