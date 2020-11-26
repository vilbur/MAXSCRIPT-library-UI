	
	/** Set dimensions of control, add to Bounding box
	  * @param	Params	Params
	  * @param	int	columns	Width of control
	  *
	 */
	function setControlDimensions &Control =
	(
		--format "------------\nLayout.setControlDimensions %\n" (Control.id.get())
		--Dimensions	= this._getControlDimensions Control
		--format "Dimensions = %\n" Dimensions
		_width  = this._getControlWidth  Control
		height = this._getControlHeight Control
		
		this._trySetNewControlsRow _width
		
		pos    = this._getControlPos    Control _width
		--format "pos = % \n" pos
		pos.x += padding -- add padding to left side of group box
		
		Dimensions = Dimensions_v pos:pos width:_width height:height
		--print Dimensions_v as string 
		
		this._setNextControlPosition Dimensions.width

		Control.setDimensions Dimensions
		--format "Dimensions =%\n" Dimensions	
		
 		Bbox.add Dimensions
	),

	/** Try set new row of controls
	  * Add margin between controls
	 */
	function _trySetNewControlsRow current_control_width =
	(
		if not ( this._controlFitIntoRollout current_control_width ) then
			_pos_last = [ Bbox.origin.x, (Bbox.getMax #y) + margin.y ]
	),

	/** Control is out of rollout
     */
    function _controlFitIntoRollout current_control_width =
    (
        (_pos_last.x + current_control_width) < this._getRollWidthByColumns() --return
    ),
	
	/** _get roll _width
	 */
	function _getRollWidthByColumns=
	(
		(columns * grid) + margin.x*4 + 14 --return
	),

	/** Set new control position
	  * Add margin between controls
  	 */
	function _setNextControlPosition current_control_width =
	(
		_pos_last.x += current_control_width + margin.x
	),

	/** _get control _width
	 */
	function _getControlWidth Control =
	(
		_width   = Control.property width: #get
		
		if( _width == undefined ) then
			_width = this._getControlWidthRaw Control
		
		_width --return
	),
	
	/** _get control height
	 */
	function _getControlHeight Control =
	(
		height  = Control.property height:#get
		
		if( height == undefined ) then
			height = this._getControlHeightRaw()
		
		height --return
	),
	
	/** _get control position;
	 */
	function _getControlPos Control _width =
	(
		pos     = Control.property pos:   #get
		if( pos == undefined ) then
			pos = this._getControlPositionRaw _width
		
		pos --return
	),

	/** _get position of last control
	 */
	function _getControlPositionRaw _width =
	(
		--format "***\nLayout._getControlPositionRaw()\n"
		[ _pos_last.x, _pos_last.y ] --return
	),
	
	/** Get height
	 */
	function _getControlWidthRaw Control =
	(
		--format "HOTFIX LayoutControl.ms _getControlWidthRaw()\n"
		--format "Control._Parameters.keys = % \n" Control._Parameters.keys
		--format "Control.params columns:#get = % \n" (Control.params columns:#get)
		(Control.params columns:#get) * grid --return
	),	
	
	/** Get height
	 */
	function _getControlHeightRaw =
	(
		--format "HOTFIX LayoutControl.ms _getControlHeightRaw()\n"
		--grid --return
		grid - padding * 2 --return
	),