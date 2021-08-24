clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))


/** Add Groupboxes
 */
function addGroupboxes =
(
	for g = 1 to 6 do
	(
		Controls    = _Rollout.Controls.new groupbox:("Groupbox " + g as string)
		
		for i = 1 to g do
			Controls.button ("Button "+g as string +"."+i as string )
	)
)

/*---------------------------------------
	RUN TEST
-----------------------------------------*/
addGroupboxes()

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:512

_Rollout.addSubRollouts()