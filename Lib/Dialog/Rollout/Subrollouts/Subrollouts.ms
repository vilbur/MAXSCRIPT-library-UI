/** Store subrollouts
  *
  */
struct Subrollouts_v
(
	/* required */
	id,

	/* reference */
	Parent_roll, -- Parent rollout if this is subrollout, undefined for RolloutMain
	
	/* properties */
	Rollouts	= #(),  -- store rollouts used as subrollouts

	/* dependency */
	RolloutProperty = Properties_v Parent_Control:this,

	/** New	subrollout
	  *
	  * @return	object Rollout_v	
     */
    function new title =
    (
        print("Subrollouts.new() title " +title)
		new_subrollout = Parent_roll.newSubrollout title
		
		new_subrollout.Parent_Subrollouts = this

		new_subrollout.Layout = (Parent_roll.Layout.copySetup new_subrollout.Layout)
		
		--format "new_subrollout=%"new_subrollout
		append Rollouts new_subrollout
		
		new_subrollout --return		
    ),

	/** Create Subrollouts and generate slot_string
	 */
	function create =
	(
		for _Rollout in Rollouts do
			_Rollout.createRollout()
			
		Parent_roll.RolloutCreator.addSubrolloutSlot( this._getSubrolloutSlot() )
	),
	
	/** Set rollouts width
	 */
	function setRolloutsWidth =
	(
		widths	= #()
		
		--format "Subrollouts_v.setRolloutsWidth() = % \n" id
		for _Rollout in Rollouts do
			append widths (_Rollout.setRolloutWidth())
			
		--format "Subrollouts % widths = %\n\n" id (amax widths)
		
		this.resize (amax widths)
		
		amax widths
	),
	
	/** Fit subrollouts
	 */
	function fitSubrollouts =
	(
		print "Subrollouts_v.fitSubrollouts()"
		--format "Rollouts = % \n" Rollouts.count
		for _Rollout in Rollouts do
			_Rollout.fitSubrollouts()
	),
	
	/** Resize subrollouts
	 */
	function resize width =
	(
		this.property width:(width+16)
		
		for _Rollout in Rollouts do
			this._resizeRollout _Rollout
	),
	
	/** Remove and Add Rollout Again
	  * Refresh rollout width
	 */
	function _resizeRollout _Rollout =
	(
		this.remove         _Rollout
		this._addSubRollout _Rollout
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
		for Subrollout in Rollouts do
			this._addSubRollout Subrollout
	),

	/** Set any property for rollout 
	  * https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
	  *
	  * @property	mixed	name|title|open|scrollPos|height|width
     */
    function property offset: open: pos: height: width: =
    (
		RolloutProperty.getOrSet #(#offset, #open, #pos, #height, #width) #(offset, open, pos, height, width)
	),
	
	/** Get id
	 */
	function getId =
	(
		Parent_roll.id + "." + id --return
	),
	/** Remove Subrollout
	 */
	function remove Subrollout =
	(
		execute ( "\n RemoveSubRollout " + this.getId() + " " + Subrollout.id )
	),
	/** 
	  *
	 */
	function exists =
	(
		Parent_roll.exists() --return
	),

	/** Add subrollout to UI
	 */
	function _addSubRollout Subrollout =
	(
		execute ( "\n AddSubRollout " + this.getId() + " " + Subrollout.id + " rolledUp:" + this._getIniSetting Subrollout )

		Subrollout.addSubRollouts()					
	),
	
	/** Get ini setting
	 */
	function _getIniSetting Subrollout =
	(
		if( Subrollout.ini != undefined ) then
		(
			Ini = Ini_v()
			Ini.path Subrollout.ini

			(Ini.load Subrollout.id "rolledUp" default:true) as string --return
		)
		else
			false as string  --return default
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
		"subRollout "+id+" \"slot_name\" height:96" -- HOTFIX set mininum height
		--"subRollout "+id+" \"slot_name\"" --return
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
		print"-----------------"
		format "Parent_roll.id = % \n" Parent_roll.id
		format "this.id = % \n" this.id
		format "this.getId() = % \n" (this.getId())
	)
		
		
		
		
		
)