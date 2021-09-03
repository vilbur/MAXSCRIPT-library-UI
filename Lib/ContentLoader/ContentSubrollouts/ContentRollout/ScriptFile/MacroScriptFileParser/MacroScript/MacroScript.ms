/** MacroScript_Content_v represent single macrosript in ".mcr" file
  *
  * http://docs.autodesk.com/3DSMAX/15/ENU/MAXScript-Help/index.html?url=files/GUID-6E21C768-7256-4500-AB1F-B144F492F055.htm,topicNumber=d30e636049
  *
  *
  * @property	string	icom	can contain params for control E.G.: "type:checkbox|checked:true|border:false"
  *
  */
struct MacroScript_Content_v
(
	macro_name,
	category,
	buttontext,
	tooltip = "",
	icon    = "",
	
	/** Id consist of category and buttontext
	  *
	  * Id is generated from button text because of one control can consist of multiple macroscripts E.G.: Left\Righclick
	  *
	  * @return	string e.g.: "category_buttontext"	
	 */
	function getId =
	(
		category as string + "_"+ (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-_]" ).Replace ( toLower buttontext ) "") --return
	),
	
	/** Get type parse icon string and get "type:(.*)" portion of E.G.: "type:checkbox|checked:true|border:false"
	  *
	  * @return	#type of control e.g.: #checkbox
	 */
	function getType =
	(
		--if( icon = undefined ) then
		format "icon = % \n" icon
		if( matchPattern icon pattern:"type:*" ) then
			((this._getMatches icon "Type:([^\|]+)"))[1][2] as name
		else
			#button
	),
	
	/** _get matches
	 */
	function _getMatches string pattern ignorecase:true =
	(
		rx         = dotNetClass "System.Text.RegularExpressions.RegEx"
		rx_options	= dotNetClass "System.Text.RegularExpressions.RegexOptions"
		
		matches = if (ignorecase) then rx.matches string pattern rx_options.IgnoreCase else rx.matches string pattern 
		
		(for matchIdx = 0 to matches.count-1 collect for groupIdx = 0 to matches.item[matchIdx].groups.count-1 collect ( matches.item[matchIdx].groups.item[groupIdx].value )) --return
	),
	
	/** Parse string of icon property
	  *
	  *
	  * @return	2D matrix of keys and values E.G.: #( #(#border, #tooltip), #(true, "Foo tooltip") )	
	 */
	function getParams =
	(
		keys	= #()
		values	= #()
		
		params_split = (this._getMatches icon "(\w+):([^\|]+)")
		format "params_split = % \n" params_split
		
		
		for param in params_split do
		(
			--format "param = % \n" (param[2]) as name
			--format "param = % \n" param[2]
			append keys   (param[2] as name)
			append values (this._formatDatatypeValue param[3])
		)
		--format "keys = % \nvalues = % \n\n" keys values
		
		
		
		#( keys, values ) --return
	),

	
		/** Format datatype of value
	  * Put quotes around string value
	 */
	function _formatDatatypeValue value =
	(
		--if( classOf value == String and this._isValueBooleanString value == false ) then 
		if( this._isValueBooleanString value ) then
			value	= (( toLower value) == "true")
			 
		value --return 
	),
	
	/** Is value boolean string E.G.: "true" OR "false"
	 */
	function _isValueBooleanString value =
	(
		matchPattern value pattern:"true" or matchPattern value pattern:"false" 
	),

	
	/**  
	 */
	on create do
	(
	)
)