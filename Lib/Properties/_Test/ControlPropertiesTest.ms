clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Dialog/Rollout/Rollout.ms" )


global _Rollout	   = Rollout_v title:(getFilenameFile(getSourceFileName()))
global Controls      = _Rollout.Controls.new groupbox:"Controls 1"
global btn_disable   = Controls.button "Button Properties"
global btn_invisible = Controls.button "Button No Props"

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )



/** SET PROPERTY  
 */
btn_disable.property   #enabled false
btn_invisible.property #visible false



/** GET PROPERTY  
 */
property_value = btn_disable.property #enabled #get

format "property_value	= % \n" property_value