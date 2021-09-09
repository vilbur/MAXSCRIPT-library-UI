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
	file_path = getFilenamePath(getSourceFileName()) + "..\\ControlBoxControlTypes.ms"
	
	file_content = ""
	--print ("------------\n ControlBox.writeControlTypesFile()" + Groupbox.id.id as string )
	control_types	= #( #button, #spinner, #edittext, #browsePath, #checkbox, #checkbutton );
	
	param_custom = #( #columns )  
	param_shared = #( #toolTip )  
	param_common = #( #pos, #height, #width, #align, #offset, #across )  -- http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_EA37E7DB_1E74_4377_B3D8_EDAE19CE27E7_htm
	
	params_by_type	= #(
			#( #images, #border )                                                                 -- button
		   ,#( #range, #type, #scale, #fieldwidth, #Indeterminate, #controller, #setKeyBrackets ) -- spinner
		   ,#( #fieldwidth, #text, #bold, #labelOnTop, #readOnly )                                -- edittext
		   ,#( #fieldwidth, #initialDir )                                                         -- path
		   ,#( #checked, #triState )                                                              -- checkbox
		   ,#( #checked, #highlightColor, #images )                                               -- checkbutton	https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_084BC777_9353_455E_A869_9F5C514E0CE6_htm
		 )

	params_defaults = param_custom + param_common + param_shared
	
	params_all = #()
	
	for param_by_type in params_by_type do 
		params_all += param_by_type
	
		
	params_by_type = join #(makeUniqueArray params_all) params_by_type
	
	for i = 1 to control_types.count do
	(

		params_keys_array = params_defaults + params_by_type[i]
		
		
		params_passed = ""
		params_keys   = ""
		params_values = ""
		
		for _param in params_keys_array do 
			params_passed += _param as string + ": "
		
		for _param in params_keys_array do 
			params_keys += "#" + _param as string + ", "
		
		for _param in params_keys_array do 
			params_values += _param as string + ", "
		
		params_keys	=  trimRight params_keys ", "
		params_values	=  trimRight params_values ", "
		
		--params_values         = "#"+(( dotNetObject "System.Text.RegularExpressions.Regex" @"#"        ).Replace ( params_keys ) "")  -- strip array to string:       "columns, pos, height, width, ..."
		--params_array_stripped =     (( dotNetObject "System.Text.RegularExpressions.Regex" @"[#\(\)]+" ).Replace ( params_keys ) "")  -- strip array to string:       "columns, pos, height, width, ..." 
		--params_passed         =     (( dotNetObject "System.Text.RegularExpressions.Regex" @",|$"      ).Replace ( params_array_stripped) ":") -- add colon ":" to parameters: "columns: pos: height: width: ..." 
		--format "\nparams_keys   = % \n" params_keys
		--format "params_keys = % \n" params_keys
		--format "params_values = % \n" params_values
		--format "params_passed = % \n" params_passed
	
		
		params_matrix = "#(#(" + params_keys + "), #(" + params_values + "))" -- wrap matrix #( #(), #()) 
		
		file_content += "/*\n*/\nfunction "+control_types[i] as string +" caption id: "+params_passed+" =
(
	" +control_types[i] as string +"_v id:id caption:caption ControlBox:this init_parameters:" + params_matrix + "
),\n\n"
			
	
	)
	
	f = (createFile file_path )

	format file_content to:f
	
	
	close f
	
	print ("\nwriteControlTypesFile to file " + file_path + "\n\nSUCCESS")
)

writeControlTypesFile()