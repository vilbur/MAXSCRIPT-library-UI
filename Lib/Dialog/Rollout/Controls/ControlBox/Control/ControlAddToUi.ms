public

/** Add to ui
*/
function addToUi =
(
	--format "\nControlAddToUi.ms.addToUi() % %\n" type id.id
	--format "\nParameters  = % \n" (this._getParameters())
	--format "\nControlAddToUi.ms.addToUi()	% 	% 	\"%\"" type id.id caption
	
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
	tooltip =	_Parameters.getVal #tooltip

	if( tooltip == undefined ) then
		tooltip = ""

	tooltip_LMB = if( type == #checkbox ) then  "Checked: " else "LMB: "

	Event_pressed	= Events.Events.getEvent #pressed
	Event_rightclick	= Events.Events.getEvent #rightclick
	
	if( Event_pressed != undefined ) then
		tooltip = Event_pressed.tooltip

	if( Event_rightclick != undefined ) then
		tooltip = tooltip_LMB + tooltip + "\nRMB: " + Event_rightclick.tooltip
	
	
	if( tooltip!=undefined ) then ( "tooltip:\""+tooltip+"\"" ) else "" --return
),