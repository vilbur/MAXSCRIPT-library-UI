public

/** Add to ui
*/
function addToUi =
(
	format "\nControlAddToUi.ms.addToUi() % %\n" type id.id
	--format "Parameters  = % \n" (this._getParameters())
	--format "tooltip  = % \n" (this._getTooltip())
	
	this.Events.setDefaultEvents()

    ControlBox.Parent_roll.RolloutCreator.addControl type id.id caption (this._getParameters())
),

/** Get parameters
 */
function _getParameters =
(
	(_Parameters.join()) + " " + (this._getTooltip()) --return
),


/** Get tooltip, if button then get tooltips from eventsz
	Set prefixes "Leftclick:" & "\nRightclick:"
 */
function _getTooltip =
(
	if( (tooltip = _Parameters.getVal #tooltip) == undefined ) then
		tooltip = ""
		
	for event_type in Events.Events.event_types do
		if( (_Event	= Events.Events.Custom.getVal event_type) != undefined ) then
			tooltip += (this._getEventPrefix event_type) + _Event.tooltip + "\n"
	
	"tooltip:\""+tooltip+"\""
),

/** _get event prefix
 */
function _getEventPrefix event_type =
(
	case event_type of
	(
		#pressed:	"LMB: "	
		#rightclick:	"RMB: "	
		default:	""
	)
),