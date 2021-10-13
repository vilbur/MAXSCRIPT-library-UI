clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../Rollout.ms" )


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))
_Controls	= _Rollout.controls.new groupbox:"Test Groupbox"



/** Layout setup
 */
--_Rollout.Layout.columns  = 16
--_Rollout.Layout.grid     = 48

--_Rollout.Layout.padding  = 0
--_Rollout.Layout.margin.x = 0
--_Rollout.Layout.margin.y = 0





/* BUTTON  */
_Button = _Controls.button "Test 1" 


/* CHECKBOX  */
_Checkbox = _Controls.checkbox	"Checkbox" checked:true


/* SPINNER  */
_Controls.spinner	"Spinner int"   range:[0,9,99]
_Controls.spinner	"Spinner float" range:[0,999,999.0] type:#float
_Controls.spinner	"Test Spinner" 


/* CHECKBUTTON  */
_Controls.checkbutton	"Checkbutton"


/* EDITTEXT  */
_Controls.edittext	"Edit Text" 


/* BROWSEPATH  */
BrowsePath = _Controls.BrowsePath	"Get Dir" columns:16 

/* LISTBOX  */
Listbox = _Controls.Listbox	"Listbox"



/** Grid of buttons 
 *	
 */
--for i = 1 to 8 do
	--_Controls.button ("Button A "+i as string ) id: ("ButtonA"+i as string )
	

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts