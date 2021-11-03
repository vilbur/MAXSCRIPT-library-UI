clearListener()


filein( getFilenamePath(getSourceFileName()) + "/../../../Dialog.ms" )

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


/** Button test
 */
function CallbackNoParam =
(
	print "CallbackNoParam"

	format "EventFired.control 	= % \nEventFired.type 	= % \n\n" EventFired.control EventFired.type
)
/** on value changed
 */
function CallbackWithValue val =
(
	print "CallbackWithValue"
	
	format "EventFired.control 	= % \nEventFired.type 	= % \n" EventFired.control EventFired.type
	
	format "val 	= % \n" val
	
	format "EventFired 	= % \n\n" EventFired
)


/** on value changed
 */
function CallbackWith2Params arg_1 arg_2 =
(
	print "SpinnerEnteredTest"
	
	format "EventFired.control 	= % \nEventFired.type 	= % \n" EventFired.control EventFired.type

	format "arg_1 	= % \narg_2  	= % \n" arg_1 arg_2

	format "EventFired 	= % \n\n" EventFired
)

/*
	SET CUSTOM EVENTS
*/
--Dialog.Events.setEvent #open	"CallbackNoParam()"
--Dialog.Events.setEvent #close	"CallbackNoParam()"
--Dialog.Events.setEvent #moved	"CallbackWithValue(val)"
--Dialog.Events.setEvent #resized	"CallbackWithValue(val)"


Dialog.Events.setEvent #docked	"print \"\DOCKED\""


--Dialog.Events.setEvent #lbuttondown	"CallbackWithValue(val)"
--Dialog.Events.setEvent #oktoclos	"CallbackNoParam()"



/* CREATE DIALOG */
Dialog.create()


Dialog.dock #left




