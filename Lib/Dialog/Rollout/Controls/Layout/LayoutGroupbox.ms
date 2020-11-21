	/** Set init _pos_last 
	 */
	function newControlsBox =
	(
		--format "\n------------\nLayout.newControlsBox()"
		Bbox = Bbox_v origin:(this._getBboxOrigin())

		_pos_last = copy Bbox.origin
		--_pos_last.x += 32
		this._addFirstControlPadding()
	),

	/** Get params string of Controls box
	 */
	function setGroupboxDimensions &Groupbox =
	(
		--format "------------\nLayout._getGroupboxDimensions()"
		Groupbox.property pos:Bbox.origin width:(Bbox.width + padding) height:(Bbox.height + padding)
	),
	
	/** Set first
	 */
	function _addFirstControlPadding =
	(
		if( _pos_last == Bbox.origin ) then
            _pos_last.y  += _padding_corrention + padding
	),
	
	/** _offset groubox
	 */
	function _offsetGroubox Groupbox offset =
	(
		Groupbox.offsetGroupbox [0, offset] -- !!! TODO: ADD X POSITION TO OFFSET FUNCTION
		
		offset += (Groupbox.property height:#get)
	),
	
	/** _get bbox origin
	 */
	function _getBboxOrigin =
	(
		box_origin = [0,0]
		
		if( Bbox != undefined ) then
			box_origin.y = Bbox.getMax #y

		 box_origin
	),

