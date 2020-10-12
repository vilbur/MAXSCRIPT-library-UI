clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))



controls_1    = _Rollout.Controls.new "Groupbox 1"

Subrollouts_A = _Rollout.subrollouts()

_SubRollout_A1 = Subrollouts_A.new   "Subrollout A1"
_SubRollout_A2 = Subrollouts_A.new   "Subrollout A2"

controls_2    = _Rollout.Controls.new "Groupbox 2"

Subrollouts_B = _Rollout.subrollouts()
_SubRollout_B1 = Subrollouts_B.new   "Subrollout B1"
_SubRollout_B1_controls = _SubRollout_B1.Controls.new "SubRollout A1 controls"



controls_1.button "Button before subrollout 1"
controls_2.button "Button after subrollout 2"
--_SubRollout_B1_controls.button "Button in subrollout 2"



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )

--execute add_subrollouts

_Rollout.addSubRollouts()
