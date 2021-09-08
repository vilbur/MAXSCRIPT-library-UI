clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../Rollout.ms" )


_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))
Controls = _Rollout.Controls.new()



/** Added straight to controls by method "fooTYpe()" 
 */
_Button = Controls.button "By method"


/** Added Control_v object to ControlsBox later 
 */
_Control = Control_v type:#button caption:"By Control_v"

Controls.add _Control



/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:512 height:512