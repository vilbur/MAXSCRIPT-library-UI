/** 
 *
 */
struct ContentSubrollouts_v
(
	/* required properties */
	path,
	
	/*  properties */
	slot,
	Rollouts	= #(),

	/** Add to ui
	 */
	function addToUi _Rollout =
	(
		print ("ContentSubrollouts_v.addToUi() " + (filenameFromPath path) )
		
		Subrollouts = _Rollout.subrollouts()
		--Rollout_A	= Subrollouts.new "Rollout A"
		
		for ContentRollout in Rollouts do
			ContentRollout.addToUi Subrollouts
	),
	
	--/** Insert to ui
	-- */
	--function addToUi _Rollout =
	--(
	--	print ( "ContentSubrollouts_v.addToUi()" )
	--
	--	----name	= if( name==undefined )then "" else "";
	--	--
	--	--if( this.isMacrosriptFile() ) then
	--	--(
	--	--	--format " _Rollout	= % \n" _Rollout
	--	--	--format "this._getGroupboxName() = % \n" (this._getGroupboxName())
	--	--	_controls	= _Rollout.Controls.new groupbox:(this._getGroupboxName())
	--	--	--format " _controls = % \n" _controls
	--	--
	--	--	for m = 1 to MacroScripts.count do
	--	--		MacroScripts[m]._addControls _controls
	--	--)
	--	--else
	--	--	this._fileIn()
	--),
		
	
	/** Set slot name
	 */
	function _setSlot =
	(
		slot = filenameFromPath path
		slot = ( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-]" ).Replace slot ""
	),
	
	/** _set rollouts
	 */
	function _setRollouts paths =
	(
		--format "\n"
		--print ("ContentSubrollouts_v._setRollouts()")
		--for path in paths do 
			--format "rollout = % \n" (filenameFromPath path)
			
		for path in paths do 
			append Rollouts (ContentRollout_v path:path )
	),
	
	
	/** _get sub directories
	 */
	function _getSubDirs =
	(
		getDirectories (path + "/*") --return
	),
	
	
	on create do
	(
		this._setSlot()
		format "\n---------------\n"
		print ("ContentSubrollouts_v.onCreate " + slot )
		this._setRollouts(this._getSubDirs())

	)
)