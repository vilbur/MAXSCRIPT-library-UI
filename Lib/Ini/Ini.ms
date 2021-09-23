/** Save Load ini settings
  *
  *
  */
struct Ini_v
(
	_dir,	-- dir of *.ini file
	_file,	-- *.ini filename
	_path,	-- full pah to *.ini file
	
	/** Set path to dir which contains *.ini fie
	  * @property	string	_path	path to dir
	 */
	function dir _path =
	(
		--print ( "Ini_v.dir() = " + _path as string )
		_path = this._escapePath _path
		
		this._getSetProp #_dir _path --return
	),

	/** Set filename of *.ini file
	  * @property	string	filename	of *.ini file E.G.: "foo.ini" 
	 */
	function file filename =
	(
		--print ( "Ini_v.file() = " + filename as string )
		this._getSetProp #_file filename --return
	),

	/** Get\set ini file path
	  * @param	string|#get _path	Path to ini file, or #get
	  *
	  * @return	string|self path to ini file if _path=#get	
	  */
	function path _path =
	(
		--print ("------------\nIni.path() " + _path as string) 
		if( _path != #get ) then
			_path = this._escapePath _path

		this._getSetProp #_path _path --return
	),

	/** Ini save control state
	  * @property	string|name	_section
	  * @property	string|name	key
	  * @property	mixed	value
	 */
	function save _section key value =
	(
		setINISetting _path ( _section as string ) ( key as string ) ( value as string )
	),
	
	/** Ini load control state
	 */
	function load _section _key default:undefined =
	(
		--format "------------\nIni.load()"
		_section	= _section	as string
		_key	= _key	as string
		val	= default
		
		val_from_ini = getINISetting _path _section _key -- return

		if( val_from_ini != undefined ) then this._formatDatatypeValue(val_from_ini) else val --return
	),

	
	private


	/** Combine path
	 */
	function _combinePath =
	(
		if( _path == undefined and _dir != undefined and _file != undefined ) then
			_path = _dir +"\\" + _file
	),

	/** Format string value to valid datatype
	  *
	  * Put quotes around string value
	  *
	  *
	 */
	function _formatDatatypeValue val =
	(		
		data_type	= this._getDataType val
		
		case data_type of
		(
			(#boolean):	this._formatBoolean val
			(#number):	this._formatNumber  val
			(#color):	this._formatColor   val
			default:	val
		)
		
	),

	/** _get data type
	 */
	function _getDataType val =
	(
		if( this._isValueBooleanString val ) then
			#boolean --return
		
		else if( val as number != undefined ) then 
			#number --return
		
		else if( matchPattern val pattern:"color*" ) then
			#color --return
		
		else
			#string
	),
	
	/** Find out if value boolean string ? E.G.: "true" OR "false"
	 */
	function _isValueBooleanString val =
	(
		matchPattern val pattern:"true" or matchPattern val pattern:"false" 
	),
	
	/** Format boolean
	  *
	  * @return	Boolean
	 */
	function _formatBoolean val =
	(
		( toLower val ) == "true" --return 
	),
	
	/** _format color
	  *
	  * @return	Color
	 */
	function _formatColor val =
	(
		pattern = "color\s+(\d+)\s+(\d+)\s+(\d+)"
		rx         = dotNetClass "System.Text.RegularExpressions.RegEx"
		rx_options	= dotNetClass "System.Text.RegularExpressions.RegexOptions"
		
		matches = rx.matches val pattern rx_options.IgnoreCase
		
		_rgb = (for matchIdx = 0 to matches.count-1 collect for groupIdx = 0 to matches.item[matchIdx].groups.count-1 collect ( matches.item[matchIdx].groups.item[groupIdx].val )) --return

		color (_rgb[1][2] as number) (_rgb[1][3] as number) (_rgb[1][4] as number)
	),
	
	/** _format number
	 */
	function _formatNumber =
	(
		val as number --return
	),
	
	/** Get\set value of property 
	  * @param	string|name key	Name  of property E.G.: "foo_key" OR #foo_key 
	  * @param	string|#get value	Value of property
	  *
	  * @return	string|self Value or self
	  *
	  * @example this._getSetProp "foo" "bar" -- SET "bar" to property "foo"
	  * @example this._getSetProp #foo  #get  -- GET value of property "foo"
	  *
	  */
	function _getSetProp key value =
	(
		if( value != #get ) then
		(
			setProperty  this ( key as string ) value
			this --return
		) else
			getProperty this ( key as string ) --return
	),
	
	/** Escape path
	 */
	function _escapePath path_for_escape =
	(
		--if( path_for_escape != #get ) then ( substituteString ( path_for_escape as string ) "\\" "\\\\" ) else path_for_escape  --return
		if( path_for_escape != #get ) then ( pathConfig.normalizePath path_for_escape ) else path_for_escape  --return
	),
	
	/**  
	 */
	on create do
	(
		print("Ini_v.onCreate()")
	)
)