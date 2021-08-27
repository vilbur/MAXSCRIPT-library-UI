clearListener()


/** Generate methods for control types above
 * 
 * Control Types: http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_E421933F_958E_42FD_80A1_D66F2A2C0A06_htm
 * 
 * @return	generated method returns object of new Control
 * Generate method like this:
 *			function caption button width:64 =
 *			(
 *				Button_v caption:caption ControlBox:groupbox_global[1] init_parameters: #(#(#width), #(64)) -- return
 *			)
 *
 */
function writeControlTypesFile =
(
	file_content = ""
	--print ("------------\n ControlBox.writeControlTypesFile()" + Groupbox.id.id as string )
	control_types	= #( #button, #spinner, #edittext, #browsePath, #checkbox)
	--control_types	= #( #spinner, #edittext, #browsePath, #checkbox)
	
	param_custom = #( #columns )  
	param_shared = #( #toolTip )  
	param_common = #( #pos, #height, #width, #align, #offset, #across )  -- http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_EA37E7DB_1E74_4377_B3D8_EDAE19CE27E7_htm
	
	params_by_type	= #(#( #images, #border )                                                                 -- button
		   ,#( #range, #type, #scale, #fieldwidth, #Indeterminate, #controller, #setKeyBrackets ) -- spinner
		   ,#( #fieldwidth, #text, #bold, #labelOnTop, #readOnly )                                -- edittext
		   ,#( #fieldwidth, #initialDir )                                                         -- path
		   ,#( #checked, #triState ))                                                             -- checkbox

	params_all = param_custom + param_common + param_shared
	
	for i = 1 to control_types.count do
	(
		params_keys = params_all + params_by_type[i]
		
		params_values         = "#"+(( dotNetObject "System.Text.RegularExpressions.Regex" @"#" ).Replace        ( params_keys as string ) "")  -- strip array to string:       "columns, pos, height, width, ..."
		params_array_stripped =     (( dotNetObject "System.Text.RegularExpressions.Regex" @"[#\(\)]+" ).Replace ( params_keys as string ) "")  -- strip array to string:       "columns, pos, height, width, ..." 
		params_passed         =     (( dotNetObject "System.Text.RegularExpressions.Regex" @",|$" ).Replace      ( params_array_stripped) ":") -- add colon ":" to parameters: "columns: pos: height: width: ..." 
		--format "params_keys   = % \n" params_keys
		--format "params_values = % \n" params_values
		
		params_matrix = "#(" +params_keys as string + ", " + params_values + ")" 
		
		file_content += "/*\n*/\nfunction "+control_types[i] as string +" caption id: "+params_passed+" =
(
	" +control_types[i] as string +"_v id:id caption:caption ControlBox:this init_parameters:" + params_matrix + "
),\n\n"
			
	
	--file_content += "Twas brillig and the slithy tobes
	--				did gyre and gimbol in the wabe
	--				or something like that..."
	
	
	
	)
	
	f = (createFile (getFilenamePath(getSourceFileName()) + "..\\ControlBoxControlTypes.ms") )

	format file_content to:f
	
	
	close f
	
)


writeControlTypesFile()
