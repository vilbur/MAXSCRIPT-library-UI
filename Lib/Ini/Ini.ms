/** Save Load ini settings
  *
  *
  */
struct Ini_v
(
	_dir,	-- dir of *.ini file
	_file,	-- *.ini filename
	_path,	-- full pah to *.ini file
	
	--/** Get _value from ini
	-- */
	--function getValueFromIni _section key =
	--(
	--	print "------------\nIni_v._getValueFromIni()"
	--	--print "HOTFIX"
	--	format "selection = % \nkey = % \n\n" _section key
	--	--format "ini = % \n" ( Parent_Control.ControlBox.Parent_roll.ini )
	--	
	--	--if( (ini = Parent_Control.ControlBox.Parent_roll.ini ) != undefined ) then
	--	--	_value = getINISetting ini rollout_id control_id --return
	--	--format "_value = % \n" _value
	--	--( this._formatDatatypeValue _value ) --return
	--),	
	
		
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
		_value	= default

		_value_ini = getINISetting _path _section _key -- return

		if( _value_ini != undefined ) then _value_ini else _value --return
	),

	private
	


	/** Combine path
	 */
	function _combinePath =
	(
		if( _path == undefined and _dir != undefined and _file != undefined ) then
			_path = _dir +"\\" + _file
			
		--print ( "Ini._combinePath = " + _path as string )
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