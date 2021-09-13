/** Dialog global
 */
struct DialogsGlobal_v
(
	ids     = #(),
	Dialogs = #(),
	
	/* required */
	/* dependency */
	/* reference */
	/* properties */
	id,

	
	/** Set dialog
	 */
	function setDialog id Dialog =
	(
		appendIfUnique ids id
		
		index	= findItem ids id
		
		Dialogs[index] = Dialog
		
	),
	
	private
	

	/**  
	 */
	on create do
	(
		print("DialogGlobal_v.onCreate()")
	)
	
)
