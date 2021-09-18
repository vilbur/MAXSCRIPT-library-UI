
/*------------------------------------------------------------------------------
	BUTTON
--------------------------------------------------------------------------------*/
macroscript MacroFileTest_A
	category:	"MacroFileTest"
	buttontext:	"MacroFileTest A"
	toolTip:	"Tooltip with Colon:\nand new line"
	--icon:	"#(path, index)"
(
	
)


/*------------------------------------------------------------------------------
  LEFT RIGHT CLICK TEST
--------------------------------------------------------------------------------*/	

/*
*/
macroscript macroFileTest_cotrol_button
	category:	"MacroFileTest"
	buttontext:	"Button"
	toolTip:	"Left click tooltip"
	--icon:	"border:false"
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
	

/*------------------------------------------------------------------------------
  CONTROL TYPES
--------------------------------------------------------------------------------*/	

macroscript macroFileTest_checkbox
	category:	"MacroFileTest"
	buttontext:	"Checkbox"
	toolTip:	"Changed event tooltip"
	icon:	"type:checkbox|checked:true|border:false|columns:12"
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
	
/*
*/
macroscript macroFileTest_checkbutton
	category:	"MacroFileTest"
	buttontext:	"Checkbutton"
	toolTip:	"Checkbutton tooltip"
	icon:	"type:checkbutton|highlightColor:(color 50 150 30)"
	--icon:	"type:checkbutton"
(
	print "Checkbutton #test"
	format "EventFired = % \n" EventFired.type
) 