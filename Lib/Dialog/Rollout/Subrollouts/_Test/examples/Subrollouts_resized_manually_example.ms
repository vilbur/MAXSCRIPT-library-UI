rollout roll "roll"
(
  spinner spinner_main_1 "spinner_main_1"

  --subrollout slot_1 "subrollout1"
  subrollout slot_1 "subrollout1" width:32
  --subrollout roll3 "roll3"
  --spinner spinner_main_2 "spinner_main_2"
  
  --subrollout slot_2 "subrollout2"
)

rollout subrollout1 "subrollout 1 title"
(
  --spinner spinner_1 "spinner_1"
  --spinner spinner_12 "spinner_1"
)

rollout subrollout2 "subrollout 2  title"
(
  spinner spinner_2 "spinner_2"
)

rollout subrollout3 "subrollout 3  title"
(
  spinner spinner_3 "spinner_3"
)

CreateDialog roll


AddSubRollout roll.slot_1 subrollout1



roll.height = 512

roll.slot_1.height = 128
roll.slot_1.width = 128

messageBox "Yupiii" beep:false

RemoveSubRollout roll.slot_1 subrollout1

messageBox "Yupiii" beep:false

AddSubRollout roll.slot_1 subrollout1

--subrollout1.width = 128

--cui.RegisterDialogBar	roll style:#(#cui_dock_left,#cui_dock_right,#cui_floatable,#cui_handles)
