	
	/** Add subrollout
	  *
	  * @return	object new instance of Subrollouts_v
	 */
	function subrollouts =
	(
		_Subrollouts = Subrollouts_v id:( "subrollouts_slot_" + (slot_id+=1) as string ) Parent_roll:this

		append Controls_and_Rollouts _Subrollouts
		
		_Subrollouts --return 
	), 
	
	/** Add sub rollouts
     */
    function addSubRollouts =
    (
		for Subrollouts in Controls_and_Rollouts do
			if ( this.isSubrollouts Subrollouts ) then
				Subrollouts.addSubRollouts()
    ),

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
		Parent_roll != undefined --return
	),
	