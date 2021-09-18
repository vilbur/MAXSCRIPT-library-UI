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
		(this._prefixByType()) + "_"+ (( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-_]" ).Replace ( toLower buttontext ) "_") --return
	),
	
	/** Get full id
	 */
	function _prefixByType =
	(
		toUpper ((this.getType()) as string )+ "_"   --return
	),
	
	/** Get type parse icon string and get "type:(.*)" portion of E.G.: "type:checkbox|checked:true|border:false"
	  *
	  * @return	string type of control e.g.: "checkbox"
	 */
	function getType =
	(
		if( matchPattern icon pattern:"type:*" ) then
			((this._getMatches icon "Type:([^\|]+)"))[1][2]
		else
			"button"
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
	  * @return	string passed to methods in ControlBoxControlTypes E.G.: "columns: pos:"
	  --* @return	2D matrix of keys and values E.G.: #( #(#border, #tooltip), #(true, "Foo tooltip") )	
	 */
	function getParams =
	(
		init_params_string = ""
		
		for param in (this.splitParams()) where param[2] != "type" do
			init_params_string += param[2] as string +":"+ param[3]+" "

		init_params_string --return
	),
	
	/** Split params in icon parameter by pipe "|" E.G.: "type:checkbox|checked:true|border:false"
	  *
	  * @return	2D matrix of splitted params	E.G.: #( #("checked:true", "checked", "true"), #("border:false", "border", "false")) 
	 */
	function splitParams =
	(
		this._getMatches icon "(\w+):([^\|]+)"
	),

	
	/**  
	 */
	on create do
	(
	)
)