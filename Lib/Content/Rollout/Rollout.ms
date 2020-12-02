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
	
	ScriptFiles	= #(),
	--_macros	= #(),
	
	/** Load
	 */
	function load dir =
	(
		print ( "Rollout_Content_v.load " + dir as string )
		this.dir	= dir

		this._setName()

		this._loadMacroFiles()
		--format "Rollout_Content_v.name = % \n" this.name
		this --return
	),
	
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

	/** Set content controls
	 */
	function _loadMacroFiles =
	(
		macro_files = sort ( join (getFiles (dir + "/*.mcr")) (getFiles (dir + "/*.ms")) )
		--format "macro_files = % \n" macro_files
		
		if( macro_files.count > 0 ) then
			for macro_file in macro_files do
				append ScriptFiles ( ScriptFile_Content_v file:macro_file )
	
		this --return
	),
	
	on create do
	(
		print "Rollout_Content_v.onCreate()"
	)
)







