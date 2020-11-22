
		/** _offset subrollouts
	 */
	function _offsetSubrollouts Subrollouts slot_height offset =
	(
		Subrollouts.property height:(slot_height - 4) pos:[0,offset]
		
		offset += slot_height --return
	),
	

	/** Get type
	 */
	function _getType Object =
	(
		--print (toLower (( filterString( classof Object as string ) "_*(:" )[2]))
		toLower (( filterString( classof Object as string ) "_*(:" )[2])  --return
	),
	
	/** Analyze layout
	 */
	function _getFixedSizes Controlboxes_and_Subrollouts =
	(
		height_fixed = #()
		
		for Control_or_Rollout in Controlboxes_and_Subrollouts do
			if ( (height = Control_or_Rollout.property height:#get) > 14 ) then 
				append height_fixed height

		height_fixed --return
	),
