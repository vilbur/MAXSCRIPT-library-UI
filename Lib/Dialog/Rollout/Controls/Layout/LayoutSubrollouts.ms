	/** If only single subrollouts
	 */
	function fitSubrollouts =
	(
		Controls_and_Rollouts = Parent_roll.Controls_and_Rollouts

		dialog_height     = (Parent_roll.property height:#get) as integer
		fixed_heights     = this._getFixedSizes Controls_and_Rollouts
		fixed_height      = 0; for val in fixed_heights do ( fixed_height += val )
		empty_space       = dialog_height - fixed_height
		
		subrollouts_count = Controls_and_Rollouts.count - fixed_heights.count
		
		slot_height       = if (subrollouts_count>0 )then (empty_space/subrollouts_count) as integer else empty_space
		offset            = 0
		
		--format "Layout.fitSubrollouts() % \n" Controls_and_Rollouts.count
		--format "dialog_height       = % \n" dialog_height
		--format "fixed_heights       = % \n" fixed_heights
		--format "fixed_heights.count = % \n" fixed_heights.count
		--format "fixed_height        = % \n" fixed_height
		--format "empty_space         = % \n" empty_space
		--format "subrollouts_count   = % \n" subrollouts_count
		--format "slot_height         = % \n" slot_height
		--format "offset              = % \n" offset
		
		if( offset == undefined ) then
			return false
			
		for Control_or_Rollout in Controls_and_Rollouts do
			if( this._getType Control_or_Rollout == "subrollouts" ) then
				offset = this._offsetSubrollouts Control_or_Rollout slot_height offset
			else
				offset = this._offsetGroubox Control_or_Rollout offset
	),
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
	function _getFixedSizes Controls_and_Rollouts =
	(
		height_fixed = #()
		
		for Control_or_Rollout in Controls_and_Rollouts do
			if ( (height = Control_or_Rollout.property height:#get) > 14 ) then 
				append height_fixed height

		height_fixed --return
	),
