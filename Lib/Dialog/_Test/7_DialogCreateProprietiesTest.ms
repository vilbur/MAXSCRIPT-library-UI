clearListener()
--
--filein( getFilenamePath(getSourceFileName()) + "/../Dialog.ms" )
--
--
--Dialog	= Dialog_v title:(getFilenameFile(getSourceFileName()))
--format "Dialog = % \n" Dialog
--
--Rollouts_1 = Dialog.rollouts()
--
--Rollout_A	= Rollouts_1.new "Rollout A"
--
--Controls = Rollout_A.Controls.new  groupbox:"Groupbox 2"
--
--
--Controls.checkbox	"Test"
--Controls.button	"Test"
--Controls.label	"Test"
--
--/*------ CREATE FLOATER DIALOG ------*/
----Dialog.create()
--Dialog.create pos:[0,0] width:512 height:512 bgcolor:(color 128 128 128) fgcolor:red style:#(#style_resizing)
----Dialog.create pos:[0,0] width:512 height:512 bgcolor:(color 128 128 128) fgcolor:red 
--

rollout roll_test "test" (
	dotNetControl dnc_label "Windows.Forms.Label"

	on roll_test open do (
		dnc_label.text = "Hello World"
		local bkgCol = yellow
		dnc_label.ForeColor  = (dotNetClass "System.Drawing.Color").fromArgb bkgCol.r bkgCol.g bkgCol.b
	)
)
createDialog roll_test