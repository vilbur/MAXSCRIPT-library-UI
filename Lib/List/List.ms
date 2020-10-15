
/** Object or assoc array fake
 *	https://github.com/davestewart/maxscript/blob/master/3D/3ds2ae/03_3ds/dev/compound%20structures/associative%20array.ms
 */
struct List_v
(
	keys	= #(),
	values	= #(),
	
	/**  
	 */
	function setVal key val =
	(
		key = key as string
		
		local i=findItem keys key

		if i>0 then
		(
			keys[i]	= key
			values[i]	= val
		)
		else
		(
			append keys key
			append values val
		)
		val --return
	),
	/**  
	 */
	function getVal key =
	(
		key = key as string

		local i = findItem keys key
		
		if i>0 then
			values[i] --return
		else
			undefined --return
	),
	/**  
	 */
	function delete key=
	(
		local i=findItem keys key
		if i>0 then
		(
			deleteItem keys	i
			deleteItem values	i
			
		)
	)
)
