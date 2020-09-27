/** DIALOG ROLLOUT 
 */
rci = rolloutCreator "main_rollout_creator" "Dialog Rollout" height:256

rci.begin()

rci.addControl #button #dialog_button_1 "Dialog Button 1"
 
rci.addText( "subrollout slot_1 \"subrollout1\" height:256")

rci.addControl #button #dialog_button_2 "Dialog Button 2"

rci.end()


/** ROLLOUT 1 
 */
--rci_sub = rolloutCreator "subrollout_1" "My Rollout" width:400 height:256
rci_sub = rolloutCreator "subrollout_1" "My Rollout 1"

rci_sub.begin()

rci_sub.addControl #button #myButton "My Button"

rci_sub.addHandler #myButton #pressed filter:on codeStr:"MessageBox @Isn't this cool@ title:@Wow@"

rci_sub.end()


/** ROLLOUT 2 
 */
--rci_sub = rolloutCreator "subrollout_1" "My Rollout" width:400 height:256
rci_sub_2 = rolloutCreator "subrollout_2" "My Rollout 2"

rci_sub_2.begin()

rci_sub_2.addControl #button #myButton "My Button"

rci_sub_2.addHandler #myButton #pressed filter:on codeStr:"MessageBox @Isn't this cool@ title:@Wow@"

rci_sub_2.end()



/* CREATE DIALOG */ 
CreateDialog rci.def height:312

AddSubRollout main_rollout_creator.slot_1 rci_sub.def	rolledUp:false
AddSubRollout main_rollout_creator.slot_1 rci_sub_2.def	rolledUp:false