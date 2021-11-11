clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

CONTROLS_COUNT = 4


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




rollout_titles	= #( "Rollout_1", "Rollout_2", "Rollout_3", "Rollout_4" )

r = 0

for rollout_title in rollout_titles do 
(
	try( execute("destroyDialog ROLLOUT_"+rollout_title) )catch()

	/* ROLLOUT DEFINITION */
	_Rollout	= Rollout_v title:rollout_title

	/** LAYOUT SETUP	 */
	--_Rollout.Layout.columns  = 16
	--_Rollout.Layout.grid     = 48
	
	_Rollout.Layout.padding  = r*2
	_Rollout.Layout.margin.x = r*2
	_Rollout.Layout.margin.y = r*2
	

	/* DEFINE GROUPBOXES */ 
	_Buttons	= _Rollout.Controls.new groupbox:"Buttons"
	_Spinners	= _Rollout.Controls.new groupbox:"Spinners"
	_Dropdowns	= _Rollout.Controls.new groupbox:"Dropdowns"


	/*---------------------------------------
		ADD CONTROLS
	-----------------------------------------*/
	addButtons()
	addSpinners()
	addDropdowns()

	
	

	/* CREATE ROLLOUT */
	_Rollout.createRollout()
	
	/* CREATE DIALOG */
	CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:512 pos:[ (r*512),512]
	
	_Rollout.addSubRollouts()

	r += 1
)









