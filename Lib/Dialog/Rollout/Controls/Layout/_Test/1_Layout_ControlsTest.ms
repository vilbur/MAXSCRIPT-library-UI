clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))


/* DEFINE LAYOUT OF CONTROLS & ROLLOUTS */ 

/* DEFINE GROUPBOXES */ 
controls_1    = _Rollout.Controls.new()
--controls_2    = _Rollout.Controls.new id:"Groupbox_Test"
--controls_3    = _Rollout.Controls.new groupbox:"Groupbox Test" 

/* DEFINE CONTROLS */ 
--Controls_1.button "No Groupbox"


/** Add extra rollout
 */
function addRolloutByCodeTest =
(

	
	for i = 1 to 2 do
		--controls_1.button ("Button A "+i as string )
		--controls_1.button ("Button A "+i as string ) id: ("Button A"+i as string )
		controls_1.button ("Button A "+i as string ) id: ("ButtonA"+i as string )
	
	--for i = 1 to 12 do
	--(
	--	_button = _controlsB.button ("Col "+i as string )
	--	_button.col i
	--)
	--	
	--_controlsB.button ("button by code B")
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