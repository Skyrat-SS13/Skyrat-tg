/obj/machinery/gun_vendor
	name = "Armadyne weapons dispensary"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption."
	icon = 'modular_skyrat/master_files/icons/obj/guns/gunsets.dmi'
	icon_state = "gunvend"
	use_power = NO_POWER_USE
	circuit = /obj/item/circuitboard/machine/gun_vendor
	max_integrity = 2000
	density = TRUE
	/// If FALSE, does not require an alert level to redeem the token.
	var/requires_alert = TRUE

/obj/item/circuitboard/machine/gun_vendor
	name = "Weapons Dispenser (Machine Board)"
	icon_state = "circuit_map"
	build_path = /obj/machinery/gun_vendor
	req_components = list(
		/obj/item/stock_parts/manipulator = 2,
		/obj/item/stock_parts/capacitor = 2)

/obj/structure/gun_vendor/wrench_act(mob/living/user, obj/item/item)
	default_unfasten_wrench(user, item, 120)
	return TRUE

/obj/machinery/gun_vendor/attacked_by(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/armament_token))
		RedeemToken(I, user)
		return

/obj/machinery/gun_vendor/proc/RedeemToken(obj/item/armament_token/token, mob/redeemer)
	if((SSsecurity_level.get_current_level_as_number() < token.minimum_sec_level) && requires_alert)
		to_chat(redeemer, span_redtext("Warning, this holochip is locked to [SSsecurity_level.get_current_level_as_text()]!"))
		message_admins("ARMAMENT LOG: [redeemer] attempted to redeem a [token.name] on the incorrect security level!")
		return
	var/list/radial_build = token.get_available_gunsets()
	var/obj/item/storage/box/gunset/chosen_gunset = show_radial_menu(redeemer, src, radial_build, radius = 40)
	if(!chosen_gunset)
		return
	if(!redeemer.Adjacent(src))
		return
	if(QDELETED(token))
		return
	var/obj/item/storage/box/gunset/dispensed = new chosen_gunset(src.loc)

	if(redeemer.CanReach(src) && redeemer.put_in_hands(dispensed))
		to_chat(redeemer, span_notice("You take [dispensed] out of the slot."))
	else
		to_chat(redeemer, span_warning("[dispensed] falls onto the floor!"))
	playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
	to_chat(redeemer, "Thank you for redeeming your token. Remember. Do NOT take lethal ammo without permission or good reasoning.")
	SSblackbox.record_feedback("tally", "armament_token_redeemed", 1, dispensed)
	qdel(token)

/obj/machinery/gun_vendor/no_alert
	requires_alert = FALSE
