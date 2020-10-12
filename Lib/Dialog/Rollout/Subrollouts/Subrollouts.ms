/** Store subrollouts
  *
  */
struct Subrollouts_v
(
	__construct = #( #slot ),

	/* required */
	slot,

	/* properties */
	slot_string = " ", -- used in "rolloutCreator.addText( slot_string )", !!! NOTE: empty string must has whitespace, otherwise is threated as undefined 
	
	Rollouts	= #(),  -- store rollouts used as subrollouts
	
	/* reference */
	Parent_roll, -- Parent rollout if this is subrollout, undefined for RolloutMain
	
	/** New	
     */
    function new title =
    (
        --print("Subrollouts.new() title"+title)
		new_subrollout = Rollout_v title:title Parent_roll:this
		--format "new_subrollout=%"new_subrollout
		append Rollouts new_subrollout
		
		new_subrollout --return		
    ),
	
	--/** Add
	-- */
	--function add _subrollout =
	--(
	--	--format "_subrollout=%"_subrollout
	--	append Rollouts _subrollout
	--),
	
	/** Create Subrollouts and generate slot_string
	 */
	function addToRollout =
	(
		print ( "\nSubrollouts_v.addToRollout() slot="+slot  )
		--if not ( this._anySubrolloutExists() ) then
		--	return()
			
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
		if not ( this._anySubrolloutExists() ) then
			return()
			
		--slot_string = "subrollout "+slot+" \"slot_name\" height:256"
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
		print ( "Subrollouts_v.addSubRollouts()" )
		--if not ( this._anySubrolloutExists() ) then
		--	return()
		
		add_subrollouts = " "
		--
		for subrollout in Rollouts do
			add_subrollouts += "\n AddSubRollout " + Parent_roll.id + "." + slot + " " + subrollout.id
		--
		execute (add_subrollouts)
	),
	
	/** Any subrollout exists
	 */
	function _anySubrolloutExists =
	(
		Rollouts.count > 0 --return
	),
	
	/*------------------------------------------------------------------------------
		CONSTRUCT
	--------------------------------------------------------------------------------*/
		
	/** Check if required properties are defined when an instance of the struct is created.
	 *
	 * @example __construct = #( #property_name )
	 */
	function _checkConstctructProperties =
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),
	
	/**
	 */
	on create do
	(
		this._checkConstctructProperties()
	)
)