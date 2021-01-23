/obj/machinery/transformer_rp
	name = "\improper Automatic Robotic Factory 5000"
	desc = "A large metallic machine with an entrance and an exit. A sign on \
		the side reads, 'human go in, robot come out'. The human must be \
		lying down and alive. Has to cooldown between each use."
	icon = 'icons/obj/recycling.dmi'
	icon_state = "separator-AO1"
	layer = ABOVE_ALL_MOB_LAYER // Overhead
	density = FALSE
	/// How many cyborgs are we storing
	var/stored_cyborgs
	/// How many cyborg syndicate upgrades do we have ? the AI can purchase them.
	var/syndicate_upgrades
	/// How many cyborgs can we store?
	var/max_stored_cyborgs
	/// How much between the construction of a cyborg?
	var/cooldown_duration = 600 // 1 minute
	/// Used to check if we are cooling down
	var/cooldown = 0
	/// Handles the timer , shouldn't touch.
	var/cooldown_timer
	/// The amount of charge in the cell
	var/robot_cell_charge = 10000
	/// The countdown itself
	var/obj/effect/countdown/transformer/countdown
	var/mob/living/silicon/ai/masterAI

/obj/machinery/transformer_rp/Initialize()
	// On us
	. = ..()
	new /obj/machinery/conveyor/auto(locate(x - 1, y, z), WEST)
	new /obj/machinery/conveyor/auto(loc, WEST)
	new /obj/machinery/conveyor/auto(locate(x + 1, y, z), WEST)
	countdown = new(src)
	countdown.start()

/obj/machinery/transformer_rp/examine(mob/user)
	. = ..()
	if(cooldown && (issilicon(user) || isobserver(user)))
		. += "It will be ready in [DisplayTimeText(cooldown_timer - world.time)]."

/obj/machinery/transformer_rp/Destroy()
	QDEL_NULL(countdown)
	. = ..()

/obj/machinery/transformer_rp/update_icon_state()
	if(machine_stat & (BROKEN|NOPOWER) || cooldown == 1)
		icon_state = "separator-AO0"
	else
		icon_state = initial(icon_state)

/obj/machinery/transformer_rp/attack_ghost(mob/user)
	. = ..()
	create_a_cyborg(user)

/obj/machinery/transformer_rp/Bumped(atom/movable/AM)
	if(cooldown == 1)
		return
	// Crossed didn't like people lying down.
	if(iscyborg(AM))
		// Only humans can enter from the west side, while lying down.
		var/move_dir = get_dir(loc, AM.loc)
		var/mob/living/silicon/robot/cyborg = AM
		if(move_dir == EAST || move_dir == WEST)
			return

/obj/machinery/transformer_rp/CanAllowThrough(atom/movable/mover, turf/target)
	. = ..()
	// Allows items to go through,
	// to stop them from blocking the conveyor belt.
	if(!iscyborg(mover))
		if(get_dir(src, mover) == EAST)
			return
	return FALSE

/obj/machinery/transformer_rp/process()
	if(cooldown && (cooldown_timer <= world.time))
		cooldown = FALSE
		update_icon()
		if(stored_cyborgs > max_stored_cyborgs)
			return
		stored_cyborgs++

/obj/machinery/transformer_rp/proc/create_a_cyborg(mob/user)
	if(machine_stat & (BROKEN|NOPOWER))
		return
	if(cooldown == 1)
		return
	var/cyborg_ask = alert("Become a cyborg?", "Are you a terminator?", "Yes", "No")
	if(cyborg_ask == "No" || !src || QDELETED(src) || stored_cyborgs < 1)
		return FALSE
	var/mob/living/carbon/human/human = new /mob/living/carbon/human(loc)
	human.key = user.key
	if(!human.mind)
		human.mind = user.mind
	//cyborg.set_connected_ai(masterAI)
	//cyborg.lawsync()
	//cyborg.lawupdate = TRUE
	//stored_cyborgs--
	// Activate the cooldown
	cooldown = 1
	cooldown_timer = world.time + cooldown_duration
