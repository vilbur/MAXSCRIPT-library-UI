	
	columns_default = 4,
	
	/** Set dimensions of control, add to Bounding box
	  * @param	Params	Params
	  * @param	int	columns	Width of control
	  *
	 */
	function setControlDimensions &Control =
	(
		--format "\n"
		--print ("LayoutControl.ms.setControlDimensions() " + (Control.id.get()))
		--format "Control = % \n" Control._parameters.values
		_width  = this._getControlWidth  Control
		_height = this._getControlHeight Control
		--format "_width	= % \n_height	= % \n\n" _width _height
		--format "_width	= *% \n" _width
		
		this._trySetNewControlsRow _width
		
		pos    = this._getControlPos Control _width
		--format "pos = % \n" pos
		pos.x += padding -- add padding to left side of group box
		
		Dimensions = Dimensions_v pos:pos width:_width height:_height
		--print Dimensions_v as string 
		
		this._setNextControlPosition Dimensions.width
		--format "Dimensions =%\n" Dimensions	

		Control.setDimensions Dimensions

 		Bbox.add Dimensions
	),

	/** Try set new row of controls
	  * Add margin between controls
	 */
	function _trySetNewControlsRow control_width =
	(
		if not ( this._isControlFitIntoRollout control_width ) then
			_pos_last = [ Bbox.origin.x, (Bbox.getMax #y) + margin.y ]
	),

	/** Control is out of rollout
     */
    function _isControlFitIntoRollout control_width =
    (
		--print ("LayoutControl.ms._isControlFitIntoRollout " + control_width as string )

		--format "_pos_last.x	= % \n" _pos_last.x
		--format "control_width = % \n" control_width
		--format "new control	  = % \n" (_pos_last.x + control_width)
		
        fit_test = (_pos_last.x + control_width) <= (this._getRollWidthByColumns()) --return
		
		--format "fit_test  	= % \n" fit_test
		fit_test --return
    ),
	
	/** _get roll _width
	 */
	function _getRollWidthByColumns =
	(
		--(columns * grid) + margin.x*4 + _padding_corrention --return
		controlbox_width = (grid + margin.x ) * columns
		
		--format "controlbox 	  = % \n" ( controlbox_width as integer ) 
		controlbox_width --return
	),

	/** Set new control position
	  * Add margin between controls
  	 */
	function _setNextControlPosition control_width =
	(
		_pos_last.x += control_width + margin.x
	),

	/** _get control _width
	 */
	function _getControlWidth Control =
	(
		--print "LayoutControl.ms _getControlWidth()"

		_width = Control._Parameters.getVal #width
		
		if( _width == undefined ) then
			_width = this._getControlWidthByColumns Control
		
		--format "_width	= % \n" _width
		_width --return
	),
	
	/** Get height
	 */
	function _getControlWidthByColumns Control =
	(
		if( (columns_count = Control._Parameters.getVal #columns) == undefined ) then 
			columns_count = columns_default -- set default columns width
		
		((grid + margin.x) * columns_count) - margin.x --return
	),
	
	/** _get control height
	 */
	function _getControlHeight Control =
	(
		--print "LayoutControl.ms _getControlHeight()"
		 -- if is user defined
		--format "height	= % \n" height
		
		if( (height = Control._Parameters.getVal #height) == undefined ) then
			height = this._getControlHeightByColumns Control
		
		height --return
	),
	
	/** Get height
	 */
	function _getControlHeightByColumns Control =
	(
		double_height_controls = #( #dropdownList )
		
		--format "Control.type	= % \n" Control.type
		--format "ROLLOUT_1_controlstypestestms.DROPDOWNLIST_dropdownlist.height	= % \n" ROLLOUT_1_controlstypestestms.DROPDOWNLIST_dropdownlist.height
		--format "HOTFIX LayoutControl.ms _getControlHeightByColumns()\n"
		--grid --return
		
		if( hasProperty Control "_getControlHeight" ) then
			Control._getControlHeight()
		
		else
			grid
		
		--multiplier	= findItem double_height_controls Control.type 
		
		--grid - padding * 2 --return
	),
	
	/** _get control position;
	 */
	function _getControlPos Control _width =
	(
		--print "HOTFIX LayoutControl.ms _getControlPos()"
		pos = Control._Parameters.getVal #pos
		
		if( pos == undefined ) then
			pos = this._getControlPositionRaw _width (Control._Parameters.getVal #offset)
		
		pos --return
	),

	/** _get position of last control
	 */
	function _getControlPositionRaw _width offset =
	(
		if( offset == undefined ) then
			offset = [0,0]
		
		--format "***\nLayout._getControlPositionRaw()\n"
		--control_pos = [ _pos_last.x, _pos_last.y ] --return
		[ _pos_last.x, _pos_last.y ] + offset --return
	),
	
