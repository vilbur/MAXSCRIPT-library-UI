clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout.ms" )


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))


/* DEFINE GROUPBOXES */ 
controls_1    = _Rollout.Controls.new()
controls_2    = _Rollout.Controls.new groupbox:"" id:"groupbox_id"
controls_3    = _Rollout.Controls.new groupbox:"Groupbox Test"


Controls_1.button "No Groupbox"
controls_2.button "No Caption"
controls_2.button "No Caption 2"
controls_3.button "Groupbox"


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:256 height:256

_Rollout.addSubRollouts()