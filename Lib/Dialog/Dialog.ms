filein( getFilenamePath(getSourceFileName()) + "/../Menu/Menu.ms" )

filein( getFilenamePath(getSourceFileName()) + "/Rollout/Rollout.ms" )

filein( getFilenamePath(getSourceFileName()) + "/DialogGlobals/DialogGlobals.ms" )


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

	/*  properties */
	style = #(#style_titlebar, #style_sysmenu, #style_resizing ),
	
	/* dependency */
	RolloutMain,
	Menu	= Menu_v(),
	Ini	= Ini_v(),
	
	/* inherit */	
	Events,
	
	/* store */
	Dialog,

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
	function create pos: width: height: bgcolor: fgcolor: bitmap: style:style modal: escapeEnable: lockHeight:false lockWidth:true parent: =
	(		
		RolloutMain.createRollout() -- create all rollouts and subrollouts
		
		RolloutMain.Events.setSaveToIniEvents()
		
		Dialog = RolloutMain.RolloutCreator.getDefinition()

		CreateDialog Dialog pos:pos width:width height:height menu:(Menu.create()) bgcolor:bgcolor fgcolor:fgcolor bitmap:bitmap style:style modal:modal escapeEnable:escapeEnable lockHeight:lockHeight lockWidth:lockWidth parent:parent

		RolloutMain.addSubRollouts() -- dialog must exist for adding subrollouts
		
		RolloutMain.Layout.fitSubrollouts()
		
		max_width = RolloutMain.setRolloutWidth()
		
		this.width max_width
				
		this._runCallbacksOnStart()
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
		RolloutMain	= Rollout_v title:title id:id --ini:ini
		
		Events = RolloutMain.Events
	),

	/** Set id of rollout as global variable
	  *	Id is sanitized title to id "Foo Bar" >>> "foo_bar"
	  */
	function _setDialogGlobal =
	(
		DialogGlobals.setDialog RolloutMain.id this
	),
	
	/** Run callbacks of controls on start
	 */
	function _runCallbacksOnStart =
	(
		for callback in STARTUP_EVENTS do
			execute (callback)
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
		
		--this._setIniFile()

		this._setMainRollout()
		
		this._unregisterOldDialog()
		
		this.destroy()
		
		this._setDialogGlobal()
	)
)