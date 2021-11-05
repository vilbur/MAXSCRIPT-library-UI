/** Rollout https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
 *
 *
 */
global GROUPBOX_GLOBAL = #() -- store groupboxes for dynamic method creation in ControlBoxControlTypes.ms

filein( getFilenamePath(getSourceFileName()) + "/../../../../List/List.ms" )

filein( getFilenamePath(getSourceFileName()) + "/../../Events/Event/Event.ms" )
filein( getFilenamePath(getSourceFileName()) + "/../../Events/Events.ms" )


filein( getFilenamePath(getSourceFileName()) + "/../../Ini/Ini.ms" )
filein( getFilenamePath(getSourceFileName()) + "/../../Properties/Properties.ms" )
filein( getFilenamePath(getSourceFileName()) + "/RolloutCreator/RolloutCreator.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Subrollouts/Subrollouts.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Controls/Controls.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Layout/Layout.ms" )

filein( getFilenamePath(getSourceFileName()) + "/Rollouts/Rollouts.ms" )
filein( getFilenamePath(getSourceFileName()) + "/RolloutEvent/RolloutEvent.ms" )


/** Create Rollout
  * Rollout has generated global variable by id with prefix "rollout" E.G.: "fooroll" >>> "rollout_fooroll"
  *
  * @property	string	title	Title of rollout
  * @property	string	id	Id of rollout, if not defined then sanitized title is used E.G.: title="Foo Roll" >>> id="fooroll"
  * @property	int	height	Height of rollout
  *
  *
  * @property	string	_Ini	Path to _Ini where state of UI is saved, if false then _Ini state is not saved
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
	slot_id   = 0,
	
	Controlboxes_and_Subrollouts	= #(),  -- store subrollouts and controlboxes

	min_width_of_rollout = 128,
	
	/* dependency */
	RolloutCreator,
	
	Events	    = RolloutEvent_v    Parent_roll:   this,
 	Controls   = Controls_v        Parent_roll:   this,
	Layout     = Layout_v          Parent_roll:   this,
	Properties = Properties_v      Parent_Control:this, -- https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm

	/* inherit */	
	_Ini       = Ini_v(),
	
	/* reference */
	Parent_Subrollouts,

	include "Library/UI/Lib/Dialog/Rollout/RolloutSubrollouts.ms"

	/** Create rollout with [ rolloutCreator() ](http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_5FC5036F_E2D7_46C9_9AFA_7B3550B9F254_htm)
	  *	  
	 */
	function createRollout =
	(
		--format "Rollout_v.createRollout %\n" id

		for Controlbox_or_Subrollouts in Controlboxes_and_Subrollouts do
			Controlbox_or_Subrollouts.create()
		
		this.setDefaultEvents()

		Events._addHandlers()
		
		
		try /*------ PREVENT adding same control again ------*/
		(
			Rollout_new = RolloutCreator.end()
			--format "Rollout_new	= % \n" Rollout_new
			--ROLLOUTS.add Rollout_new
			ROLLOUTS_GLOBAL.add Rollout_new
		)
		catch(
			messageBox (getCurrentException()) beep:false
			return false
		)
	),
	
	/** Set any property for rollout 
	  * https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
	  *
	  * @property	mixed key #caption|#text|#enabled|#pos|#visible|#hwnd OR #get for get value
	  * @property	mixed value
	  *
	  * @return mixed
     */
    function property key val =
    (
		--print ("Rollout_v.ms.property() " + id as string )
		Properties.getOrSet #( key ) #( val )
	),
	
	/** Set rollout width if Rollout is Parent rollout 
	  *
	  * @return	int	width of widest element
	 */
	function setRolloutWidth =
	(
		--Controlboxes_and_Subrollouts = Parent_Subrollouts.Parent_roll.Controlboxes_and_Subrollouts
		max_width = this._getMaxWidthOfNestedElements()
		
		-- HOTFIX WIDTH OF ROLLUTS
		max_width + 24 --return
	),
	
	/** Find if rollout has been added to UI already
	 */
	function exists =
	(
		(execute id) != undefined --return
	),
	
	/** Ini set\get ini path
	  *
	  * @property	string|#get	_path	set or get path t ini file
	  * @property	boolean	load	load values from ini on init
	  *
	  * @return	string path	to ini file
	 */
	function ini _path load:true =
	(
		--print "Rollout_v.ini()"
		--format "_path	= % \n" _path
		
		_Ini.load_values_on_init = load

		_Ini.path _path --return
	),
	
	/** Get id
	 */
	function getId =
	(
		if( this._isSubrollout() == true ) then 
			(Parent_Subrollouts.getId()) + "." + id --return
		else
			id --return
	),
	
	/** Add default events
	 */
	function setDefaultEvents =
	(
		--print "\n"
		--print ("Rollout_v.setDefaultEvents() " +id)
		--format "_Ini	= % \n" _Ini
		--print (  "Rollout_v.setDefaultEvents() "+title+ " " + ( _Ini ) as string )
		if( _Ini.isDefined() ) then
			Events.setSaveToIniEvents()
	),
	
	/** Test if this rollout is subrollout
	 */
	function _isParentRoll =
	(
		--print ("\nRollout_v._isParentRoll() " + (Parent_Subrollouts == undefined) as string )
		--format "id	= % \n" id
		--format "Parent_Subrollouts	= % \n" (Parent_Subrollouts == undefined)
		--format "this	= % \n" this
		Parent_Subrollouts == undefined --return
	),
	
	private
	
	/** Loop CotrolBoxes and Rollouts and find element with max width
	 */
	function _getMaxWidthOfNestedElements =
	(
		--print "Rollout_v._getMaxWidthOfNestedElements"
		widths	= #()
		
		for Controlbox_or_Subrollouts in Controlboxes_and_Subrollouts do
		(
			if( this._getType Controlbox_or_Subrollouts == "controlbox" ) then
				append widths (Controlbox_or_Subrollouts.property width:#get)

			else if( Controlbox_or_Subrollouts.Rollouts.count > 0 ) then
				append widths (Controlbox_or_Subrollouts.resizeSobrolloutsSlot())
		)
		--format "TOTAL widths = % \n" widths
		this._getMaxWidth widths --return
	),

	/** Get name given struct
	  * @property	struct	_Struct
	  *
	  * @return	string lower case	name of given struc stripped of "_v" suffix E.G.: "FooStruct_v" returm "foostruct"
	 */
	function _getType _Struct =
	(
		toLower (( filterString( classof _Struct as string ) "_*(:" )[2])  --return
	),
	
	/** Get widest rollout5
	  * 
	  * @return	int max element in rollout, or minimal width if dialog is empty
	 */
	function _getMaxWidth widths =
	(
		if( widths.count > 0 ) then
			amax widths --return
		else
			min_width_of_rollout   --return
	),
	
	/** Set id by title if not defined
	 */
	function _setId =
	(
		--print "Rollout_v._setId()"
		if not ( id == undefined or id == unsupplied ) then
			return()
			
		title_no_whitespace = substituteString title " " "_" -- replace whitespace

		id_by_title = (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9_]+" ).Replace ( toLower (title_no_whitespace) ) "") --return
	
	
		--if not( this._isParentRoll() ) then 
			id = "ROLLOUT_" + id_by_title
	),

	/** Declare rollout global variable
	  * Global variable is id with prefix "rollout" E.G.: "fooroll" >>> "rollout_fooroll"
	  *
	  * Declared as undefined, because of reset rollout when script is restarted
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
		
		RolloutCreator = RolloutCreator_v id:id title:title
		
		this.Events.setEventTypes()
	)

)