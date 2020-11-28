/** Object or assoc array fake
 *	https://github.com/davestewart/maxscript/blob/master/3D/3ds2ae/03_3ds/dev/compound%20structures/associative%20array.ms
 */
struct List_v
(
	keys	= #(),
	values	= #(),
	
	/**  Set Value
	 */
	function setVal key val =
	(
		if (i = findItem keys key ) > 0 then
			this._replaceValue   i key val 
		else
			this._appendNewValue i key val 
	),

	/**  Gt Value
	 */
	function getVal key =
	(
		--format "List_v.getVal % %\n" (key as string) (findItem keys key)
		--format "values = % \n" values

		if (i = findItem keys key ) > 0 then
			values[i] --return
		else
			undefined --return
	),
	
	/** Get values
	  *
	  * @return	array values if more then 1 values
	  * @return	mixed values if only 1 value
	  * @return	undefined    if values are empty
	 */
	function getValues =
	(
		if( this.count() > 1 ) then
			values --return
		else if( this.count() == 1 ) then 
			values[1] --return
	),
	
	/**  Delete Value
	 */
	function delete key =
	(
		if (i = findItem keys key ) > 0 then
			this._removeKeyAndValue i
	),

	/** Filter
	 */
	function filter pattern test:true =
	(
		for i in values.count to 1 by -1 do
			if ( pattern == undefined or values[i] == undefined ) then
				this._removeUndefined i pattern test

			else if( matchPattern values[i] pattern:pattern != test ) then 
				this._removeKeyAndValue i
	),
	
	/** Get Count of values
	 */
	function count =
	(
		values.count --return
	),
	
	private
	
	/** _remove undefined
	 */
	function _removeUndefined i pattern test =
	(
		if( (values[i] == pattern ) != test ) then 
			this._removeKeyAndValue i
	),

	/** _replace value
	 */
	function _replaceValue i key val =
	(
		keys[i]	= key
		values[i]	= val
	),
	
	/** _append new value
	 */
	function _appendNewValue i key val  =
	(
		append keys key
		append values val
	),
	
	/** _remove key and value
	 */
	function _removeKeyAndValue i =
	(
		--print ("List._removeKeyAndValue " + i as string)
		deleteItem keys	i
		deleteItem values	i
	)
	
)