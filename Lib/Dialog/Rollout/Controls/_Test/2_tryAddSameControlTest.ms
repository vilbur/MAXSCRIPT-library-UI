clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )



/* ROLLOUT DEFINITION */
_Rollout	= Rollout_v title:(getFilenameFile(getSourceFileName()))

/* DEFINE SLOTS FOR ROLLOUTS */ 
Rollouts_1 = _Rollout.subrollouts()

--format "Rollouts_1 = % \n" Rollouts_1
--Rollouts_2 = _Rollout.subrollouts()


/* DEFINE ROLLOUTS */ 
Rollout_A	= Rollouts_1.new "Rollout A"
Rollout_B	= Rollouts_1.new "Rollout B"
Rollout_C	= Rollouts_1.new "Rollout B"


controls_A    = Rollout_A.Controls.new groupbox:"Groupbox Test"
controls_B    = Rollout_B.Controls.new groupbox:"Groupbox Test"



controls_A.button "Same button"
controls_A.button "Same button"

controls_B.button "Same button"





/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() ) height:256 

/* ADD SUBROLLOUTS */ 
_Rollout.addSubRollouts() -- dialog must exist for adding subrollouts

Rollouts_1.property #height 232 