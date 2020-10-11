filein( getFilenamePath(getSourceFileName()) + "/RolloutCreator/RolloutCreator.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Subrollouts/Subrollouts.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Controls/Controls.ms" )

global add_subrollouts = " "


/** Create Rollout
  * Rollout has generated global variable by id with prefix "rollout" E.G.: "fooroll" >>> "rollout_fooroll"
  *
  * @property	string	title	Title of rollout
  * @property	string	id	Id of rollout, if not defined then sanitized title is used E.G.: title="Foo Roll" >>> id="fooroll"
  * @property	int	height	Height of rollout
  *
  *
  * @property	string	ini	Path to ini where state of UI is saved, if false then ini state is not saved
  *
  --* @method	void	onOpen(  @param	string	callback[, @param	string	tooltip] )	
  --* @method	void	onClose( @param	string	callback[, @param	string	tooltip] )	
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
 	Controls	= Controls_v    Parent_roll:this,
	
	Controls_and_Rollouts	= #(),  -- store rollouts used as subrollouts

	/* reference */
	Parent_roll, -- Parent rollout if this is subrollout, undefined for RolloutMain


	/** Create rollout with [ rolloutCreator() ](http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_5FC5036F_E2D7_46C9_9AFA_7B3550B9F254_htm)
	  * Used for creation of rollout and subrollout subrollout
	 */
	function createRollout =
	(
		print( "\nRollout.createRollout() "+id )
		for Control_and_Rollout in Controls_and_Rollouts do
				Control_and_Rollout.addToRollout()
			--format "\nControl_and_Rollout=%	"Control_and_Rollout.id

		--Subrollouts.createSubRollouts()
		--Subrollouts.setSubrolloutSlot()
		
		--RolloutCreator.addSubrolloutSlot( Subrollouts.slot_string )
	
		RolloutCreator.endOfCreation()
	),
	
	/** Add to rollout
     */
    function addToRollout =
    (
		print ( "\nRollout.addToRollout() 	 " + id )
 		this.createRollout()
		this.setSubrolloutSlot()
		this.addSubRollouts()

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
	function setSubrolloutSlot =
	(
		slot_string = "subrollout "+id+" \""+id+"\" height:128"
		print ("slot_string="+slot_string)

		Parent_roll.RolloutCreator.addSubrolloutSlot( slot_string )
	),

	/** Add subrollout
	  *
	  * @return	object new instance of Rollout_v
	 */
	function subrollout title id: =
	(
		new_subrollout = Rollout_v title:title id:id Parent_roll:this
		--format "new_subrollout=%"new_subrollout
		append Controls_and_Rollouts new_subrollout
		
		new_subrollout --return 
	),
	
	/** Add sub rollouts
     */
    function addSubRollouts =
    (
		add_subrollouts += "\nAddSubRollout " + Parent_roll.id + "." + id + " " + id
		print ("add_subrollouts="+add_subrollouts)
		--execute (add_subrollouts)
    ),
	
	private

	/** Set id by title if not defined
	 */
	function _setId =
	(
		if not ( id == undefined or id == unsupplied ) then
			return()
			
		title_no_whitespace = substituteString title " " "_" -- replace whitespace
		--print ( title_no_whitespace as String )
		id_by_title = (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9_]+" ).Replace ( toLower (title_no_whitespace) ) "") --return
		
		id = "rollout_" + id_by_title
		--print ( "------ID = "+id as String )	
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