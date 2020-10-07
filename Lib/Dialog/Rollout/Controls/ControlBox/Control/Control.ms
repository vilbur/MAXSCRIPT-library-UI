--filein( getFilenamePath(getSourceFileName()) + "/ControlEvents/ControlEvents.ms" )
--filein( getFilenamePath(getSourceFileName()) + "/Props/Props.ms" )

/** Control
 */
struct Control_v 
(
	include "Library/UI/Lib/Dialog/Rollout/Controls/ControlBox/Control/ControlExtends.ms"
	/*------------------------------------------------------------------------------
		INTERFACE METHODS
	--------------------------------------------------------------------------------*/
	
	
	
	/*------------------------------------------------------------------------------
		PRIVATE
	--------------------------------------------------------------------------------*/
	--/** Sanitize parameters by specific control type
	--  *
	--  * This method must be in all structs which include "ControlExtends.ms"
	-- */
	--function _sanitizeParame tersByControlType =
	--(
	--	
	--),

	function test =
	(
		messagebox "Control_v.test()"
	)
)
