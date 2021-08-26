macroscript macro_test
	category:	"_macrotest"
	buttontext: "Macro test"
	toolTip:	"Test tooltip"
	icon:	"#(path, index)"
(
	messagebox "Macro Test \n\nSUCCESS";
)
	
	
	
	
/** EXAMPLE OF LEFT \RIGHT CLICK BUTTON 
 *	
 *	Both has same buttontext
 *	
 *	First  is left  click
 *	Second is right click
 */

macroscript macro_left_click_test
	category:	"_macrotest"
	buttontext: "Left\Right click" 
	toolTip:	"Button generated"
	icon:	"#(path, index)"
(
	messagebox "If exists more then one macro with same \"buttontext\" property \n\nthen next macro will be added as rightclick"
)

macroscript  macro_right_click_test
	category:	"_macrotest"
	buttontext: "Left\Right click" 
	toolTip:	"From macro"
	icon:	"#(path, index)"
(
	messagebox "Right click on button"
)
	




/** TEST OF COMMENTED MACROSCRIPT  
 *	
 *	IMPORTANT:
 *		Don`t use block comment !
 *		Only inline comment works for MacroScriptParser_v
 */
--macroscript  macro_comented
--	category:	"_macrotest"
--	buttontext: ""
--	toolTip:	""
--	icon:	""
--(
--)