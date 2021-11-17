

	/** Add Edit text field http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_FC73C160_735C_4F65_A71D_722D63BBB591_htm
	 */
	function _addTextField =
	(
		--print("BrowsePath._addTextField() " + id.id)
		--print ("ControlBox.EditText " + (this._getEditTextParameters()))

		global ControlBoxEditText = ControlBox
			
		this._EditText = execute ("ControlBoxEditText.EditText \"\" " + (this._getEditTextParameters()))
		--_EditText = ControlBox.Parent_roll.RolloutCreator.addControl #EditText id.id "" (this._getEditTextParameters())

		ControlBoxEditText = undefined
		
		--format "EditText	= % \n" EditText
	),
	
	/** _get edit text parameters
	 */
	function _getEditTextParameters =
	(
		--print("BrowsePath.EditText._getEditTextParameters()" )

		--_params_ = #( #id, #columns, #params )
		_params_ = #( #id, #columns, #pos )
			
			
		values =  for param in _params_ collect
			case param of
			(
				#id:	"\""+id.id+ "\""
				#pos:	this._getEditTextPosition() as string
				#columns:	12 as string
			)
		 
		--format "values	= % \n" values
		
		--_id    = "id:"   +	"\""+id.id + "_BUTTON"+"\""
		--pos = ""
		--pos    = "pos:"  +	(this._getEditTextPosition())    as string 
		--pos    = "pos:"  +	(this._getEditTextPosition())    as string 
		--width  = "fieldwidth:"+	(_Parameters.getVal #fieldwidth) as string
		--width  = "fieldwidth:64"
		--params = (_Parameters.join())
		
		--_id + " " +pos + " " + width + " " + params --return 
		
		this._getParamsString _params_ values --return
	),
	
	/** Get edit text position 
	 */
	function _getEditTextPosition =
	(
		--print("BrowsePath.EditText._getEditTextPosition()" )
		--format "this._Button	= % \n" this._Button

		pos = _Parameters.getVal #pos

		pos.x += this._Button.ControlBox.Layout._getControlWidth (this._Button)
		--format "pos	= % \n" pos
		pos --return
	),	