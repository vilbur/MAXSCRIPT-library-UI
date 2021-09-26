clearListener()


/** Generate methods for control types above
 * 
 * Control Types: https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_E421933F_958E_42FD_80A1_D66F2A2C0A06_htm
 * 
 * @return	generated method returns object of new Control
 * Generate method like this:
 *			function caption button width:64 =
 *			(
 *				Button_v caption:caption ControlBox:GROUPBOX_GLOBAL[1] init_parameters: #(#(#width), #(64)) -- return
 *			)
 *
 */
function writeControlTypesFile =
(
	file_path = getFilenamePath(getSourceFileName()) + "..\\ControlBoxControlTypes.ms"
	
	file_content = ""
	--print ("------------\n ControlBox.writeControlTypesFile()" + Groupbox.id.id as string )
	control_types	= #( #label, #button, #checkbox, #spinner, #edittext, #checkbutton, #browsePath )
	
	
	param_custom = #( #columns )  
	param_shared = #( #toolTip )  
	param_common = #( #pos, #height, #width, #align, #offset, #across )  -- http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_EA37E7DB_1E74_4377_B3D8_EDAE19CE27E7_htm
	
	params_by_type	= #(
			#( #images, #border )                                                                 -- button
		   ,#( #style_sunkenedge )                                                                -- label
		   
		   /* Default controls with kind of "value" parameter */ 
		   ,#( #checked,#triState )                                                               -- checkbox	
		   ,#( #range,  #type, #scale, #fieldwidth, #Indeterminate, #controller, #setKeyBrackets )-- spinner	https://help.autodesk.com/view/3DSMAX/2017/ENU/?guid=__files_GUID_E421933F_958E_42FD_80A1_D66F2A2C0A06_htm
		   ,#( #text,   #fieldwidth, #bold, #labelOnTop, #readOnly )                              -- edittext	
		   ,#( #checked,#highlightColor, #images )                                                -- checkbutton	https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_084BC777_9353_455E_A869_9F5C514E0CE6_htm
		   
		   /* Custom compounded controls */ 
		   ,#( #text,   #fieldwidth, #initialDir )                                                -- browsePath
		 )

	params_defaults = param_custom + param_common + param_shared
	
	--params_all = #()
	--
	--for param_by_type in params_by_type do 
	--	params_all += param_by_type
	
		
	--params_by_type = join #(makeUniqueArray params_all) params_by_type
	--format "params_by_type = % \n" params_by_type
	
	for i = 1 to control_types.count do
	(
		format "control_types[i] = % \n" control_types[i]
		format "params_by_type[i] = % \n" params_by_type[i]
		
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
		
	
		params_matrix = "#(#(" + params_keys + "), #(" + params_values + "))" -- wrap matrix #( #(), #()) 
		
		file_content += "/*\n*/\nfunction "+control_types[i] as string +" caption id: "+params_passed+" =
(
	" +control_types[i] as string +"_v id:id caption:caption add_to_controls:add_to_controls ControlBox:this init_parameters:" + params_matrix + "
),\n\n"
			
	
	)
	
	f = (createFile file_path )

	format file_content to:f
	
	
	close f
	
	print ("\nwriteControlTypesFile to file " + file_path + "\n\nSUCCESS")
)

writeControlTypesFile()