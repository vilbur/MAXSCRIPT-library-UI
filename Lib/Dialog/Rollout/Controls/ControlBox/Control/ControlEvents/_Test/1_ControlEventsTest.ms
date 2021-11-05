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
Controls_1 	= _Rollout.controls.new groupbox:"Control types"



--Button1 = Controls_1.Button "Test"
--Button1.Events.setEvent #pressed	"CallbackNoParam"	""
--Button1.Events.setEvent #rightclick	"CallbackNoParam()"	""
--
--
--Checkbox = Controls_1.Checkbox "Test"
--Checkbox.Events.setEvent #changed	"CallbackWithValue(val)"	""
--Checkbox.Events.setEvent #rightclick	"CallbackNoParam()"	""


Spinner = Controls_1.Spinner "Test"
--Spinner.Events.setEvent #changed	"CallbackWith2Params"	""
--Spinner.Events.setEvent #entered	"CallbackWith2Params"	""
--Spinner.Events.setEvent #buttondown	"CallbackNoParam"	""
--Spinner.Events.setEvent #buttonup	"CallbackWithValue"	""
--
--
--Edittext = Controls_1.Edittext "Test"
--Edittext.Events.setEvent #changed	"CallbackWithValue"	""
--Edittext.Events.setEvent #entered	"CallbackWithValue"	""


--BrowsePath = Controls_1.BrowsePath "Test"
--BrowsePath.Events.setEvent #changed	"CallbackWithValue"	""
--BrowsePath.Events.setEvent #entered	"CallbackWithValue"	""


--Listbox = Controls_1.Listbox "Test" items:#("item 1","item 2","item 3")
--Listbox.Events.setEvent #selected	"CallbackWithValue"	""
--Listbox.Events.setEvent #doubleClicked	"CallbackWithValue"	""
--Listbox.Events.setEvent #rightClick	"CallbackWithValue"	""
--
--
--Multilistbox = Controls_1.Multilistbox "Test" items:#("item 1","item 2","item 3")
--Multilistbox.Events.setEvent #selected	"CallbackWithValue"	""
--Multilistbox.Events.setEvent #doubleClicked	"CallbackWithValue"	""
--Multilistbox.Events.setEvent #rightClick	"CallbackNoParam"	""
--Multilistbox.Events.setEvent #selectionEnd	"CallbackNoParam"	""


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512


--clearListener()

