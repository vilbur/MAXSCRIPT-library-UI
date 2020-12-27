/** 
 *
 */
struct ContentSubrollouts_v
(
	/* required properties */
	path,
	
	/*  properties */
	slot,
	Rolllouts	= #(),

	/** Set slot name
	 */
	function _setSlot =
	(
		slot = filenameFromPath path
		slot = ( dotNetObject "System.Text.RegularExpressions.Regex" @"[^A-Za-z0-9-]" ).Replace slot ""
	),
	
	/** _set rollouts
	 */
	function _setRollouts =
	(
		
	),
	
	on create do
	(
		this._setSlot()
		print ("ContentSubrollouts_v.onCreate " + slot )
		this._setRollouts()

	)
)





