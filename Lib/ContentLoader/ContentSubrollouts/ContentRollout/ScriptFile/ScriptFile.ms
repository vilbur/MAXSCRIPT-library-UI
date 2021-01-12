/** Process ".ms" & ".mcr" file
  * 1) Get macroscripts from '.mcr' files
  * 2) Filein '.ms' files
  *
  * @property	string	file	Path to file
  *
  *
  *
  */
struct ScriptFile_Content_v
(
	/* public properties */
	path,

	/* private properties */
	name,
	MacroScripts	= #(),
	_MacroScript,	-- store currently parsed Macro file

	/** File
	 */
	function load =
	(
		--print ("------------\nScriptFile.load file="+file)
		if( this.isMacrosriptFile() ) then
		(
			filein path

			this._parseMacrosInFile (this._getFileContent path)
		)
		this --return
	),
	
	--/** Add to ui
	-- */
	--function addToUi _Rollout =
	--(
	--	--print ("ScriptFile_Content_v.addToUi() " + (getFilenameFile file) )
	--),
	
	--/** Insert to ui
	-- */
	--function addToUi _Rollout =
	--(
	--	print ( "ScriptFile_Content.addToUi()" )
	--
	--	--name	= if( name==undefined )then "" else "";
	--	
	--	if( this.isMacrosriptFile() ) then
	--	(
	--		--format " _Rollout	= % \n" _Rollout
	--		--format "this._getGroupboxName() = % \n" (this._getGroupboxName())
	--		--_controls	= _Rollout.Controls.new groupbox:(this._getGroupboxName())
	--	--	--format " _controls = % \n" _controls
	--	--
	--	--	for m = 1 to MacroScripts.count do
	--	--		MacroScripts[m]._addControls _controls
	--	)
	--	--else
	--	--	this._fileIn()
	--),
	
	--/** Add groupbox
	-- */
	--function addGroupbox _Rollout =
	--(
	--	_Rollout.controls groupbox:( this._getGroupboxName() ) -- get new container for controls
	--),

	/** Is maxscript file
	 */
	function isMaxscriptFile =
	(
		 getFilenameType path == ".ms" --return
	),

	/** Is maxscript file
	 */
	function isMacrosriptFile =
	(
		 getFilenameType path == ".mcr" --return
	
	),
	/** Has macro scripts
	 */
	function hasMacroScripts =
	(
		MacroScripts.count > 0 --return
	),


	/** Get name of groupbox by file name
	  * 
	  * @return	string	Name of groupbox, If filename starts with underscore "_", then return undefined and controls are placed to new controls box without groupbox
	 */
	function _getGroupboxName =
	(
		--if ( this.hasGroupbox() ) then
			( dotNetObject "System.Text.RegularExpressions.Regex" @"[_]+" ).Replace ( trimLeft ( trimRight (getFilenameFile path) "_" )  "_" ) " "
		--else
		--	undefined
	),

	--/** If filename starts with underscore "_"
	--  * @return	boolean	
	-- */
	--function hasGroupbox =
	--(
	--	( dotNetClass "System.Text.RegularExpressions.Regex" ).isMatch ( getFilenameFile file ) "^_" == false --return 
	--),

	/** _run script file
	 */
	function _fileIn =
	(
		--print ("FILEIN:\""+file+"\"")
		filein path
	),

	/** Parse MacroScripts in file
	 */
	function _parseMacrosInFile lines =
	(
		--format ( "ScriptFile_Content._parseMacrosInFile()\n" )

		for _line in lines do
		(
			rx_options	= dotNetClass "System.Text.RegularExpressions.RegexOptions"
			rx	= dotNetClass "System.Text.RegularExpressions.Regex"

			if( rx.isMatch _line "(?<!--)macroscript" rx_options.IgnoreCase == true  ) then
			(
				if( _MacroScript!=undefined ) then
					append MacroScripts _MacroScript

				_MacroScript = (MacroScript_Content_v()).setName _line
			)
			--else if( _MacroScript!=undefined and  matchPattern _line pattern:@"*:*" ) then
			else if( _MacroScript!=undefined and rx.isMatch _line "(?<!--)\s*(category|buttonText|toolTip|icon|silentErrors|autoUndoEnabled)\s*:\s*" rx_options.IgnoreCase == true  ) then
				_MacroScript.setProp (filterString _line ":") 
		)

		--format "_MacroScript = %\n" _MacroScript
		if( _MacroScript!=undefined) then
			append MacroScripts _MacroScript
	),

	/** Get file content
	 */
	function _getFileContent _path =
	(
		file_opened	= openFile _path mode:"r+"
		line_cnt	= 0
		lines	= #() --the array that will hold the lines

		while not eof file_opened do 
		(
			append lines ( readLine file_opened ) --append the first line to lines array
			line_cnt += 1 --add 1 to the counter
		)

		seek file_opened 0    -- reset position to beginning

		close file_opened -- closes the file

		lines --return
	),


	/** Set rollout name by folder name E.g.: "Rollout-1" >> "Rollout 1"
	 */
	function _setName =
	(
		name = getFilenameFile path
	),
	
	on create do
	(
		this._setName()
		--format "\n"
		print ("ScriptFile_Content_v.onCreate " + name )

		--this.load()
	)
)
