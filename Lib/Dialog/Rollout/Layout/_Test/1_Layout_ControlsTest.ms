clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )


CONTROLS_COUNT = 4


/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))

/** Layout setup
 */
--_Rollout.Layout.columns  = 16
--_Rollout.Layout.grid     = 48

_Rollout.Layout.padding  = 2
_Rollout.Layout.margin.x = 0
_Rollout.Layout.margin.y = 0




/* DEFINE GROUPBOXES */ 
--_Buttons    = _Rollout.Controls.new()
_Buttons	= _Rollout.Controls.new groupbox:"Buttons"
_Spinners	= _Rollout.Controls.new groupbox:"Spinners"
_Dropdowns	= _Rollout.Controls.new groupbox:"_Dropdowns"




/** Add extra rollout
 */
function addButtons =
(
	for i = 1 to CONTROLS_COUNT do
		_Buttons.button ("Button "+i as string )
)


/** Add extra rollout
 */
function addSpinners =
(
	for i = 1 to CONTROLS_COUNT do
		_Spinners.spinner ("Spinner "+i as string )
)


/** Add dropdowns
 */
function addDropdowns =
(
	captions = #(
		--"Dropdown",
		"" -- Dropdown without caption
	)
	
	for caption in captions do 
		_Dropdowns.dropdownlist caption

)


/*---------------------------------------
	RUN TEST
-----------------------------------------*/
addButtons()
--addSpinners()
addDropdowns()


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:512

_Rollout.addSubRollouts()