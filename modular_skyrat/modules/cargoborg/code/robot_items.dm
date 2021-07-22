/// CARGO BORGS ///
#define CYBORG_FONT "Consolas"

/obj/item/pen/cyborg
	name = "mechanical pen"
	font = CYBORG_FONT
	desc = "You can almost hear the sound of gears grinding against one another as you write with this pen. Almost."


/obj/item/clipboard/cyborg
	name = "\improper integrated clipboard"
	desc = "A clipboard which seems to come adapted with a paper synthetizer, carefully hidden in its paper clip."
	/// When was the last time the printer was used?
	var/printer_last_used = 0
	/// How long is the integrated printer's cooldown?
	var/printer_cooldown = 10 SECONDS
	/// How much charge is required to print a piece of paper?
	var/paper_charge_cost = 50

/obj/item/clipboard/cyborg/Initialize()
	pen = new /obj/item/pen/cyborg
	. = ..()

/obj/item/clipboard/cyborg/examine()
	. = ...()
	var/obj/item/paper/toppaper = toppaper_ref?.resolve()
	if(toppaper)
		. += span_notice("Right-click to remove [toppaper].")

/obj/item/clipboard/cyborg/remove_pen(mob/user)
	to_chat(user, span_warning("[src]'s integrated pen cannot be removed!"))

/obj/item/clipboard/cyborg/AltClick(mob/user)
	if(!iscyborg(user))
		to_chat(user, span_warning("You do not seem to understand how to use [src]."))
		return
	var/mob/living/silicon/robot/cyborg_user = user
	// Not enough charge? Tough luck.
	if(user?.cell.charge < paper_charge_cost)
		to_chat(user, span_warning("Your internal cell doesn't have enough charge left to use [src]'s integrated printer."))
		return
	// Check for cooldown to avoid paper spamming
	if(world.time - printer_last_used > printer_cooldown)
		// If there's not too much paper already, let's go
		if(!toppaper_ref || length(contents) < 10)
			cyborg_user.cell.use(paper_charge_cost)
			var/obj/item/paper/new_paper = new /obj/item/paper
			new_paper.forceMove(src)
			toppaper_ref = WEAKREF(new_paper)
			to_chat(user, span_notice("[src]'s integrated printer whirs to life, spitting out a fresh piece of paper and clipping it into place."))
		else
			to_chat(user, span_warning("[src]'s integrated printer refuses to print more paper, as [src] already contains enough paper."))
	else
		to_chat(user, span_warning("[src]'s integrated printer refuses to print more paper, its bluespace paper synthetizer not having finished recovering from its last synthesis."))

/obj/item/clipboard/cyborg/ui_act(action, params)
	. = ...()
	if(.)
		return

	if(usr.stat != CONSCIOUS || HAS_TRAIT(usr, TRAIT_HANDS_BLOCKED))
		return

	switch(action)
		// Take paper out
		if("remove_paper")
			var/obj/item/paper/paper = locate(params["ref"]) in src
			if(istype(paper))
				remove_paper(paper, usr)
				. = TRUE
		// Look at (or edit) the paper
		if("edit_paper")
			var/obj/item/paper/paper = locate(params["ref"]) in src
			if(istype(paper))
				paper.ui_interact(usr)
				update_icon()
				. = TRUE
		// Move paper to the top
		if("move_top_paper")
			var/obj/item/paper/paper = locate(params["ref"]) in src
			if(istype(paper))
				toppaper_ref = WEAKREF(paper)
				to_chat(usr, span_notice("You move [paper] to the top."))
				update_icon()
				. = TRUE
		// Rename the paper (it's a verb)
		if("rename_paper")
			var/obj/item/paper/paper = locate(params["ref"]) in src
			if(istype(paper))
				paper.rename()
				update_icon()
				. = TRUE
