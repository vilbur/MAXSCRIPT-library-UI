filein( getFilenamePath(getSourceFileName()) + "/../Dialog/Dialog.ms" )

	
filein( getFilenamePath(getSourceFileName()) + "/ContentSubrollouts/ContentRollout/ScriptFile/ScriptFile.ms" )
filein( getFilenamePath(getSourceFileName()) + "/ContentSubrollouts/ContentRollout/ContentRollout.ms" ) 
filein( getFilenamePath(getSourceFileName()) + "/ContentSubrollouts/ContentSubrollouts.ms" )

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
	path, -- source dir of content
	
	/*  properties */
	name,
	Dialog,
	ContentRollout,
	
	/** Set controls to
	  * @param	__[Dialog](../Dialog)__
	 */
	function craeteDialog =
	(
		--print "Content.setControlsToUI()"

		--Dialog.addToUi Dialog:Dialog
		
		ContentRollout.addToUi()

			--format "content = % \n" content
		
		Dialog.create()
	),
	
	/** Set rollout name by folder name E.g.: "Rollout-1" >> "Rollout 1"
	 */
	function _setName =
	(
		name = getFilenameFile path
	),
	
	on create do
	(
		this._setName()
		
		Dialog	= Dialog_v title:name
			
		ContentRollout =  ContentRollout_v path:path
		
		this.craeteDialog()
		
	)
	
	
	
	
)

