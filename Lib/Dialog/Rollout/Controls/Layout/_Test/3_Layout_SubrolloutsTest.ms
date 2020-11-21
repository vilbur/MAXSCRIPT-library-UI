clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout.ms" )


/* ROLLOUT DEFINITION */
global _Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))

/** Layout setup
 */
function layoutSetup =
(
	_Rollout.Layout.columns  = 16
	_Rollout.Layout.grid     = 48
	
	_Rollout.Layout.padding  = 16
	_Rollout.Layout.margin.x = 8
	_Rollout.Layout.margin.y = 16
)

/** Add extra rollout
 */
function addControls groupboxes:1 =
(
	/* DEFINE SLOTS FOR ROLLOUTS */
	for g = 1 to groupboxes do
	(
		Controls    = _Rollout.Controls.new groupbox:("Groupbox " + g as string)
		
		for i = 1 to g + 4 do
			Controls.button ("Button "+g as string +"."+i as string )
	)
)

/** Add extra rollout
 */
function addSubRollouts subrollouts:1 =
(
	
	/* DEFINE ROLLOUTS SLOTS */ 

	for s = 1 to subrollouts do
	(
		SubRollouts = _Rollout.subrollouts()
		
		/* DEFINE SUBROLLOUTS */ 
		for r = 1 to 2 do
		(
			_SubRollout	= SubRollouts.new ( s as string + r as string )
			
			/* DEFINE GROUPBOX */ 
			for g = 1 to 3 do
			(
				Controls    = _SubRollout.Controls.new groupbox:("Groupbox " + r as string +"" + g as string)
				
				/* DEFINE CONTROLS */ 
				for c = 1 to 4 do
					Controls.button ("Button " + s as string +"" + r as string +""+ g as string +"" + c as string )
			)
		)
	)
)



/*------------------------------------------------------------------------------
	RUN TESTS
--------------------------------------------------------------------------------*/

--layoutSetup()

addControls groupboxes:3
--addSubRollouts()

--addSubRollouts subrollouts:2


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:640 height:512

/* ADD SUBROLLOUTS */ 
_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

_Rollout.fitSubrollouts()