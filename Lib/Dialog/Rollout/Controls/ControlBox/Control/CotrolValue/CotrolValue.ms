/** Control value
 */
struct CotrolValue_v
(
	/* required */
	Parent_Control,
	
	/* dependency */
	/* reference */
	
	/* properties */
	_value,
	--name_of_value_param,
	
	/** Set value
	 */
	function setValue _value =
	(
		print "CotrolValue_v.setValue()"
		this._value = _value
	),
	
	/** Get _value from ini
	 */
	function getValueFromIni =
	(
		print "------------\nCotrolValue_v._getValueFromIni()"
		print "HOTFIX"
		--format "ini = % \n" ( Parent_Control.ControlBox.Parent_roll.ini )
		
		--if( (ini = Parent_Control.ControlBox.Parent_roll.ini ) != undefined ) then
		--	_value = getINISetting ini rollout_id control_id --return
		--format "_value = % \n" _value
		--( this._formatDatatypeValue _value ) --return
	),	
	
	/** Format datatype of value
	  * Put quotes around string value
	 */
	function _formatDatatypeValue value =
	(
		--if( classOf value == String and this._isValueBooleanString value == false ) then
	
		if( this._isValueBooleanString value ) then
			value	= (( toLower value) == "true")
		
		else if( matchPattern value pattern:"color*") then 
		(
			/** Color datatype https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_D8DBE1AA_F3D7_4708_93FA_7C28845A1C03_htm
			  
			  Litle dirty code
			  
			 */
			pattern    = "color\s+(\d+)\s+(\d+)\s+(\d+)"
			rx         = dotNetClass "System.Text.RegularExpressions.RegEx"
			rx_options	= dotNetClass "System.Text.RegularExpressions.RegexOptions"
			
			matches = rx.matches value pattern rx_options.IgnoreCase
			
			_rgb = (for matchIdx = 0 to matches.count-1 collect for groupIdx = 0 to matches.item[matchIdx].groups.count-1 collect ( matches.item[matchIdx].groups.item[groupIdx].value )) --return
	
			value = color (_rgb[1][2] as number) (_rgb[1][3] as number) (_rgb[1][4] as number)
			
		)
		else if( value as number != undefined ) then 
			value = value as number
			
		value --return 
	),
	
	/** Format datatype of _value
	  * Put quotes around string _value
	 */
	function _formatDatatypeValue _value =
	(
		if( classOf _value == String and this._isValueBooleanString _value == false ) then 
			"\""+_value+"\"" --return
		else
			_value --return 
	),

	/** Is _value boolean string E.G.: "true" OR "false"
	 */
	function _isValueBooleanString _value =
	(
		matchPattern _value pattern:"true" or matchPattern _value pattern:"false" 
	),
	
	/** _set _value
	 */
	function _setValue =
	(
		--if( _value==undefined ) then
			this._getValueFromIni()
		--
		--if( _value!=undefined and _value!=""  ) then
		--	this._setValueParameter _value
		----else
			----this._getValueFromIni()
	),
	
	--/** Add quotes to parameter if _value is string
	--  * Add _value to params
	-- */
	--function _setValueParameter _value =
	--(
	--	--print "------------\nCotrolValue_v._setValueParameter()"
	--	_Parameters.getOrSet name_of_value_param _value
	--),
	

	private
	

	/**  
	 */
	on create do
	(
		--print("CotrolValue_v.onCreate()")
	)
	
)
