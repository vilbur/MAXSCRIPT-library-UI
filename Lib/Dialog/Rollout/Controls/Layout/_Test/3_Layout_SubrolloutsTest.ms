clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../Rollout.ms" )


/* ROLLOUT DEFINITION */
global _Rollout	= Rollout_v title:(filenameFromPath(getSourceFileName()))

--
--/** Add extra rollout
-- */
--function addRolloutByCodeTest =
--(
--	/* DEFINE SLOTS FOR ROLLOUTS */ 
--	Rollouts_1 = _Rollout.subrollouts()
--	Rollout_A	= Rollouts_1.new "Rollout A"
--	Rollout_B	= Rollouts_1.new "Rollout B"
--
--	for _Rollout in #(Rollout_A) do 
--		for g = 1 to 3 do
--		(
--			Controls    = _Rollout.Controls.new groupbox:("Groupbox " + g as string)
--			
--			for i = 1 to 4 do
--				Controls.button ("Button "+g as string +"."+i as string )
--		)
--		
--)

/** Add extra rollout
 */
function addControls =
(
	/* DEFINE SLOTS FOR ROLLOUTS */
	for g = 1 to 1 do
	(
		Controls    = _Rollout.Controls.new groupbox:("Groupbox " + g as string)
		
		for i = 1 to g do
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



--addSubRollouts()
addControls()
addSubRollouts subrollouts:2


/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) width:512 height:512

/* ADD SUBROLLOUTS */ 
_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

_Rollout.fitSubrollouts()