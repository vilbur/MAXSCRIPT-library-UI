


filename = getFilenameFile(getSourceFileName())

_rollout	= __GLOBAL__v.dialog.roll ("Rollout " +filename ) ""

_controls	= _rollout.controls groupbox:("Groupbox "+filename) -- get new container for controls

_controls.button "Button from script"
