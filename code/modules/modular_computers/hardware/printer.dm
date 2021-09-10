/obj/item/computer_hardware/printer
	name = "printer"
	desc = "Computer-integrated printer with paper recycling module."
	power_usage = 100
	icon_state = "printer"
	w_class = WEIGHT_CLASS_NORMAL
	device_type = MC_PRINT
	expansion_hw = TRUE
	var/stored_paper = 20
	var/max_paper = 30

/obj/item/computer_hardware/printer/diagnostics(mob/living/user)
	..()
	to_chat(user, span_notice("Paper level: [stored_paper]/[max_paper]."))

/obj/item/computer_hardware/printer/examine(mob/user)
	. = ..()
	. += span_notice("Paper level: [stored_paper]/[max_paper].")


/obj/item/computer_hardware/printer/proc/print_text(text_to_print, paper_title = "")
	if(!stored_paper)
		return FALSE
	if(!check_functionality())
		return FALSE

	var/obj/item/paper/P = new/obj/item/paper(holder.drop_location())

	// Damaged printer causes the resulting paper to be somewhat harder to read.
	if(damage > damage_malfunction)
		P.info = stars(text_to_print, 100-malfunction_probability)
	else
		P.info = text_to_print
	if(paper_title)
		P.name = paper_title
	P.update_appearance()
	stored_paper--
	P = null
	return TRUE

/obj/item/computer_hardware/printer/try_insert(obj/item/I, mob/living/user = null)
	if(istype(I, /obj/item/paper))
		if(stored_paper >= max_paper)
			to_chat(user, span_warning("You try to add \the [I] into [src], but its paper bin is full!"))
			return FALSE

		if(user && !user.temporarilyRemoveItemFromInventory(I))
			return FALSE
		to_chat(user, span_notice("You insert \the [I] into [src]'s paper recycler."))
		qdel(I)
		stored_paper++
		return TRUE
	/// SKYRAT EDIT ADDITION BEGIN: Paper Buffs
	if(istype(I, /obj/item/paper_bin))
		var/obj/item/paper_bin/bin = I
		if(stored_paper >= max_paper)
			to_chat(user, span_warning("You try to dump \the [bin] into [src], but its paper bin is full!"))
			return FALSE
		if(LAZYLEN(bin.papers))
			var/papers_added = 0 // Number of sheets we added overall
			var/rejected_sheets = 0 // Dump any sheets with info on them, in case some goober put their manifesto in there
			for(var/obj/item/paper/the_paper in bin.papers)
				if(the_paper.info != "") // Uh oh, paper has words!
					LAZYREMOVE(bin.papers, the_paper)
					the_paper.add_fingerprint(user)
					the_paper.forceMove(user.loc)
					user.put_in_hands(the_paper)
					rejected_sheets ++
					continue
				var/num_to_add = 1
				if(istype(the_paper, /obj/item/paper/carbon))
					var/obj/item/paper/carbon/carbon_paper = the_paper
					if(!carbon_paper.copied && ((max_paper - stored_paper) >= 2)) // See if there's room for both
						num_to_add = 2
				LAZYREMOVE(bin.papers, the_paper)
				qdel(the_paper)
				stored_paper += num_to_add
				papers_added += num_to_add
				if(stored_paper >= max_paper)
					break // All full!
			bin.update_appearance()
			switch(papers_added)
				if(0)
					to_chat(user, span_warning("You try to dump \the [bin] into [src]'s paper recycler, but it simply spits out everything you added!"))
				if(1)
					to_chat(user, span_notice("You insert a single [initial(bin.papertype)] into [src]'s paper recycler."))
				if(2 to INFINITY)
					if(rejected_sheets)
						to_chat(user, span_notice("You insert [papers_added] sheets into [src]'s paper recycler, but it detects [rejected_sheets] of them aren't blank, spitting those right back out!"))
					else
						to_chat(user, span_notice("You insert [papers_added] sheets into [src]'s paper recycler."))
				else
					to_chat(user, span_warning("You somehow manage to insert a negative number sheets into [src]'s paper recycler. Nothing seems to happen."))
			return TRUE
		else
			to_chat(user, span_warning("\The [bin] is empty."))
			return FALSE
	/// SKYRAT EDIT ADDITION END
	return FALSE

/obj/item/computer_hardware/printer/mini
	name = "miniprinter"
	desc = "A small printer with paper recycling module."
	power_usage = 50
	icon_state = "printer_mini"
	w_class = WEIGHT_CLASS_TINY
	stored_paper = 5
	max_paper = 15
