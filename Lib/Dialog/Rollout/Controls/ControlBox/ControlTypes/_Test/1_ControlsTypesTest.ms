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




/* CONTROL TYPES */
--_Controls.button	"Button"

_Controls.edittext	"Edit Text" 
_Controls.edittext	"Edit Text Custom Width" fieldwidth:32
_Controls.edittext	"Edit Text Auto Field Width" 

--BrowsePath = _Controls.BrowsePath	"Browse"
--BrowsePath = _Controls.BrowsePath	"Browse" width:256
--BrowsePath = _Controls.BrowsePath	"Browse" width:256  fieldwidth:192  initialDir:(getDir #maxroot)

_Controls.spinner	"Spinner with long label" columns:12
_Controls.spinner	"Spinner" offset:[32,0] 

_Controls.checkbutton	"Checkbutton"
_Controls.checkbox	"Checkbox"

/** Grid of buttons 
 *	
 */
for i = 1 to 8 do
	_Controls.button ("Button A "+i as string ) id: ("ButtonA"+i as string )
	

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts