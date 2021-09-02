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
			this._replaceValue   i key val  --return
		else
			this._appendNewValue i key val  --return
	),

	/**  Gt Value
	  *
	  * @return	value|undefined	
	 */
	function getVal key =
	(
		if (i = findItem keys key ) > 0 then
			values[i] --return
	),

	/** Get values
	  *
	  * @return	array values
	 */
	function getValues =
	(
		--if( this.count() > 1 ) then
			--values --return
		--else if( this.count() == 1 ) then 
			values[1] --return
	),
	
	/** Add array
	 */
	function addArray _array =
	(
		this.setVal _array[1] _array[2]
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
	function filter pattern =
	(
		for i in values.count to 1 by -1 do
			if ( pattern == undefined or values[i] == undefined ) then
				this._removeUndefined i pattern

			else if( matchPattern values[i] pattern:pattern != false ) then 
				this._removeKeyAndValue i
	),
	
	/** Format keys to #name dattype
	  *
	  *
	  *
	  *
	 */
	function formatKeys =
	(
		for i = 1 to keys.count do
			keys[i] = keys[i] as name
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
	function _removeUndefined i pattern =
	(
		if( (values[i] == pattern ) != false ) then 
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