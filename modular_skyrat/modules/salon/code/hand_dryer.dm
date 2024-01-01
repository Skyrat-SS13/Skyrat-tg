/obj/machinery/dryer
	name = "hand dryer"
	desc = "The Breath Of Lizards-3000, an experimental dryer."
	icon = 'modular_skyrat/modules/salon/icons/dryer.dmi'
	icon_state = "dryer"
	density = FALSE
	anchored = TRUE
	var/busy = FALSE

/obj/machinery/dryer/attack_hand(mob/user)
	if(iscyborg(user) || isAI(user))
		return

	if(!can_interact(user))
		return

	if(busy)
		to_chat(user, span_warning("Someone's already drying here."))
		return

	to_chat(user, span_notice("You start drying your hands."))
	playsound(src, 'modular_skyrat/modules/salon/sound/drying.ogg', 50)
	add_fingerprint(user)
	busy = TRUE
	if(do_after(user, 4 SECONDS, src))
		busy = FALSE
		user.visible_message("[user] dried their hands using \the [src].")
	else
		busy = FALSE
