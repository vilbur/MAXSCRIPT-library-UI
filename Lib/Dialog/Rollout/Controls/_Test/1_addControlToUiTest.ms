clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/**  Test of adding controls to Parent_roll
 */


_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))

struct Control_mock(type = #button, id="test", caption="Test button")

Controls = Controls_v Parent_roll:_Rollout

Controls._addControlToUi (Control_mock())

/* CREATE ROLLOUT */
_Rollout.createRollout()	-- create with default parameters

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )