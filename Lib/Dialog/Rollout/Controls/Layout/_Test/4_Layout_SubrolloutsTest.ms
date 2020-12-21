clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout.ms" )

/* ROLLOUT DEFINITION */
global _Rollout = Rollout_v title:(filenameFromPath(getSourceFileName()))


global counter_subrollouts = 0
global counter_rollouts    = 0
global counter_groupboxes  = 0
global counter_controls    = 0

/** Layout setup
  * Make UI big
 */
function layoutSetup =
(
	_Rollout.Layout.columns  = 16
	_Rollout.Layout.grid     = 48
	
	_Rollout.Layout.padding  = 16
	_Rollout.Layout.margin.x = 32
	_Rollout.Layout.margin.y = 16
)

/** Add extra rollout
 */
function addControls groupboxes:1 =
(
	/* DEFINE SLOTS FOR ROLLOUTS */
	for g = 1 to groupboxes do
	(
		Controls = _Rollout.Controls.new groupbox:("Groupbox " + (counter_groupboxes += 1) as string)
		
		for i = 1 to g + 2 do
			Controls.button ("Button "+counter_groupboxes as string +"."+i as string )
	)
)

/** Add extra rollout
 */
function addSubRollouts subrollouts:1 rollouts:1 =
(
	
	/* DEFINE ROLLOUTS SLOTS */ 
	for s = 1 to subrollouts do
	(
		SubRollouts = _Rollout.subrollouts()
		
		/* DEFINE SUBROLLOUTS */ 
		for r = 1 to rollouts do
		(
			_SubRollout	= SubRollouts.new ( s as string + (counter_subrollouts += 1) as string )
			
			/* DEFINE GROUPBOX */ 
			for g = 1 to r do -- every rollout has 1 groupbox more then before
			(
				Controls    = _SubRollout.Controls.new groupbox:("Groupbox " + r as string +"" + (counter_groupboxes += 1) as string)
				
				/* DEFINE CONTROLS */ 
				for c = 1 to r do
					Controls.button ("Button " + s as string +"" + r as string +""+ counter_groupboxes as string +"" + c as string )
			)
		)
	)
)





/*------------------------------------------------------------------------------
	RUN TESTS
--------------------------------------------------------------------------------*/

layoutSetup()

addControls    groupboxes:1
addSubRollouts subrollouts:2 rollouts:1
addControls    groupboxes:1
addSubRollouts subrollouts:1 rollouts:3


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) height:720

/* ADD SUBROLLOUTS */ 
_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

_Rollout.Layout.fitSubrollouts()

_Rollout.setRolloutWidth()