/*
*/
macroscript macroFileTest_cotrol_button
	category:	"MacroFileTest"
	buttontext:	"Button"
	toolTip:	"Basic type of control"
	--icon:	"#(path, index)"
	--icon:	#("Cameras",2)
	icon:	"border:false"
(
	print "Button X"

)

/*
*/
macroscript macroFileTest_checkbox
	category:	"MacroFileTest"
	buttontext:	"Checkbox"
	toolTip:	"Checkbox type of control"
	--icon:	"#(path, index)"
	--icon:	"type:checkbox"
	icon:	"type:checkbox|checked:true|border:false"
(
	print "checkbox X"
)