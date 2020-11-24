clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

global _Rollout	  = Rollout_v title:(filenameFromPath(getSourceFileName()))
global Controls     = _Rollout.Controls.new groupbox:"Controls 1"
global btn_props    = Controls.button "Button Properties" height:32 border:false
--global btn_props    = Controls.button "Button Properties" border:false
--global _spinner     = Controls.spinner "Spinner" scale:10

--btn_props.params  border:false

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )

_Rollout.setRolloutWidth()


