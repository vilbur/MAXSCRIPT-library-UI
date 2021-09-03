/*
*/
macroscript macroFileTest_cotrol_button
	category:	"MacroFileTest"
	buttontext:	"Button"
	toolTip:	"Left click tooltip"
	icon:	"border:false"
(
	print "Button #pressed"
)

/*
*/
macroscript macroFileTest_cotrol_button_right
	category:	"MacroFileTest"
	buttontext:	"Button"
	toolTip:	"Right click tooltip"
(
	print "Button #rightclick"
)
	
/*
*/
macroscript macroFileTest_checkbox
	category:	"MacroFileTest"
	buttontext:	"Checkbox"
	toolTip:	"Changed event tooltip"
	icon:	"type:checkbox|checked:true|border:false"
(
	print "checkbox #changed"
)

/*
*/
macroscript macroFileTest_checkbox_right
	category:	"MacroFileTest"
	buttontext:	"Checkbox"
	toolTip:	"Right click tooltip"
(
	print "checkbox #rightclick"
)