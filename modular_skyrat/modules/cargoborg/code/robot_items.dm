/// CARGO BORGS ///
#define CYBORG_FONT "Consolas"
#define MAX_PAPER_INTEGRATED_CLIPBOARD 10

/obj/item/pen/cyborg
	name = "integrated pen"
	font = CYBORG_FONT
	desc = "You can almost hear the sound of gears grinding against one another as you write with this pen. Almost."


/obj/item/clipboard/cyborg
	name = "\improper integrated clipboard"
	desc = "A clipboard which seems to come adapted with a paper synthetizer, carefully hidden in its paper clip."
	integrated_pen = TRUE
	/// When was the last time the printer was used?
	var/printer_last_used = 0
	/// How long is the integrated printer's cooldown?
	var/printer_cooldown = 10 SECONDS
	/// How much charge is required to print a piece of paper?
	var/paper_charge_cost = 50

/obj/item/clipboard/cyborg/Initialize()
	pen = new /obj/item/pen/cyborg
	. = ..()

/obj/item/clipboard/cyborg/AltClick(mob/user)
	if(!iscyborg(user))
		to_chat(user, span_warning("You do not seem to understand how to use [src]."))
		return
	var/mob/living/silicon/robot/cyborg_user = user
	// Not enough charge? Tough luck.
	if(cyborg_user?.cell.charge < paper_charge_cost)
		to_chat(user, span_warning("Your internal cell doesn't have enough charge left to use [src]'s integrated printer."))
		return
	// Check for cooldown to avoid paper spamming
	if(world.time - printer_last_used > printer_cooldown)
		// If there's not too much paper already, let's go
		if(!toppaper_ref || length(contents) < MAX_PAPER_INTEGRATED_CLIPBOARD)
			cyborg_user.cell.use(paper_charge_cost)
			printer_last_used = world.time
			var/obj/item/paper/new_paper = new /obj/item/paper
			new_paper.forceMove(src)
			if(toppaper_ref)
				var/obj/item/paper/toppaper = toppaper_ref?.resolve()
				UnregisterSignal(toppaper, COMSIG_ATOM_UPDATED_ICON)
			RegisterSignal(new_paper, COMSIG_ATOM_UPDATED_ICON, .proc/on_top_paper_change)
			toppaper_ref = WEAKREF(new_paper)
			update_appearance()
			to_chat(user, span_notice("[src]'s integrated printer whirs to life, spitting out a fresh piece of paper and clipping it into place."))
		else
			to_chat(user, span_warning("[src]'s integrated printer refuses to print more paper, as [src] already contains enough paper."))
	else
		to_chat(user, span_warning("[src]'s integrated printer refuses to print more paper, its bluespace paper synthetizer not having finished recovering from its last synthesis."))

/// Holders for the package wrap and the wrapping paper synthetizers.

/datum/robot_energy_storage/package_wrap
	name ="package wrapper synthetizer"
	max_energy = 25
	recharge_rate = 2

/datum/robot_energy_storage/wrapping_paper
	name ="wrapping paper synthetizer"
	max_energy = 25
	recharge_rate = 2


/obj/item/stack/package_wrap/cyborg
	name = "integrated package wrapper"
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/package_wrap

// /obj/item/stack/package_wrap/cyborg/use(used, transfer = FALSE, check = FALSE)
// 	. = ..()

/obj/item/stack/wrapping_paper/xmas/cyborg
	name = "integrated wrapping paper"
	is_cyborg = TRUE
	source = /datum/robot_energy_storage/wrapping_paper

/obj/item/stack/wrapping_paper/use(used, transfer, check = FALSE)
	. = ..()
