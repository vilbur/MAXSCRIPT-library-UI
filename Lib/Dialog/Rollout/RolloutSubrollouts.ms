	
	/** New subrollout
	  * used in Subrollouts_v
	 */
	function newSubrollout title =
	(
		Rollout_v title:title --return
	),
	
	/** Add subrollout
	  *
	  * @return	object new instance of Subrollouts_v
	 */
	function subrollouts =
	(
		--_Subrollouts = Subrollouts_v id:( "subrollouts_slot_" + (slot_id+=1) as string ) Parent_roll:this
		
		nested_level	= if( Parent_Subrollouts != undefined ) then (Parent_Subrollouts.nested_level +1) else 0 
		
		_Subrollouts = Subrollouts_v id:( id as string + "_subrollouts_" + (slot_id+=1) as string ) Parent_roll:this  nested_level:nested_level
	
		append Controlboxes_and_Subrollouts _Subrollouts
		
		_Subrollouts --return 
	), 
	
	/** Add sub rollouts
	 */
	function addSubRollouts =
	(
		--format "\n" 
		--print("RolloutSubrollouts.addSubRollouts()")
		--format "Controlboxes_and_Subrollouts.count = % \n" Controlboxes_and_Subrollouts.count
		--format "Controlboxes_and_Subrollouts = % \n" Controlboxes_and_Subrollouts
		for Controlbox_or_Subrollouts in Controlboxes_and_Subrollouts do
			if ( this.isSubrollouts Controlbox_or_Subrollouts ) then
				Controlbox_or_Subrollouts.addSubRollouts()
	),
	
	--/** Fit subrollouts
	-- */
	--function fitSubrollouts =
	--(
	--	format "\n" 
	--	print ("RolloutSubrollouts.ms.fitSubrollouts() " + id as string )
	--	--format "Controlboxes_and_Subrollouts = % \n" Controlboxes_and_Subrollouts
	--
	--	Layout.fitSubrollouts()
	--	
	--	for Controlbox_or_Subrollouts in Controlboxes_and_Subrollouts do
	--		if ( this.isSubrollouts Controlbox_or_Subrollouts ) then
	--			Controlbox_or_Subrollouts.fitSubrollouts()
	--		else
	--		(
	--			--format "Controlbox_or_Subrollouts = % \n" Controlbox_or_Subrollouts
	--			--print ("Groupbox " + Controlbox_or_Subrollouts.id as string )
	--		)
	--),
	
	/** Is subrollout class
	 */
	function isSubrollouts _struct =
	(
		((filterString( classof _struct as string ) "_*(:" )[2]) == "Subrollouts" --return
	),
	
	/** Test if this rollout is subrollout
	 */
	function _isSubrollout =
	(
		Parent_Subrollouts != undefined --return
	),