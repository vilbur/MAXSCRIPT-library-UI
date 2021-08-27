/** 
  *
  *
  */
struct DialogCreator_v
(
	
	ContentRollout,
	
	Dialog,
	
	
	/** 
	 */
	function createDialog =
	(
		Dialog	= Dialog_v title:ContentRollout.name
		
		for Subrollouts_or_Controls in ContentRollout.Subrollouts_and_Controls do
			Subrollouts_or_Controls.addToUi Dialog.RolloutMain
			
		Dialog.create()
		
		Dialog --return
	),
	
	--/** Add subrollouts or groupbox
	-- */
	--function addSubrolloutsOrGroupBox Subrollouts_or_Controls =
	--(
	--	if( this.isSubrollouts Subrollouts_or_Controls == true )
	--	then
	--		this.addSubrolloutsToUI Subrollouts_or_Controls
	--	else
	--		this.addGroupboxToUI Subrollouts_or_Controls
	--),

	--/** Is subrollouts
	-- */
	--function isSubrollouts Subrollouts_or_Controls =
	--(
	--	matchPattern ( classof Subrollouts_or_Controls as string ) pattern:"#Struct:ContentSubrollouts*" --return
	--),
	
	--/** Add subrollouts to
	-- */
	--function addSubrolloutsToUI ContentSubrollouts =
	--(
	--	print "addSubrolloutsToUI"
	--	
	--	Subrollouts = Dialog.rollouts()
	--	Rollout_A	= Subrollouts.new "Rollout A"
	--	
	--	for ContentRollout in ContentSubrollouts.Rollouts do
	--		format "ContentRollout = % \n" ContentRollout 
	--		 
	--),
	--
	--
	--
	--
	--/** Add groupbox to
	-- */
	--function addGroupboxToUI Subrollouts_or_Controls =
	--(
	--	print "addGroupboxToUI"
	--	
	--),

	
	on create do
	(
		format "\n---------------\n"
		print ("DialogCreator_v.onCreate")

		
	)
)