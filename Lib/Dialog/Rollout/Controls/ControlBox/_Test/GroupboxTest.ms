clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout.ms" )


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))


/* DEFINE GROUPBOXES */ 
controls_1    = _Rollout.Controls.new()
controls_2    = _Rollout.Controls.new groupbox:"" id:"groupbox_id"
controls_3    = _Rollout.Controls.new groupbox:"Groupbox Test"


Controls_1.button "No Groupbox" columns:6


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )

_Rollout.addSubRollouts()