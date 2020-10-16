/** Store subrollouts
  *
  */
struct Subrollouts_v
(
	/* required */
	slot,

	/* reference */
	Parent_roll, -- Parent rollout if this is subrollout, undefined for RolloutMain
	
	/* properties */
	Rollouts	= #(),  -- store rollouts used as subrollouts
	
	/** New	subrollout
	  *
	  * @return	object Rollout_v	
     */
    function new title =
    (
        --print("Subrollouts.new() title"+title)
		new_subrollout = Parent_roll.new title
		--format "new_subrollout=%"new_subrollout
		append Rollouts new_subrollout
		
		new_subrollout --return		
    ),
	
	/** Create Subrollouts and generate slot_string
	 */
	function _create =
	(
		for _Rollout in Rollouts do
			_Rollout.createRollout()
			
		Parent_roll.RolloutCreator.addSubrolloutSlot( this._getSubrolloutSlot() )
	),
	
	/** [ Get slot_string of subrollouts ](http://help.autodesk.com/view/3DSMAX/2019/ENU/?guid=GUID-CDE5B06D-4BB4-4DEA-96C1-6BAB98709F09#GUID-CDE5B06D-4BB4-4DEA-96C1-6BAB98709F09__WS73099CC142F487553098682E12AC2FC2BC7-7472)
	  *
	  * This definitions is added to with "rolloutCreator.addText( getSubrolloutsDefinition() )"
	  *
	  * @example of returned snippet:
	  * --------------------------------------------------------------------------------
	  *		
	  *	  subRollout subrollout_id_1 "Subrollouts"
	  *	  subRollout subrollout_id_2 "Subrollouts"
	  *		
	  * --------------------------------------------------------------------------------
	  *
	  * @return	string|undefined If any subrollout is defined, otherwise undefined
	 */
	function _getSubrolloutSlot =
	(
		--if not ( this._anySubrolloutExists() ) then
			--return()
			
		"subrollout "+slot+" \"slot_name\" height:128" --return
	),

	/** [ Execute "AddSubRollout" command for all subrollouts ](http://help.autodesk.com/view/3DSMAX/2019/ENU/?guid=GUID-CDE5B06D-4BB4-4DEA-96C1-6BAB98709F09#GUID-CDE5B06D-4BB4-4DEA-96C1-6BAB98709F09__WS73099CC142F487553098682E12AC2FC2BC7-7472)
	  *
	  * @example of executed snippet:
	  * --------------------------------------------------------------------------------
	  *
	  *		AddSubRollout rollout_id.subrollout_id_1 subrollout_id_1 -- THIS KIND OF LINES IS EXECUTED
	  *		AddSubRollout rollout_id.subrollout_id_2 subrollout_id_2 -- THIS KIND OF LINES IS EXECUTED
	  *
	  * --------------------------------------------------------------------------------
	  *
	  * @param	string	parrent_rollout_id
	 */
	function addSubRollouts =
	(
		for subrollout in Rollouts do
			execute ( "\n AddSubRollout " + Parent_roll.id + "." + slot + " " + subrollout.id )
	),
	
	/** Any subrollout exists
	 */
	--function _anySubrolloutExists =
	--(
	--	Rollouts.count > 0 --return
	--),
	
	/*------------------------------------------------------------------------------
		CONSTRUCT
	--------------------------------------------------------------------------------*/

	/**
	 */
	on create do
	(

	)
)