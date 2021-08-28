public

/** Add to ui
*/
function addToUi =
(
	--format "\n"
	print ("ControlAddToUi.ms.addToUi() " + id.id )
	format "_Parameters.join() = % \n" (_Parameters.join())
    ControlBox.Parent_roll.RolloutCreator.addControl type id.id caption (_Parameters.join())
),
