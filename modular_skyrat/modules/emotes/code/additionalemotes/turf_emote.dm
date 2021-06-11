var/current_turf

/mob/living
	var/obj/owned_turf
	var/list/allowed_turfs = list()

/datum/emote/living/mark_turf
	key = "turf"
	key_third_person = "turf"
	cooldown = 10 SECONDS

/datum/emote/living/mark_turf/run_emote(mob/living/user, params, type_override, intentional)
	. = ..()
	var/mob/living/carbon/human/H = user

	if(ishuman(user))
		if(!(DIGITIGRADE in H.dna.species.species_traits) && !(H.dna.species.mutant_bodyparts["taur"]))
			user.allowed_turfs += "footprint"

		//species & taurs
		if(ismammal(user) || issynthanthro(user))
			if((DIGITIGRADE in H.dna.species.species_traits) || H.dna.species.mutant_bodyparts["taur"])
				user.allowed_turfs += list("pawprint", "hoofprint", "clawprint")

		if(islizard(user) || issynthliz(user) || HAS_TRAIT(user, TRAIT_ASH_ASPECT))
			user.allowed_turfs += "smoke"

			if((DIGITIGRADE in H.dna.species.species_traits) || H.dna.species.mutant_bodyparts["taur"])
				user.allowed_turfs += "clawprint"

			var/list/snake_taurs = list("Naga", "Cybernetic Naga")
			if(H.dna.species.mutant_bodyparts["taur"])
				if(H.dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME] in snake_taurs)
					user.allowed_turfs -= "clawprint" //e
					if(!(H.wear_suit && istype(H.wear_suit, /obj/item/clothing/suit/space/hardsuit)))
						user.allowed_turfs += "constrict"

		if(isplasmaman(user))
			if(H.w_uniform && istype(H.w_uniform, /obj/item/clothing/under/plasmaman))
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
			if(H.dna.species.mutant_bodyparts["taur"])
				user.allowed_turfs += "holobed" //taurs get the holobed instead
			else
				user.allowed_turfs += "holoseat"

		//wings
		if(istype(user.getorganslot(ORGAN_SLOT_WINGS), /obj/item/organ/wings/moth))
			user.allowed_turfs += "dust" //moth's dust ✨

		//tail time
		if(istype(user.getorganslot(ORGAN_SLOT_TAIL), /obj/item/organ/tail))
			var/list/fluffy_tails = list("Tamamo Kitsune Tails", "Sergal", "Fox", "Fox (Alt 2)", "Fox (Alt 3)", "Fennec", "Red Panda", "Husky", "Skunk", "Lunasune", "Squirrel", "Wolf", "Stripe", "Kitsune", "Leopard")
			if(H.dna.species.mutant_bodyparts["tail"][MUTANT_INDEX_NAME] in fluffy_tails)
				user.allowed_turfs += "tails"

		//clothing
		var/obj/item/O = user.get_item_by_slot(ITEM_SLOT_FEET)
		if(istype(O, /obj/item/clothing/shoes))
			if(!H.dna.species.mutant_bodyparts["taur"])
				user.allowed_turfs += "shoeprint"

	if(issilicon(user))
		user.allowed_turfs += list("holoseat", "holobed", "borgmat")


	var/list/display_turf = list()
	for(var/choice in user.allowed_turfs)

		var/datum/radial_menu_choice/option = new
		option.image = image(icon = 'modular_skyrat/master_files/icons/effects/turf_effects_icons.dmi', icon_state = initial(choice))

		display_turf[initial(choice)] = option

	sortList(display_turf)
	var/chosen_turf = show_radial_menu(user, user, display_turf, custom_check = CALLBACK(src, .proc/check_menu, user))

	if(QDELETED(src) || QDELETED(user) || !chosen_turf)
		return FALSE

	if(do_after(user,10))
		current_turf = chosen_turf

		var/obj/turf_icon = /obj/structure/mark_turf
		user.owned_turf = new turf_icon(get_turf(user))
		user.owned_turf.dir = user.dir

		if(ishuman(user))
			H.update_mutant_bodyparts()

		var/list/DNA_trail = list("shoeprint", "footprint", "pawprint", "hoofprint", "clawprint")
		if(current_turf in DNA_trail) //These turfs leave clues of their owner
			user.owned_turf.add_fingerprint(user)


		var/list/colorable = list("dust", "slime", "vines", "footprint", "pawprint", "hoofprint", "clawprint")
		if(current_turf in colorable) //These turfs are simply colored after their owner's primary
			if(ishumanbasic(user) || ishumanoid(user))
				user.owned_turf.color = "#" + H.dna.features["skin_color"]
			else
				user.owned_turf.color = "#" + H.dna.features["mcolor"]


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
			var/list/color_list = H.dna.species.mutant_bodyparts[key][MUTANT_INDEX_COLOR_LIST] //identify color
			var/datum/sprite_accessory/S = GLOB.sprite_accessories[key][H.dna.species.mutant_bodyparts[key][MUTANT_INDEX_NAME]] //identify type

			switch(S.color_src)
				if(USE_MATRIXED_COLORS)
					finished_list += ReadRGB("[color_list[1]]0")
					finished_list += ReadRGB("[color_list[2]]0")
					finished_list += ReadRGB("[color_list[3]]0")
				if(USE_ONE_COLOR)
					finished_list += ReadRGB("[color_list[1]]0")
					finished_list += ReadRGB("[color_list[1]]0")
					finished_list += ReadRGB("[color_list[1]]0")

			finished_list += list(0,0,0,255)
			for(var/index in 1 to finished_list.len)
				finished_list[index] /= 255

			user.owned_turf.color = finished_list

			//scaling
			var/atom/movable/A = user.owned_turf
			var/change_multiplier = H.dna.features["body_size"] / BODY_SIZE_NORMAL
			var/translate = ((change_multiplier-1) * 32)/2
			A.transform = A.transform.Scale(change_multiplier)
			A.transform = A.transform.Translate(0, translate)
			A.appearance_flags = PIXEL_SCALE

		RegisterSignal(user, COMSIG_MOVABLE_MOVED, .proc/turf_owner, override = TRUE)

	return ..()

/datum/emote/living/mark_turf/select_message_type(mob/living/user, intentional)
	. = ..()

	switch(current_turf)
		if("web")
			user.spin(8, 1) //Ssspin a web
			. = "neatly spins a web beneath themself."
		if("water")
			. = "submerges their surroundings in a pool of water."
		if("vines")
			. = "sprouts vines reaching down beneath themself."
		if("dust")
			. = "flutters their wings, scattering their dust around."
		if("smoke")
			. = "expirates a mist of ashes around themself."
		if("slime")
			. = "splits their gel, forming an oozing shape."
		if("xenoresin")
			. = "secretes thick resin, covering the ground beneath themself."
		if("holoseat")
			. = "artificially summons a seat beneath themself."
		if("holobed")
			. = "artificially summons a bed beneath themself."
		if("borgmat")
			. = "dispenses a soft mat, rolling it out beneath themself."
		else
			return

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
	UnregisterSignal(user, COMSIG_MOVABLE_MOVED)

	var/obj/owned_turf = user.owned_turf
	INVOKE_ASYNC(owned_turf, /obj/structure/mark_turf/proc/turf_check, user)
