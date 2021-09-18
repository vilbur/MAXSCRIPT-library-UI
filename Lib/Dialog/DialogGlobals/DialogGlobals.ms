/** Dialog global
 */
struct DialogGlobals_v
(
	ids     = #(),
	Dialogs = #(),

	
	/** Set dialog
	 */
	function setDialog id Dialog =
	(
		appendIfUnique ids id
		
		Dialogs[this.index id] = Dialog
	),
	
	/** Get Dialog
	 */
	function get id =
	(
		
		index = this.index id
		
		if( index > 0 ) then 
			Dialogs[this.index id] --return
	),
	
	/** Index
	 */
	function index id =
	(
		findItem ids id
	),
	
	private
	

	/**  
	 */
	on create do
	(
		print("DialogGlobal_v.onCreate()")
	)
	
)



if( DialogGlobals == undefined ) then
	global DialogGlobals = DialogGlobals_v()