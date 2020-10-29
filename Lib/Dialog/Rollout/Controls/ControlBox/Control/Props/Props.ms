filein( getFilenamePath(getSourceFileName()) + "/../../../../../../List/List.ms" )

/** Props
 */
struct Props_v
(
	Control,

	Props	= List_v(),

	/** Add value
	 */
	function add param value force:true =
	(
		print "------------\nProps.add()"

		--if( force == true or this.get param == undefined ) then  
		--	Props.setVal param value
		--
		if ( Control.exists() ) then
			this.applyProp param value
		
		this --return
	), 
	/** Get value
	 */
	function get param =
	(
		--print "------------\nProps.get()"
		--format " param	= % \n" param
		--format " Control.exists()	= % \n" (Control.exists())
		
		if not ( Control.exists() ) then
			Props.getVal param -- return
			
		else
			this.getProp param 
	),
	/** Remove
	 */
	function remove param =
	(
		Props.delete param
		
		this
	),
	/** Join array
	 */
	function join =
	(
		--print "------------\nProps.join()"
		params = ""

		for k=1 to Props.keys.count do
			params = params + " " + Props.keys[k] +":"+ Props.values[k] as string

		--format " params	= % \n" params
		params --return
	),
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	
	/** Apply prop to UI control
	 */
	function applyProp prop_name _value =
	(
		print "------------\nProps.applyProp()"
		if( classOf _value == String ) then 
			_value = "\""+_value as string +"\""
		
		execute ((this.propPath prop_name) + "="+_value as string ) -- set value
		
		this --return	
	),

	/** Get prop path
	 */
	function propPath prop_name =
	(
		--print "------------\nProps.propPath()"
		Control.id.full + "." + ( prop_name as string ) --return
	),

	/** Get prop
	 */
	function getProp prop_name =
	(
		--print "------------\nProps.getProp()"
		--format " prop_name	= % \n" prop_name
		execute (this.propPath prop_name)
	),
	
	/** Construct
	 */
	function _construct =
	(
		--print "------------\nProps._construct()"
	),
	
	__construct = this._construct()	
	
	--function test =
	--(
	--	messagebox "Props.test()"
	--)
	
	
)
