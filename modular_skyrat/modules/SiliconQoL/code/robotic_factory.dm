/obj/machinery/transformer_rp
	name = "\improper Automatic Robotic Factory 5000"
	desc = "A large metallic machine with an entrance and an exit. A sign on \
		the side reads, 'Mass robot production facility'"
	icon = 'icons/obj/machines/recycling.dmi'
	icon_state = "separator-AO1"
	base_icon_state = "separator-AO0"
	layer = ABOVE_ALL_MOB_LAYER // Overhead
	density = TRUE
	/// How many cyborgs are we storing
	var/stored_cyborgs = 1
	/// How many cyborgs can we store?
	var/max_stored_cyborgs = 4
	// How much time between the spawning of new cyborgs?
	var/cooldown_duration = 1 MINUTES
	/// Handles the Cyborg spawner timer.
	var/cooldown_timer = 0
	/// Whether we're on spawn cooldown
	var/cooldown = FALSE
	/// How much time between the storing of cyborgs?
	var/stored_duration = 5 MINUTES
	/// Handles the stored Cyborg timer.
	var/stored_timer
	/// The countdown itself
	var/obj/effect/countdown/transformer_rp/countdown
	/// The master AI , assigned when placed down with the ability.
	var/mob/living/silicon/ai/master_ai

/obj/machinery/transformer_rp/Initialize(mapload)
	// On us
	. = ..()
	new /obj/machinery/conveyor/auto(loc, WEST)
	stored_timer = stored_duration
	countdown = new(src)
	countdown.start()

/obj/machinery/transformer_rp/on_set_is_operational(old_value)
	if(old_value)
		end_processing()
	else
		begin_processing()

/obj/machinery/transformer_rp/examine(mob/user)
	. = ..()
	if(issilicon(user) || isobserver(user))
		. += "<br>It has [stored_cyborgs] cyborgs stored."
		if(!is_operational)
			. += span_warning("It has no power!")
			return
		if(cooldown && cooldown_timer)
			. += "<br>It will be ready to deploy a stored cyborg in [DisplayTimeText(max(0, cooldown_timer))]."
		if(stored_cyborgs >= max_stored_cyborgs)
			return
		. += "<br>It will store a new cyborg in [DisplayTimeText(max(0, stored_timer))]."

/obj/machinery/transformer_rp/Destroy()
	QDEL_NULL(countdown)
	. = ..()

/obj/machinery/transformer_rp/update_icon_state()
	. = ..()
	if(is_operational)
		icon_state = "separator-AO1"
	else
		icon_state = base_icon_state

/obj/machinery/transformer_rp/attack_ghost(mob/dead/observer/target_ghost)
	. = ..()
	create_a_cyborg(target_ghost)

/obj/machinery/transformer_rp/process(seconds_per_tick)
	cooldown_timer = max(0, cooldown_timer - (seconds_per_tick * 10))
	if(cooldown_timer == 0)
		cooldown = FALSE

	stored_timer = max(0, stored_timer - (seconds_per_tick * 10))
	if(stored_timer > 0)
		return

	stored_timer = stored_duration

	if(stored_cyborgs >= max_stored_cyborgs)
		return

	stored_cyborgs++
	notify_ghosts("A new cyborg shell has been created at the [src]",
		source = src,
		notify_flags = NOTIFY_CATEGORY_NOFLASH,
		header = "New malfunctioning cyborg created!",
	)

/obj/machinery/transformer_rp/proc/create_a_cyborg(mob/dead/observer/target_ghost)
	if(!is_operational)
		return
	if(stored_cyborgs < 1)
		return
	if(cooldown)
		return

	var/cyborg_ask = tgui_alert(target_ghost, "Become a cyborg?", "Are you a terminator?", list("Yes", "No"))
	if(cyborg_ask == "No" || !src || QDELETED(src))
		return FALSE

	var/mob/living/silicon/robot/cyborg = new /mob/living/silicon/robot(loc)
	cyborg.key = target_ghost.key
	cyborg.set_connected_ai(master_ai)
	cyborg.lawsync()
	cyborg.lawupdate = TRUE
	stored_cyborgs--

	cooldown = TRUE
	cooldown_timer = cooldown_duration
