
macroscript macro_left_click_test
category:	"_macrotest"
buttontext:	"Left\Right click"
toolTip:	"Tooltip button pressed"
--icon:	"#(path, index)"
(
	--messagebox "Left click on button"
	messagebox "If exists more then one macro with same \"buttontext\" properity \n\nthen next macro will be added as rightclick"
)

macroscript macro_right_click_test
category:	"_macrotest"
buttontext:	"Left\Right click"
toolTip:	"Tooltip button rightclick"
--icon:	"#(path, index)"
(
	messagebox "Right click on button"
)