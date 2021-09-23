global LAYOUT_FITSUBROLLOUTS_DEFAULT_HEIGHT = 99 -- used in Layout.fitSubrollouts()

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

	--height = 256, -- default height of subrollouts slot, observed in Layout_v._occupiedSpace()
	
	nested_level =0,
	
	/** New	subrollout
	  *
	  * @return	Rollout_v	
     */
    function new title =
    (
        --print("Subrollouts.new() title " +title)
		new_subrollout = Parent_roll.newSubrollout title
		
		new_subrollout.Parent_Subrollouts = this

		new_subrollout.Layout = (Parent_roll.Layout.copySetup new_subrollout.Layout)
		
		new_subrollout.Layout.slot_padding = 96  --!!! HOT FIX
		
		--format "new_subrollout=%"new_subrollout
		append Rollouts new_subrollout
		
		new_subrollout --return		
    ),

	/** Create Subrollouts and generate slot_string
	 */
	function create =
	(
		--print ("Subrollouts_v.create() "+ (this._getSubrolloutSlot()) )
		for _Rollout in Rollouts do
			_Rollout.createRollout()
			
		Parent_roll.RolloutCreator.addSubrolloutSlot( this._getSubrolloutSlot() )
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
        --print("Subrollouts.addSubRollouts to slot " + id)
		for _Rollout in Rollouts do
			this._addSubRollout _Rollout
	),
	
	/** Resize subrollout slot
	 */
	function resizeSobrolloutsSlot =
	(
		--format "Subrollouts_v.resizeSobrolloutsSlot() = % \n" id
		widths	= #()
	
		for _Rollout in Rollouts do
			append widths (_Rollout.setRolloutWidth())
		
		this.resize (amax widths) unsupplied

		amax widths
	),
	
	/** Fit subrollouts
	 */
	function fitSubrollouts =
	(
		--print "Subrollouts_v.fitSubrollouts()"
		--format "Rollouts = % \n" Rollouts.count
		for _Rollout in Rollouts do
			_Rollout.fitSubrollouts()
	),
	
	/** Resize subrollouts
	 */
	function resize width height =
	(
		--format "Subrollouts_v.resize() = % \n" id
		this.property width:width height:height
		
		for _Rollout in Rollouts do
			this._resizeRollout _Rollout
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
	/** Remove _Rollout
	 */
	function remove _Rollout =
	(
		execute ( "\n RemoveSubRollout " + this.getId() + " " + _Rollout.id )
	),
	/** 
	  *
	 */
	function exists =
	(
		Parent_roll.exists() --return
	),
	
	
	private

	
	/** Add subrollout to UI
	 */
	function _addSubRollout _Rollout =
	(
        --print("Subrollouts._addSubRollout() " + _Rollout.title )
		--print ( "Subrollouts._addSubRollout " + this.getId() + " " + _Rollout.id  )

		format "this._getIniRolledUp _Rollout = % \n" (this._getIniRolledUp _Rollout)

		--execute ( "\n AddSubRollout " + this.getId() + " " + _Rollout.id + " rolledUp:" + this._getIniRolledUp _Rollout )
		--execute ( "\n AddSubRollout " + this.getId() + " " + _Rollout.id + " rolledUp:true" )
		
		execute ( "\n AddSubRollout " + this.getId() + " " + _Rollout.id + " rolledUp:" + (this._getIniRolledUp _Rollout) as string )
		--execute( "\n AddSubRollout " + this.getId() + " " + _Rollout.id  )

		_Rollout.addSubRollouts()
	),
	
	/** Get ini setting
	  *
	  * @return	boolean	
	 */
	function _getIniRolledUp _Rollout =
	(
		if( _Rollout._ini._path != undefined ) then
			(_Rollout._Ini.load (_Rollout.id) "rolledUp" default:false)  --return

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
		"subRollout "+id+" \"slot_name\" height:" + LAYOUT_FITSUBROLLOUTS_DEFAULT_HEIGHT as string 

		--"subRollout "+id+" \"slot_name\" height:" + height as string + " width:64"
		--"subRollout "+id+" \"slot_name\" height:256 width:256"
		--"subRollout "+id+" \"slot_name\" height:256"
		--"subRollout "+id+" \"slot_name\"" --return
	),
	
	/** Remove and Add Rollout Again
	  * Refresh rollout width
	 */
	function _resizeRollout _Rollout =
	(
		this.remove         _Rollout
		this._addSubRollout _Rollout
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
		--print"----------------- Subrollouts_v"
		--format "Parent_roll.id = % \n" Parent_roll.id
		--format "this.id = % \n" this.id
		--format "this.getId() = % \n" (this.getId())
	)
		
		
		
		
		
)