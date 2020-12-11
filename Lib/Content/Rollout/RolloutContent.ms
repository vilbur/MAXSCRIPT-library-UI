/** Create rollout from dir containing ".ms" & ".mcr" files
 * 
 * @property	string	dir	Path to dir
 * @property	string	name	Name of rollout
 *
 */
struct Rollout_Content_v
(
	dir,
	name,
	
	_Rollout,
	--Rollouts	= #(),
	--ScriptFiles	= #(),
	--_macros	= #(),
	
	ScriptFile_and_RolloutContent = #(),
	
	
	/** Load
	 */
	function load =
	(
		--print ( "Rollout_Content_v.load " + dir as string )
		this._getControlsAndRollouts (this._getDirContent())
		--format "Rollout_Content_v.name = % \n" this.name
		--format "ScriptFile_and_RolloutContent = % \n" ScriptFile_and_RolloutContent
	
		this --return
	),
	
	/** Add to ui
	 */
	function addToUi Rollouts: Dialog: = -- HOT FIX parameter add: should be removed for cleaner code, it disallows adding of first rollout
	(
		--print ("Rollout_Content_v.addToUi() " + name)
		if( Dialog == unsupplied ) then
			
			_Rollout	= Rollouts.new name
		else
			_Rollout = Dialog._RolloutMain
		
		
		_Rollout	= if( Dialog == unsupplied ) then Rollouts.new name else Dialog._RolloutMain 
		
		
		
		for ScriptFile_or_RolloutContent in ScriptFile_and_RolloutContent do
			if( (this._isRolloutContent ScriptFile_or_RolloutContent ) == true ) then
			
				this._addRolloutToUi Rollouts ScriptFile_or_RolloutContent
			else
				this._addGroupBoxToUi ScriptFile_or_RolloutContent
	),
	
		
	/** _is rollout contet
	 */
	function _isRolloutContent ScriptFile_or_RolloutContent =
	(
		hasProperty ScriptFile_or_RolloutContent "ScriptFile_and_RolloutContent" == true --return
	),
	
	/** _add rollout to ui
	 */
	function _addRolloutToUi Rollouts ScriptFile_or_RolloutContent =
	(
		if(  _Rollout != undefined ) then
			Rollouts = _Rollout.subrollouts()
		
		ScriptFile_or_RolloutContent.addToUi Rollouts:Rollouts  
	),
	
	/** _add group box to ui
	 */
	function _addGroupBoxToUi ScriptFile =
	(
		print ("Rollout_Content_v._addGroupBoxToUi() ")
		--format "ScriptFile = % \n" ScriptFile
		
		if( _Rollout != undefined ) then
			ScriptFile.addToUi _Rollout 
	),
	
	
	
	/** _get controls and rollouts
	 */
	function _getControlsAndRollouts dir_contents =
	(
		for dir_content in dir_contents do
			if( this._isRollout dir_content == true  ) then
				
				append ScriptFile_and_RolloutContent ( Rollout_Content_v dir:dir_content )
			else
				append ScriptFile_and_RolloutContent ( ScriptFile_Content_v file:dir_content )
		
	),

	/** Is maxscript file
	 */
	function _isRollout file =
	(
		 getFilenameType file == "" --return
	),
	
	--/** Set content controls
	-- */
	--function _loadMacroFiles =
	--(
	--	macro_files = this._getMacroFiles()
	--	format "macro_files = % \n" macro_files
	--	
	--	if( macro_files.count > 0 ) then
	--		for macro_file in macro_files do
	--			append ScriptFiles ( ScriptFile_Content_v file:macro_file )
	--
	--	this --return
	--),
	
	/** Insert rollout
	 */
	function insertRollout Rollouts name =
	(
		print "------------\nRollout.insertRollout()"
		format " name	= % \n" name
		format " Rollouts	= % \n" Rollouts
		_rollout = Rollouts.new name
		format "_rollout = % \n" _rollout
		print ( "rollout.name = " + name as string )
		for f=1 to ScriptFiles.count do
			if( ScriptFiles[f].hasMacroScripts() or ScriptFiles[f].isMaxscriptFile() ) then
				ScriptFiles[f].addControls _rollout
				--format " ScriptFiles[f]	= % \n" ScriptFiles[f]
	),
	
	private
	
	/** Set name "Rollout-1" >> "Rollout 1"
	 */
	function _setName =
	(
		if( name==undefined ) then
			name = filenameFromPath dir

		name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-_]" ).Replace name ""            -- remove unwanted characters but "A-Za-z0-9-_"
		name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_]+"           ).Replace name " " -- replace "_" with whitespace e.g.: "This_is_test" >>> "This is test"
	),

	/** _get dir content
	 */
	function _getDirContent =
	(
		sort ( join (this._getSubDirs()) (this._getMacroFiles()) ) --return
	),
	
	/** _get sub directories
	 */
	function _getSubDirs =
	(
		getDirectories (dir + "/*") --return
	),
	/** _get macro files
	 */
	function _getMacroFiles =
	(
		sort ( join (getFiles (dir + "/*.mcr")) (getFiles (dir + "/*.ms")) ) --return
	),

	on create do
	(
		--print "Rollout_Content_v.onCreate()"
		
		this._setName()

		
		this.load()
		
		--_Rollout = 
		
	)
)







