clearListener()

/** INCLUDE UI 
 */
filein( getFilenamePath(getSourceFileName()) + "/../../Dialog/Dialog.ms" )


/**  Include scripts
 */
filein( getFilenamePath(getSourceFileName()) + "/Dialog-level/includes.ms" )


/** DEFINE DIALOG  */
Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))


/** Load content from file tree
 */
function loadContentTest =
(
	current_dir	= getFilenamePath(getSourceFileName())
	----Content	= (Content_v dir:(current_dir+"/Rollout-tooltip-test")	match:"rollout-(.*)$"	).load()
	
	--Content	= (Content_v dir:(current_dir+"/Rollouts-in-dirs")	match:"rollout-(.*)$"	).load()
	--Content.setControlsToUI Dialog

	--Content	= (Content_v dir:(current_dir+"/Rollouts-in-nested-subdirs")	match:"rollout-(test-.*)"	).load()	
	Content	= ContentLoader_v dir:(current_dir+"/Dialog-level")
	Content.craeteDialog Dialog
)

/** Add extra rollout
 */
function addRolloutByCodeTest name =
(
	_rollout    = __GLOBAL__v.Dialog.roll name ""
	_controls_A = _rollout.controls groupbox:"Groupbox A" -- get new container for controls
	_controls_B = _rollout.controls groupbox:"Groupbox B" -- get new container for controls
	_controls_A.button ("button by code")
	_controls_B.button ("button by code B")
)

/*---------------------------------------
	RUN TESTR
-----------------------------------------*/
--addRolloutByCodeTest "Rollout by code 1"
loadContentTest()
--addRolloutByCodeTest "Rollout by code 2"

