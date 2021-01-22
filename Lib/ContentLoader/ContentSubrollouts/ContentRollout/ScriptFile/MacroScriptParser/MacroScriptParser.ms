/** Parese macroscripts in "*.mcr file"
  *
  *
  */
struct MacroScriptParser_v
(
	file_content,
	
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
		format ( "ScriptFile_Content._parseMacros()\n" )

		for line in file_content do
		(
			if( this._lineIsMacroName line )
			then
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
	  *
	  * @property	string	line	"MacroScript macro_name"
	  *
	  * @return	string	macro_name
	 */
	function _getMacroName line =
	(
		(filterString line " ")[2] --return
	),

	/** _get key value pair
	 */
	function _getKeyValuePair line =
	(
		key_value = (filterString line ":")

		key   = this._removeWhiteSpace key_value[1]
		value = this._stripQuotes ( this._removeWhiteSpace key_value[2] )
		
		format "key   = % \n" key
		format "value = % \n" value
		
		#(key, value) --return
	),
	
	/** Remove leading and trailing white space
	 */
	function _removeWhiteSpace _string =
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
	
	on create do
	(
		--format "\n"
		print ("MacroScriptParser_v.onCreate()" )

		this._parseMacros()
	)
)