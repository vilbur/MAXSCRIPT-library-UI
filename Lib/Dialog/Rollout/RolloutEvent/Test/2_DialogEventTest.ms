clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Dialog.ms" )


/*  Import callback methods
  
	CallbackNoParam()
	CallbackWithValue(val)
	CallbackWith2Params(arg_1) (arg_2)
*/ 
filein( getFilenamePath(getSourceFileName()) + "/../../../../Events/Test/inlcude_test_callbacks.ms" )


/*------ CREATE FLOATER DIALOG ------*/
Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))

Dialog.RolloutMain.ini (getFilenamePath(getSourceFileName()) + "2_DialogEventTest.ini")


/*------ CREATE ROLLOUTS ------*/
--Rollouts = Dialog.rollouts()
--Rollout_A	= Rollouts.new "Rollout A"
--Rollout_B	= Rollouts.new "Rollout B"

global ENABLE_RESIZING = false


/*
	CHANGE DEFAULT EVENTS

Rollout_A.Events.Events.setDefaultEvent ( Event_v type:"onOpen"	code:	"messagebox \"Default Event onOpen\"" )
Rollout_A.Events.Events.setDefaultEvent ( Event_v type:"onClose"	code:	"messagebox \"Default Event onClose\"" )

*/

/** On dock test
 */
function onDockResizeDialogCallback val =
(
	--print "\n onDockResizeDialogCallback()"
	--
	--format "EventFired = % \n" EventFired
	--
	--format "ENABLE_RESIZING = % \n" ENABLE_RESIZING
	--format "STATE = % \n" (cui.getDockState ROLLOUT_2_dialogeventtest)

	if( ENABLE_RESIZING ) then
	(
	
		if( ( Dialog_global = DialogGlobals.get(EventFired.Control) )!= undefined ) then
		(
			Dialog_global.resizeSubrolloutsOfDockedDialog()
		)
		
	)
	
	--max_height	= this._getViewportHeight()
	--
	--this.RolloutMain.Layout.fitSubrollouts dialog_height:max_height -- resize subrollouts
	--
	--this.height max_height -- resize dialog	
)


/*
	SET CUSTOM EVENTS
*/
--Dialog.Events.setEvent #open	"CallbackNoParam()"
--Dialog.Events.setEvent #close	"CallbackNoParam()"
Dialog.Events.setEvent #moved	"CallbackWithValue(val)"
--Dialog.Events.setEvent #resized	"CallbackWithValue(val)"
Dialog.Events.setEvent #docked	"CallbackWithValue(val)"


Dialog.Events.setEvent #oktoclose	"CallbackNoParam()"

Dialog.Events.setEvent #lbuttondown	"CallbackWithValue(val)"



/* CREATE DIALOG */
Dialog.create()
Dialog.register()

--clearListener()

--Dialog.dock #left


--is_docked = Dialog.getDockState()
--format "is_docked	= % \n" is_docked

