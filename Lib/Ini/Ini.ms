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
		_path = this._normalizePath _path
		
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
		--print "------------\nIni.path()"
		if( _path == #get ) then
			this._combinePath()

		_path = this._normalizePath _path
		
		this._getSetProp #_path _path --return
	),

	/** Ini save control state
	  * @property	string|name	section
	  * @property	string|name	key
	  * @property	mixed	value
	 */
	function save section key value =
	(
		--setINISetting _path ( section as string ) ( key as string ) ( value as string )
	),
	
	/** Ini save control state
	 */
	function load section key default:undefined =
	(
		format "------------\nIni.load()"
		section	= section	as string
		key	= key	as string
		value	= default
		--ini	= ( dotnetObject "System.Text.RegularExpressions.Regex" @"\\/+" ).Replace ini "\\\\"
		
		--format " _path	= % \n" _path
		--format " section	= % \n key	= % \n value	= % \n\n" section key value
		--format " hasINISetting _path section key	= % \n" (hasINISetting _path section key)
		--format " _path != undefined and hasINISetting _path section key == true	= % \n" (_path != undefined and hasINISetting _path section key == true)
		if( _path != undefined and hasINISetting _path section key == true ) then
			value = getINISetting _path section key -- return
		
		--format " value	= % \n" value
		value --return
	),

	private
	
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

	/** Combine path
	 */
	function _combinePath =
	(
		if( _path == undefined and _dir != undefined and _file != undefined ) then
			_path = _dir +"\\" + _file
			
		--print ( "Ini._combinePath = " + _path as string )
	),

	/** Escape path
	 */
	function _normalizePath __path =
	(
		--if( __path != #get ) then ( substituteString ( __path as string ) "\\" "\\\\" ) else __path  --return
		if( __path != #get ) then ( pathConfig.normalizePath __path ) else __path  --return
	),
	
	function test =
	(
		messagebox "Ini.test()"
	)
)
