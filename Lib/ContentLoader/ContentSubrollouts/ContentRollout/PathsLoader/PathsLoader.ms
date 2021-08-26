/**  
 *	
 *	
 */
struct PathsLoader_v
(
	path,
	
	folder_prefix = "rollouts-*",
	
	--Subrollouts_and_Controls = #(), -- store groupboxes and rollouts
	
	dirs	= #(),
	
	rollout_dirs = #(),

	macro_files	= #(),
	
	maxscript_files	= #(),
	

	/** _get controls and rollouts
	  *
	  * @return	array	
	 */
	function _isSubrolloutsSlot path =
	(
		matchPattern ( filenameFromPath path ) pattern:folder_prefix ignoreCase:true --return
	),
		
	/** Get full paths of directories and files in this.dir
	  *
	  * @return	array of paths	sorted alphabetically
	 */
	function _getSubrolloutsAndControlsPaths =
	(
		sort ( join rollout_dirs macro_files ) --return
	),
	

	/** 
	 */
	function _getRolloutDirs =
	(
		for dir in (getDirectories (path + "/*")) where ( this._isSubrolloutsSlot dir ) collect dir --return
	),
	
	/** 
	 */
	function _getDirs =
	(
		for dir in (getDirectories (path + "/*")) where not ( this._isSubrolloutsSlot dir ) collect dir --return
	),
	
	
	
	/** Get *.mcr files
	 */
	function _getMacroFiles =
	(
		sort ( getFiles (path + "/*.mcr")) --return
	),
	
	/** Get *.ms files
	 */
	function _getMaxscriptFiles =
	(
		sort ( getFiles (path + "/*.ms")) --return
	),	
	
	
	on create do
	(
		dirs            = this._getDirs()
		
		rollout_dirs    = this._getRolloutDirs()

		macro_files     = this._getMacroFiles()

		maxscript_files = this._getMaxscriptFiles()
		
		format "macro_files = % \nmaxscript_files = % \nrollout_dirs = % \ndirs = % \n\n" macro_files maxscript_files rollout_dirs dirs
	)
	
	
)



