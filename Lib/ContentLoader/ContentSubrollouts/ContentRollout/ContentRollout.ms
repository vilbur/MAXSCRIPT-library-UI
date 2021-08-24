filein( getFilenamePath(getSourceFileName()) + "/../ContentSubrollouts.ms" )
filein( getFilenamePath(getSourceFileName()) + "/ScriptFile/ScriptFile.ms" )

/** Create rollout from dir containing ".ms" & ".mcr" files
 * 
 * @property	string	dir	Path to dir
 * @property	string	name	Name of rollout
 *
 */
struct ContentRollout_v
(
	/* required properties */
	path,
	
	/*  properties */
	name,
	
	Subrollouts_and_Controls = #(), -- store groupboxes and rollouts

	folder_prefix = "rollouts-*",
	
	/** Create and add Rollouts and Controls to UI
	 */
	function addToUi Subrollouts =
	(
		Rollout_new	= Subrollouts.new name -- get new rollout
		
		print ("ContentRollout_v.addToUi ADD " + name +" TO "+ Subrollouts.id )
		--format "Subrollouts_and_Controls = % \n" Subrollouts_and_Controls
		
		for Subrollouts_or_Controls in Subrollouts_and_Controls do
		--format "Subrollouts_or_Controls = % \n" Subrollouts_or_Controls
			Subrollouts_or_Controls.addToUi Rollout_new
		
	),
	
	/** Get new instance of This
	 */
	function new path =
	(
		ContentRollout_v path:path --return
	),
	
	private

	/** _get controls and rollouts
	 */
	function _loadContentFromDir paths =
	(
		--format "\n"
		--print ("ContentRollout_v._loadContentFromDir() " + name)
		
		for path in paths do
			append Subrollouts_and_Controls (this._getGroupboxOrSubrollout path)
	),
	
	/** _get control or rollout
	 */
	function _getGroupboxOrSubrollout path =
	(
		if( this._isSubrolloutsSlot path == true  )
		then
			ContentSubrollouts_v path:path RolloutParrent:this     -- return
		else
			ScriptFile_Content_v path:path	-- return
	),
	
	/** Find out if path is subrollouts slot
	  *
	  * @return	boolean	
	 */
	function _isSubrolloutsSlot path =
	(
		matchPattern ( filenameFromPath path ) pattern:folder_prefix ignoreCase:true --return
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
		getDirectories (path + "/*") --return
	),
	



	/** Get macro files
	 */
	function _getMacroFiles =
	(
		--sort ( join (getFiles (path + "/*.mcr")) (getFiles (path + "/*.ms")) ) --return
		sort ( getFiles (path + "/*.mcr")) --return
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
		name = filenameFromPath path
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
		
		this._loadContentFromDir(this._getPathsInDir())
	)
)