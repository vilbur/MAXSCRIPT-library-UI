
	/** _offset subrollouts
	 */
	function _offsetSubrollouts Subrollouts slot_height offset =
	(
		print("LayoutSubrollouts.ms _offsetSubrollouts()")
		
		Subrollouts.property height:(slot_height - 4) pos:[0,offset]
		
		offset += slot_height --return
	),
	
	/** Get type
	 */
	function _getType Object =
	(
		--print (toLower (( filterString( classof Object as string ) "_*(:" )[2]))
		toLower (( filterString( classof Object as string ) "_*(:" )[2])  --return
	),