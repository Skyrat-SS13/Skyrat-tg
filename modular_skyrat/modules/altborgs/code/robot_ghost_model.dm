// Ghost spawn role for DS-2 that's a dedicated borg.
/mob/living/silicon/robot/model/ds2
	lawupdate = FALSE
	scrambledcodes = TRUE // Ghost borgs aren't real
	set_model = /obj/item/robot_model/ds2


/mob/living/silicon/robot/model/ds2/Initialize(mapload)
	. = ..()
	cell = new /obj/item/stock_parts/cell/high(src, 10000)
	laws = new /datum/ai_laws/ds2()
	//This part is because the camera stays in the list, so we'll just do a check
	if(!QDELETED(builtInCamera))
		QDEL_NULL(builtInCamera)

/mob/living/silicon/robot/model/ds2/binarycheck()
	return FALSE //Ghost borgs aren't truly borgs

/datum/ai_laws/ds2
	name = "DS2-Bound"
	id = "ds2"
	zeroth = ""
	inherent = list()


/// DS2 specific borg module
/obj/item/robot_model/ds2
	name = "DS2"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/sight/meson,
		/obj/item/extinguisher,
		/obj/item/weldingtool/electric,
		/obj/item/screwdriver/cyborg/power,
		/obj/item/crowbar/cyborg/power,
		/obj/item/multitool/cyborg,
		/obj/item/lightreplacer/cyborg,
		/obj/item/stack/sheet/iron,
		/obj/item/stack/sheet/glass,
		/obj/item/stack/sheet/rglass/cyborg,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/iron,
		/obj/item/stack/cable_coil,
		/obj/item/stack/medical/gauze,
		/obj/item/shockpaddles/cyborg,
		/obj/item/healthanalyzer/advanced,
		/obj/item/surgical_drapes,
		/obj/item/retractor/advanced,
		/obj/item/cautery/advanced,
		/obj/item/scalpel/advanced,
		/obj/item/reagent_containers/borghypo/borgshaker/specific/juice, // They can make glasses, and have their own, let them serve drinks!
		/obj/item/reagent_containers/borghypo/borgshaker/specific/soda,
		/obj/item/reagent_containers/borghypo/borgshaker/specific/alcohol,
		/obj/item/reagent_containers/borghypo/borgshaker/specific/misc,
		/obj/item/reagent_containers/cup/glass/drinkingglass,
		/obj/item/soap/syndie,
		/obj/item/lightreplacer, // Lights go out sometimes, or get broken, let the Borg help fix them
		/obj/item/reagent_containers/borghypo,
		)
	cyborg_base_icon = "synd_engi"
	model_select_icon = "malf"
	hat_offset = -3
	model_traits = list(TRAIT_NEGATES_GRAVITY)
	canDispose = TRUE
	borg_skins = list(
		"Saboteur" = list(SKIN_ICON_STATE = "synd_engi", SKIN_ICON = 'icons/mob/silicon/robots.dmi'),
		"Medical" = list(SKIN_ICON_STATE = "synd_medical", SKIN_ICON = 'icons/mob/silicon/robots.dmi'),
		"Assault" = list(SKIN_ICON_STATE = "synd_sec", SKIN_ICON = 'icons/mob/silicon/robots.dmi'),
		"Meka" = list(SKIN_ICON_STATE = "mekasyndi", SKIN_ICON = CYBORG_ICON_SYNDIE_TALL, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_UNIQUETIP, R_TRAIT_TALL), SKIN_HAT_OFFSET = 15),
		"Heavy" = list(SKIN_ICON_STATE = "syndieheavy", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Miss M" = list(SKIN_ICON_STATE = "missm_syndie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Arachne" = list(SKIN_ICON_STATE = "arachne_synd", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Spider" = list(SKIN_ICON_STATE = "spidersyndi", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Booty Striker" = list(SKIN_ICON_STATE = "bootynukie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Booty Syndicate" = list(SKIN_ICON_STATE = "bootysyndie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Bird Syndicate" = list(SKIN_ICON_STATE = "bird_synd", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Male Booty Striker" = list(SKIN_ICON_STATE = "male_bootynukie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Male Booty Syndicate" = list(SKIN_ICON_STATE = "male_bootysyndie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Mech" = list(SKIN_ICON_STATE = "chesty", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Hound" = list(SKIN_ICON_STATE = "k9", SKIN_ICON = CYBORG_ICON_SEC_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)),
		"Otie" = list(SKIN_ICON_STATE = "oties", SKIN_ICON = CYBORG_ICON_SEC_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)),
		"Alina" = list(SKIN_ICON_STATE = "alina-sec", SKIN_LIGHT_KEY = "alina", SKIN_ICON = CYBORG_ICON_SEC_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)),
		"Darkhound" = list(SKIN_ICON_STATE = "k9dark", SKIN_ICON = CYBORG_ICON_SEC_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)),
		"Vale" = list(SKIN_ICON_STATE = "valesec", SKIN_ICON = CYBORG_ICON_SEC_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)),
		"Drake" = list(SKIN_ICON_STATE = "drakesec", SKIN_ICON = CYBORG_ICON_SEC_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)),
		"Borgi" = list(SKIN_ICON_STATE = "borgi-sec", SKIN_ICON = CYBORG_ICON_SEC_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL))
	)
