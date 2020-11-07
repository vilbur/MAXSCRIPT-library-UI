clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout.ms" )
/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))


/* DEFINE GROUPBOXES */ 
controls_1    = _Rollout.Controls.new()
controls_2    = _Rollout.Controls.new groupbox:"" id:"Groupbox_Test"
controls_3    = _Rollout.Controls.new groupbox:"Groupbox Test"

/* DEFINE CONTROLS */ 
Controls_1.button "No Groupbox"



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )

_Rollout.addSubRollouts()