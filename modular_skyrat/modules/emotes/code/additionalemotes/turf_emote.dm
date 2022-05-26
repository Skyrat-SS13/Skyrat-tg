/mob/living
	var/obj/owned_turf
	var/list/allowed_turfs = list()

/datum/emote/living/mark_turf
	key = "turf"
	key_third_person = "turf"
	cooldown = 4 SECONDS
	/// The current turf ID that the user selected in the radial menu.
	var/current_turf

/datum/emote/living/mark_turf/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	var/mob/living/carbon/human/human_user = user

	if(ishuman(user))
		//feet
		if(!(human_user.dna.species.bodytype & BODYTYPE_DIGITIGRADE) && !(human_user.dna.species.mutant_bodyparts["taur"]))
			user.allowed_turfs += "footprint"

		if((human_user.dna.species.bodytype & BODYTYPE_DIGITIGRADE) || human_user.dna.species.mutant_bodyparts["taur"])
			user.allowed_turfs += list("pawprint", "hoofprint", "clawprint")

		//species & taurs
		if(islizard(user) || issynthliz(user) || HAS_TRAIT(user, TRAIT_ASH_ASPECT))
			user.allowed_turfs += "smoke"
			user.allowed_turfs -= list("pawprint", "hoofprint")

		if(isplasmaman(user))
			if(human_user.w_uniform && istype(human_user.w_uniform, /obj/item/clothing/under/plasmaman))
				user.allowed_turfs += "holoseat"

		if(isroundstartslime(user) || isslimeperson(user) || isjellyperson(user))
			user.allowed_turfs += "slime"

		if(isxenohybrid(user))
			user.allowed_turfs += "xenoresin"

		if(isinsect(user) || HAS_TRAIT(user, TRAIT_WEBBING_ASPECT))
			user.allowed_turfs += "web"

		if(isaquatic(user) || isakula(user) || HAS_TRAIT(user, TRAIT_WATER_ASPECT))
			user.allowed_turfs += "water"

		if(ispodperson(user) || ispodweak(user) || HAS_TRAIT(user, TRAIT_FLORAL_ASPECT))
			user.allowed_turfs += "vines"

		if(isipc(user) || issynthanthro(user) || issynthhuman(user) || issynthliz(user))
			if(human_user.dna.species.mutant_bodyparts["taur"])
				user.allowed_turfs += "holobed" //taurs get the holobed instead
			else
				user.allowed_turfs += "holoseat"

		//wings
		if((istype(user.getorganslot(ORGAN_SLOT_WINGS), /obj/item/organ/external/wings/moth)) || HAS_TRAIT(user, TRAIT_SPARKLE_ASPECT))
			user.allowed_turfs += "dust" //moth's dust ✨

		//body parts
		if(istype(user.getorganslot(ORGAN_SLOT_TAIL), /obj/item/organ/tail))
			var/name = human_user.dna.species.mutant_bodyparts["tail"][MUTANT_INDEX_NAME]
			var/datum/sprite_accessory/tails/tail = GLOB.sprite_accessories["tail"][name]
			if(tail.fluffy)
				user.allowed_turfs += "tails"

		if(human_user.dna.species.mutant_bodyparts["taur"])
			var/name = human_user.dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]
			var/datum/sprite_accessory/taur/taur = GLOB.sprite_accessories["taur"][name]
			if(taur.taur_mode & STYLE_TAUR_SNAKE)
				user.allowed_turfs -= list("pawprint", "hoofprint", "clawprint")
				user.allowed_turfs += "constrict"

		//clothing
		var/obj/item/shoes = user.get_item_by_slot(ITEM_SLOT_FEET)
		if(istype(shoes, /obj/item/clothing/shoes))
			if(!human_user.dna.species.mutant_bodyparts["taur"])
				user.allowed_turfs += "shoeprint"

	if(issilicon(user))
		user.allowed_turfs += list("holoseat", "holobed", "borgmat")


	var/list/display_turf = list()
	for(var/choice in user.allowed_turfs)

		var/datum/radial_menu_choice/option = new
		option.image = image(icon = 'modular_skyrat/master_files/icons/effects/turf_effects_icons.dmi', icon_state = initial(choice))

		display_turf[initial(choice)] = option

	sort_list(display_turf)
	var/chosen_turf = show_radial_menu(user, user, display_turf, custom_check = CALLBACK(src, .proc/check_menu, user))

	if(QDELETED(src) || QDELETED(user) || !chosen_turf)
		return FALSE

	if(do_after(user, 1 SECONDS))
		current_turf = chosen_turf

		user.owned_turf = new /obj/structure/mark_turf(get_turf(user), current_turf)
		user.owned_turf.dir = user.dir

		if(ishuman(user))
			human_user.update_mutant_bodyparts()

		var/list/DNA_trail = list("shoeprint", "footprint", "pawprint", "hoofprint", "clawprint")
		if(current_turf in DNA_trail) //These turfs leave clues of their owner
			user.owned_turf.add_fingerprint(user)


		var/list/colorable = list("dust", "slime", "vines", "footprint", "pawprint", "hoofprint", "clawprint")
		if(current_turf in colorable) //These turfs are simply colored after their owner's primary
			if(ishumanbasic(user) || ishumanoid(user))
				user.owned_turf.color = human_user.dna.features["skin_color"]
			else
				user.owned_turf.color = human_user.dna.features["mcolor"]


		var/list/body_part = list("tails", "constrict")
		if(current_turf in body_part) //These turfs can be a body part and need color/size applied
			var/key = null

			var/list/tail_emotes = list("tails")
			if(current_turf in tail_emotes)
				key = "tail"
			var/list/taur_emotes = list("constrict")
			if(current_turf in taur_emotes)
				key = "taur"

			//coloring
			var/list/finished_list = list()
			var/list/color_list = human_user.dna.species.mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] //identify color
			var/datum/sprite_accessory/sprite_type = GLOB.sprite_accessories[key][human_user.dna.species.mutant_bodyparts[key][MUTANT_INDEX_NAME]] //identify type

			switch(sprite_type.color_src)
				if(USE_MATRIXED_COLORS)
					finished_list += ReadRGB("[color_list[1]]00")
					finished_list += ReadRGB("[color_list[2]]00")
					finished_list += ReadRGB("[color_list[3]]00")
				if(USE_ONE_COLOR)
					var/padded_string = "[color_list[1]]00"
					finished_list += ReadRGB(padded_string)
					finished_list += ReadRGB(padded_string)
					finished_list += ReadRGB(padded_string)

			finished_list += list(0,0,0,255)
			for(var/index in 1 to finished_list.len)
				finished_list[index] /= 255

			user.owned_turf.color = finished_list
			if(isroundstartslime(user) || isslimeperson(user) || isjellyperson(user))
				user.owned_turf.alpha = 130

			//scaling
			var/atom/movable/owned_turf = user.owned_turf
			var/change_multiplier = human_user.dna.features["body_size"] / BODY_SIZE_NORMAL
			var/translate = ((change_multiplier-1) * 32)/2
			owned_turf.transform = owned_turf.transform.Scale(change_multiplier)
			owned_turf.transform = owned_turf.transform.Translate(0, translate)
			owned_turf.appearance_flags = PIXEL_SCALE

		RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/turf_owner, override = TRUE)

	return ..()

/datum/emote/living/mark_turf/select_message_type(mob/living/user, intentional)
	. = ..()

	if(current_turf == "web")
		user.spin(8, 1) //Ssspin a web

	current_turf = null
	LAZYCLEARLIST(user.allowed_turfs)


/datum/emote/living/mark_turf/proc/check_menu(mob/living/user)
	if(user.owned_turf != null)
		return FALSE
	if(isspaceturf(get_turf(user)))
		return FALSE
	if(user.buckled)
		return FALSE
	else
		return TRUE

/datum/emote/living/mark_turf/proc/turf_owner(mob/living/user)
	SIGNAL_HANDLER
	UnregisterSignal(user, COMSIG_MOVABLE_MOVED)

	var/obj/owned_turf = user.owned_turf
	INVOKE_ASYNC(owned_turf, /obj/structure/mark_turf/proc/turf_check, user)
