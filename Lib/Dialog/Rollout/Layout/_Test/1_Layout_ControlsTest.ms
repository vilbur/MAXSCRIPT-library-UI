clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )


CONTROLS_COUNT = 4


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))

/* DEFINE GROUPBOXES */ 
--_Buttons    = _Rollout.Controls.new()
_Buttons  = _Rollout.Controls.new groupbox:"Buttons"
_Spinners = _Rollout.Controls.new groupbox:"Spinners"


/** Add extra rollout
 */
function addButtons =
(
	for i = 1 to CONTROLS_COUNT do
		_Buttons.button ("Button "+i as string )
)


/** Add extra rollout
 */
function addSpinners =
(
	for i = 1 to CONTROLS_COUNT do
		_Spinners.spinner ("Spinner "+i as string )
)




/*---------------------------------------
	RUN TEST
-----------------------------------------*/
addButtons()
addSpinners()


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:512

_Rollout.addSubRollouts()