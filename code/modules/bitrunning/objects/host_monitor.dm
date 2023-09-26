/obj/item/bitrunning_host_monitor
	name = "host monitor"

	custom_materials = list(/datum/material/iron = SMALL_MATERIAL_AMOUNT * 2)
	desc = "A complex medical device that, when attached to an avatar's data stream, can detect the user of their host's health."
	flags_1 = CONDUCT_1
	icon = 'icons/obj/device.dmi'
	icon_state = "gps-b"
	inhand_icon_state = "electronic"
	item_flags = NOBLUDGEON
	lefthand_file = 'icons/mob/inhands/items/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items/devices_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	throw_range = 7
	throw_speed = 3
	throwforce = 3
	w_class = WEIGHT_CLASS_TINY
	worn_icon_state = "electronic"

/obj/item/bitrunning_host_monitor/attack_self(mob/user, modifiers)
	. = ..()

	var/datum/component/avatar_connection/connection = user.GetComponent(/datum/component/avatar_connection)
	if(isnull(connection))
		balloon_alert(user, "data not recognized")
		return

	var/mob/living/pilot = connection.old_body_ref?.resolve()
	if(isnull(pilot))
		balloon_alert(user, "host not recognized")
		return

	// SKYRAT EDIT ADDITION START - For accurate health readings we need to cast them as a human here
	var/mob/living/carbon/human/human_pilot
	if(ishuman(pilot))
		human_pilot = pilot
	// SKYRAT EDIT ADDITION END
	to_chat(user, span_notice("Current host health: [pilot.health / (human_pilot ? human_pilot.maxHealth : pilot.maxHealth)*100]%")) // SKYRAT EDIT CHANGE - ORIGINAL: to_chat(user, span_notice("Current host health: [pilot.health / pilot.maxHealth * 100]%"))
