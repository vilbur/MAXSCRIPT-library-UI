
/*------------------------------------------------------------------------------
	BUTTON
--------------------------------------------------------------------------------*/
macroscript MacroFileTest_A
	category:	"MacroFileTest"
	buttontext:	"MacroFileTest A"
	toolTip:	"Tooltip with Colon:\nand new line"
	icon:	"#(path, index)"
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

/* CHECKBOX 
*/ 
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
	
/* CHECKBUTTON 
*/ 
macroscript macroFileTest_checkbutton
	category:	"MacroFileTest"
	buttontext:	"Checkbutton"
	toolTip:	"Checkbutton tooltip"
	icon:	"type:checkbutton|highlightColor:(color 50 150 30)"
(
	print "Checkbutton #test"
	format "EventFired = % \n" EventFired.type
)

/* CHECKBUTTON 
*/ 
macroscript macroFileTest_checkbutton
	category:	"MacroFileTest"
	buttontext:	"Listbox test"
	toolTip:	"Listbox tooltip"
	icon:	"type:Listbox|items:#( 'item 1', 'item 2', '3' )|selection:2"
(


) 