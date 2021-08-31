/*
*/
macroscript MacroFileTest_A
	category:	"MacroFileTest"
	buttontext:	"MacroFileTest A"
	toolTip:	"Tooltip with Colon:\nand new line"
	icon:	"#(path, index)"
(
	
)
	
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