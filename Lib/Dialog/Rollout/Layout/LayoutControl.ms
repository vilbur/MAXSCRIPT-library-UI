	
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
		Dimensions = Dimensions_v width:( this._getControlWidth  Control ) height:( this._getControlHeight Control )
		--format "Dimensions	= % \n" Dimensions
		this._trySetNewControlsRow Dimensions.width
		
		Dimensions.pos = this._getControlPos Control Dimensions.width
		--format "pos = % \n" pos
		Dimensions.pos.x += padding -- add padding to left side of group box
		
		Control._setParamteresPosWidthHeight Dimensions
		
		this._setNextControlPosition Dimensions.width
		--format "Dimensions =%\n" Dimensions
		
 		Bbox.add Dimensions
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
		--format "_width	= % \n" _width
		if( _width == undefined ) then
			_width = this._getControlWidthByColumns Control
		
		--format "_width	= % \n" _width
		_width --return
	),
	
	/** Get height
	 */
	function _getControlWidthByColumns Control =
	(
		--print "LayoutControl.ms _getControlWidthByColumns()"
		if( (columns_count = Control._Parameters.getVal #columns) == undefined ) then 
			columns_count = columns_default -- set default columns width
		
		((grid + margin.x) * columns_count) - margin.x --return
	),
	
	/** _get control height
	 */
	function _getControlHeight Control =
	(
		--print "LayoutControl.ms _getControlHeight()"
		height = Control._Parameters.getVal #height -- if user defined height
		
		if( hasProperty Control "_getControlHeightByType" ) then
			height = Control._getControlHeightByType height
			
		if( height == undefined ) then -- get default height if not defined by user or control type
			height = grid
		
		height --return
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
        (_pos_last.x + control_width) <= (this._getRollWidthByColumns()) --return
    ),
	
