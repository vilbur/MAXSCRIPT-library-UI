/** Control Params http://help.autodesk.com/view/3DSMAX/2016/ENU/?guid=__files_GUID_EA37E7DB_1E74_4377_B3D8_EDAE19CE27E7_htm
  * 
  * @method	propertySet	Set any property to rollout
  * 
 */
struct Params_v
(
	--__construct = #(#Parent_Control),
	
	/* reference */
	
	--Parent_Control,
	
	List	= List_v(),

	/** Set any property to rollout
	  * According to Rollout Properties: https://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_DC435555_362D_4A03_BCF2_21179C5442F2_htm
	  *
	  * @property	#(#name)	keys	of properties
	  * @property	#("value", #get)	values	of properties, to get values set value to #get
	 */
	function setParams keys values =
	(
		--format "Params_v.setParams % \n" values
		suplied_parameters = this._filterUnsuppliedParameters keys values
		
		List.keys   += suplied_parameters.keys
		List.values += suplied_parameters.values
	),
	
	/** Filter unsupplied parameters
	  * Return only supplied parameters
	  *
	  * @param	array keys array of keys
	  * @param	array keys array of values
	  *
	  * @return	matrix #( #(parameter_names), #(parameter_values ))		
	  *
	  * @example
	  *     function foo param_1: param_2: =
	  *		(
	  *			param_name_and_value = this._filterUnsuppliedParameters #(#param_1, #param_2) #(unsupplied, "value_2") 
	  *			-- return #( #(#param_2), #("value_2") )
	  * 	)
     */
    function _filterUnsuppliedParameters keys values =
    (
		keys_values = List_v()
		
		for i = 1 to values.count  where not ( values[i] == unsupplied ) do
			keys_values.setVal keys[i] values[i]

		keys_values --return
    ),
	
	/** Join array
	 */
	function join =
	(
		--print "------------\nParams_v.join()"
		_params = ""
		
		for k=1 to List.keys.count do
			_params = _params + " " + List.keys[k] +":"+ List.values[k] as string
		
		--format " _params	= % \n" _params
		_params --return
	),

	/** Check if required properties are defined
	  * Names of construct props are defined in __construct array E.g.: __construct = #( #prop_name ) 
	  * @param	construct_properties this.properties required for initialization of struct
	 */
	function _checkConstctructProperties =
	(
		for prop in __construct where getProperty this prop == undefined do
			messageBox ("Undefined construct property !\n\n"+ ((filterString( classof this as string )"(:")[2]) +"."+ prop )
	),
	on create do
	(
		--this._checkConstctructProperties()
		format "Params_v.onCreate()"
	)
)