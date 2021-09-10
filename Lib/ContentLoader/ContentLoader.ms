filein( getFilenamePath(getSourceFileName()) + "/../Dialog/Dialog.ms" )

filein( getFilenamePath(getSourceFileName()) + "/ContentSubrollouts/ContentRollout/ContentRollout.ms" ) 

filein( getFilenamePath(getSourceFileName()) + "/DialogCreator/DialogCreator.ms" )

/** Load content to UI by file tree
  *
  * @property	string	dir	Directory where rollout directories are placed, rollouts are used if ends with "*"
  * @property	regEx	match	Only directories matching this regex are threaded as rollouts, rollout name is matching group if defined
  *
  * --------------------------------------------------------------------------------------------------------------------
  *
  *
  *
  *
  */
struct ContentLoader_v
(
	__construct = #( #path ),
	
	/* required properties */
	path, -- source dir of content
	
	/*  properties */
	Dialog,

	/* depoendency */ 
	DialogCreator,
	
	/** Create
	 */
	function create =
	(
		print "create()"
		Dialog = DialogCreator.createDialog()
	),
	

	
	private
	
	/** Check if required properties are defined when an instance of the struct is created.
	 *	
	 * @example __construct = #( #property_name ) 
	 */
	function _checkConstctructProperties =
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ("ContentLoader\nUndefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),
	/**  
	 */
	on create do
	(
		print("ContentLoader_v.onCreate()")

		this._checkConstctructProperties()
		
		ContentRollout =  ContentRollout_v path:path
		
		DialogCreator  = DialogCreator_v ContentRollout:ContentRollout
	)
	
)
