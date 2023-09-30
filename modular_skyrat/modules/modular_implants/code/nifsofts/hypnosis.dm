/*
/datum/nifsoft/hypnosis
	name = "Purpura Eyes"
	program_desc = "Based on the hypnotic equipment provided by the LustWish vendor, the purpura eyes NIFSoft allows the user to ensare others in a hypnotic trance. ((This is intended as a tool for ERP, don't use this for gameplay reasons.))"
	buying_category = NIFSOFT_CATEGORY_FUN
	lewd_nifsoft = TRUE
	purchase_price = 150
	able_to_keep = TRUE
	active_mode = TRUE
	activation_cost = 10
	active_cost = 0.1
	ui_icon = "eye"

	/// The linked ability that the user can use to hypnotize others.
	var/datum/action/innate/nif_hypnotize/hypnosis_ability

/datum/nifsoft/shapeshifter/activate()
	. = ..()
	if(active)
		shapeshifter = new
		shapeshifter.Grant(linked_mob)
		return

	if(shapeshifter)
		shapeshifter.Remove(linked_mob)

/datum/nifsoft/shapeshifter/Destroy()
	. = ..()
	if(shapeshifter)
		QDEL_NULL(shapeshifter)
*/

