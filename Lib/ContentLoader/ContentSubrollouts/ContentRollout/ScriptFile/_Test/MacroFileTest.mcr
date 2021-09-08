--/*
--*/
--macroscript MacroFileTest_A
--	category:	"MacroFileTest"
--	buttontext:	"MacroFileTest A"
--	toolTip:	"Tooltip with Colon:\nand new line"
--	icon:	"#(path, index)"
--(
--	
--)
	
/*
*/
macroscript MacroFileTest_B_1
	category:	"MacroFileTest"
	buttontext:	"Same Button"
	toolTip:	"LeftClick"
	icon:	"#(path, index)"
(
	print "LeftClickTest"
)

/*
*/
macroscript MacroFileMacroFileTest_B_2
	category:	"MacroFileTest"
	buttontext:	"Same Button"
	toolTip:	"RightClick"
	icon:	"#(path, index)"
(
	print "RightClickTest"
)

--/*
--*/
--macroscript macroFileTest_cotrol_button
--	category:	"MacroFileTest"
--	buttontext:	"Button"
--	toolTip:	"Left click tooltip"
--	--icon:	"border:false"
--	icon:	"border:false"
--(
--	print "Button #pressed"
--)

--/*
--*/
--macroscript macroFileTest_cotrol_button_right
--	category:	"MacroFileTest"
--	buttontext:	"Button"
--	toolTip:	"Right click tooltip"
--(
--	print "Button #rightclick"
--)
--	
--/*
--*/
--macroscript macroFileTest_checkbox
--	category:	"MacroFileTest"
--	buttontext:	"Checkbox"
--	toolTip:	"Changed event tooltip"
--	icon:	"type:checkbox|checked:true|border:false|columns:12"
--(
--	print "checkbox #changed"
--)
--
--/*
--*/
--macroscript macroFileTest_checkbox_right
--	category:	"MacroFileTest"
--	buttontext:	"Checkbox"
--	toolTip:	"Right click tooltip"
--(
--	print "checkbox #rightclick"
--)