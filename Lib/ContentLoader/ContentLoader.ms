filein( getFilenamePath(getSourceFileName()) + "/../Dialog/Dialog.ms" )

	
--filein( getFilenamePath(getSourceFileName()) + "/ContentSubrollouts/ContentRollout/ScriptFile/ScriptFile.ms" )
filein( getFilenamePath(getSourceFileName()) + "/ContentSubrollouts/ContentRollout/ContentRollout.ms" ) 
--filein( getFilenamePath(getSourceFileName()) + "/ContentSubrollouts/ContentSubrollouts.ms" )

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
	/* required properties */
	path, -- source dir of content
	
	/*  properties */
	ContentRollout,
	DialogCreator,

	on create do
	(
		ContentRollout =  ContentRollout_v path:path
		
		DialogCreator  = DialogCreator_v ContentRollout:ContentRollout
		
		DialogCreator.createDialog()
	)
)