filein( getFilenamePath(getSourceFileName()) + "/../Menu/Menu.ms" )

filein( getFilenamePath(getSourceFileName()) + "/Rollout/Rollout.ms" )


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

	/*  properties */
	id,

	/* dependency */
	RolloutMain,
	Menu	= Menu_v(),
	Ini	= Ini_v(),
	
	/* options */	
	
	/* store */
	Dialog,
	size_init, -- size of dialog after creation


	include "Library/UI/Lib/Dialog/DialogRemote.ms"
	include "Library/UI/Lib/Dialog/DialogRegister.ms"
	include "Library/UI/Lib/Dialog/DialogDock.ms"
	
	
	/** Create Dialog
	  * Parameters: https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_816D257C_CD2D_4753_A792_6E7AEFAFA6A7_htm
	  *
	  * IMPORTANT: param fgcolor doesn't work
		WORKAROUND:
		
		rollout roll_test "test" (
			  dotNetControl dnc_label "Windows.Forms.Label"
		  
			  on roll_test open do (
				  dnc_label.text = "Hello World"
				  local bkgCol = (colorman.getcolor #background * 255) as color
				  dnc_label.backColor = (dotNetClass "System.Drawing.Color").fromArgb bkgCol.r bkgCol.g bkgCol.b
			  )
		  )
		  createDialog roll_test
		
	  *
	 */
	function create pos: width:512 height:320 bgcolor: fgcolor: bitmap: style: modal: escapeEnable: lockHeight: lockWidth: parent: =
	(		
		RolloutMain.createRollout() -- create all rollouts and subrollouts
		
		Dialog = RolloutMain.RolloutCreator.getDefinition()

		CreateDialog Dialog pos:pos width:width height:height menu:(Menu.create()) bgcolor:bgcolor fgcolor:fgcolor bitmap:bitmap style:style modal:modal escapeEnable:escapeEnable lockHeight:lockHeight lockWidth:lockWidth parent:parent

		RolloutMain.addSubRollouts() -- dialog must exist for adding subrollouts
		
		--RolloutMain.Layout.fitSubrollouts()
		
		--RolloutMain.setRolloutWidth()
	),
	 
	/** rollouts
     */
    function rollouts =
    (
        RolloutMain.subrollouts() --return
    ),
	
	
	private
	
	/** Set main rollout
	 */
	function _setMainRollout =
	(
		RolloutMain	= Rollout_v title:title id:id
		--ini:ini
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
	  * Default dir:	"#temp\ini-files\" E.G.: ""C:\Users\[USERNAME]\AppData\Local\Autodesk\3dsMax\2016 - 64bit\ENU\temp""
	  * Default file:	"%dialog_id%.ini"
	 */
	function _setIniFile =
	(
		if( Ini.dir #get == undefined ) then
			Ini.dir (( pathConfig.GetDir #temp ) + "\ini-files")
		
		if( Ini.file #get == undefined ) then
			Ini.file ( (getFilenameFile id) + ".ini" )
			
		Ini._combinePath()
		format "Ini._path = % \n" Ini._path
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
		
		this.destroy()
		
		--this._setIniFile()
		
		this._setMainRollout()
		
		this._setDialogGlobal()
	)
)