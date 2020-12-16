clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))

/* DEFINE GROUPBOXES */ 
controls_1    = _Rollout.Controls.new()

/** Add extra rollout
 */
function addRolloutByCodeTest =
(
	for i = 1 to 3 do
		controls_1.button ("Button A "+i as string ) id: ("ButtonA"+i as string )
)


/*---------------------------------------
	RUN TEST
-----------------------------------------*/
addRolloutByCodeTest()


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:312

_Rollout.addSubRollouts()