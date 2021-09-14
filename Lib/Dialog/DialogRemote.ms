

/** Destroy dialog
 */
function destroy =
(
	if( ( Dialog_global = DialogGlobals.get(RolloutMain.id) )!= undefined ) then
		try
		(
			DestroyDialog Dialog_global.Dialog
		)
		catch()
),

/** Position
 */
function position x y =
(
	SetDialogPos Dialog [0, 0]
),

/** Set width
 */
function width width =
(
	Dialog.width = width
),	
/** Set width
 */
function height height =
(
	Dialog.height = height
),