filein( getFilenamePath(getSourceFileName()) + "/MacroScript/MacroScript.ms" )

/** Parese macroscripts in "*.mcr file"
  *
  * https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_6E21C768_7256_4500_AB1F_B144F492F055_htm
  * 
  */
struct MacroScriptParser_v
(
	__construct = #( #path ),
	/* required */
	path,
	
	file_content = #(),
	
	MacroScripts	= #(),
	MacroScript_last,	-- store currently parsed Macro file

	RegEx	= dotNetClass "System.Text.RegularExpressions.Regex",
	RegEx_options	= dotNetClass "System.Text.RegularExpressions.RegexOptions",
			
	/** Parse MacroScripts
	  *
	  * IMPORTANT: Keep EACH PROPERTY on SEPARATE LINE
	  *
	  *	MacroScript <macro_name>
	  *		category:	  ""
	  *		buttontext: ""
	  *		toolTip:	   ""
	  *		icon:	   "#(path, index)"
	  *	(
	  *		messagebox "MacroScript";
	  *	)
	  *
	  */
	function _parseMacros =
	(
		--format ( "MacroScriptParser._parseMacros()\n" )
		for line in file_content do
		(
			if( this._lineIsMacroName line ) then
				--format "line = % \n" line
				this._setNewMacroSript (this._getMacroName line)
			else
				this._parseProperties line
		)
		
		this._addLastMacroscript()
	),

	/** _get new macro sript
	 */
	function _setNewMacroSript name =
	(
		--format "MacroScriptParser._setNewMacroSript() %\n" name 
		this._addLastMacroscript()

		MacroScript_last = MacroScript_Content_v name

		MacroScript_last --return
	),
	
	/** _parse macro props
	 */
	function _parseProperties line =
	(
		if( this._lineIsProperty line ) then
			MacroScript_last.setProp (this._getKeyValuePair line)
	),
	
	/** Find if line start with "MacroScript <macro_name>"
	 */
	function _lineIsMacroName line =
	(
		RegEx.isMatch line "^\s*MacroScript\s+.+" RegEx_options.IgnoreCase == true --return
	),
	
	/** _line is property
	 */
	function _lineIsProperty line =
	(
		RegEx.isMatch line "^\s*(category|buttonText|toolTip|icon|silentErrors|autoUndoEnabled)\s*:\s*" RegEx_options.IgnoreCase == true --return
	),
	/** Get name of macro from line
	  * remove whitespace and tab
	  *
	  * @property	string	line	"MacroScript macro_name"
	  *
	  * @return	string	macro_name
	 */
	function _getMacroName line =
	(
		(filterString line " 	")[2] --return
	),

	/** _get key value pair
	 */
	function _getKeyValuePair line =
	(
		
		delimeter = ":"
		key_value = (filterString line delimeter)

		key   = toLower key_value[1]
		value = key_value[2]
		format "key = % \n" key
		
		value = case key of
		(
			"icon":       this._getIcon value  			
			"tooltip":    this._joinValues (deleteItem key_value 1) delimeter	
			--"category":	
			--"buttontext":	
			default: value	
		)
		
		--format "value = % \n" value
		--format "classof value = % \n" (classof value)
		value = this._stripQuotes ( this._trimWhiteSpace value )
		#(key, value) --return
	),
	
	/** Join values
	 */
	function _joinValues values delimeter =
	(
		val_join = ""
		
		for val in values do
			val_join += ( val + delimeter)
	
		trimRight val_join delimeter	
	),
	
	
	/** _get icon
	 */
	function _getIcon value =
	(
		format ( "MacroScriptParser_v._getIcon " + value as string )
		value --return

	),
	
	
	/** Remove leading and trailing white space
	 */
	function _trimWhiteSpace _string =
	(
		trimLeft ( trimRight _string ) --return
	),
	
	/** Strip leading and trailing quotes
	  *
	  * @property	string	_string	quoted string
	  * @return	string	
	 */
	function _stripQuotes _string =
	(
		trimLeft ( trimRight _string "\"" ) "\"" --return
	),
	
	
	/** _add latest parsed macroscript
	 */
	function _addLastMacroscript =
	(
		if( MacroScript_last != undefined ) then
			append MacroScripts MacroScript_last
	),


	/** Get file content
	 */
	function _setFileContent =
	(
		file_opened	= openFile path mode:"r+"
		counter	= 0
		--lines	= #()

		while not eof file_opened do 
		(
			line =  readLine file_opened
			if( line.count > 1 ) then 
				append file_content ( this._trimWhiteSpace(line))
				
			counter += 1
		)

		seek file_opened 0    -- reset position to beginning

		close file_opened -- closes the file

		file_content --return
	),
	
	/*------------------------------------------------------------------------------
		CONSTRUCT
	--------------------------------------------------------------------------------*/
	
	/** Check if properties in __construct are defined when an instance of the struct is created.
	  * @example __construct = #( #property_name ) 
	 */
	function _checkConstctructProperties =
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),
	
	on create do
	(
		--format "\n"
		--print ("MacroScriptParser_v.onCreate ")
		this._checkConstctructProperties()
		
		this._setFileContent()
		--format "file_content = % \n" file_content
		this._parseMacros()
	)
)