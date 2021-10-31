/** Store Rollouts
 */
struct Rollouts_v
(
	_Rollouts = #(  ),
	
	/** Add
	 */
	function add _Rollout =
	(
		this.remove _Rollout.name
		
		append _Rollouts _Rollout
	),
	
	/** Get
	 */
	function get id =
	(
		for _Rollout in _Rollouts where _Rollout.name == id as string do return _Rollout
	),
	
	/** Remove
	 */
	function remove id =
	(
		for i = _Rollouts.count to 1 by -1 where _Rollouts[i].name == id  do deleteItem _Rollouts i
	)
)

if( ROLLOUTS_GLOBAL == undefined ) then
	global ROLLOUTS_GLOBAL = Rollouts_v()