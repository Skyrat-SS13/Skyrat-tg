/// The exact same as the standard /tg/ photocopier ass proc, except it uses a .dmi for the ass images and accepts far more species. Hurray!
/obj/machinery/photocopier/proc/make_ass_copy()
	if(!check_ass() || !toner_cartridge)
		return
	if(ishuman(ass) && (ass.get_item_by_slot(ITEM_SLOT_ICLOTHING) || ass.get_item_by_slot(ITEM_SLOT_OCLOTHING)))
		to_chat(usr, span_notice("You feel kind of silly, copying [ass == usr ? "your" : ass][ass == usr ? "" : "\'s"] ass with [ass == usr ? "your" : "[ass.p_their()]"] clothes on.") )
		return

	var/icon/temp_img
	if(ishuman(ass))
		var/mob/living/carbon/human/H = ass
		var/datum/species/spec = H.dna.species
		if(spec.ass_image)
			temp_img = icon('modular_skyrat/master_files/icons/obj/butts.dmi', spec.ass_image)
	else if(isalienadult(ass))
		temp_img = icon('modular_skyrat/master_files/icons/obj/butts.dmi', "xeno"))
	else if(issilicon(ass))
		temp_img = icon('modular_skyrat/master_files/icons/obj/butts.dmi', "machine")
	else if(isdrone(ass))
		temp_img = icon('modular_skyrat/master_files/icons/obj/butts.dmi', "drone")

	var/obj/item/photo/copied_ass = new /obj/item/photo(loc)
	var/datum/picture/toEmbed = new(name = "[ass]'s Ass", desc = "You see [ass]'s ass on the photo.", image = temp_img)
	give_pixel_offset(copied_ass)
	toEmbed.psize_x = 128
	toEmbed.psize_y = 128
	copied_ass.set_picture(toEmbed, TRUE, TRUE)
	toner_cartridge.charges -= ASS_TONER_USE
