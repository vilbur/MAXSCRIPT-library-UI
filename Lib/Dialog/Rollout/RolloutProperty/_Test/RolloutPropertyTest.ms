clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../Rollout.ms" )

/* ROLLOUT DEFINITION */
_Rollout_Dialog	= Rollout_v title:(getFilenameFile(getSourceFileName()))

Subrollouts_A = _Rollout_Dialog.subrollouts()

Rollout_A = Subrollouts_A.new   "Rollout A"
Rollout_B = Subrollouts_A.new   "Rollout B"


/* CREATE ROLLOUT */
_Rollout_Dialog.createRollout()	-- create with default parameters

/* CREATE DIALOG */
CreateDialog ( _Rollout_Dialog.RolloutCreator.getDefinition() )
_Rollout_Dialog.addSubRollouts()


Rollout_A.open false


/* Test properties with default maxscript */
--print ( rollout_property_test.title as String )

--rollout_property_test.default_slot.rollout_subrollout_a.title  = "Renamed rollout manually"

--Rollout_A.Property.title "Renamed rollout"

--print ( (Rollout_A.Property._getPropertyString #title) as String )

Rollout_A.Property.title "Property Test"

--rollout_property_test.default_slot.rollout_subrollout_a.title = "New title" 
--execute ( "rollout_property_test.default_slot.rollout_subrollout_a.title = \"New title\"")