filein( getFilenamePath(getSourceFileName()) + "//Rollout/Rollout.ms" )

/** Store dialog in global variable
  * 
  */
struct Globals_v
(
	Dialog
)
if( __GLOBAL__v == undefined ) then
	global __GLOBAL__v = Globals_v()


/** Use Rollout as dialog
  *
  * Rollout dialog with subroullouts is used as "Dialog" instead of using regular [RolloutDialog](https://help.autodesk.com/view/3DSMAX/2018/ENU/?guid=__files_GUID_A72112A6_BDFB_47A6_88FB_8D49C4CBD049_htm)
  *
  */
struct Dialog_v
(
	__construct = #(#title),

	/* required properties */
	title,

	/* dependency */
	_RolloutMain,
	
	/* config */	
	id,
	
	/* options */	
	
	/* store */
	Dialog,
	size_init, -- size of dialog after creation


	include "Library/UI/Lib/Dialog/DialogRegister.ms"
	include "Library/UI/Lib/Dialog/DialogDock.ms"
	
	
	/** Create Dialog
	  * Same parameters as __[ Rollout.create() ](../Rollouts/Rollout)__
	 */
	function create width: height: pos: =
	(		
		_RolloutMain.createRollout()
		
		Dialog = _RolloutMain.RolloutCreator.getDefinition()
	
		CreateDialog ( Dialog )

		_RolloutMain.addSubRollouts()
	),
	
	/** Set rollout in Dialog
	  * UPDATE OF THIS BLOCK IS NEEDED
	  *
	  * @param	string	title	Title of rollout
	  * @param	string	id	Id of roullout, if empty then sanitized title is used
	  * @return	[Rollout](../Rollouts/Rollout)
	  *
	  * @example roll "Roll Title" "rollout_id" 	// set rollout
	  * @example roll "Roll Title" "" 	// set rollout, id will be sanitized title "roll_title"
	  */
	function roll title id:  =
	(
		--_rollout	= Rollout_v ini:(Ini.path #get) title:title id:id
		_RolloutMain.subrollout title id:id --return
	),
		
	private
	
	/** Set main rollout
	 */
	function _setMainRollout =
	(
		_RolloutMain	= Rollout_v title:title id:id
	),

	/** Set id of rollout as global variable
	  *	Id is sanitized title to id "Foo Bar" >>> "foo_bar"
	  */
	function _setDialogGlobal =
	(
		__GLOBAL__v.Dialog = this
	),

	/** Set default path to ini file
	  *
	  * Default dir:	"#temp\ini-files\"
	  * Default file:	"%dialog_id%.ini"
	 */
	function _setIniFile =
	(
		if( Ini.dir #get == undefined ) then
			Ini.dir (( pathConfig.GetDir #temp ) + "\ini-files")
		
		if( Ini.file #get == undefined ) then
			Ini.file ( (getFilenameFile id) + ".ini" )
	),
	
	/*------------------------------------------------------------------------------
		CONSTRUCT
	--------------------------------------------------------------------------------*/
	
	/** Check if required properties are defined
	  * Names of required props are defined in __construct array
	 */
	function _checkConstctructProperties =  
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),
	
	on create do
	(
		this._checkConstctructProperties()
		
		this._unregisterOldDialog()
		
		this._setMainRollout()
		
		this._setDialogGlobal()
	)
)
