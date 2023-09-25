/obj/machinery/rnd/production/colony_lathe
	name = "protolathe"
	desc = "Converts raw materials into useful objects."

	icon = 'modular_skyrat/modules/fancy_fabricators/icons/colony_fabricator.dmi'
	icon_state = "colony_lathe"

	circuit = null
	production_animation = "colony_lathe_n"

	allowed_buildtypes = COLONY_PRINTER

/obj/machinery/rnd/production/colony_lathe/Initialize(mapload)
	. = ..()

	if(!mapload)
		flick("colony_lathe_deploy", src) // Sick ass deployment animation

/obj/machinery/rnd/production/colony_lathe/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(. == SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN)
		return

	if(!can_interact(user) || !user.can_perform_action(src))
		return

	balloon_alert_to_viewers("repacking...")
	if(!do_after(user, 3 SECONDS, target = src))
		playsound(src, 'sound/items/ratchet.ogg', 50, TRUE)
		new

	return SECONDARY_ATTACK_CANCEL_ATTACK_CHAIN

// Item for carrying the lathe around and building it

/obj/item/flatpacked_machine
	name = "\improper flatpacked rapid construction fabricator"
	desc = "All of the parts, tools, and a manual that you'd need to make a rapid construction fabricator. \
		These bad boys are seen just about anywhere someone would want or need to build fast, damn the consequences. \
		That tends to be colonies, especially on dangerous worlds, where the influences of this one machine can be seen \
		in every bit of architecture."

	icon = 'modular_skyrat/modules/fancy_fabricators/icons/colony_fabricator.dmi'
	icon_state = "colony_lathe_packed"

	w_class = WEIGHT_CLASS_BULKY

	/// What structure is created by this item.
	var/type_to_deploy = /obj/machinery/mounted_machine_gun
	/// How long it takes to create the structure in question.
	var/deploy_time = 5 SECONDS
