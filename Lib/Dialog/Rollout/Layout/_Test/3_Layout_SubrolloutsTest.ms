clearListener()


filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/* ROLLOUT DEFINITION */
global _Rollout = Rollout_v title:(filenameFromPath(getSourceFileName()))


global counter_subrollouts = 0
global counter_rollouts    = 0
global counter_groupboxes  = 0
global counter_controls    = 0

/** Layout setup
  * Make UI big
 */
function layoutSetup columns: grid: padding: marginx: marginy:  =
(
	_Rollout.Layout.columns  = columns
	_Rollout.Layout.grid     = grid
	
	_Rollout.Layout.padding  = padding
	_Rollout.Layout.margin.x = marginx
	_Rollout.Layout.margin.y = marginy
)

/** Add extra rollout
 */
function addControls _Rollout groupboxes:1 =
(
	/* DEFINE SLOTS FOR ROLLOUTS */
	for g = 1 to groupboxes do
	(
		Controls = _Rollout.Controls.new groupbox:("Groupbox " + (counter_groupboxes += 1) as string )
		
		for i = 1 to g + 1 do
			Controls.button ("Button "+counter_groupboxes as string +"."+i as string )
	)
)

/** Add extra rollout
 */
function addSubRollouts _Rollout subrollouts:1 rollouts:1 =
(
	
	/* DEFINE ROLLOUTS SLOTS */ 
	for s = 1 to subrollouts do
	(
		SubRollouts = _Rollout.subrollouts()
		
		/* DEFINE SUBROLLOUTS */ 
		for r = 1 to rollouts do
		(
			_SubRollout	= SubRollouts.new ( s as string + (counter_subrollouts += 1) as string )
			
			addControls _SubRollout groupboxes:2
		)
	)
)

/** Add neste sub rollouts
 */
function addNesteSubRollouts _Rollout =
(
	
	/* DEFINE ROLLOUTS SLOTS */ 
	for s = 1 to 1 do
	(
		SubRollouts = _Rollout.subrollouts()
		
		/* DEFINE SUBROLLOUTS */ 
		for r = 1 to 1 do
		(
			_SubRollout	= SubRollouts.new ( s as string + "." + (counter_subrollouts += 1) as string )
			
			--addControls _SubRollout groupboxes:2
			--
			--SubRolloutsNested = _SubRollout.subrollouts()
			--
			--SubRolloutsNested.height = 256
			--
			--SubRolloutNested	= SubRolloutsNested.new ( s as string + "." + (counter_subrollouts += 1) as string )
			addControls _SubRollout groupboxes:4
			--
			if( counter_subrollouts < 3 ) then 
				addNesteSubRollouts _SubRollout
			
		)
	)
)
	
	

/*------------------------------------------------------------------------------
	RUN TESTS
--------------------------------------------------------------------------------*/

--layoutSetup columns:16 grid:48 padding:16 marginx:32 marginy:16
--layoutSetup columns:12 grid:16 padding:2 marginx:64 marginy:6





--addControls    _Rollout groupboxes:1
--addSubRollouts _Rollout subrollouts:1 rollouts:3
--addControls    _Rollout groupboxes:1
--addSubRollouts _Rollout subrollouts:3 rollouts:2

addNesteSubRollouts _Rollout


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) height:1024 width:512


/* ADD SUBROLLOUTS */ 
_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

--_Rollout.Layout.fitSubrollouts()

--_Rollout.setRolloutWidth()