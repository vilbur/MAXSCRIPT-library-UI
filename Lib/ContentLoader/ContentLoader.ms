
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
	/* required properties */
	dir, -- source dir of content
	
	/*  properties */
	Dialog,
	
	/** Set controls to
	  * @param	__[Dialog](../Dialog)__
	 */
	function craeteDialog Dialog =
	(
		--print "Content.setControlsToUI()"

		--Dialog.addToUi Dialog:Dialog
		
		--Dialog.create()
	),
	
	



	
	
	
	
	
	on create do
	(
		Dialog =  ContentRollout_v dir:dir
		
	)
	
	
	
	
)