clearListener()
filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )


/* ROLLOUT DEFINITION */
_Rollout_Dialog	= Rollout_v title:(getFilenameFile(getSourceFileName()))

Subrollouts_A = _Rollout_Dialog.subrollouts()

Rollout_A = Subrollouts_A.new   "Rollout A"

/* CREATE ROLLOUT */
_Rollout_Dialog.createRollout()	-- create with default parameters

/* CREATE DIALOG */
CreateDialog ( _Rollout_Dialog.RolloutCreator.getDefinition() )
_Rollout_Dialog.addSubRollouts()



/* TEST PROPERTIES */ 
Rollout_A.property title:"Property Test" open:false height:128