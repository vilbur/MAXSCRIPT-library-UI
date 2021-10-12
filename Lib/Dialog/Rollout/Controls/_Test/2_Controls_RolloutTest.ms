clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))


/* DEFINE MAIN LAYOUT OF CONTROLSBOXES & ROLLOUTS */ 
Groupbox_1    = _Rollout.Controls.new groupbox:"Groupbox 1"

Subrollouts_A = _Rollout.subrollouts()

Groupbox_2    = _Rollout.Controls.new groupbox:"Groupbox 2"

Subrollouts_B = _Rollout.subrollouts()



/* DEFINE SUBROLLOUTS */ 
_SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"

_SubRollout_B = Subrollouts_B.new   "Subrollout B1"



/* DEFINE CONTROLS */ 
Groupbox_1.button "Buttons"
Groupbox_1.button "Before"

Groupbox_2.button "Buttons 2"
Groupbox_2.button "After 2"




/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) height:512

_Rollout.addSubRollouts()

_Rollout.Layout.fitSubrollouts()