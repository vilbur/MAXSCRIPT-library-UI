/*
*/
--macroscript macroFileTest_cotrol_button
--	category:	"MacroFileTest"
--	buttontext:	"Button"
--	toolTip:	"Basic type of control"
--	--icon:	"#(path, index)"
--	--icon:	#("Cameras",2)
--(
--	
--)

/*
*/
macroscript macroFileTest_checkbox
	category:	"MacroFileTest"
	buttontext:	"Checkbox"
	toolTip:	"Checkbox type of control"
	--icon:	"#(path, index)"
	icon:	"type:checkbox"
	--icon:	"type:checkbox|checked:true"
(
	print "checkbox"
)