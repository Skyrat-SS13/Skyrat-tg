/obj/structure/mark_turf
	name = "turf"
	icon = 'modular_skyrat/master_files/icons/effects/turf_effects.dmi'
	desc = "It's turf." //Debug stuff, won't be seen
	anchored = TRUE
	density = FALSE
	max_integrity = 15

/obj/structure/mark_turf/Initialize()
	. = ..()

	switch(current_turf)
		if("web")
			name = "hand-sewn web"
			desc = "It's a sticky web."
			icon_state = pick("stickyweb1", "stickyweb2")

		if("vines")
			name = "sprouted vines"
			desc = "It's an entanglement of vines."
			icon_state = pick("kudzu1", "kudzu1", "kudzu3")

		if("water")
			name = "puddle of water"
			desc = "It's a patch of water."
			icon_state = "water"
			src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "water_top", ABOVE_MOB_LAYER))
			flick_overlay_static(image('modular_skyrat/modules/liquids/icons/obj/effects/splash.dmi', "splash", ABOVE_MOB_LAYER), src, 20)

		if("smoke")
			name = "lizard's smoke"
			desc = "It's a mist of smoke."
			icon_state = "smoke"
			src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "smoke_top", ABOVE_MOB_LAYER))

		if("xenoresin")
			name = "resin"
			desc = "Looks like some kind of thick resin."
			icon_state = "xenoresin"

		if("holobed")
			name = "physical hologram"
			desc = "It's a hologram of a pet bed."
			icon_state = "holobed"

		if("holoseat")
			name = "physical hologram"
			desc = "It's a hologram of a barstool."
			icon_state = "holoseat"
			src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "holoseat_top", ABOVE_MOB_LAYER))

		if("slime")
			name = "pile of oozing slime"
			desc = "It's just a bunch of slime."
			playsound(get_turf(src), 'sound/misc/soggy.ogg', 50, TRUE)
			switch(rand(1,100))
				if(-INFINITY to 40)
					icon_state = "slimeobj1"
					src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "slimeobj1_top", ABOVE_MOB_LAYER))
				if(40 to 80)
					icon_state = "slimeobj2"
					src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "slimeobj2_top", ABOVE_MOB_LAYER))
				if(80 to 98)
					icon_state = "slimeobj3"
					src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects.dmi', "slimeobj3_top", ABOVE_MOB_LAYER))
				if(98 to INFINITY)
					name = "slime bust" //rare obj/item/statuebust
					desc = "A priceless slime bust, the kind that belongs in a museum."
					icon_state = "slimeobj4"
					AddElement(/datum/element/art, GREAT_ART)
				else
					return

		if("dust")
			name = "cloud of dust"
			desc = "It's a cloud of glittering moth's dust."
			icon = 'modular_skyrat/master_files/icons/effects/turf_effects_64.dmi'
			icon_state = "dust"
			pixel_x = -16
			src.add_overlay(image('modular_skyrat/master_files/icons/effects/turf_effects_64.dmi', "dust_top", ABOVE_MOB_LAYER))

		if("borgmat")
			name = "soft-foam mat"
			desc = "It's a rolled out mat, doesn't include wireless charging."
			icon = 'modular_skyrat/master_files/icons/effects/turf_effects_64.dmi'
			icon_state = "borgmat"
			pixel_x = -16
			pixel_y = -4
			playsound(get_turf(src), 'sound/items/handling/taperecorder_pickup.ogg', 50, TRUE)

		//bodyparts
		if("tails")
			name = "tail"
			desc = "It's a fluffy tail."
			icon = 'modular_skyrat/master_files/icons/effects/turf_effects_64.dmi'
			icon_state = "tails"
			pixel_x = -16 //correcting the offset for 64
			var/mutable_appearance/overlay = mutable_appearance('modular_skyrat/master_files/icons/effects/turf_effects_64.dmi', "tails_top", ABOVE_MOB_LAYER)
			overlay.appearance_flags = TILE_BOUND|PIXEL_SCALE|KEEP_TOGETHER
			src.add_overlay(overlay)

		if("constrict")
			name = "tail"
			desc = "It's a scaly tail."
			icon = 'modular_skyrat/master_files/icons/effects/turf_effects_64.dmi'
			icon_state = "naga"
			pixel_x = -16
			var/mutable_appearance/overlay = mutable_appearance('modular_skyrat/master_files/icons/effects/turf_effects_64.dmi', "naga_top", ABOVE_MOB_LAYER)
			overlay.appearance_flags = TILE_BOUND|PIXEL_SCALE|KEEP_TOGETHER
			src.add_overlay(overlay)

		//prints
		if("pawprint")
			name = "pawprint"
			desc = "It's a pawprint left on the ground."
			icon_state = pick("pawprint", "pawprint1")
			playsound(get_turf(src), pick('sound/effects/footstep/hardbarefoot1.ogg',
			'sound/effects/footstep/hardbarefoot2.ogg',
			'sound/effects/footstep/hardbarefoot3.ogg',
			'sound/effects/footstep/hardbarefoot4.ogg',
			'sound/effects/footstep/hardbarefoot5.ogg'), 50)

		if("hoofprint")
			name = "hoofprint"
			desc = "It's a hoofprint left on the ground."
			icon_state = pick("hoofprint", "hoofprint1")
			playsound(get_turf(src), pick('sound/effects/footstep/hardbarefoot1.ogg',
			'sound/effects/footstep/hardbarefoot2.ogg',
			'sound/effects/footstep/hardbarefoot3.ogg',
			'sound/effects/footstep/hardbarefoot4.ogg',
			'sound/effects/footstep/hardbarefoot5.ogg'), 50)
		if("footprint")
			name = "footprint"
			desc = "It's a footprint left on the ground."
			icon_state = pick("footprint", "footprint1")
			playsound(get_turf(src), pick('sound/effects/footstep/hardbarefoot1.ogg',
			'sound/effects/footstep/hardbarefoot2.ogg',
			'sound/effects/footstep/hardbarefoot3.ogg',
			'sound/effects/footstep/hardbarefoot4.ogg',
			'sound/effects/footstep/hardbarefoot5.ogg'), 50)

		if("clawprint")
			name = "clawprint"
			desc = "It's a clawprint left on the ground."
			icon_state = pick("clawprint", "clawprint1")
			playsound(get_turf(src), pick('sound/effects/footstep/hardbarefoot1.ogg',
			'sound/effects/footstep/hardbarefoot2.ogg',
			'sound/effects/footstep/hardbarefoot3.ogg',
			'sound/effects/footstep/hardbarefoot4.ogg',
			'sound/effects/footstep/hardbarefoot5.ogg'), 50)

		if("shoeprint")
			name = "shoeprint"
			desc = "It's a shoeprint left on the ground."
			icon_state = pick("shoeprint", "shoeprint1")
			playsound(get_turf(src), pick('sound/effects/footstep/floor1.ogg',
			'sound/effects/footstep/floor2.ogg',
			'sound/effects/footstep/floor3.ogg',
			'sound/effects/footstep/floor4.ogg',
			'sound/effects/footstep/floor5.ogg'), 50)

		else
			return

/obj/structure/mark_turf/proc/turf_check(mob/living/user) //This gets called when a player leaves their turf
	var/list/no_trail = list("tail", "constrict")
	var/list/long_trail = list("pawprint", "hoofprint", "clawprint", "footprint", "shoeprint")

	if(user.owned_turf.name in no_trail)
		QDEL_NULL(src)
	if(user.owned_turf.name in long_trail)
		QDEL_IN(src, 60 SECONDS)
		user.owned_turf = null
	else
		QDEL_IN(src, 15 SECONDS)
		user.owned_turf = null

	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		human_user.update_mutant_bodyparts()
