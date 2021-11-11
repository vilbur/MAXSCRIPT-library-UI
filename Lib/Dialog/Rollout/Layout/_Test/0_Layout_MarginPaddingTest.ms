clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

CONTROLS_COUNT = 8

global _Rollout
	
/** Add extra rollout
 */
function addButtons =
(
	_Buttons	= _Rollout.Controls.new groupbox:"Buttons"
	
	for i = 1 to CONTROLS_COUNT do
		_Buttons.button ("Button "+i as string )
)


/** Add extra rollout
 */
function addSpinners =
(
	_Spinners	= _Rollout.Controls.new groupbox:"Spinners"
	
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
	
	_Dropdowns	= _Rollout.Controls.new groupbox:"Dropdowns"

	for caption in captions do 
		_Dropdowns.dropdownlist caption
)



rollout_titles = #(
	"Rollout_1",
	"Rollout_2",
	"Rollout_3",
	"Rollout_4",
	"Rollout_5"
)

for rollout_title in rollout_titles do 
(
	try( execute("destroyDialog ROLLOUT_"+rollout_title) )catch()

	r	= (findItem rollout_titles rollout_title) - 1
	
	/* ROLLOUT DEFINITION */
	_Rollout	= Rollout_v title:rollout_title

	/** LAYOUT SETUP	 */
	--_Rollout.Layout.columns  = 24
	--_Rollout.Layout.grid     = 48
	
	_Rollout.Layout.padding  = r*2
	_Rollout.Layout.margin.x = r*2
	_Rollout.Layout.margin.y = r*2
	
	format "\n"
	print rollout_title
	format "_Rollout.Layout.padding = % \n" _Rollout.Layout.padding 
	format "_Rollout.Layout.margin  = % \n" _Rollout.Layout.margin

	/*---------------------------------------
		ADD CONTROLS
	-----------------------------------------*/
	addButtons()
	addSpinners()
	addDropdowns()

	
	offset_position_x = (r + 2) * 380
	--format "r	= % \n" r
	/* CREATE ROLLOUT */
	_Rollout.createRollout()
	
	/* CREATE DIALOG */
	CreateDialog ( _Rollout.RolloutCreator.getDefinition()) pos:[ offset_position_x, 512 ]
	--width:512
	
	 execute("ROLLOUT_"+rollout_title+".width = " + (_Rollout.setRolloutWidth() as string ))
	 
	--_Rollout.addSubRollouts()

)









