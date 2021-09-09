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
	
	/** Get id of control
	  *
	  * Id is generated from button text because of one control can consist of multiple macroscripts E.G.: Left\Righclick
	  *
	  * @return	string e.g.: "category_buttontext"	
	 */
	function getControlId =
	(
		--id =
		--(this._prefixByType()) +	category as string + "_"+ (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-_]" ).Replace ( toLower buttontext ) "_") --return
		(this._prefixByType()) + "_"+ (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-_]" ).Replace ( toLower buttontext ) "_") --return
	
		--( dotNetObject "System.Text.RegularExpressions.Regex" @"[_]+"           ).Replace ( id ) "_"  --return
		--id
	),
	
	/** Get full id
	 */
	function _prefixByType =
	(
		toUpper ((this.getType()) as string )+ "_"   --return
	),
	
	/** Get type parse icon string and get "type:(.*)" portion of E.G.: "type:checkbox|checked:true|border:false"
	  *
	  * @return	#type of control e.g.: #checkbox
	 */
	function getType =
	(
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
		
		for param in (this.splitParams()) do
		(
			append keys   (param[2] as name)
			append values (this._formatDatatypeValue param[3])
		)
		
		this.removeParam #( keys, values ) #type --return
	),
	
	/** Split params in icon parameter by pipe "|" E.G.: "type:checkbox|checked:true|border:false"
	  *
	  * @return	2D matrix of splitted params	E.G.: #( #("checked:true", "checked", "true"), #("border:false", "border", "false")) 
	 */
	function splitParams =
	(
		this._getMatches icon "(\w+):([^\|]+)"
	),
	
	/** Remove param
	 */
	function removeParam matrix key =
	(
		if( (i = findItem matrix[1] key) > 0 ) then 
		(
			deleteItem matrix[1] i
			deleteItem matrix[2] i
		)
		matrix --return
	),
	
		/** Format datatype of value
	  * Put quotes around string value
	 */
	function _formatDatatypeValue value =
	(
		--if( classOf value == String and this._isValueBooleanString value == false ) then
		
		if( this._isValueBooleanString value ) then
			value	= (( toLower value) == "true")
		
		else if( value as number != undefined ) then 
			value = value as number
			
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