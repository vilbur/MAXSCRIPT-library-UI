/** Control value
 */
struct CotrolValue_v
(
	/* dependency */
	Parent_Control,
	
	/* properties */
	_value,

	/** _get value from ini
	 */
	function _getValueFromIni =
	(
		--print "CotrolValue_v._getValueFromIni()"
		
		if( this.loadIniValuesOnInit() and Parent_Control.name_of_value_param != undefined ) then 
			if( (val = this._loadValueFromFile()) != undefined ) then
				Parent_Control._Parameters.setVal Parent_Control.name_of_value_param (this._convertValueForControlType val)
	),
	
	/** _if ini is defined
	 */
	function loadIniValuesOnInit =
	(
		Parent_Control.ControlBox.Parent_roll._Ini.loadValuesOnInit() --return
	),

	/** _load value from file
	 */
	function _loadValueFromFile =
	(
		Parent_Control.ControlBox.Parent_roll._Ini.load (Parent_Control.ControlBox.Parent_roll.id) (Parent_Control.id.get()) -- return
	),
	
	/** _convert value for control type
	 */
	function _convertValueForControlType val =
	(
		if( Parent_Control.type == #spinner ) then
			val   = this._convertDatatype val
	
		val --return
	),
	/** Format string value to valid datatype
	 */
	function _convertDatatype val =
	(		
		if( (for pattern in #( "true", "false", "color*", "[*,*]" ) where matchPattern val pattern:pattern collect pattern).count > 0 ) then 
			execute val

		else if( ( val_as_number = val as number) != undefined ) then 
			val_as_number --return
			
		else
			val --return
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
	
	/**  
	 */
	on create do
	(
		--print("CotrolValue_v.onCreate()")
	)
	
)
