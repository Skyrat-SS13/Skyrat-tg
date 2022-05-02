/obj/machinery/rnd/production
	var/total_cost = 0
	var/on_station_lathe = TRUE
	var/free_lathe = FALSE
/obj/machinery/rnd/production/proc/skyrat_lathe_tax()
	total_cost ? (free_lathe ? 0 : total_cost) : (CONFIG_GET(number/protolathe_tax))

	if(is_station_level(z) && on_station_lathe && total_cost && !free_lathe)
		var/mob/living/user = usr
		var/obj/item/card/id/card = user.get_idcard(TRUE)
		if(!card && istype(user.pulling, /obj/item/card/id))
			card = user.pulling
		if(card)
			var/datum/bank_account/our_acc = card.registered_account
			if(our_acc.account_job && SSeconomy.get_dep_account(our_acc.account_job?.paycheck_department) == SSeconomy.get_dep_account(payment_department))
				total_cost = 0 //We are not charging crew for printing their own supplies and equipment.
		if(!iscarbon(usr)) // catch all cyborg types
			total_cost = 0
	if(attempt_charge(src, usr, total_cost) & COMPONENT_OBJ_CANCEL_CHARGE)
		return FALSE

/obj/machinery/rnd/production/protolathe/offstation
	on_station_lathe = FALSE

/datum/config_entry/number/protolathe_tax
	default = 0
	min_val = 0
	max_val = 65535
