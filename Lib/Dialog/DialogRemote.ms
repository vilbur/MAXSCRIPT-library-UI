	
	
	/** Destroy dialog
	 */
	function destroy =
	(
		if( __GLOBAL__v.Dialog != undefined ) then
		
		try
		(
			DestroyDialog __GLOBAL__v.Dialog.Dialog
			
		)
		catch()
		
	),
	
	
	/** Position
	 */
	function position x y =
	(
		--SetDialogPos __GLOBAL__v.Dialog.Dialog [0, 0]
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