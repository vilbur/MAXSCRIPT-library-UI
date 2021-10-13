clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))
_Controls	= _Rollout.controls.new groupbox:"Test Groupbox"

_Rollout.ini	(getFilenamePath(getSourceFileName()) + getFilenameFile(getSourceFileName()) + ".ini")



/* LISTBOX  */
Listbox = _Controls.Listbox	"Listbox" items:#("item 1", "item 2", "item 3")

/* BUTTON  */
--_Button = _Controls.button "Test 1" 



/** Grid of buttons 
 *	
 */
--for i = 1 to 8 do
	--_Controls.button ("Button A "+i as string ) id: ("ButtonA"+i as string )
	

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512