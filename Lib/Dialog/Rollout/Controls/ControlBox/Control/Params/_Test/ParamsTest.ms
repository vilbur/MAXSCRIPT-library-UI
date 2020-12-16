clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

global _Rollout	  = Rollout_v title:(filenameFromPath(getSourceFileName()))

_Rollout.Layout.padding = 0
_Rollout.Layout.margin = [0,0]

global Controls     = _Rollout.Controls.new()
--global Controls     = _Rollout.Controls.new groupbox:"Controls 1"

--global btn_props    = Controls.button "Button Params"
--global btn_props    = Controls.button "Button Params" columns:6 height:32 border:false
global btn_props    = Controls.button "Button Params" border:false

global btn_props_2    = Controls.button "Button Params 2" 

global btn_props_3    = Controls.button "Button Params 3" 

global _spinner     = Controls.spinner "Spinner" scale:10 columns:6 pos:[132,16]

--global _spinner     = Controls.spinner "Spinner" scale:10 columns:6


format "btn_props = % \n" btn_props

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:512 height:512