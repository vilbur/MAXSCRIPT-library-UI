filein( getFilenamePath(getSourceFileName()) + "/PathsLoader/PathsLoader.ms" )
filein( getFilenamePath(getSourceFileName()) + "/ScriptFile/ScriptFile.ms" )
filein( getFilenamePath(getSourceFileName()) + "/../ContentSubrollouts.ms" )

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

	PathsLoader,
	
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
	function _loadContentFromDir =
	(
		--print ("ContentRollout_v._loadContentFromDir() " + name)
		
		for path in (PathsLoader.getSubrolloutsAndControlsPaths()) do
			append Subrollouts_and_Controls	(this._addSubrolloutOrControlBox path)
	),
	
	/** _add subrollout or control box
	 */
	function _addSubrolloutOrControlBox path =
	(
		if (this._isDir path) then
			this._ifPathIsDir path
		else
			this._ifPathIsFile path
	),
	
	/** _is dir
	 */
	function _isDir path =
	(
		getFilenameType path == "" --return
	),
	
	/** _if path is dir
	 */
	function _ifPathIsDir path =
	(
		--if( this._isSubrolloutsSlot path == true  ) then
			ContentSubrollouts_v path:path RolloutParrent:this     -- return
	),
	
	/** If path is file
	 */
	function _ifPathIsFile path =
	(
		filein path
		
		ScriptFile_Content_v path:path	-- return
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
		
		print ("ContentRollout_v.onCreate 	" + path)
		
		PathsLoader = PathsLoader_v path:path
		
		PathsLoader.fileInMaxscriptFiles()
		
		this._loadContentFromDir()
		--Subrollouts_and_Controls =
		
	)
)