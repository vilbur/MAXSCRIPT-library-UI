filein( getFilenamePath(getSourceFileName()) + "/RolloutCreator/RolloutCreator.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Subrollouts/Subrollouts.ms" )

/** Create Rollout
  * 
  * 
  */
struct Rollout_v
(
	__construct = #( #title ),
	
	/* required */
	title,

	/* optional */
	id,

	/* properties */
	subrollouts_slot = "default_slot",
	
	/* dependency */
	RolloutCreator,
	
	Subrollouts	= Subrollouts_v slot:subrollouts_slot,
	
	/* reference */
	Parent_roll, -- Parent rollout if this is subrollout, undefined for RolloutMain


	/** Create rollout with [ rolloutCreator() ](http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_5FC5036F_E2D7_46C9_9AFA_7B3550B9F254_htm)
	  * Used for creation of rollout and subrollout subrollout
	 */
	function createRollout =
	(
		Subrollouts.createSubRollouts()
		Subrollouts.setSubrolloutSlot()
		
		RolloutCreator.addSubrolloutSlot( Subrollouts.slot_string )
	
		RolloutCreator.endOfCreation()
	),
	
	/** Add subrollout
	  *
	  * @return	object new instance of Rollout_v
	 */
	function subrollout title id: =
	(
		new_subrollout = Rollout_v title:title id:id Parent_roll:this
		--format "new_subrollout=%"new_subrollout
		Subrollouts.add new_subrollout
		
		new_subrollout --return 
	),
	
	private

	/** Set id by title if not defined
	 */
	function _setId =
	(
		if not ( id == undefined or id == unsupplied ) then
			return()
			
		title_no_whitespace = substituteString title " " "_" -- replace whitespace
		print ( title_no_whitespace as String )
		id_by_title = (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9_]+" ).Replace ( toLower (title_no_whitespace) ) "") --return
		
		id = "rollout_" + id_by_title
		
		print ( "------ID = "+id as String )	
	),

	/** Declare rollout global variable
	  * Global variable is id with prefix "rollout" E.G.: "fooroll" >>> "rollout_fooroll"
	  *
	  * Declared as undefined, because of reset rollout when script is restarted
	  *
	  */
	function _setGlobalVariable =
	(
		execute ( "global "+ id +" = undefined")
	),

	/** Try destroy dialog by global variable before variable will be overwritten
	 */
	function _destroy =
	(
		try( execute("cui.UnRegisterDialogBar " +i d) )catch()
		try( execute("DestroyDialog "           + id) )catch()
	),
	
	/*------------------------------------------------------------------------------
		HELPERS
	--------------------------------------------------------------------------------*/
	/** Test if this rollout is subrollout
	 */
	function _isSubrollout =
	(
		Parent_roll != undefined --return
	),
	
	/*------------------------------------------------------------------------------
		CONSTRUCT
	--------------------------------------------------------------------------------*/
	
	/** Check if properties in __construct are defined when an instance of the struct is created.
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
		
		this._setId()
		
		this._destroy()
		
		this._setGlobalVariable()
				
		RolloutCreator = RolloutCreator_v id:id title:title
	)

)