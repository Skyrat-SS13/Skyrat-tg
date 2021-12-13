/obj/structure/closet/crate/guncrate
	name = "gun crate"
	desc = "A crate loaded with guns. Crowbar it open!"
	icon = 'modular_skyrat/modules/gun_dealer/icons/crate.dmi'
	icon_state = "guncrate"
	density = TRUE
	open_sound = 'sound/machines/wooden_closet_open.ogg'
	close_sound = 'sound/machines/wooden_closet_close.ogg'
	open_sound_volume = 25
	close_sound_volume = 50
	can_install_electronics = FALSE
	// Stops people from "diving into" a crate you can't open normally
	divable = FALSE

/obj/structure/closet/crate/guncrate/attack_hand(mob/user, list/modifiers)
	add_fingerprint(user)
	if(manifest)
		tear_manifest(user)
	else
		if(!opened)
			balloon_alert(user, "need crowbar to open")
			to_chat(user, span_warning("You need a crowbar to pry this open!"))
		else
			balloon_alert(user, "cant close")
			to_chat(user, span_warning("You don't think you can get the lid back on."))

/obj/structure/closet/crate/guncrate/attackby(obj/item/W, mob/living/user, params)
	if(W.tool_behaviour == TOOL_CROWBAR && !opened)
		if(manifest)
			tear_manifest(user)
		user.visible_message(span_notice("[user] starts prying \the [src] open."), \
			span_notice("You start prying open \the [src]."), \
			span_hear("You hear splitting wood."))
		playsound(src.loc, 'modular_skyrat/modules/gun_dealer/sounds/crate_open.wav', 75, TRUE)
		if(do_after(user, 5 SECONDS, src))
			open()
	else
		if(user.combat_mode)
			return ..()

		else
			to_chat(user, span_warning("You need a crowbar to pry this open!"))
			return FALSE


/obj/structure/closet/crate/guncrate/test/PopulateContents()
	..()
	new /obj/item/gun/ballistic/automatic/l6_saw/unrestricted(src)
