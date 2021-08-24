clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))


/* DEFINE LAYOUT OF CONTROLS & ROLLOUTS */ 
Controls_1    = _Rollout.Controls.new groupbox:"Groupbox 1"

Subrollouts_A = _Rollout.subrollouts()

controls_2    = _Rollout.Controls.new groupbox:"Groupbox 2"

--Subrollouts_B = _Rollout.subrollouts()


/* DEFINE SUBROLLOUTS */ 
_SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"
--_SubRollout_A2 = Subrollouts_A.new   "Subrollout A2"
--
--_SubRollout_B = Subrollouts_B.new   "Subrollout B1"


/* DEFINE SUBROLLOUT CONTROLS */ 
--_SubRollout_B_controls = _SubRollout_B.Controls.new groupbox:"SubRollout B controls"


/* DEFINE CONTROLS */ 
Controls_1.button "Btn 1 before subrollouts A" id:"optionable_id"
--Controls_1.button "Btn 2 before subrollouts A"
--
controls_2.button "Btn before subrollouts B"
--
--_SubRollout_B_controls.button "Btn in subrollout 2"


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) height:256

_Rollout.addSubRollouts()