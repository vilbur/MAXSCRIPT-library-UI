/** Create rollout from dir containing ".ms" & ".mcr"
 * 
 * @property	string	dir	Path to rollout dir
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
		--print ( "Rollout_Content_v.load dir=" + dir as string )
		this.dir	= dir

		this._setName()

		this._loadMacroFiles()

		this --return
	),
	
	/** Insert rollout
	 */
	function insertRollout Dialog name =
	(
		print "------------\nRollout.insertRollout()"
		format " name	= % \n" name
		format " Dialog	= % \n" Dialog
		_rollout = Dialog.roll name unsupplied
		
		--print ( "rollout.name = " + name as string )
		for f=1 to ScriptFiles.count do
			if( ScriptFiles[f].hasMacroScripts() or ScriptFiles[f].isMaxscriptFile() ) then
				ScriptFiles[f].addControls _rollout
				--format " ScriptFiles[f]	= % \n" ScriptFiles[f]
	),
 
	/** Set name "Rollout-1" >> "Rollout 1"
	 */
	function _setName =
	(
		if( name==undefined ) then
			name = filenameFromPath dir
		
		name_Sanitized	= ( dotnetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-_]" ).Replace name ""
		name_whitespace	= ( dotnetObject "System.Text.RegularExpressions.Regex" @"[_]+" ).Replace name_Sanitized " "

		name = name_whitespace
	),
	
	/** Set content controls
	 */
	function _loadMacroFiles =
	(
		macro_files = sort ( join (getFiles (dir + "/*.mcr")) (getFiles (dir + "/*.ms")) )
		--print ( "macro_files=" + macro_files as string )

		if( macro_files.count > 0 ) then
			for macro_file in macro_files do
				append ScriptFiles ( (ScriptFile_Content_v()).load macro_file )
	
		this --return
	),
	
	on create do
	(
		print "Rollout_Content_v.onCreate()"
	)
)







