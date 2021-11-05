clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

/*  Import callback methods
  
	CallbackNoParam()
	CallbackWithValue(val)
	CallbackWith2Params(arg_1) (arg_2)
*/ 
filein( getFilenamePath(getSourceFileName()) + "/../../../../../../../Events/Test/inlcude_test_callbacks.ms" )

/*---------------------------------------
	ROLLOUT DEFINITION
-----------------------------------------*/
_Rollout 	= Rollout_v title:(getFilenameFile(getSourceFileName()))
_Rollout.ini (getFilenamePath(getSourceFileName()) + "1_ControlEventsTest.ini") load:true




/* CONTROLS
*/ 
_Controls 	= _Rollout.controls.new groupbox:"Control types"



Button1 = _Controls.Button "Test"
Button1.Events.setEvent #pressed	"CallbackNoParam"	""
Button1.Events.setEvent #rightclick	"CallbackNoParam()"	""


Checkbox = _Controls.Checkbox "Test"
Checkbox.Events.setEvent #changed	"CallbackWithValue(val)"	""
Checkbox.Events.setEvent #rightclick	"CallbackNoParam()"	""


Checkbutton = _Controls.checkbutton "Test"
Checkbutton.Events.setEvent #changed	"CallbackWithValue(val)"	""
Checkbutton.Events.setEvent #rightclick	"CallbackNoParam()"	""


Spinner = _Controls.Spinner "Test"
Spinner.Events.setEvent #changed	"CallbackWith2Params"	""
Spinner.Events.setEvent #entered	"CallbackWith2Params"	""
Spinner.Events.setEvent #buttondown	"CallbackNoParam"	""
Spinner.Events.setEvent #buttonup	"CallbackWithValue"	""


Edittext = _Controls.Edittext "Test"
Edittext.Events.setEvent #changed	"CallbackWithValue"	""
Edittext.Events.setEvent #entered	"CallbackWithValue"	""


BrowsePath = _Controls.BrowsePath "Test"
BrowsePath.Events.setEvent #changed	"CallbackWithValue"	""
BrowsePath.Events.setEvent #entered	"CallbackWithValue"	""


Listbox = _Controls.Listbox "Test" items:#("item 1","item 2","item 3")
Listbox.Events.setEvent #selected	"CallbackWithValue"	""
Listbox.Events.setEvent #doubleClicked	"CallbackWithValue"	""
Listbox.Events.setEvent #rightClick	"CallbackWithValue"	""


Multilistbox = _Controls.Multilistbox "Test" items:#("item 1","item 2","item 3")
Multilistbox.Events.setEvent #selected	"CallbackWithValue"	""
Multilistbox.Events.setEvent #doubleClicked	"CallbackWithValue"	""
Multilistbox.Events.setEvent #rightClick	"CallbackNoParam"	""
Multilistbox.Events.setEvent #selectionEnd	"CallbackNoParam"	""


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512