clearListener()

filein( getFilenamePath(getSourceFileName()) + "/../../../../../Rollout.ms" )

global _Rollout	  = Rollout_v title:(filenameFromPath(getSourceFileName()))
global Controls     = _Rollout.Controls.new()
--global Controls     = _Rollout.Controls.new groupbox:"Controls 1"
global btn_props    = Controls.button "Button Properties"
--global btn_props_2    = Controls.button "Button Properties 2"
--global btn_props    = Controls.button "Button Properties" height:32 border:false
--global btn_props    = Controls.button "Button Properties" columns:6 height:32 border:false
--global btn_props    = Controls.button "Button Properties" border:false
--global _spinner     = Controls.spinner "Spinner" scale:10

--btn_props.params  border:false
format "btn_props = % \n" btn_props
--format "btn_props.caption = % \n" btn_props.caption
--format "btn_props_2.caption = % \n" btn_props_2.caption

--format "Controls.Controls = % \n" Controls.Controls

/* CREATE ROLLOUT */
_Rollout.createRollout()

/* CREATE DIALOG */
CreateDialog ( _Rollout.RolloutCreator.getDefinition() )

_Rollout.setRolloutWidth()



--
--/** Test
-- */
--struct Test
--(
--	method,
--	
--	
--	/** Init
--	 */
--	function init =
--	(
--		this.method = fn test = (messageBox "Yupiii" beep:false)
--	)
--	
--	
--	on create do
--	(
--		this.init()
--	)
--	
--)
--
--
--_Test = Test()
--
----_Test.method()