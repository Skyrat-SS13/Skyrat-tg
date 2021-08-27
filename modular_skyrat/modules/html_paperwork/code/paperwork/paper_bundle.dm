/obj/item/paper_bundle
	name = "paper bundle"
	gender = NEUTER
	icon = 'icons/obj/bureaucracy.dmi'
	icon_state = "paper"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_range = 2
	throw_speed = 1
	layer = ABOVE_OBJ_LAYER
	attack_verb_simple = list("bapped")
	attack_verb_simple = list("baps")
	var/page = 1    // current page
	var/list/pages = list()  // Ordered list of pages as they are to be displayed. Can be different order than src.contents.


/obj/item/paper_bundle/attackby(obj/item/weapon, mob/user)
	..()
	if(!istype(weapon))
		return
	var/obj/item/paper/paper = weapon
	if(istype(paper) && !paper.can_bundle())
		return //non-paper or bundlable paper only
	if (istype(weapon, /obj/item/paper/carbon))
		var/obj/item/paper/carbon/carbon_paper = weapon
		if (!carbon_paper.iscopy && !carbon_paper.copied)
			to_chat(user, span_notice("Take off the carbon copy first."))
			add_fingerprint(user)
			return
	// adding sheets
	if(istype(weapon, /obj/item/paper) || istype(weapon, /obj/item/photo))
		insert_sheet_at(user, pages.len+1, weapon)

	// burning
	else if(istype(weapon, /obj/item/lighter))
		// burnpaper(W, user)
		burn_paper_product_attackby_check(weapon, user)

	// merging bundles
	else if(istype(weapon, /obj/item/paper_bundle))
		for(var/obj/bundle_page in weapon)
			bundle_page.forceMove(src)
			bundle_page.add_fingerprint(user)
			pages.Add(bundle_page)

		to_chat(user, span_notice("You add \the [weapon.name] to [(src.name == "paper bundle") ? "the paper bundle" : src.name]."))
		qdel(weapon)
	else
		if(istype(weapon, /obj/item/stack/sticky_tape))
			return FALSE
		if(istype(weapon, /obj/item/pen))
			show_browser(user, "", "window=[name]") //Closes the dialog
		var/obj/current_page = pages[page]
		current_page.attackby(weapon, user)

	update_icon()
	attack_self(user) //Update the browsed page.
	add_fingerprint(user)
	return

/obj/item/paper_bundle/proc/insert_sheet_at(mob/user, index, obj/item/sheet)
	if (!user.transferItemToLoc(sheet, src))
		return
	var/bundle_name = "paper bundle"
	var/sheet_name = istype(sheet, /obj/item/photo) ? "photo" : "sheet of paper"
	bundle_name = (bundle_name == name) ? "the [bundle_name]" : name
	sheet_name = (sheet_name == sheet.name) ? "the [sheet_name]" : sheet.name

	to_chat(user, span_warning("You add [sheet_name] to [bundle_name]."))
	pages.Insert(index, sheet)
	if(index <= page)
		page++

/*/obj/item/paper_bundle/proc/burnpaper(obj/item/lighter/flame, mob/user)
	var/mob/living/carbon/carbon_user = user
	if(istype(carbon_user) && carbon_user.handcuffed)
		return
	if(flame.lit)
		user.visible_message(span_warning("[user] holds \the [flame] up to \the [src], it looks like [user.p_theyre()] trying to burn it!"), \
		span_warning("You hold \the [flame] up to \the [src], burning it slowly."))

		spawn(20)
			if(get_dist(src, user) < 2 && user.get_active_hand() == flame && flame.lit)
				user.visible_message(span_warning("[user] burns right through \the [src], turning it to ash. It flutters through the air before settling on the floor in a heap."), \
				span_warning("You burn right through \the [src], turning it to ash. It flutters through the air before settling on the floor in a heap."))

				if(user.get_inactive_held_item() == src)
					user.dropItemToGround(src)

				new /obj/effect/decal/cleanable/ash(src.loc)
				qdel(src)

			else
				to_chat(user, span_warning("You must hold \the [flame] steady to burn \the [src]."))*/

/obj/item/paper_bundle/examine(mob/user, distance)
	. = ..()
	if(distance <= 1)
		src.show_content(user)
	else
		to_chat(user, "<span class='notice'>It is too far away.</span>")

/obj/item/paper_bundle/proc/show_content(mob/user)
	var/dat
	var/obj/item/weapon = pages[page]

	// first
	if(page == 1)
		dat+= "<DIV STYLE='float:left; text-align:left; width:33.33333%'><A href='?src=\ref[src];prev_page=1'>Front</A></DIV>"
		dat+= "<DIV STYLE='float:left; text-align:center; width:33.33333%'><A href='?src=\ref[src];remove=1'>Remove [(istype(weapon, /obj/item/paper)) ? "paper" : "photo"]</A></DIV>"
		dat+= "<DIV STYLE='float:left; text-align:right; width:33.33333%'><A href='?src=\ref[src];next_page=1'>Next Page</A></DIV><BR><HR>"
	// last
	else if(page == pages.len)
		dat+= "<DIV STYLE='float:left; text-align:left; width:33.33333%'><A href='?src=\ref[src];prev_page=1'>Previous Page</A></DIV>"
		dat+= "<DIV STYLE='float:left; text-align:center; width:33.33333%'><A href='?src=\ref[src];remove=1'>Remove [(istype(weapon, /obj/item/paper)) ? "paper" : "photo"]</A></DIV>"
		dat+= "<DIV STYLE='float;left; text-align:right; with:33.33333%'><A href='?src=\ref[src];next_page=1'>Back</A></DIV><BR><HR>"
	// middle pages
	else
		dat+= "<DIV STYLE='float:left; text-align:left; width:33.33333%'><A href='?src=\ref[src];prev_page=1'>Previous Page</A></DIV>"
		dat+= "<DIV STYLE='float:left; text-align:center; width:33.33333%'><A href='?src=\ref[src];remove=1'>Remove [(istype(weapon, /obj/item/paper)) ? "paper" : "photo"]</A></DIV>"
		dat+= "<DIV STYLE='float:left; text-align:right; width:33.33333%'><A href='?src=\ref[src];next_page=1'>Next Page</A></DIV><BR><HR>"

	if(istype(pages[page], /obj/item/paper))
		var/obj/item/paper/attached_paper = weapon
		dat+= "<HTML><HEAD><TITLE>[paper_sheet.name]</TITLE></HEAD><BODY>[attached_paper.show_info(user)][attached_paper.stamps]</BODY></HTML>"
		show_browser(user, dat, "window=[name]")
	else if(istype(pages[page], /obj/item/photo))
		var/obj/item/photo/attached_photo = weapon
		dat += "<html><head><title>[attached_photo.name]</title></head><body style='overflow:hidden'>"
		dat += "<div> <img src='tmp_photo.png' width = '180'[attached_photo.scribble ? "<div> Written on the back:<br><i>[attached_photo.scribble]</i>" : null ]</body></html>"
		send_rsc(user, attached_photo.img, "tmp_photo.png")
		show_browser(user, JOINTEXT(dat), "window=[name]")

/obj/item/paper_bundle/attack_self(mob/user)
	src.show_content(user)
	add_fingerprint(user)
	update_icon()
	return

/obj/item/paper_bundle/Topic(href, href_list)
	if(..())
		return 1
	if((src in usr.contents) || (istype(src.loc, /obj/item/folder) && (src.loc in usr.contents)))
		usr.set_machine(src)
		var/obj/item/in_hand = usr.get_active_hand()
		if(href_list["next_page"])
			if(in_hand && (istype(in_hand, /obj/item/paper) || istype(in_hand, /obj/item/photo)))
				insert_sheet_at(usr, page+1, in_hand)
			else if(page != pages.len)
				page++
				playsound(src.loc, "pageturn", 50, 1)
		if(href_list["prev_page"])
			if(in_hand && (istype(in_hand, /obj/item/paper) || istype(in_hand, /obj/item/photo)))
				insert_sheet_at(usr, page, in_hand)
			else if(page > 1)
				page--
				playsound(src.loc, "pageturn", 50, 1)
		if(href_list["remove"])
			var/obj/item/W = pages[page]
			usr.put_in_hands(W)
			pages.Remove(pages[page])

			to_chat(usr, "<span class='notice'>You remove the [W.name] from the bundle.</span>")

			if(pages.len <= 1)
				var/obj/item/paper/P = src[1]
				usr.drop_from_inventory(src)
				usr.put_in_hands(P)
				qdel(src)

				return

			if(page > pages.len)
				page = pages.len

			update_icon()

		src.attack_self(usr)
		updateUsrDialog()
	else
		to_chat(usr, "<span class='notice'>You need to hold it in hands!</span>")

/obj/item/paper_bundle/verb/rename()
	set name = "Rename bundle"
	set category = "Object"
	set src in usr

	var/n_name = sanitizeSafe(input(usr, "What would you like to label the bundle?", "Bundle Labelling", null)  as text, MAX_NAME_LEN)
	if((loc == usr || loc.loc && loc.loc == usr) && usr.stat == 0)
		SetName("[(n_name ? text("[n_name]") : "paper")]")
	add_fingerprint(usr)
	return


/obj/item/paper_bundle/verb/remove_all()
	set name = "Loose bundle"
	set category = "Object"
	set src in usr

	to_chat(usr, "<span class='notice'>You loosen the bundle.</span>")
	for(var/obj/O in src)
		O.dropInto(usr.loc)
		O.reset_plane_and_layer()
		O.add_fingerprint(usr)
	qdel(src)


/obj/item/paper_bundle/on_update_icon()
	var/obj/item/paper/P = pages[1]
	icon_state = P.icon_state
	overlays = P.overlays
	underlays.Cut()
	var/i = 0
	var/photo
	for(var/obj/O in src)
		var/image/img = image('icons/obj/bureaucracy.dmi')
		if(istype(O, /obj/item/paper))
			img.icon_state = O.icon_state
			img.pixel_x -= min(1*i, 2)
			img.pixel_y -= min(1*i, 2)
			pixel_x = min(0.5*i, 1)
			pixel_y = min(  1*i, 2)
			underlays += img
			i++
		else if(istype(O, /obj/item/photo))
			var/obj/item/photo/Ph = O
			img = Ph.tiny
			photo = 1
			overlays += img
	if(i>1)
		desc =  "[i] papers clipped to each other."
	else
		desc = "A single sheet of paper."
	if(photo)
		desc += "\nThere is a photo attached to it."
	overlays += image('icons/obj/bureaucracy.dmi', "clip")
	return
