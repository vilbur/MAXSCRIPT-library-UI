clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../Rollout.ms" )


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))
_Rollout.ini	= getFilenamePath(getSourceFileName()) + "ControlTest.ini"
_controls_1	= _Rollout.controls.new groupbox:"Test Groupbox"



/** Layout setup
 */
--_Rollout.Layout.columns  = 16
--_Rollout.Layout.grid     = 48

--_Rollout.Layout.padding  = 0
--_Rollout.Layout.margin.x = 0
--_Rollout.Layout.margin.y = 0


/* CONTROL TYPES */
--_controls_1.button	"Button"

--_controls_1.spinner	"Spinner" columns:5

_controls_1.edittext	"Edit Text" 
--_controls_1.edittext	"Edit Text Auto Field Width" 
--_controls_1.edittext	"Edit Text Custom Width" fieldwidth:32
----_controls_1.edittext	"Edit Text Custom Width" fieldwidth:32

--BrowsePath = _controls_1.BrowsePath	"Browse"
--BrowsePath = _controls_1.BrowsePath	"Browse" width:256
--BrowsePath = _controls_1.BrowsePath	"Browse" width:256  fieldwidth:192  initialDir:(getDir #maxroot)

--_controls_1.spinner	"Spinner with long label" columns:12 this.
--_controls_1.spinner	"Spinner" offset:[32,0] 

--_controls_1.checkbutton	"Checkbutton"
--_controls_1.checkbox	"Checkbox"

_controls_1.edittext	"Edit Text" 
/** Grid of buttons 
 *	
 */
--for i = 1 to 5 do
	--_controls_1.button ("Button A "+i as string ) id: ("ButtonA"+i as string )
	

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts