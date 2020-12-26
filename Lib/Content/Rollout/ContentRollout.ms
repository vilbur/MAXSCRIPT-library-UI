/** Create rollout from dir containing ".ms" & ".mcr" files
 * 
 * @property	string	dir	Path to dir
 * @property	string	name	Name of rollout
 *
 */
struct ContentRollout_v
(
	dir,
	name,
	
	_Rollout,
	
	Controls_and_Rollouts = #(),
	
	
	/** Load
	 */
	function load =
	(
		--print ( "ContentRollout_v.load " + dir as string )
		this._getControlsAndRollouts (this._getPathsInDir())
	
		this --return
	),


	/** _get controls and rollouts
	 */
	function _getControlsAndRollouts paths =
	(
		format "paths = % \n" paths
		for path in paths do
		(
			
			Controls_or_Rollout = if( this._isDir path == true  ) then
				
				ContentRollout_v dir:path
			else
				ScriptFile_Content_v file:path
			

			append Controls_and_Rollouts Controls_or_Rollout
		)
		
	),

	/** Find out if path is direcotry
	  *
	  * @return	boolean	
	 */
	function _isDir path =
	(
		 getFilenameType path == "" --return
	),
	
	
	
	/** Add to ui
	 */
	function addToUi Dialog: Rollouts: =
	(
		--print ("ContentRollout_v.addToUi() " + name)
		this._setRollout Dialog Rollouts
		
		for Control_or_Rollout in Controls_and_Rollouts do
		(
			if( (this._isContentRollout Control_or_Rollout ) == true ) then
			
				this._addRolloutToUi  Control_or_Rollout Rollouts
			else
				this._addGroupBoxToUi Control_or_Rollout
		)
	),
	
	/** If rollout
	 */
	function _setRollout Dialog Rollouts =
	(
		if( Dialog == unsupplied ) then
			
			_Rollout	= Rollouts.new name
		
		else
			_Rollout = Dialog._RolloutMain
	),
		
	/** _is rollout content
	 */
	function _isContentRollout ScriptFile_or_RolloutContent =
	(
		hasProperty ScriptFile_or_RolloutContent "Controls_and_Rollouts" == true --return
	),
	
	/** _add rollout to ui
	 */
	function _addRolloutToUi ScriptFile_or_RolloutContent Rollouts =
	(
		if(  _Rollout != undefined ) then
			Rollouts = _Rollout.subrollouts()
		
		ScriptFile_or_RolloutContent.addToUi Rollouts:Rollouts  
	),
	
	/** _add group box to ui
	 */
	function _addGroupBoxToUi ScriptFile =
	(
		--print ("ContentRollout_v._addGroupBoxToUi() ")
		--format "ScriptFile = % \n" ScriptFile
		
		if( _Rollout != undefined ) then
			ScriptFile.addToUi _Rollout 
	),
	
	
	private
	
	/** Set name "Rollout-1" >> "Rollout 1"
	 */
	function _setName =
	(
		if( name==undefined ) then
			name = filenameFromPath dir

		name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-_]" ).Replace name ""  -- remove unwanted characters, valid characters: "A-Za-z0-9-_"
		name	= ( dotNetObject "System.Text.RegularExpressions.Regex" @"[_]+"           ).Replace name " " -- replace "_" with whitespace e.g.: "This_is_test" >>> "This is test"
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

	on create do
	(
		--print "ContentRollout_v.onCreate()"
		
		this._setName()

		
		this.load()
		
	)
)