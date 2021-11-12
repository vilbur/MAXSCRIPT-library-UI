	_padding_top = 12,

	--groupbox_margin = 0,
	
	/** Set init _pos_last 
	 */
	function newControlsBox =
	(
		--print "LayoutGroupbox.ms.newControlsBox()"
		Bbox = Bbox_v origin:(this._getBboxOrigin())
		--format "Bbox.origin	= % \n" Bbox.origin
		_pos_last = copy Bbox.origin
		--format "_pos_last	= % \n" _pos_last
		
		this._addDefaultTopPadding()
	),

	/** Set position, width and height of groupbox
	 */
	function setGroupboxDimensions &Groupbox =
	(
		--print "Layout.setGroupboxDimensions()"
		Groupbox._Parameters.setValues #( #pos, #width, #height ) #( Bbox.origin, (Bbox.width + padding), (Bbox.height + padding) )
		--Groupbox._Parameters.setValues #( #pos, #width, #height ) #( Bbox.origin, (Bbox.width + padding), (Bbox.height) )
	),
	
	/** _get bbox origin
	 */
	function _getBboxOrigin =
	(
		--print "Layout._getBboxOrigin()"
		box_origin = [padding, padding]
		
		if( this._isNotFirstGroupBox() == true ) then
			box_origin.y = this._setNextGroupBoxOrigin box_origin
		--format "box_origin = % \n" box_origin
		box_origin
	),

	/** Is not first group box in rollout
	 */
	function _isNotFirstGroupBox =
	(
		Bbox != undefined --return
	),

	/** _set next group box origin
	 */
	function _setNextGroupBoxOrigin &box_origin =
	(
		(Bbox.getMax #y) + padding --return
	),

	/** Set first
	 */
	function _addDefaultTopPadding =
	(
		if( _pos_last == Bbox.origin ) then
            _pos_last.y  += _padding_top + padding
	),
	
	/** _offset groubox
	 */
	function _offsetGroubox ControlBox offset =
	(
		--print("LayoutGroupbox.ms _offsetGroubox()")
		--format "ControlBox = % \n" ControlBox
		
		ControlBox.offsetGroupbox [padding, offset] -- !!! TODO: ADD X POSITION TO OFFSET FUNCTION
		--format "offset = % \n" offset
		offset += (ControlBox.property height:#get)
		--offset += (ControlBxo._Params.getVal #height)
		--format "offset = % \n" offset
		
		offset --return
	),
	
