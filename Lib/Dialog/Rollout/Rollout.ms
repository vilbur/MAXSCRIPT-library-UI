filein( getFilenamePath(getSourceFileName()) + "/../../List/List.ms" )
filein( getFilenamePath(getSourceFileName()) + "/../../Properties/Properties.ms" )
filein( getFilenamePath(getSourceFileName()) + "/RolloutCreator/RolloutCreator.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Subrollouts/Subrollouts.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Controls/Controls.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Controls/Layout/Layout.ms" )

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
	slot_id = 0,
	
	/* dependency */
	RolloutCreator,
	
	--Subrollouts	= Subrollouts_v slot:slot_id,
 	Controls        = Controls_v        Parent_roll:this,
	Layout          = Layout_v          Parent_roll:this,
	Properties = Properties_v Parent_Control:this,

	Controls_and_Rollouts	= #(),  -- store subrollouts and controlboxes
	
	include "Library/UI/Lib/Dialog/Rollout/RolloutSubrollouts.ms"

	/** New	subrollout
	  *
	  * @return	object Rollout_v	
     */
    function new title =
    (
		Rollout_v title:title
    ),

	/** Create rollout with [ rolloutCreator() ](http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_5FC5036F_E2D7_46C9_9AFA_7B3550B9F254_htm)
	  * Used for creation of rollout and subrollout subrollout
	 */
	function createRollout =
	(
		format "Rollout_v.createRollout %\n" id
		for Control_or_Rollout in Controls_and_Rollouts do
			Control_or_Rollout._create()
	
		RolloutCreator.endOfCreation()
	),
	
	/** Fit subrollouts
	 */
	function fitSubrollouts =
	(
		print "*********** fitSubrollouts"
		
		--_subrollouts = Layout.analyze Controls_and_Rollouts
		
		this.Layout.fitSubrollouts()
	),

	/** Get type
	 */
	function _getType Object =
	(
		toLower (( filterString( classof Object as string ) "_*(:" )[2])  --return
	),
	
	
	/** Set any property for rollout 
	  * https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
	  *
	  * @property	mixed	name|title|open|scrollPos|height|width
     */
    function property name: title: open: scrollPos: height: width: =
    (
		Properties.getOrSet #(#name, #title, #open, #scrollPos, #height, #width) #(name, title, open, scrollPos, height, width)
	),
	
	/** Find if rollout has been added to UI already
	 */
	function exists =
	(
		(execute id) != undefined --return
	),
	
	/** Get id
	 */
	function getId =
	(
		id --return
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
		try( execute("cui.UnRegisterDialogBar " + id) )catch()
		try( execute("DestroyDialog "           + id) )catch()
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