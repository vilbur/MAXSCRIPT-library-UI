	/** Set init _pos_last 
	 */
	function newControlsBox =
	(
		--format "\n------------\nLayout.newControlsBox()\n"
		Bbox = Bbox_v origin:(this._getBboxOrigin())

		_pos_last = copy Bbox.origin
		--format "% = % \n" Parent_roll.id Bbox.origin

		this._addFirstControlPadding()
	),

	/** Set position, width and height of groupbox
	 */
	function setGroupboxDimensions &Groupbox =
	(
		--print "Layout.setGroupboxDimensions()"
		--Groupbox.params pos:Bbox.origin width:(Bbox.width + padding) height:(Bbox.height + padding)
		Groupbox._Parameters.getOrSet #( #pos, #width, #height ) #( Bbox.origin, (Bbox.width + padding), (Bbox.height + padding) )
	),
	
	/** _get bbox origin
	 */
	function _getBboxOrigin =
	(
		--print "Layout._getBboxOrigin()"
		box_origin = [0,0]
		
		if( this._notFirstGroupBox() == true ) then
			box_origin.y = this._setNextGroupBoxOrigin box_origin
		--format "box_origin = % \n" box_origin
		box_origin
	),

	/** Is not first group box in rollout
	 */
	function _notFirstGroupBox =
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
	function _addFirstControlPadding =
	(
		if( _pos_last == Bbox.origin ) then
            _pos_last.y  += _padding_corrention + padding
	),
	
	/** _offset groubox
	 */
	function _offsetGroubox ControlBox offset =
	(
		--print("LayoutGroupbox.ms _offsetGroubox()")
		--format "ControlBox = % \n" ControlBox
		
		ControlBox.offsetGroupbox [0, offset] -- !!! TODO: ADD X POSITION TO OFFSET FUNCTION
		--format "offset = % \n" offset
		offset += (ControlBox.property height:#get)
		--offset += (ControlBxo._Params.getVal #height)
		--format "offset = % \n" offset
		
		offset --return
	),
	
