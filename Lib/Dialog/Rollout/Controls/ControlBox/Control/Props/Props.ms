filein( getFilenamePath(getSourceFileName()) + "/../../../../../../List/List.ms" )

/** Control Properties
  * http://help.autodesk.com/view/3DSMAX/2015/ENU/?guid=__files_GUID_3880D745_8496_4DFB_8B31_4DEAC152DBB3_htm
  *
 */
struct Props_v
(
	Control,

	Params	= List_v(),

	/** Add value
	 */
	function add param value force:true =
	(
		--print ("------------\nProps.add param:"+param as string + " value:" + value as string)
	
		--if( force == true or this.get param == undefined ) then  
			Params.setVal param value
		
		if ( Control.exists() ) then
			this.applyProp param value
		
		this --return
	),
 
	/** Set dimensions
     */
    function setDimensions Dimensions =
    (
		this.add #pos    Dimensions.pos    force:true
		this.add #width  Dimensions.width  force:true
		this.add #height Dimensions.height force:true
    ),
	
	/** Get value of parameter
	 */
	function get param =
	(
		if not ( Control.exists() ) then
			Params.getVal param -- return
			
		else
			this.getProp param
		--format "this.getProp param = % \n" (this.getProp param)
		--"Test"
	),

	/** Remove
	 */
	function remove param =
	(
		Params.delete param
		
		this
	),
	
	/** Join array
	 */
	function join =
	(
		--print "------------\nProps.join()"
		_params = ""
	
		for k=1 to Params.keys.count do
			_params = _params + " " + Params.keys[k] +":"+ Params.values[k] as string
	
		--format " _params	= % \n" _params
		_params --return
	),
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	/** Apply prop to UI control
	 */
	function applyProp prop_name _value =
	(
		print ("------------\nProps.applyProp " +prop_name as string +":"+_value as string )
		if( classOf _value == String ) then 
			_value = "\""+_value as string +"\""
		
		--print ((this.propPath prop_name) + "="+_value as string ) -- set value
		execute ((this.propPath prop_name) + "="+_value as string ) -- set value
		
		this --return	
	),
	
	/** Get prop path
	 */
	function propPath prop_name =
	(
		print ("------------\nProps.propPath() return " + Control.id.full + "." + ( prop_name as string ))
		Control.Id.full + "." + ( prop_name as string ) --return
	),
	
	/** Get prop
	 */
	function getProp prop_name =
	(
		print "------------\nProps.getProp()"
		format " prop_name	= % \n" prop_name
		--format " value	= % \n" (execute (this.propPath prop_name))
		--try
		--(
		execute (this.propPath prop_name)
		--	
		--)
		--catch
		--(
		--	format "\n************ EXCEPTION ************\n%\n***********************************\n" (getCurrentException())
		--	format "\n**************** EXCEPTION File: % ****************\n\n%\n\n**************************************************************************************************************************************\n" filein_path (getCurrentException())
		-- 0
		--)
		
	),
	
	/** Construct
	 */
	function _construct =
	(
		--print "------------\nProps._construct()"
	),
	
	__construct = this._construct()	
	
)
