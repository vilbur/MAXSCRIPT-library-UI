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
		format "\n"
		print ("ContentRollout_v._setControlsAndRollouts() " + name)
		--format "paths = % \n" paths
		for path in paths do  --DEBUG
			format "path = % \n" (filenameFromPath path)
		
		for path in paths do
			append UI_elements (this._getGroupboxOrSubrollout path)
	),
	
	/** _get control or rollout
	 */
	function _getGroupboxOrSubrollout path =
	(
		--print ("ContentRollout_v._getGroupboxOrSubrollout " + (filenameFromPath path))

		if( this._isSubrolloutsSlot path == true  ) then
			--format "Subrollouts = % \n" (filenameFromPath path)
			ContentSubrollouts_v path:path      -- return
		else
			ScriptFile_Content_v path:path	-- return
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
	
	/** Get macro files
	 */
	function _getMacroFiles =
	(
		--sort ( join (getFiles (dir + "/*.mcr")) (getFiles (dir + "/*.ms")) ) --return
		sort ( getFiles (dir + "/*.mcr")) --return
	),

	/** Find out if path is direcotry
	  *
	  * @return	boolean	
	 */
	function _isDir path =
	(
		getFilenameType path == "" --return
	),
	
	/** Find out if path is subrollouts slot
	  *
	  * @return	boolean	
	 */
	function _isSubrolloutsSlot path =
	(
		matchPattern ( filenameFromPath path ) pattern:"rollouts-*" ignoreCase:true --return
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
		--print ("ContentRollout_v.onCreate " + name)
		
		this._setControlsAndRollouts(this._getPathsInDir())
		
		--format "UI_elements.count = % \n" UI_elements.count
	)
)