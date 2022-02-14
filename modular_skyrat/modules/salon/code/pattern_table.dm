#define DMI_TUTORIAL_URL "https://file.house/o2mE.png"
/obj/item/pattern_kit
	name = "pattern kit"
	desc = "A pattern kit for clothing."
	icon = 'modular_skyrat/modules/salon/icons/items.dmi'
	icon_state = "pattern_kit"
	var/datum/tailor_clothing/clothing_datum

/obj/item/pattern_kit/proc/update_details()
	name = "[clothing_datum.name] pattern kit"
	desc = "A pattern kit to manufacture [clothing_datum.desc] at a sewing machine."

/obj/machinery/pattern_table
	name = "pattern table"
	desc = "Use this to design new clothing! Left click to design a new clothing item, right click to print an existing pattern!"
	icon = 'modular_skyrat/modules/salon/icons/machinery.dmi'
	icon_state = "pattern"
	use_power = IDLE_POWER_USE
	idle_power_usage = 2
	active_power_usage = 500
	density = TRUE
	interaction_flags_atom = INTERACT_ATOM_ATTACK_HAND // Otherwise it opens the UI every time.
	var/list/pattern_categories = list("Back","Face","Neck","Belt","Ears","Glasses","Gloves","Hat","Shoes","Suit","Jumpsuit")
	var/selected_category = "Jumpsuit"
	var/printing = FALSE

/obj/machinery/pattern_table/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "PatternTable")
		ui.open()

/obj/machinery/pattern_table/ui_act(action, params)
	. = ..()
	if(.)
		return
	switch(action)
		if("select_category")
			selected_category = params["category"]
			if(!(selected_category in pattern_categories)) // nice try
				selected_category = "Jumpsuit"
			. = TRUE
		if("print_pattern")
			var/selected_pattern = params["pattern_id"]
			if(printing)
				balloon_alert(usr, "already printing!")
				return
			var/datum/tailor_clothing/clothing_datum = SSclothing_database.clothing_loaded[selected_pattern]
			if(clothing_datum.banned)
				balloon_alert(usr, "banned pattern!")
				return
			playsound(src, 'sound/items/poster_being_created.ogg', 100)
			printing = TRUE
			if(do_after(usr, 3 SECONDS, src))
				var/obj/item/pattern_kit/new_pattern = new(get_turf(src))
				new_pattern.clothing_datum = SSclothing_database.clothing_loaded[selected_pattern]
				new_pattern.update_details()
			printing = FALSE
			. = TRUE
		if("ban_pattern_admin")
			var/is_admin = is_admin(usr.client)
			if(!is_admin)
				balloon_alert(usr, "not an admin!") // The button shouldn't be available, but cheeky fuckers messing with tgui could send this input anyways so we sanity check.
				return
			var/selected_pattern = params["pattern_id"]
			var/are_you_sure = tgui_alert(usr, "ADMIN: Are you sure you want to ban this pattern?", "Pattern Ban", list("Yes", "No"))
			if(are_you_sure == "Yes")
				var/datum/tailor_clothing/clothing_datum = SSclothing_database.clothing_loaded[selected_pattern]
				clothing_datum.ban_pattern()
				message_admins("[key_name(usr)] banned [clothing_datum.name] (ID #[clothing_datum.id]) from the pattern database.")
				log_admin("[key_name(usr)] banned [clothing_datum.name] (ID #[clothing_datum.id]) from the pattern database.")
			. = TRUE

/obj/machinery/pattern_table/ui_data(mob/user)
	var/list/data = list()
	var/list/patterns = list()
	var/is_admin = is_admin(user.client)
	for(var/datum/tailor_clothing/clothing_datum in SSclothing_database.clothing_loaded)
		if(selected_category == clothing_datum.slot && !clothing_datum.banned)
			patterns.Add(list(clothing_datum.get_list()))
			var/icon/inventory_icon = new(file("data/clothing_icons/[clothing_datum.id].dmi"), "inventory")
			user << browse_rsc(inventory_icon, "clothing_[clothing_datum.id].png")
	data["patterns"] = patterns
	data["category"] = selected_category
	data["is_admin"] = is_admin
	return data

/obj/machinery/pattern_table/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(LAZYACCESS(modifiers, RIGHT_CLICK))
		print_patterns(user, modifiers)
	else
		if(is_banned_from(user.ckey, BAN_CLOTHING))
			to_chat(user, "You are banned from uploading custom clothing.")
			return
		create_pattern(user, modifiers)

/obj/machinery/pattern_table/proc/print_patterns(mob/living/user, list/modifiers)
	ui_interact(user)
	return

/obj/machinery/pattern_table/proc/create_pattern(mob/living/user, list/modifiers)
	var/has_dmi = tgui_alert(user, "Do you have a prepared .dmi file?", "Pattern Design", list("Yes", "No"))
	if(!has_dmi || has_dmi == "No")
		user.balloon_alert(user, "see chat!")
		to_chat(user, "Please see [DMI_TUTORIAL_URL] for an example of a properly set up 32x32 .dmi file from inside Dream Maker.")
		to_chat(user, "If the URL does not function for you, your .dmi file will need an onmob icon state with the 4 cardinal directions, and an inventory icon state.")
		to_chat(user, "If you want your clothing to support digitigrade, you can add an onmob_digit icon state. This is optional, and isn't required.")
		to_chat(user, "Clothing .dmi files must be 32x32.")
		return
	var/clothing_icon_upload = input("Select your clothing .dmi:","Icon") as null|icon
	if(!clothing_icon_upload)
		user.balloon_alert(user, "no .dmi selected!")
		return
	if(!isicon(clothing_icon_upload))
		user.balloon_alert(user, ".dmi file invalid/broken!")
		return
	var/icon/clothing_icon = new(clothing_icon_upload)
	if(!clothing_icon)
		user.balloon_alert(user, ".dmi file invalid/broken!")
		return
	if(clothing_icon.Width() != 32 || clothing_icon.Height() != 32)
		user.balloon_alert(user, ".dmi file not 32x32!")
		return
	var/list/icon_states = icon_states(clothing_icon)
	if(!("onmob" in icon_states))
		user.balloon_alert(user, "missing onmob icon state!")
		return
	if(!("inventory" in icon_states))
		user.balloon_alert(user, "missing inventory icon state!")
		return
	var/digitigrade = FALSE
	if("onmob_digit" in icon_states)
		digitigrade = TRUE
	if(icon_states.len > 3)
		user.balloon_alert(user, "too many icon states!")
		return
	var/clothing_name = tgui_input_text(user, "Enter a name for your clothing:", "Pattern Design", max_length = MAX_NAME_LEN)
	if(!clothing_name)
		user.balloon_alert(user, "no name entered!")
		return
	var/clothing_desc = tgui_input_text(user, "Enter a description for your clothing:", "Pattern Design", multiline = TRUE)
	if(!clothing_desc)
		user.balloon_alert(user, "no desc entered!")
		return
	var/author = tgui_input_text(user, "Enter the author of the clothing sprites:", "Pattern Design", max_length = MAX_NAME_LEN)
	if(!author)
		user.balloon_alert(user, "no author entered!")
		return
	var/ckey_author = user.ckey
	var/slot_input = tgui_input_list(user, "Select a slot for your clothing:", "Pattern Design", list("Back","Face","Neck","Belt","Ears","Glasses","Gloves","Hat","Shoes","Suit","Jumpsuit"))
	if(!slot_input)
		user.balloon_alert(user, "no slot selected!")
		return
	// register the pattern
	var/datum/tailor_clothing/new_clothing = new
	new_clothing.name = clothing_name
	new_clothing.desc = clothing_desc
	new_clothing.ckey_author = ckey_author
	new_clothing.author = author
	new_clothing.slot = slot_input
	new_clothing.digitigrade = digitigrade
	SSclothing_database.register_clothing(new_clothing, clothing_icon)
	user.balloon_alert(user, "pattern uploaded!")
	var/obj/item/pattern_kit/pattern_kit_new = new(get_turf(src))
	pattern_kit_new.clothing_datum = new_clothing
	pattern_kit_new.update_details()
