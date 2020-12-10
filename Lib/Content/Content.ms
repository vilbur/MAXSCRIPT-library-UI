filein( getFilenamePath(getSourceFileName()) + "/Rollout/ScriptFile/MacroScript/MacroScript.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Rollout/ScriptFile/ScriptFile.ms" )
filein( getFilenamePath(getSourceFileName()) + "/Rollout/RolloutContent.ms" )


/** Load content to UI by file tree
  *
  * @property	string	dir	Directory where rollout directories are placed, rollouts are used if ends with "*"
  * @property	regEx	match	Only directories matching this regex are threaded as rollouts, rollout name is matching group if defined
  *
  * --------------------------------------------------------------------------------------------------------------------
  *
  * @example 1) Content_v dir:("C:/ContentDir") -- load all dirs in directory as rollouts
  *		ContentDir\  
  *			rollout-A\
  *				groupbox.mcr	-- Hole file is Gorupbox & every macro in *.mcr file is button
  *				_no_groupbox.mcr	-- File which starts with underscopre "_" will not be placed to groupbox
  *			rollout-B\
  *				custom-ui.ms	-- Each script will be executed on dialog creation
  *	 
  * --------------------------------------------------------------------------------------------------------------------
  *
  * @example 2) Content_v dir:("C:/ContentDir/*") match:"rollout-(.*)" -- load directories in subdirs, only dirs matching regex are used as rollouts, rollout name is match group
  *		ContentDir\
  *			Subdir-1\
  *				rollout-A\
  *				this-is-not-matching\
  *			Subdir-2\
  *				rollout-C\
  *
  */
struct Content_v
(
	dir	= getFilenamePath(getSourceFileName()) + "/../../../Content",
	match	= ".*",
	
	--Rollouts	= #(),
	RolloutContent	= #(),
	
	rx_options	= dotNetClass "System.Text.RegularExpressions.RegexOptions",
	rx	= dotNetClass "System.Text.RegularExpressions.Regex",
	
	/** Load UI structure from dir
	 */
	function load =
	(
		--print "Content.load()"

		RolloutContent =  Rollout_Content_v dir:dir
		--format "RolloutContent = % \n" RolloutContent
		
		this --return
	),
	
	/** Set controls to
	  * @param	__[Dialog](../Dialog)__
	 */
	function setControlsToUI =
	(
		--print "Content.setControlsToUI()"
		Dialog	= Dialog_v title:RolloutContent.name

		--Rollouts = Dialog.rollouts()

		RolloutContent.addToUi Rollouts:Rollouts Dialog:Dialog
		
		Dialog.create()
	),

--	/** Get rollout directories
--	 */
--	function _getRolloutDirectories _dir =
--	(
--		match_dirs	= #()
--		dirs	= getDirectories (_dir + "/*")
--		
--		for dir in dirs where this._isDirNameMatch dir == true do
--			append match_dirs dir
--		
--		match_dirs --return
--	),
--
--	/** If directory name match to regext
--	 */
--	function _isDirNameMatch _dir =
--	(		
--		rx.isMatch (this._dirName _dir) match rx_options.IgnoreCase --return
--	),
--	
--	/** _dir name
--	 */
--	function _dirName _dir =
--	(
--		filenameFromPath (trimRight _dir "\\") --return
--	),
--			
--	/** _load directories as rollouts
--	 */
--	function _loadDirectoriesAsRollouts main_dir =
--	(
--		for dir_as_rollout in main_dir do
--			format "dir_as_rollout = % \n" dir_as_rollout
--			--this._loadDirectoryAsRollout dir_as_rollout
--	),
--	
--	/** _load directories as rollouts
--t "Rollout_Content = % \n" Rollout_Content
--		appen	 */
--	function _loadDirectoryAsRollout dir_as_rollout =
--	(
--		format "dir_as_rollout = %\n" dir_as_rollout as string
--		Rollout_Content = Rollout_Content_v()
--		--formad Rollouts ( Rollout_Content.load dir_as_rollout )
--	),
	
	on create do
	(

	)
)



