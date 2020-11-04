clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/**  Test of adding controls to Parent_roll
 */
_Rollout = Rollout_v title:(filenameFromPath(getSourceFileName()))
Controls = (Controls_v Parent_roll:_Rollout).new "Controls"

/* Define mock buton */ 
struct Control_mock(type = #button, id, caption)

/* ADD TO UI */ 
Controls._addControlToUi (Control_mock caption:"Button 1" id:"Button_1")
Controls._addControlToUi (Control_mock caption:"Button 2" id:"Button_2")


/* CREATE ROLLOUT */
_Rollout.createRollout()	-- create with default parameters

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )