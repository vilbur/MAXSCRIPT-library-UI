clearListener()



filein ( getFilenamePath(getSourceFileName()) + "/../../Control.ms" )
--filein ( getFilenamePath(getSourceFileName()) + "/../../../Controls.ms" )


Button_1	= Control_v type:#button	caption:"Test button"
ControlId 	= ControlId_v Parent_control:Button_1



/**  
 *	DEFINE CONTROLS
 */
Button_1	= Control_v type:#button	caption:"Test button"
Checkbox_1	= Control_v type:#checkbox	caption:"Test checkbox"


/* define rollut */
rci = rolloutCreator "myRollout" "My Rollout"
rci.begin()


/**  
 *	ADD CONTROLS
 */
rci.addControl Button_1.type	Button_1.id	Button_1.caption
rci.addControl Checkbox_1.type	Checkbox_1.id	Checkbox_1.caption


/* create rollout */
createDialog (rci.end())