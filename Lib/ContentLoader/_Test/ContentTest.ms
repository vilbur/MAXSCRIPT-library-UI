clearListener()

/** INCLUDE UI 
 */
filein( getFilenamePath(getSourceFileName()) + "/../ContentLoader.ms" )

/**  Include scripts
 */
--filein( getFilenamePath(getSourceFileName()) + "/Dialog-level/includes.ms" )


/** DEFINE DIALOG  */


/** Load content from file tree
 */
function loadContentTest =
(
	current_dir	= getFilenamePath(getSourceFileName())
	----Content	= (Content_v dir:(current_dir+"/Rollout-tooltip-test")	match:"rollout-(.*)$"	).load()
	
	--Content	= (Content_v dir:(current_dir+"/Rollouts-in-dirs")	match:"rollout-(.*)$"	).load()
	--Content.setControlsToUI Dialog

	--Content	= (Content_v dir:(current_dir+"/Rollouts-in-nested-subdirs")	match:"rollout-(test-.*)"	).load()	
	Content	= ContentLoader_v path:(current_dir+"/Dialog-level")

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





--
--struct testCopy
--(
--	prop = "original"
--)
--
--original   = testCopy()
--
--
--copy_1 = copy original
--copy_2 = copy original
--copy_1.prop = "copy_1"
--copy_2.prop = "copy_2"
--
--print original.prop
--print copy_1.prop
--print copy_2.prop
--
--
--
--
--Struct test (pos1) --define a structure
--testval_orig      = test()  --create struct value
--testval_copy      = copy testval_orig --copy the struct value
--testval_copy.pos1 = 9999 --change component value of a compound --value in the copy
--testval --look at original struct value
--
--format "testval_orig = % \n" testval_orig
--format "testval_copy = % \n" testval_copy
