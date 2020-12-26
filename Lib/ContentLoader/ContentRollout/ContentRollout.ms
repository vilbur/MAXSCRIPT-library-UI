/** Create rollout from dir containing ".ms" & ".mcr" files
 * 
 * @property	string	dir	Path to dir
 * @property	string	name	Name of rollout
 *
 */
struct ContentRollout_v
(
	/* required properties */
	dir,
	
	/*  properties */
	name,
	
	UI_elements = #(), -- store groupboxes and rollouts

	private
	
	/** _get controls and rollouts
	 */
	function _setControlsAndRollouts paths =
	(
		--format "paths = % \n" paths
		for path in paths do
			append UI_elements (this._getGroupboxOrRollout path)
	),
	
	/** _get control or rollout
	 */
	function _getGroupboxOrRollout path =
	(
		if( this._isDir path == true  ) then
			
			ContentRollout_v dir:path      -- return
		else
			ScriptFile_Content_v file:path	-- return
	),
	
	/** Get full paths of directories and files in this.dir
	  *
	  * @return	array of paths	sorted alphabetically
	 */
	function _getPathsInDir =
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

	/** Find out if path is direcotry
	  *
	  * @return	boolean	
	 */
	function _isDir path =
	(
		getFilenameType path == "" --return
	),
	
	/** Set rollout name by folder name E.g.: "Rollout-1" >> "Rollout 1"
	 */
	function _setName =
	(
		name = filenameFromPath dir
	),

	/** 1) Remove invalid characters, valid characters: "A-Za-z0-9-_"
	  * 2) Replace underscore "_" with whitespace " " E.G.: This_is_test" >>> "This is test"
	 */
	function _sanitizeName =
	(
		name = ( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-_]" ).Replace name ""
		name = ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_]+"           ).Replace name " "
	),
	
	on create do
	(
		
		this._setName()
		this._sanitizeName()
		print ("ContentRollout_v.onCreate " + name)
		
		this._setControlsAndRollouts(this._getPathsInDir())
		
		format "UI_elements.count = % \n" UI_elements.count
	)
)