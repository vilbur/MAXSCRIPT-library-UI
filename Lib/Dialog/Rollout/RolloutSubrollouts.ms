	
	/** New subrollout
	  * used in Subrollouts_v
	 */
	function newSubrollout title =
	(
		Rollout_v title:title _ini:_ini --return
	),
	
	/** Add subrollout
	  *
	  * @return	object new instance of Subrollouts_v
	 */
	function subrollouts =
	(
		--_Subrollouts = Subrollouts_v id:( "subrollouts_slot_" + (slot_id+=1) as string ) Parent_roll:this
		
		nested_level	= if( Parent_Subrollouts != undefined ) then (Parent_Subrollouts.nested_level +1) else 0 
		
		--_Subrollouts = Subrollouts_v id:( id as string + "_subrollouts_" + (slot_id+=1) as string ) Parent_roll:this  nested_level:nested_level
		_Subrollouts = Subrollouts_v id:( "subrollouts_" + (slot_id+=1) as string ) Parent_roll:this  nested_level:nested_level
	
		append Controlboxes_and_Subrollouts _Subrollouts
		
		_Subrollouts --return 
	), 
	
	/** Add sub rollouts
	 */
	function addSubRollouts =
	(
		--print("RolloutSubrollouts.addSubRollouts()")
		for Controlbox_or_Subrollouts in Controlboxes_and_Subrollouts do
			if ( this._isSubrolloutsStruct Controlbox_or_Subrollouts ) then
				Controlbox_or_Subrollouts.addSubRollouts()
	),

	/** Is subrollout class
	 */
	function _isSubrolloutsStruct _struct =
	(
		--print("RolloutSubrollouts._isSubrolloutsStruct()")
		((filterString( classof _struct as string ) "_*(:" )[2]) == "Subrollouts" --return
	),
	
	/** Test if this rollout is subrollout
	 */
	function _isSubrollout =
	(
		--print("RolloutSubrollouts._isSubrollout()")
		Parent_Subrollouts != undefined --return
	),