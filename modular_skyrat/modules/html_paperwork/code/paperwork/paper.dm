// large amount of fields creates a heavy load on the server, see updateinfolinks() and addtofield()
#define MAX_FIELDS 50

#define PAPER_CAMERA_DISTANCE 2
#define PAPER_EYEBALL_DISTANCE 3

#define PAPER_META(message) "<p><i>[message]</i></p>"
#define PAPER_META_BAD(message) "<p style='color:red'><i>[message]</i></p>"

/*
 * Paper
 * also scraps of paper
 */

/obj/item/paper
	name = "sheet of paper"
	gender = NEUTER
	icon = 'modular_skyrat/modules/html_paperwork/icons/bureaucracy.dmi'
	icon_state = "paper"
	inhand_icon_state = "paper"
	worn_icon_state = "paper"
	custom_fire_overlay = "paper_onfire_overlay"
	throwforce = 0
	w_class = WEIGHT_CLASS_TINY
	throw_range = 1
	throw_speed = 1
	pressure_resistance = 0
	layer = ABOVE_OBJ_LAYER
	slot_flags = ITEM_SLOT_HEAD
	body_parts_covered = HEAD
	resistance_flags = FLAMMABLE
	max_integrity = 50
	dog_fashion = /datum/dog_fashion/head
	drop_sound = 'sound/items/handling/paper_drop.ogg'
	pickup_sound =  'sound/items/handling/paper_pickup.ogg'
	grind_results = list(/datum/reagent/cellulose = 3)
	color = "white"
	attack_verb_simple = list("bapped")
	attack_verb_continuous = list("baps")

	var/info		//What's actually written on the paper.
	var/info_links	//A different version of the paper which includes html links at fields and EOF
	var/list/stamps /// Positioning for the stamp in tgui
	var/fields
	var/free_space = MAX_PAPER_MESSAGE_LEN
	var/list/stamped
	var/list/ico[0]      //Icons and
	var/list/offset_x[0] //offsets stored for later
	var/list/offset_y[0] //usage by the photocopier
	var/spam_flag = 0
	var/last_modified_ckey
	var/age = 0
	var/list/metadata
	///Paper will not be able to be written on and will not bring up a window upon examine if FALSE -- USED TO BE "readable"
	var/show_written_words = TRUE
	///If TRUE, paper will act the same as readable = FALSE, but will also be unrenameable.
	var/is_memo = FALSE
	///Language the paper was written in. Editable by users up until something's actually written
	var/datum/language/language = LANGUAGE_COMMON

	var/const/deffont = "Verdana"
	var/const/signfont = "Times New Roman"
	var/const/crayonfont = "Comic Sans MS"
	var/const/fancyfont = "Segoe Script"

	// var/scan_file_type = /datum/computer_file/data/text

	var/contact_poison // Reagent ID to transfer on contact
	var/contact_poison_volume = 0

/obj/item/paper/Initialize()
	. = ..()
	pixel_x = base_pixel_x + rand(-9, 9)
	pixel_y = base_pixel_y + rand(-8, 8)
	update_appearance()

/obj/item/paper/New(loc, text, title, list/md, datum/language/langdatum)
	..(loc)
	set_content(text ? text : info, title)
	metadata = md

	if (langdatum)
		language = langdatum
	var/old_language = language
	if (!set_language(language, TRUE))
		log_paper("[src] ([type]) initialized with invalid or missing language `[old_language]` defined.")
		set_language(LANGUAGE_COMMON, TRUE)

/obj/item/paper/proc/set_content(text,title) // Replace SetText() w/ set_content
	if(title)
		name = title
	info = html_encode(text)
	info = parsepencode(text)
	update_icon_state()
	update_space(info)
	updateinfolinks()

/obj/item/paper/proc/copy(paper_type = /obj/item/paper, atom/location = loc, colored = TRUE)
	var/obj/item/paper/new_paper = new paper_type (location)
	if(colored)
		new_paper.color = color
		new_paper.info = info
	var/copied = info
	copied = replacetext(copied, "<font face=\"[new_paper.deffont]\" color=", "<font face=\"[new_paper.deffont]\" nocolor=")	//state of the art techniques in action
	copied = replacetext(copied, "<font face=\"[new_paper.crayonfont]\" color=", "<font face=\"[new_paper.crayonfont]\" nocolor=")	//This basically just breaks the existing color tag, which we need to do because the innermost tag takes priority.
	new_paper.info += copied
	new_paper.info += "</font>"//</font>
	new_paper.SetName(name) // -- Doohl
	new_paper.fields = fields
	new_paper.stamps = stamps
	new_paper.stamped = stamped
	new_paper.ico = ico
	new_paper.offset_x = offset_x
	new_paper.offset_y = offset_y
	copy_overlays(new_paper, TRUE)
	return new_paper


/obj/item/paper/proc/set_language(new_lang, force = FALSE)
	var/datum/language/new_language = new_lang
	if (!new_language || (info && !force))
		return FALSE

	if (!ispath(new_language, /datum/language))
		if(istext(new_language))
			for(var/datum/language/langpath as anything in GLOB.language_datum_instances)
				if(new_language == langpath.name)
					new_language = langpath
	if (!ispath(new_language, /datum/language))
		return FALSE
	language = new_language
	return TRUE

/obj/item/paper/update_icon_state()
	if(icon_state == "paper_talisman" || is_memo)
		return ..()
	else if(info)
		icon_state = "[initial(icon_state)]_words"
	else
		icon_state = "[initial(icon_state)]"
	return ..()

/obj/item/paper/proc/update_space(new_text)
	if(new_text)
		free_space -= length(strip_html_properly(new_text))

/obj/item/paper/examine(mob/user, distance)
	. = ..()
	if(!is_memo && name != "sheet of paper")
		. += "It's titled '[name]'."
	if(distance <= 1)
		show_content(usr)
	else
		. += span_notice("You have to go closer if you want to read it.")

/obj/item/paper/verb/user_set_language()
	set name = "Set writing language"
	set category = "Object"
	set src in usr

	choose_language(usr)

/obj/item/paper/proc/choose_language(mob/user, admin_force = FALSE)
	if(info)
		to_chat(user, span_warning("\The [src] already has writing on it and cannot have its language changed."))
		return
	if(!admin_force && !user.get_random_understood_language())
		to_chat(user, span_warning("You don't know any languages to choose from."))
		return

	var/list/selectable_languages = list()
	if(admin_force)
		for(var/key in GLOB.language_datum_instances)
			var/datum/language/langdatum = GLOB.language_datum_instances[key]
			if (initial(langdatum.has_written_form))
				selectable_languages += langdatum
	else
		var/datum/language_holder/langholder = user.get_language_holder()
		for(var/datum/language/langpath as anything in langholder.understood_languages)
			selectable_languages["[initial(langpath.name)]"] = langpath

	var/datum/language/new_language = tgui_input_list(user, "What language do you want to write in?", "Change language", selectable_languages)
	if(!istype(new_language))
		new_language = selectable_languages[new_language]
	if(!new_language || new_language == language)
		to_chat(user, span_notice("You decide to keep writing in [initial(language.name)]."))
		return
	if(!admin_force && !Adjacent(user) && !can_interact(user, GLOB.deep_inventory_state))
		to_chat(user, span_warning("You must remain next to or continue holding \the [src] to do that."))
		return
	to_chat(user, span_notice("You start writing in [initial(new_language.name)]."))
	set_language(new_language)


/obj/item/paper/proc/show_content(mob/user, forced, editable)
	if(!show_written_words || is_memo)
		return
	if(!user)
		return
	var/can_read = forced || isobserver(user)
	if(!can_read)
		can_read = isAI(user)
		if(can_read)
			var/mob/living/silicon/ai/AI = user
			can_read = get_dist(src, AI.current) < PAPER_CAMERA_DISTANCE
		else
			can_read = ishuman(user) || issilicon(user)
			if(can_read)
				can_read = get_dist(src, user) < PAPER_EYEBALL_DISTANCE
	var/html = "<html><head><title>[name]</title></head><body bgcolor='[color]'>"
	if(!can_read)
		html += PAPER_META_BAD("The paper is too far away or you can't read.")
		html += "<hr/></body></html>"
	var/has_content = length(info)
	var/has_language = forced || user.has_language(language, FALSE)
	if(has_content && !has_language && !isobserver(user))
		if(language == /datum/language/codespeak)
			html += PAPER_META("The paper is written in Galactic Common")
		else
			html += PAPER_META_BAD("The paper is written in a language you don't understand.")
		var/datum/language/langdatum = GLOB.language_datum_instances[language]
		html += "<hr/>" + langdatum.scramble(info)
	else if(editable)
		if(has_content)
			html += PAPER_META("The paper is written in [initial(language.name)].")
			html += "<hr/>" + info_links
		else if(forced || user.get_random_understood_language()) // checks if any languages exist
			if(!has_language)
				language = user.get_selected_language()
			html += PAPER_META("You are writing in <a href='?src=\ref[src];change_language=1'>[initial(language.name)]</a>.")
			html += "<hr/>" + info_links
		else
			html += PAPER_META_BAD("You can't write without knowing a language.")
	else if(has_content)
		html += PAPER_META("The paper is written in [initial(language.name)].")
		html += "<hr/>" + info
	html += "[stamps]</body></html>"
	show_browser(user, html, "window=[name]") //todo - figure out what this does
	onclose(user, "[name]")


/obj/item/paper/verb/rename()
	set name = "Rename paper"
	set category = "Object"
	set src in usr

	if(!usr.can_read(src) || usr.incapacitated(TRUE, TRUE) || (isobserver(usr) && !isAdminGhostAI(usr)))
		return
	if(ishuman(usr))
		var/mob/living/carbon/human/human_user = usr
		if(HAS_TRAIT(human_user, TRAIT_CLUMSY) && prob(25))
			to_chat(human_user, span_warning("You cut yourself on the paper! Ahhhh! Ahhhhh!"))
			human_user.damageoverlaytemp = 9001
			human_user.update_damage_hud()
			return
	if(is_memo)
		to_chat(usr, span_notice("You decide not to alter the name of \the [src]."))
		return
	var/new_name = stripped_input(usr, "What would you like to label the paper?", "Paper Labelling", null, MAX_NAME_LEN)
	if((!new_name && (loc == usr || istype(loc, /obj/item/clipboard)) && usr.stat == CONSCIOUS))
		SetName(new_name)
		add_fingerprint(usr)

/obj/item/paper/attack_self(mob/living/user)
	if(user.combat_mode == TRUE)
		if(icon_state == "scrap")
			user.show_message("<span class='warning'>\The [src] is already crumpled.</span>")
			return
		//crumple dat paper
		info = stars(info,85)
		user.visible_message("\The [user] crumples \the [src] into a ball!")
		icon_state = "scrap"
		return
	user.examinate(src)

/obj/item/paper/attack_ai(mob/living/silicon/ai/user)
	show_content(user)

/obj/item/paper/attack(mob/living/carbon/target, mob/living/carbon/user)
	if(user.zone_selected == BODY_ZONE_PRECISE_EYES)
		user.visible_message("<span class='notice'>You show the paper to [target]. </span>", \
			"<span class='notice'> [user] holds up a paper and shows it to [target]. </span>")
		target.examinate(src)
/* Handled in cosmetics.dm -- TODO, make sure lipstick wiping actually works
	else if(user.zone_sel.selecting == BP_MOUTH) // lipstick wiping
		if(ishuman(M))
			var/mob/living/carbon/human/H = M
			if(H == user)
				to_chat(user, "<span class='notice'>You wipe off the lipstick with [src].</span>")
				H.lip_style = null
				H.update_body()
			else
				user.visible_message("<span class='warning'>[user] begins to wipe [H]'s lipstick off with \the [src].</span>", \
								 	 "<span class='notice'>You begin to wipe off [H]'s lipstick.</span>")
				if(do_after(user, 2 SECONDS, H, do_flags = DO_DEFAULT & ~DO_BOTH_CAN_TURN))
					user.visible_message("<span class='notice'>[user] wipes [H]'s lipstick off with \the [src].</span>", \
										 "<span class='notice'>You wipe off [H]'s lipstick.</span>")
					H.lip_style = null
					H.update_body() */

/obj/item/paper/proc/addtofield(id, text, links = 0)
	var/locid = 0
	var/laststart = 1
	var/textindex = 1
	while(locid < MAX_FIELDS)
		var/istart = 0
		if(links)
			istart = findtext(info_links, "<span class=\"paper_field\">", laststart)
		else
			istart = findtext(info, "<span class=\"paper_field\">", laststart)

		if(istart==0)
			return // No field found with matching id

		laststart = istart+1
		locid++
		if(locid == id)
			var/iend = 1
			if(links)
				iend = findtext(info_links, "</span>", istart)
			else
				iend = findtext(info, "</span>", istart)

			textindex = iend
			break

	if(links)
		var/before = copytext(info_links, 1, textindex)
		var/after = copytext(info_links, textindex)
		info_links = before + text + after
	else
		var/before = copytext(info, 1, textindex)
		var/after = copytext(info, textindex)
		info = before + text + after
		updateinfolinks()

/obj/item/paper/proc/updateinfolinks()
	info_links = info
	var/i = 0
	for(i=1,i<=fields,i++)
		addtofield(i, "<font face=\"[deffont]\"><A href='?src=\ref[src];write=[i]'>write</A></font>", 1)
	info_links = info_links + "<font face=\"[deffont]\"><A href='?src=\ref[src];write=end'>write</A></font>"


/obj/item/paper/proc/clearpaper()
	info = null
	stamps = null
	free_space = MAX_PAPER_MESSAGE_LEN
	stamped = list()
	overlays.Cut()
	updateinfolinks()
	update_icon()

/obj/item/paper/proc/get_signature(obj/item/pen/pen, mob/user)
	if(pen && istype(pen, /obj/item/pen))
		return pen.get_signature(user)
	return (user && user.real_name) ? user.real_name : "Anonymous"

/obj/item/paper/proc/parsepencode(t, obj/item/pen/pen, mob/user, iscrayon, isfancy, isadmin)
	if(length(t) == 0)
		return ""

	if (isadmin) //TODO: let admins sign things again
		t = replacetext(t, "\[sign\]", "")

	if (findtext(t, "\[sign\]"))
		t = replacetext(t, "\[sign\]", "<font face=\"[signfont]\"><i>[get_signature(pen, user)]</i></font>")

	if(iscrayon) // If it is a crayon, and he still tries to use these, make them empty!
		t = replacetext(t, "\[*\]", "")
		t = replacetext(t, "\[hr\]", "")
		t = replacetext(t, "\[small\]", "")
		t = replacetext(t, "\[/small\]", "")
		t = replacetext(t, "\[list\]", "")
		t = replacetext(t, "\[/list\]", "")
		t = replacetext(t, "\[table\]", "")
		t = replacetext(t, "\[/table\]", "")
		t = replacetext(t, "\[row\]", "")
		t = replacetext(t, "\[cell\]", "")
		t = replacetext(t, "\[logo\]", "")

	if(iscrayon)
		t = "<font face=\"[crayonfont]\" color=[pen ? pen.colour : "black"]><b>[t]</b></font>"
	else if(isfancy)
		t = "<font face=\"[fancyfont]\" color=[pen ? pen.colour : "black"]><i>[t]</i></font>"
	else
		t = "<font face=\"[deffont]\" color=[pen ? pen.colour : "black"]>[t]</font>"

	t = pencode2html(t)

	//Count the fields
	var/laststart = 1
	while(fields < MAX_FIELDS)
		var/i = findtext(t, "<span class=\"paper_field\">", laststart)	//</span>
		if(i==0)
			break
		laststart = i+1
		fields++

	return t


/* /obj/item/paper/proc/burnpaper(obj/item/lighter/lighter, mob/user)
	var/class = "warning"

	if(lighter.lit)
		if(istype(lighter, /obj/item/lighter))
			class = "rose"

		user.visible_message("<span class='[class]'>[user] holds \the [lighter] up to \the [src], it looks like \he's trying to burn it!</span>", \
		"<span class='[class]'>You hold \the [lighter] up to \the [src], burning it slowly.</span>")

		spawn(20)
			if(get_dist(src, user) < 2 && user.get_active_hand() == lighter && lighter.lit)
				user.visible_message("<span class='[class]'>[user] burns right through \the [src], turning it to ash. It flutters through the air before settling on the floor in a heap.</span>", \
				"<span class='[class]'>You burn right through \the [src], turning it to ash. It flutters through the air before settling on the floor in a heap.</span>")

				new /obj/effect/decal/cleanable/ash(get_turf(src))
				qdel(src)

			else
				to_chat(user, "<span class='warning'>You must hold \the [lighter] steady to burn \the [src].</span>") */ // Handled below - TODO -- DELETE/MERGE TOGETHER IF WORKING

/obj/item/proc/burn_paper_product_attackby_check(obj/item/item, mob/living/user, bypass_clumsy)
	var/ignition_message = item.ignition_effect(src, user)
	if(!ignition_message)
		return
	. = TRUE
	if(!bypass_clumsy && HAS_TRAIT(user, TRAIT_CLUMSY) && prob(10) && Adjacent(user))
		user.visible_message(span_warning("[user] accidentally ignites [user.p_them()]self!"), \
							span_userdanger("You miss [src] and accidentally light yourself on fire!"))
		if(user.is_holding(item)) //checking if they're holding it in case TK is involved
			user.dropItemToGround(item)
		user.adjust_fire_stacks(1)
		user.IgniteMob()
		return

	if(user.is_holding(src)) //no TK shit here.
		user.dropItemToGround(src)
	user.visible_message(ignition_message)
	add_fingerprint(user)
	fire_act(item.get_temperature())

/obj/item/paper/Topic(href, href_list)
	..()
	if(!usr || usr.stat)
		return
	var/mob/living/carbon/carbon_user = usr
	if(istype(carbon_user) && carbon_user.handcuffed)
		return

	if (href_list["change_language"])
		choose_language(usr)
		show_content(usr, editable = TRUE)
		return

	if(href_list["write"])
		var/id = href_list["write"]
		//var/t = strip_html_simple(input(usr, "What text do you wish to add to " + (id=="end" ? "the end of the paper" : "field "+id) + "?", "[name]", null),8192) as message

		if(free_space <= 0)
			to_chat(usr, "<span class='info'>There isn't enough space left on \the [src] to write anything.</span>")
			return

		var/obj/item/active_item = usr.get_active_held_item() // Check to see if he still got that darn pen, also check what type of pen
		var/iscrayon = FALSE
		var/isfancy = FALSE
		if(!istype(active_item, /obj/item/pen))
			/* Rigsuit shit, we don't have -- TODO delete if working
			if(usr.back && istype(usr.back,/obj/item/rig))
				var/obj/item/rig/r = usr.back
				var/obj/item/rig_module/device/pen/m = locate(/obj/item/rig_module/device/pen) in r.installed_modules
				if(!r.offline && m)
					active_item = m.device
				else
					return
			else
				return */

		var/obj/item/pen/active_pen = active_item
		if(!active_pen.active)
			var/obj/item/pen/retractable/active_rpen = active_pen
			if(istype(active_rpen))
				active_rpen.toggle()
			else
				to_chat(usr, span_warning("Something broke, and a non-retractable pen was retracted. Yell at coders."))
				active_pen.active = TRUE

		/*if(active_pen.iscrayon)
			iscrayon = TRUE */ // TODO -- WRITING CRAYONS

		if(active_pen.font == FOUNTAIN_PEN_FONT)
			isfancy = TRUE

		var/t =  stripped_multiline_input(usr, "Enter what you want to write:", "Write", null)

		if(!t)
			return

		// if paper is not in usr, then it must be near them, or in a clipboard or folder, which must be in or near usr
		if(src.loc != usr && !src.Adjacent(usr) && !((istype(src.loc, /obj/item/clipboard) || istype(src.loc, /obj/item/folder)) && (src.loc.loc == usr || src.loc.Adjacent(usr)) ) )
			return

		var/last_fields_value = fields

		t = parsepencode(t, active_item, usr, iscrayon, isfancy) // Encode everything from pencode to html


		if(fields > MAX_FIELDS)
			to_chat(usr, "<span class='warning'>Too many fields. Sorry, you can't do this.</span>")
			fields = last_fields_value
			return

		if(id!="end")
			addtofield(text2num(id), t) // He wants to edit a field, let him.
		else
			info += t // Oh, he wants to edit to the end of the file, let him.
			updateinfolinks()

		last_modified_ckey = usr.ckey

		update_space(t)

		show_content(usr, editable = TRUE)

		playsound(src, pick('modular_skyrat/modules/html_paperwork/sounds/pen1.ogg','modular_skyrat/modules/html_paperwork/sounds/pen2.ogg'), 10)
		update_icon()


/obj/item/paper/attackby(obj/item/weapon, mob/user)
	..()
	if(burn_paper_product_attackby_check(weapon, user))
		return
	var/clown = FALSE
	if(user.mind && (user.mind.assigned_role == "Clown"))
		clown = TRUE

	/*if(istype(weapon, /obj/item/stack/sticky_tape))
		var/obj/item/stack/sticky_tape/tape = weapon
		tape.stick_to_paper(src, user)
		tape.use(1)
		return */ // TODO -- TAPE

	if(istype(weapon, /obj/item/paper) || istype(weapon, /obj/item/photo))
		if(!can_bundle())
			return
		var/obj/item/paper/other = weapon
		if(istype(other) && !other.can_bundle())
			return
		/*if (istype(weapon, /obj/item/paper/carbon))
			var/obj/item/paper/carbon/carbon_paper = weapon
			if (!carbon_paper.iscopy && !carbon_paper.copied)
				to_chat(user, "<span class='notice'>Take off the carbon copy first.</span>")
				add_fingerprint(user)
				return */ // TODO -- CARBON PAPER
		/*var/obj/item/paper_bundle/bundle = new(src.loc)
		if (name != "paper")
			bundle.SetName(name)
		else if (weapon.name != "paper" && weapon.name != "photo")
			bundle.SetName(weapon.name)
		if(!user.transferItemToLoc(weapon, bundle) || !user.transferItemToLoc(src, bundle))
			return
		user.put_in_hands(bundle)

		to_chat(user, "<span class='notice'>You clip the [weapon.name] to [(src.name == "paper") ? "the paper" : src.name].</span>")

		bundle.pages.Add(src)
		bundle.pages.Add(weapon)
		bundle.update_icon()*/ //TODO - BUNDLES

	else if(istype(weapon, /obj/item/pen))
		if(icon_state == "scrap")
			to_chat(usr, "<span class='warning'>\The [src] is too crumpled to write on.</span>")
			return
		/*
		var/obj/item/pen/robopen/RP = weapon
		if ( istype(RP) && RP.mode == 2 )
			RP.RenamePaper(user,src)
		else */ // TODO - THIS
		show_content(user, editable = TRUE)
		return

	else if(istype(weapon, /obj/item/stamp)/* || istype(weapon, /obj/item/clothing/ring/seal)*/)
		if((!in_range(src, usr) && loc != user && !( istype(loc, /obj/item/clipboard) ) && loc.loc != user && user.get_active_hand() != weapon))
			return

		stamps += (stamps=="" ? "<HR>" : "<BR>") + "<i>This paper has been stamped with the [weapon.name].</i>"

		var/image/stampoverlay = image('icons/obj/bureaucracy.dmi')
		var/x
		var/y
		if(istype(weapon, /obj/item/stamp/captain) || istype(weapon, /obj/item/stamp/centcom))
			x = rand(-2, 0)
			y = rand(-1, 2)
		else
			x = rand(-2, 2)
			y = rand(-3, 2)
		offset_x += x
		offset_y += y
		stampoverlay.pixel_x = x
		stampoverlay.pixel_y = y

		if(istype(weapon, /obj/item/stamp/clown))
			if(!clown)
				to_chat(user, "<span class='notice'>You are totally unable to use the stamp. HONK!</span>")
				return

		if(!ico)
			ico = new
		ico += "paper_[weapon.icon_state]"
		stampoverlay.icon_state = "paper_[weapon.icon_state]"

		if(!stamped)
			stamped = new
		stamped += weapon.type
		overlays += stampoverlay

		playsound(src, 'modular_skyrat/modules/html_paperwork/sounds/stamp.ogg', 50, 1)
		to_chat(user, "<span class='notice'>You stamp the paper with your [weapon.name].</span>")

	else if(istype(weapon, /obj/item/lighter))
		burn_paper_product_attackby_check(weapon, user)

	/*else if(istype(weapon, /obj/item/paper_bundle))
		if(!can_bundle())
			return
		var/obj/item/paper_bundle/attacking_bundle = weapon
		attacking_bundle.insert_sheet_at(user, (attacking_bundle.pages.len)+1, src)
		attacking_bundle.update_icon() */ // TODO -- BUNDLES

	add_fingerprint(user)

/obj/item/paper/proc/can_bundle()
	return TRUE

/obj/item/paper/proc/show_info(var/mob/user)
	return info


//For supply.
/obj/item/paper/manifest
	name = "supply manifest"
	var/is_copy = 1
/*
 * Premade paper
 */
/obj/item/paper/spacer
	language = LANGUAGE_SPACER

/obj/item/paper/Court
	name = "Judgement"
	info = "For crimes as specified, the offender is sentenced to:<BR>\n<BR>\n"

/obj/item/paper/crumpled
	name = "paper scrap"
	icon_state = "scrap"

/obj/item/paper/crumpled/bloody
	icon_state = "scrap_bloodied"

/obj/item/paper/exodus_armory
	name = "armory inventory"
	info = "<center>\[logo]<BR><b><large>NSS Exodus</large></b><BR><i><date></i><BR><i>Armoury Inventory - Revision <field></i></center><hr><center>Armoury</center><list>\[*]<b>Deployable barriers</b>: 4\[*]<b>Biohazard suit(s)</b>: 1\[*]<b>Biohazard hood(s)</b>: 1\[*]<b>Face Mask(s)</b>: 1\[*]<b>Extended-capacity emergency oxygen tank(s)</b>: 1\[*]<b>Bomb suit(s)</b>: 1\[*]<b>Bomb hood(s)</b>: 1\[*]<b>Security officer's jumpsuit(s)</b>: 1\[*]<b>Brown shoes</b>: 1\[*]<b>Handcuff(s)</b>: 14\[*]<b>R.O.B.U.S.T. cartridges</b>: 7\[*]<b>Flash(s)</b>: 4\[*]<b>Can(s) of pepperspray</b>: 4\[*]<b>Gas mask(s)</b>: 6<field></list><hr><center>Secure Armoury</center><list>\[*]<b>LAEP90 Perun energy guns</b>: 4\[*]<b>Stun Revolver(s)</b>: 1\[*]<b>Electrolaser(s)</b>: 4\[*]<b>Stun baton(s)</b>: 4\[*]<b>Airlock Brace</b>: 3\[*]<b>Maintenance Jack</b>: 1\[*]<b>Stab Vest(s)</b>: 3\[*]<b>Riot helmet(s)</b>: 3\[*]<b>Riot shield(s)</b>: 3\[*]<b>Corporate security heavy armoured vest(s)</b>: 4\[*]<b>NanoTrasen helmet(s)</b>: 4\[*]<b>Portable flasher(s)</b>: 3\[*]<b>Tracking implant(s)</b>: 4\[*]<b>Chemical implant(s)</b>: 5\[*]<b>Implanter(s)</b>: 2\[*]<b>Implant pad(s)</b>: 2\[*]<b>Locator(s)</b>: 1<field></list><hr><center>Tactical Equipment</center><list>\[*]<b>Implanter</b>: 1\[*]<b>Death Alarm implant(s)</b>: 7\[*]<b>Security radio headset(s)</b>: 4\[*]<b>Ablative vest(s)</b>: 2\[*]<b>Ablative helmet(s)</b>: 2\[*]<b>Ballistic vest(s)</b>: 2\[*]<b>Ballistic helmet(s)</b>: 2\[*]<b>Tear Gas Grenade(s)</b>: 7\[*]<b>Flashbang(s)</b>: 7\[*]<b>Beanbag Shell(s)</b>: 7\[*]<b>Stun Shell(s)</b>: 7\[*]<b>Illumination Shell(s)</b>: 7\[*]<b>W-T Remmington 29x shotgun(s)</b>: 2\[*]<b>NT Mk60 EW Halicon ion rifle(s)</b>: 2\[*]<b>Hephaestus Industries G40E laser carbine(s)</b>: 4\[*]<b>Flare(s)</b>: 4<field></list><hr><b>Warden (print)</b>:<field><b>Signature</b>:<br>"

/obj/item/paper/exodus_cmo
	name = "outgoing CMO's notes"
	info = "<I><center>To the incoming CMO of Exodus:</I></center><BR><BR>I wish you and your crew well. Do take note:<BR><BR><BR>The Medical Emergency Red Phone system has proven itself well. Take care to keep the phones in their designated places as they have been optimised for broadcast. The two handheld green radios (I have left one in this office, and one near the Emergency Entrance) are free to be used. The system has proven effective at alerting Medbay of important details, especially during power outages.<BR><BR>I think I may have left the toilet cubicle doors shut. It might be a good idea to open them so the staff and patients know they are not engaged.<BR><BR>The new syringe gun has been stored in secondary storage. I tend to prefer it stored in my office, but 'guidelines' are 'guidelines'.<BR><BR>Also in secondary storage is the grenade equipment crate. I've just realised I've left it open - you may wish to shut it.<BR><BR>There were a few problems with their installation, but the Medbay Quarantine shutters should now be working again  - they lock down the Emergency and Main entrances to prevent travel in and out. Pray you shan't have to use them.<BR><BR>The new version of the Medical Diagnostics Manual arrived. I distributed them to the shelf in the staff break room, and one on the table in the corner of this room.<BR><BR>The exam/triage room has the walking canes in it. I'm not sure why we'd need them - but there you have it.<BR><BR>Emergency Cryo bags are beside the emergency entrance, along with a kit.<BR><BR>Spare paper cups for the reception are on the left side of the reception desk.<BR><BR>I've fed Runtime. She should be fine.<BR><BR><BR><center>That should be all. Good luck!</center>"

/obj/item/paper/exodus_bartender
	name = "shotgun permit"
	info = "This permit signifies that the Bartender is permitted to posess this firearm in the bar, and ONLY the bar. Failure to adhere to this permit will result in confiscation of the weapon and possibly arrest."

/obj/item/paper/exodus_holodeck
	name = "holodeck disclaimer"
	info = "Bruises sustained in the holodeck can be healed simply by sleeping."

/obj/item/paper/workvisa
	name = "Sol Work Visa"
	info = "<center><b><large>Work Visa of the Sol Central Government</large></b></center><br><center><img src = sollogo.png><br><br><i><small>Issued on behalf of the Secretary-General.</small></i></center><hr><BR>This paper hereby permits the carrier to travel unhindered through Sol territories, colonies, and space for the purpose of work and labor."
	desc = "A flimsy piece of laminated cardboard issued by the Sol Central Government."

/obj/item/paper/workvisa/New()
	..()
	icon_state = "workvisa" //Has to be here or it'll assume default paper sprites.

/obj/item/paper/travelvisa
	name = "Sol Travel Visa"
	info = "<center><b><large>Travel Visa of the Sol Central Government</large></b></center><br><center><img src = sollogo.png><br><br><i><small>Issued on behalf of the Secretary-General.</small></i></center><hr><BR>This paper hereby permits the carrier to travel unhindered through Sol territories, colonies, and space for the purpose of pleasure and recreation."
	desc = "A flimsy piece of laminated cardboard issued by the Sol Central Government."

/obj/item/paper/travelvisa/New()
	..()
	icon_state = "travelvisa"

/obj/item/paper/aromatherapy_disclaimer
	name = "aromatherapy disclaimer"
	info = "<I>The manufacturer and the retailer make no claims of the contained products' effacy.</I> <BR><BR><B>Use at your own risk.</B>"

/**
 * Construction paper
 */
/obj/item/paper/construction

/obj/item/paper/construction/Initialize()
	. = ..()
	color = pick("FF0000", "#33cc33", "#ffb366", "#551A8B", "#ff80d5", "#4d94ff")

/**
 * Natural paper
 */
/obj/item/paper/natural/Initialize()
	. = ..()
	color = "#FFF5ED"

/obj/item/paper/crumpled
	name = "paper scrap"
	icon_state = "scrap"
	slot_flags = null
	show_written_words = FALSE

/obj/item/paper/crumpled/bloody
	icon_state = "scrap_bloodied"

/obj/item/paper/crumpled/muddy
	icon_state = "scrap_mud"


#undef PAPER_CAMERA_DISTANCE
#undef PAPER_EYEBALL_DISTANCE

#undef PAPER_META
#undef PAPER_META_BAD
