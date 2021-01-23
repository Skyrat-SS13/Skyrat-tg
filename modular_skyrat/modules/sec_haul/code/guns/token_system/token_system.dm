
//////////////////
//TOKEN SYSTEM
/////////////////

/obj/machinery/gun_vendor
	name = "Peacekeeper Aramanet Vendor"
	desc = "This accepts armament tokens in exchange for weapons, please present your token for redemption."
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi'
	icon_state = "gunvend"
	use_power = NO_POWER_USE
	max_integrity = 2000
	density = TRUE

/obj/machinery/gun_vendor/attacked_by(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/armament_token))
		RedeemToken(I, user)
		return

/obj/machinery/gun_vendor/proc/RedeemToken(obj/item/armament_token/token, mob/redeemer)
	var/obj/item/storage/box/gunset/chosen_gunset = show_radial_menu(redeemer, src, token.available_gunsets, radius = 40)
	var/obj/item/storage/box/gunset/dispensed = new chosen_gunset(src.loc)

	if(redeemer.CanReach(src) && redeemer.put_in_hands(dispensed))
		to_chat(redeemer, "<span class='notice'>You take [dispensed] out of the slot.</span>")
	else
		to_chat(redeemer, "<span class='warning'>[dispensed] falls onto the floor!</span>")
	playsound(src, 'sound/machines/machine_vend.ogg', 50, TRUE, extrarange = -3)
	to_chat(redeemer, "Thank you for redeeming your token. Remember, you can reskin your magazines by alt+clicking them.")
	SSblackbox.record_feedback("tally", "armament_token_redeemed", 1, dispensed)
	qdel(token)

////////////////////
//TOKENS
////////////////////

/obj/item/armament_token
	icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi'
	icon_state = "token_sidearm"
	w_class = WEIGHT_CLASS_TINY
	var/level
	var/list/available_gunsets = list()

/obj/item/armament_token/typelist(key, list/values)
	. = ..()

/obj/item/armament_token/Initialize()
	. = ..()
	for(var/i in available_gunsets)
		var/obj/item/storage/box/gunset/gset = i
		available_gunsets[i] = image(icon = 'modular_skyrat/modules/sec_haul/icons/guns/gunsets.dmi', icon_state = gset.radial_icon)


//Sidearm
/obj/item/armament_token/sidearm
	name = "Sidearm Security Armament Token"
	desc = "A token used in any armament vendor, this is for sidearms. Do not bend."
	level = 1
	available_gunsets = list(
		/obj/item/storage/box/gunset/glock17
	)

//Primary
/obj/item/armament_token/primary
	name = "Primary Security Armament Token"
	desc = "A token used in any armament vendor, this is for main arms. Do not bend."
	icon_state = "token_primary"
	level = 2

