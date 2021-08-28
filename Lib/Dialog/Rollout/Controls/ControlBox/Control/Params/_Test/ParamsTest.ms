clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

global _Rollout	  = Rollout_v title:(filenameFromPath(getSourceFileName()))

_Rollout.Layout.padding = 0
_Rollout.Layout.margin = [0,0]

global Controls     = _Rollout.Controls.new()
--global Controls     = _Rollout.Controls.new groupbox:"Controls 1"

global btn_params    = Controls.button "Button Params" columns:6 height:32 border:false tooltip:"Test Tooltip"
--global btn_params    = Controls.button "Button Params" border:false

global btn_params_2    = Controls.button "Button width" width:128

global _spinner     = Controls.spinner "Spinner" scale:10 columns:6


format "btn_params = % \n" btn_params

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:512 height:512