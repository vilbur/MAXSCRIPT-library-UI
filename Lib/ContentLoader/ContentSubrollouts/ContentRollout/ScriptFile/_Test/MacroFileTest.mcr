/*
*/
macroScript MacroFileTest_A
	category:	"MacroFileTest"
	buttontext:	"MacroFileTest A"
	toolTip:	"Test Tooltip"
	icon:	"#(path, index)"
(
	
)
	
/*
*/
macroScript MacroFileTest_B_1
	category:	"MacroFileTest"
	buttontext:	"Same Button"
	toolTip:	"LeftClick"
	icon:	"#(path, index)"
(
	print "LeftClickTest"
)

/*
*/
macroScript MacroFileMacroFileTest_B_2
	category:	"MacroFileTest"
	buttontext:	"Same Button"
	toolTip:	"RightClick"
	icon:	"#(path, index)"
(
	print "RightClickTest"
)