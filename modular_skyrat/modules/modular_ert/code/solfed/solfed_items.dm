//
// GLOBAL ITEMS
//

// Custom Cellphone
/obj/item/gangster_cellphone/sol
	name = "walkie talkie"
	desc = "Yeah, yeah, Walkie Talkie isn't the right term, but do you know how agonizing it would be to call these things \"two-way transceivers\" \
	in a day-to-day conversation? I don't care how tacti-cool you want to be, at the end of the day you're gonna talkie while you walkie."
	icon = 'modular_skyrat/modules/modular_ert/icons/solfed.dmi'
	// Hard-coded icon states means that in the file, the states are called phone_on and phone_off
	w_class = WEIGHT_CLASS_SMALL


// Beamout Tool
// Used to despawn Sol from the round, as they have no shuttle
/obj/item/beamout_tool
	name = "beam-out tool" // TODO, find a way to make this into drop pods cuz that's cooler visually
	desc = "Use this to begin the lengthy beam-out process to return to Sol Federation space. It will bring anyone you are pulling with you."
	icon = 'modular_skyrat/modules/modular_ert/icons/solfed.dmi'
	icon_state = "beam_me_up_scotty"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/beamout_tool/attack_self(mob/user, modifiers)
	. = ..()
	if(!user.mind.has_antag_datum(/datum/antagonist/ert))
		to_chat(user, span_warning("You don't understand how to use this device."))
		return
	message_admins("[ADMIN_LOOKUPFLW(user)] has begun to beam-out using their beam-out tool.")
	to_chat(user, "You have begun the beam-out process. Please wait for the beam to reach the station.")
	user.balloon_alert(user, "begun beam-out")
	if(do_after(user, 30 SECONDS))
		to_chat(user, "You have completed the beam-out process and are returning to the Sol Federation.")
		message_admins("[ADMIN_LOOKUPFLW(user)] has beamed themselves out.")
		if(isliving(user))
			var/mob/living/living_user = user
			if(living_user.pulling)
				if(ishuman(living_user.pulling))
					var/mob/living/carbon/human/beamed_human = living_user.pulling
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [ADMIN_LOOKUPFLW(beamed_human)] alongside them.")
				else
					message_admins("[ADMIN_LOOKUPFLW(user)] has beamed out [living_user.pulling] alongside them.")
				var/turf/pulling_turf = get_turf(living_user.pulling)
				playsound(pulling_turf, 'sound/magic/Repulse.ogg', 100, 1)
				var/datum/effect_system/spark_spread/quantum/sparks = new
				sparks.set_up(10, 1, pulling_turf)
				sparks.attach(pulling_turf)
				sparks.start()
				qdel(living_user.pulling)
			var/turf/user_turf = get_turf(living_user)
			playsound(user_turf, 'sound/magic/Repulse.ogg', 100, 1)
			var/datum/effect_system/spark_spread/quantum/sparks = new
			sparks.set_up(10, 1, user_turf)
			sparks.attach(user_turf)
			sparks.start()
			qdel(user)
	else
		user.balloon_alert(user, "beam-out cancelled")

// MISC
/obj/item/radio/headset/headset_solfed/atmos
	name = "\improper SolFed adv. atmos headset"
	desc = "A headset used by the Solar Federation response teams."
	icon_state = "med_headset"
	keyslot = /obj/item/encryptionkey/headset_solfed/atmos
	radiosound = 'modular_skyrat/modules/radiosound/sound/radio/security.ogg'

/obj/item/encryptionkey/headset_solfed/atmos
	name = "\improper SolFed adv. atmos encryption key"
	icon_state = "cypherkey_medical"
	independent = TRUE
	channels = list(RADIO_CHANNEL_SOLFED = 1, RADIO_CHANNEL_ENGINEERING = 1, RADIO_CHANNEL_COMMAND = 1)
	greyscale_config = /datum/greyscale_config/encryptionkey_medical
	greyscale_colors = "#ebebeb#2b2793"

//
// CLOTHING
//

//Breach Control team's uniform
/obj/item/clothing/under/rank/engineering/atmospheric_technician/skyrat/utility/advanced
	name = "advanced atmospherics uniform"
	desc = "A jumpsuit worn by advanced atmospherics crews."
	icon_state = "util_eng"
	armor_type = /datum/armor/atmos_adv
	can_adjust = FALSE

/datum/armor/atmos_adv
	bio = 40
	fire = 70
	acid = 70

//Marshal uniform
/obj/item/clothing/under/rank/centcom/skyrat/solfed/marshal
	name = "\improper SolFed Marshal uniform"
	desc = "A turtleneck and cargo pants worn by SolFed's civil Marshals."
	icon_state = "sol_marshal"
	armor_type = /datum/armor/rank_security

//Marshal Armor - part of their Evasion kit
/obj/item/clothing/suit/armor/vest/alt/sol
	name = "\improper SolFed armor vest"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "armor_sol"

//SWAT's Riot Armor
/obj/item/clothing/suit/armor/riot/sol
	name = "\improper SolFed riot gear"
	desc = "A typical SolFed Type I armored vest, with the reflective plasteel replaced with a flexible polycarbonate and some heavy padding to protect against melee attacks. Helps the wearer resist shoving in close quarters."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "armor_sol_riot"

//SWAT Leader Riot Armor
/obj/item/clothing/suit/armor/riot/sol/leader
	name = "\improper SolFed team lead gear"
	desc = "A typical SolFed Type I armored vest, with the reflective plasteel replaced with a flexible polycarbonate and some heavy padding to protect against melee attacks, as well as a stab-proof durathread cape. Helps the wearer resist shoving in close quarters."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits/armor.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suits/armor.dmi'
	icon_state = "armor_sol_lead"

