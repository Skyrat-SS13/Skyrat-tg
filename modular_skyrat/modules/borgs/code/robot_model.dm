/obj/item/robot_model
	var/icon/cyborg_icon_override
	var/sleeper_overlay
	var/cyborg_pixel_offset
	var/model_select_alternate_icon
	/// Traits unique to this model, i.e. having a unique dead sprite, being wide or being small enough to reject shrinker modules. Leverages defines in code\__DEFINES\~skyrat_defines\robot_defines.dm
	/// If a sprite overlaps above the standard height, ensure it is not overlapping icons in the selector wheel.
	var/list/model_features = list()

/obj/item/robot_model/proc/update_tallborg()
	var/mob/living/silicon/robot/cyborg = robot || loc
	if (!istype(robot))
		return
	if (model_features && (TRAIT_R_TALL in model_features))
		cyborg.maptext_height = 48 //Runechat blabla
		cyborg.AddElement(/datum/element/footstep, FOOTSTEP_MOB_SHOE, 2, -6, sound_vary = TRUE)
		add_verb(cyborg, /mob/living/silicon/robot/proc/robot_lay_down)
		switch(cyborg_base_icon)
			if("mekamine")
				cyborg.AddComponent(/datum/component/robot_smoke)
			else

	else
		cyborg.maptext_height = initial(cyborg.maptext_height)
		cyborg.RemoveElement(/datum/element/footstep, FOOTSTEP_MOB_SHOE, 2, -6, sound_vary = TRUE)
		remove_verb(cyborg, /mob/living/silicon/robot/proc/robot_lay_down)
		if(cyborg.GetComponent(/datum/component/robot_smoke))
			qdel(cyborg.GetComponent(/datum/component/robot_smoke))
			QDEL_NULL(cyborg.particles)	// Removing left over particles


/obj/item/robot_model/proc/update_dogborg()
	var/mob/living/silicon/robot/cyborg = robot || loc
	if (!istype(robot))
		return
	if (model_features && (TRAIT_R_WIDE in model_features))
		hat_offset = INFINITY
		cyborg.set_base_pixel_x(-16)
		add_verb(cyborg, /mob/living/silicon/robot/proc/robot_lay_down)
		add_verb(cyborg, /mob/living/silicon/robot/proc/rest_style)
	else
		cyborg.set_base_pixel_x(0)
		remove_verb(cyborg, /mob/living/silicon/robot/proc/robot_lay_down)
		remove_verb(cyborg, /mob/living/silicon/robot/proc/rest_style)

//STANDARD
/obj/item/robot_model/standard
	name = "Standard"
	borg_skins = list(
		"Default" = list(SKIN_ICON_STATE = "robot", SKIN_FEATURES = list(TRAIT_R_SMALL)),
		"Heavy" = list(SKIN_ICON_STATE = "heavysd", SKIN_ICON = CYBORG_ICON_STANDARD, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK)),
		"Eyebot" = list(SKIN_ICON_STATE = "eyebotsd", SKIN_ICON = CYBORG_ICON_STANDARD, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL)),
		"Robot" = list(SKIN_ICON_STATE = "robot_old", SKIN_ICON = CYBORG_ICON_STANDARD, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK)),
		"Protectron" = list(SKIN_ICON_STATE = "protectron_standard", SKIN_ICON = CYBORG_ICON_STANDARD),
		"Miss M" = list(SKIN_ICON_STATE = "missm_sd", SKIN_ICON = CYBORG_ICON_STANDARD)
	)

//SERVICE
/obj/item/robot_model/service
	special_light_key = null
	borg_skins = list(
		/// 32x32 Skins
		"Waitress" = list(SKIN_ICON_STATE = "service_f", SKIN_LIGHT_KEY = "service"),
		"Butler" = list(SKIN_ICON_STATE = "service_m", SKIN_LIGHT_KEY = "service"),
		"Bro" = list(SKIN_ICON_STATE = "brobot", SKIN_LIGHT_KEY = "service"),
		"Tophat" = list(SKIN_ICON_STATE = "tophat", SKIN_HAT_OFFSET = INFINITY),
		"Sleek" = list(SKIN_ICON_STATE = "sleekserv", SKIN_ICON = CYBORG_ICON_SERVICE),
		"Heavy" = list(SKIN_ICON_STATE = "heavyserv", SKIN_ICON = CYBORG_ICON_SERVICE),
		"Kent" = list(SKIN_ICON_STATE = "kent", SKIN_LIGHT_KEY = "medical", SKIN_HAT_OFFSET = 3),
		"Can" = list(SKIN_ICON_STATE = "kent", SKIN_LIGHT_KEY = "medical", SKIN_HAT_OFFSET = 3),
		"Zoomba" = list(SKIN_ICON_STATE = "zoomba_green", SKIN_ICON = CYBORG_ICON_SERVICE, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL), SKIN_HAT_OFFSET = -13),
		"ARACHNE" = list(SKIN_ICON_STATE = "arachne_service", SKIN_ICON = CYBORG_ICON_SERVICE),
		"Slipper" = list(SKIN_ICON_STATE = "slipper_service", SKIN_ICON = CYBORG_ICON_SERVICE),
		"Birdborg" = list(SKIN_ICON_STATE = "bird_serv", SKIN_ICON = CYBORG_ICON_SERVICE),
		"Protectron" = list(SKIN_ICON_STATE = "protectron_service", SKIN_ICON = CYBORG_ICON_SERVICE),
		"Miss M" = list(SKIN_ICON_STATE = "missm_service", SKIN_ICON = CYBORG_ICON_SERVICE),
		"Mech" = list(SKIN_ICON_STATE = "lloyd", SKIN_ICON = CYBORG_ICON_SERVICE),
		"Handy" = list(SKIN_ICON_STATE = "handy-service", SKIN_ICON = CYBORG_ICON_SERVICE),
		/// 64x32 skins
		"Borgi" = list(SKIN_ICON_STATE = "borgi-serv", SKIN_ICON = CYBORG_ICON_SERVICE_WIDE, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL))
	)

//MINING
/obj/item/robot_model/miner
	special_light_key = null
	borg_skins = list(
		/// 32x32 Skins
		"Lavaland" = list(SKIN_ICON_STATE = "miner", SKIN_LIGHT_KEY = "miner"),
		"Asteroid" = list(SKIN_ICON_STATE = "minerOLD", SKIN_LIGHT_KEY = "miner"),
		"Drone" = list(SKIN_ICON_STATE = "miningdrone", SKIN_ICON = CYBORG_ICON_MINING, SKIN_FEATURES = list(TRAIT_R_SMALL)),
		"Zoomba" = list(SKIN_ICON_STATE = "zoomba_miner", SKIN_ICON = CYBORG_ICON_MINING, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL), SKIN_HAT_OFFSET = -13),
		"Slipper" = list(SKIN_ICON_STATE = "slipper_mine", SKIN_ICON = CYBORG_ICON_MINING),
		"Spider Miner" = list(SKIN_ICON_STATE = "spidermin", SKIN_LIGHT_KEY = "miner"),
		"Droid" = list(SKIN_ICON_STATE = "miner", SKIN_ICON = CYBORG_ICON_MINING, SKIN_HAT_OFFSET = 4),
		"Sleek" = list(SKIN_ICON_STATE = "sleekmin", SKIN_ICON = CYBORG_ICON_MINING),
		"Can" = list(SKIN_ICON_STATE = "canmin", SKIN_ICON = CYBORG_ICON_MINING),
		"Spider" = list(SKIN_ICON_STATE = "spidermin", SKIN_ICON = CYBORG_ICON_MINING),
		"Heavy" = list(SKIN_ICON_STATE = "heavymin", SKIN_ICON = CYBORG_ICON_MINING),
		"Birdborg" = list(SKIN_ICON_STATE = "bird_mine", SKIN_ICON = CYBORG_ICON_MINING),
		"Protectron" = list(SKIN_ICON_STATE = "protectron_miner", SKIN_ICON = CYBORG_ICON_MINING),
		"Miss M" = list(SKIN_ICON_STATE = "missm_miner", SKIN_ICON = CYBORG_ICON_MINING),
		"Mech" = list(SKIN_ICON_STATE = "ishimura", SKIN_ICON = CYBORG_ICON_MINING)
	)

//CLOWN
/obj/item/robot_model/clown
	borg_skins = list(
		"Default" = list(SKIN_ICON_STATE = "clown"),
		"ARACHNE" = list(SKIN_ICON_STATE = "arachne_clown", SKIN_ICON = 'modular_skyrat/modules/borgs/icons/robots_clown.dmi'),
		"Slipper" = list(SKIN_ICON_STATE = "slipper_clown", SKIN_ICON = 'modular_skyrat/modules/borgs/icons/robots_clown.dmi'),
		"Garish" = list(SKIN_ICON_STATE = "garish", SKIN_ICON = 'modular_skyrat/modules/borgs/icons/robots_clown.dmi'),
		"Robot" = list(SKIN_ICON_STATE = "clownbot", SKIN_ICON = 'modular_skyrat/modules/borgs/icons/robots_clown.dmi'),
		"Sleek" = list(SKIN_ICON_STATE = "clownman", SKIN_ICON = 'modular_skyrat/modules/borgs/icons/robots_clown.dmi', SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK))
	)

//ENGINEERING
/obj/item/robot_model/engineering
	borg_skins = list(
		/// 32x32 Skins
		"Default" = list(SKIN_ICON_STATE = "engineer", SKIN_FEATURES = list(TRAIT_R_SMALL)),
		"Zoomba" = list(SKIN_ICON_STATE = "zoomba_engi", SKIN_ICON = CYBORG_ICON_ENG, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL), SKIN_HAT_OFFSET = -13),
		"Default - Treads" = list(SKIN_ICON_STATE = "engi-tread", SKIN_LIGHT_KEY = "engineer", SKIN_ICON = CYBORG_ICON_ENG),
		"Loader" = list(SKIN_ICON_STATE = "loaderborg", SKIN_ICON = CYBORG_ICON_ENG, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK)),
		"Handy" = list(SKIN_ICON_STATE = "handyeng", SKIN_ICON = CYBORG_ICON_ENG),
		"Sleek" = list(SKIN_ICON_STATE = "sleekeng", SKIN_ICON = CYBORG_ICON_ENG),
		"Can" = list(SKIN_ICON_STATE = "caneng", SKIN_ICON = CYBORG_ICON_ENG),
		"Spider" = list(SKIN_ICON_STATE = "spidereng", SKIN_ICON = CYBORG_ICON_ENG),
		"Heavy" = list(SKIN_ICON_STATE = "heavyeng", SKIN_ICON = CYBORG_ICON_ENG),
		"Birdborg" = list(SKIN_ICON_STATE = "bird_eng", SKIN_ICON = CYBORG_ICON_ENG),
		"Protectron" = list(SKIN_ICON_STATE = "protectron_eng", SKIN_ICON = CYBORG_ICON_ENG),
		"Miss M" = list(SKIN_ICON_STATE = "missm_eng", SKIN_ICON = CYBORG_ICON_ENG),
		"Mech" = list(SKIN_ICON_STATE = "conagher", SKIN_ICON = CYBORG_ICON_ENG),
		"Wide" = list(SKIN_ICON_STATE = "wide-engi", SKIN_ICON = CYBORG_ICON_ENG),
		"ARACHNE" = list(SKIN_ICON_STATE = "arachne_engi", SKIN_ICON = CYBORG_ICON_ENG),
		"Slipper" = list(SKIN_ICON_STATE = "slipper_engi", SKIN_ICON = CYBORG_ICON_ENG),
		"Alina" = list(SKIN_ICON_STATE = "alina-eng", SKIN_LIGHT_KEY = "alina", SKIN_ICON = CYBORG_ICON_ENG_WIDE, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE)),
		"Eyebot" = list(SKIN_ICON_STATE = "eyeboteng", SKIN_ICON = CYBORG_ICON_ENG, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL)),
		/// 64x32 Skins
		"Borgi" = list(SKIN_ICON_STATE = "borgi-eng", SKIN_ICON = CYBORG_ICON_ENG_WIDE, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL))
	)

/obj/item/robot_model/janitor
	borg_skins = list(
		/// 32x32 Skins
		"Default" = list(SKIN_ICON_STATE = "janitor"),
		"ARACHNE" = list(SKIN_ICON_STATE = "arachne_jani", SKIN_ICON = CYBORG_ICON_JANI),
		"Slipper" = list(SKIN_ICON_STATE = "slipper_janitor", SKIN_ICON = CYBORG_ICON_JANI),
		"Zoomba" = list(SKIN_ICON_STATE = "zoomba_jani", SKIN_ICON = CYBORG_ICON_JANI, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL), SKIN_HAT_OFFSET = -13),
		"Sleek" = list(SKIN_ICON_STATE = "sleekjan", SKIN_ICON = CYBORG_ICON_JANI),
		"Can" = list(SKIN_ICON_STATE = "canjan", SKIN_ICON = CYBORG_ICON_JANI),
		"Heavy" = list(SKIN_ICON_STATE = "heavyres", SKIN_ICON = CYBORG_ICON_JANI),
		"Birdborg" = list(SKIN_ICON_STATE = "bird_jani", SKIN_ICON = CYBORG_ICON_JANI),
		"Protectron" = list(SKIN_ICON_STATE = "protectron_janitor", SKIN_ICON = CYBORG_ICON_JANI),
		"Miss M" = list(SKIN_ICON_STATE = "missm_janitor", SKIN_ICON = CYBORG_ICON_JANI),
		"Mech" = list(SKIN_ICON_STATE = "flynn", SKIN_ICON = CYBORG_ICON_JANI),
		"Eyebot" = list(SKIN_ICON_STATE = "eyebotjani", SKIN_ICON = CYBORG_ICON_JANI, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL)),
		"Insekt" = list(SKIN_ICON_STATE = "insekt-Sci", SKIN_ICON = CYBORG_ICON_JANI),
		"Wide" = list(SKIN_ICON_STATE = "wide-jani", SKIN_ICON = CYBORG_ICON_JANI),
		"Spider" = list(SKIN_ICON_STATE = "spidersci", SKIN_ICON = CYBORG_ICON_JANI),
		/// 64x32 Skins
		"Borgi" = list(SKIN_ICON_STATE = "borgi-jani", SKIN_ICON = CYBORG_ICON_JANI_WIDE, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL))
	)

//MEDICAL
/obj/item/robot_model/medical
	borg_skins = list(
		/// 32x32 Skins
		"Machinified Doctor" = list(SKIN_ICON_STATE = "medical", SKIN_TRAITS = list(TRAIT_R_SMALL)),
		"Qualified Doctor" = list(SKIN_ICON_STATE = "qualified_doctor"),
		"ARACHNE" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "arachne_med"),
		"Slipper" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "slipper_med"),
		"Zoomba" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "zoomba_med", SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL), SKIN_HAT_OFFSET = -13),
		"Droid" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "medical", SKIN_HAT_OFFSET = 4),
		"Sleek" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "sleekmed"),
		"Eyebot" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "eyebotmed", SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL)),
		"Heavy" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "heavymed"),
		"Birdborg" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "bird_med"),
		"Protectron" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "protectron_medical"),
		"Miss M" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "missm_med"),
		"Insekt" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "insekt-Med"),
		"Mech" = list(SKIN_ICON = CYBORG_ICON_MED, SKIN_ICON_STATE = "gibbs"),
		/// 64x32 Skins
		"Borgi" = list(SKIN_ICON = CYBORG_ICON_MED_WIDE, SKIN_ICON_STATE = "borgi-medi", SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE))
	)

//PEACEKEEPER
/obj/item/robot_model/peacekeeper
	borg_skins = list(
		/// 32x32 Skins
		"Default" = list(SKIN_ICON_STATE = "peace"),
		"Zoomba" = list(SKIN_ICON_STATE = "zoomba_peace", SKIN_ICON = CYBORG_ICON_PEACEKEEPER, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL), SKIN_HAT_OFFSET = -13),
		"ARACHNE" = list(SKIN_ICON_STATE = "arachne_peacekeeper", SKIN_ICON = CYBORG_ICON_PEACEKEEPER),
		"Sleek" = list(SKIN_ICON_STATE = "sleekpeace", SKIN_ICON = CYBORG_ICON_PEACEKEEPER, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK)),
		"Spider" = list(SKIN_ICON_STATE = "whitespider", SKIN_ICON = CYBORG_ICON_PEACEKEEPER, SKIN_FEATURES = list(TRAIT_R_SMALL)),
		"Birdborg" = list(SKIN_ICON_STATE = "bird_pk", SKIN_ICON = CYBORG_ICON_PEACEKEEPER),
		"Protectron" = list(SKIN_ICON_STATE = "protectron_peacekeeper", SKIN_ICON = CYBORG_ICON_PEACEKEEPER),
		"Insekt" = list(SKIN_ICON_STATE = "insekt-Default", SKIN_ICON = CYBORG_ICON_PEACEKEEPER),
		"Omni" = list(SKIN_ICON_STATE = "omoikane", SKIN_ICON = CYBORG_ICON_PEACEKEEPER, SKIN_FEATURES = list(TRAIT_R_SMALL)),
		/// 64x32 Skins
		"Borgi" = list(SKIN_ICON_STATE = "borgi", SKIN_ICON = CYBORG_ICON_PEACEKEEPER_WIDE, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL))
	)

/obj/item/robot_model/security
	borg_skins = list(
		/// 32x32 Skins
		"Default" = list(SKIN_ICON_STATE = "sec"),
		"Zoomba" = list(SKIN_ICON_STATE = "zoomba_sec", SKIN_ICON = CYBORG_ICON_SEC, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL), SKIN_HAT_OFFSET = -13),
		"Default - Treads" = list(SKIN_ICON_STATE = "sec-tread", SKIN_LIGHT_KEY = "sec", SKIN_ICON = CYBORG_ICON_SEC),
		"Sleek" = list(SKIN_ICON_STATE = "sleeksec", SKIN_ICON = CYBORG_ICON_SEC),
		"Can" = list(SKIN_ICON_STATE = "cansec", SKIN_ICON = CYBORG_ICON_SEC),
		"Spider" = list(SKIN_ICON_STATE = "spidersec", SKIN_ICON = CYBORG_ICON_SEC),
		"Heavy" = list(SKIN_ICON_STATE = "heavysec", SKIN_ICON = CYBORG_ICON_SEC),
		"Protectron" = list(SKIN_ICON_STATE = "protectron_security", SKIN_ICON = CYBORG_ICON_SEC),
		"Miss M" = list(SKIN_ICON_STATE = "missm_security", SKIN_ICON = CYBORG_ICON_SEC),
		"Eyebot" = list(SKIN_ICON_STATE = "eyebotsec", SKIN_ICON = CYBORG_ICON_SEC, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL)),
		"Insekt" = list(SKIN_ICON_STATE = "insekt-Sec", SKIN_ICON = CYBORG_ICON_SEC),
		"Mech" = list(SKIN_ICON_STATE = "woody", SKIN_ICON = CYBORG_ICON_SEC),
		/// 64x32 Skins
		"Borgi" = list(SKIN_ICON_STATE = "borgi-sec", SKIN_ICON = CYBORG_ICON_SEC_WIDE, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL))
	)

// CARGO
/obj/item/robot_model/cargo
	name = "Cargo"
	basic_modules = list(
		/obj/item/stamp,
		/obj/item/stamp/denied,
		/obj/item/pen/cyborg,
		/obj/item/clipboard/cyborg,
		/obj/item/boxcutter,
		/obj/item/stack/package_wrap/cyborg,
		/obj/item/stack/wrapping_paper/xmas/cyborg,
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/hydraulic_clamp,
		/obj/item/borg/hydraulic_clamp/mail,
		/obj/item/hand_labeler/cyborg,
		/obj/item/dest_tagger,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher,
		/obj/item/universal_scanner,
	)
	radio_channels = list(RADIO_CHANNEL_SUPPLY)
	emag_modules = list(
		/obj/item/stamp/chameleon,
		/obj/item/borg/paperplane_crossbow,
	)
	hat_offset = 0
	cyborg_base_icon = "cargo"
	model_select_icon = "cargo"
	canDispose = TRUE
	borg_skins = list(
		/// 32x32 Skins
		"Technician" = list(SKIN_ICON_STATE = "cargoborg", SKIN_ICON = CYBORG_ICON_CARGO),
		"Miss M" = list(SKIN_ICON_STATE = "missm_cargo", SKIN_ICON = CYBORG_ICON_CARGO),
		"Zoomba" = list(SKIN_ICON_STATE = "zoomba_cargo", SKIN_ICON = CYBORG_ICON_CARGO, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_SMALL), SKIN_HAT_OFFSET = -13),
		"Birdborg" = list(SKIN_ICON_STATE =  "bird_cargo", SKIN_ICON = CYBORG_ICON_CARGO),
		/// 64x32 Skins
		"Borgi" = list(SKIN_ICON_STATE =  "borgi-cargo", SKIN_ICON = CYBORG_ICON_CARGO_WIDE, SKIN_FEATURES = list(TRAIT_R_UNIQUEWRECK, TRAIT_R_WIDE, TRAIT_R_SMALL))
	)


//SYNDICATE
/obj/item/robot_model/syndicatejack
	name = "Syndicate"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/sight/thermal,
		/obj/item/extinguisher,
		/obj/item/weldingtool/electric,
		/obj/item/borg/cyborg_omnitool/engineering,
		/obj/item/crowbar/cyborg/power,
		/obj/item/screwdriver/cyborg/power,
		/obj/item/construction/rcd/borg/syndicate,
		/obj/item/lightreplacer/cyborg,
		/obj/item/stack/sheet/iron,
		/obj/item/stack/sheet/glass,
		/obj/item/borg/apparatus/sheet_manipulator,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/iron,
		/obj/item/stack/cable_coil,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/stack/medical/gauze,
		/obj/item/shockpaddles/cyborg,
		/obj/item/healthanalyzer/advanced,
		/obj/item/surgical_drapes,
		/obj/item/retractor/advanced,
		/obj/item/cautery/advanced,
		/obj/item/scalpel/advanced,
		/obj/item/gun/medbeam,
		/obj/item/reagent_containers/borghypo/syndicate,
		/obj/item/borg/lollipop,
		/obj/item/holosign_creator/cyborg,
		/obj/item/stamp/chameleon,
		/obj/item/borg_shapeshifter,
		)
	cyborg_base_icon = "synd_engi"
	model_select_icon = "malf"
	model_traits = list(TRAIT_NEGATES_GRAVITY, TRAIT_PUSHIMMUNE)
	hat_offset = INFINITY
	canDispose = TRUE
	borg_skins = list(
		/// 32x32 Skins
		"Saboteur" = list(SKIN_ICON_STATE = "synd_engi", SKIN_ICON = 'icons/mob/silicon/robots.dmi'),
		"Medical" = list(SKIN_ICON_STATE = "synd_medical", SKIN_ICON = 'icons/mob/silicon/robots.dmi'),
		"Assault" = list(SKIN_ICON_STATE = "synd_sec", SKIN_ICON = 'icons/mob/silicon/robots.dmi'),
		"ARACHNE" = list(SKIN_ICON_STATE = "arachne_syndie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Heavy" = list(SKIN_ICON_STATE = "syndieheavy", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Miss M" = list(SKIN_ICON_STATE = "missm_syndie", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Spider" = list(SKIN_ICON_STATE = "spidersyndi", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Bird Syndicate" = list(SKIN_ICON_STATE = "bird_synd", SKIN_ICON = CYBORG_ICON_SYNDIE),
		"Mech" = list(SKIN_ICON_STATE = "chesty", SKIN_ICON = CYBORG_ICON_SYNDIE)
	)

/obj/item/robot_model/syndicatejack/rebuild_modules()
	. = ..()
	var/mob/living/silicon/robot/syndicatejack = loc
	syndicatejack.scrambledcodes = TRUE // We're rouge now

/obj/item/robot_model/syndicatejack/remove_module(obj/item/I, delete_after)
	. = ..()
	var/mob/living/silicon/robot/syndicatejack = loc
	syndicatejack.scrambledcodes = FALSE // Friends with the AI again

//NINJA
/obj/item/robot_model/ninja
	name = "Spider Clan Assault"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/katana/ninja_blade,
		/obj/item/gun/energy/printer,
		/obj/item/gun/ballistic/revolver/grenadelauncher/cyborg,
		/obj/item/card/emag,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher/mini
		)
	cyborg_base_icon = "ninja_sec"
	cyborg_icon_override = CYBORG_ICON_NINJA
	model_select_icon = "ninjaborg"
	model_select_alternate_icon = 'modular_skyrat/modules/borgs/icons/screen_cyborg.dmi'
	model_traits = list(TRAIT_PUSHIMMUNE, TRAIT_NOFLASH) //No more charging them with a flash and thinking it is a good idea
	hat_offset = 3
	borg_skins = list(
		/// 32x32 Skins
		"Saboteur" = list(SKIN_ICON_STATE = "ninja_engi", SKIN_ICON = CYBORG_ICON_NINJA),
		"Medical" = list(SKIN_ICON_STATE = "ninja_medical", SKIN_ICON = CYBORG_ICON_NINJA),
		"Assault" = list(SKIN_ICON_STATE = "ninja_sec", SKIN_ICON = CYBORG_ICON_NINJA),
		"Heavy" = list(SKIN_ICON_STATE = "ninjaheavy", SKIN_ICON = CYBORG_ICON_NINJA),
		"Miss M" = list(SKIN_ICON_STATE = "missm_ninja", SKIN_ICON = CYBORG_ICON_NINJA),
		"Spider" = list(SKIN_ICON_STATE = "ninjaspider", SKIN_ICON = CYBORG_ICON_NINJA)
	)

/obj/item/robot_model/ninja/rebuild_modules()
	. = ..()
	var/mob/living/silicon/robot/Ninja = loc
	Ninja.faction  -= "silicon" //ai turrets hostile against assault and medical

/obj/item/robot_model/ninja/remove_module(obj/item/I, delete_after)
	var/mob/living/silicon/robot/Ninja = loc
	Ninja.faction += "silicon"
	. = ..()

/obj/item/robot_model/ninja/ninja_medical
	name = "Spider Clan Medical"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/katana/ninja_blade,
		/obj/item/reagent_containers/borghypo/syndicate/ninja,
		/obj/item/shockpaddles/syndicate/cyborg/ninja,
		/obj/item/healthanalyzer/advanced,
		/obj/item/surgical_drapes,
		/obj/item/retractor/advanced,
		/obj/item/cautery/advanced,
		/obj/item/scalpel/advanced,
		/obj/item/emergency_bed/silicon,
		/obj/item/card/emag,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/stack/medical/gauze,
		/obj/item/gun/medbeam,
		/obj/item/borg/apparatus/organ_storage,
		/obj/item/surgical_processor
		)
	cyborg_base_icon = "ninja_medical"
	cyborg_icon_override = CYBORG_ICON_NINJA
	model_select_icon = "ninjaborg"
	model_select_alternate_icon = 'modular_skyrat/modules/borgs/icons/screen_cyborg.dmi'

/obj/item/robot_model/ninja_saboteur
	name = "Spider Clan Saboteur"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/sight/thermal,
		/obj/item/katana/ninja_blade,
		/obj/item/construction/rcd/borg/syndicate,
		/obj/item/pipe_dispenser,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/extinguisher,
		/obj/item/weldingtool/electric,
		/obj/item/borg/cyborg_omnitool/engineering,
		/obj/item/crowbar/cyborg/power,
		/obj/item/screwdriver/cyborg/power,
		/obj/item/stack/sheet/iron,
		/obj/item/stack/sheet/glass,
		/obj/item/borg/apparatus/sheet_manipulator,
		/obj/item/stack/rods/cyborg,
		/obj/item/dest_tagger/borg,
		/obj/item/stamp/chameleon,
		/obj/item/card/emag,
		/obj/item/stack/cable_coil,
		/obj/item/borg_shapeshifter
		)
	cyborg_base_icon = "ninja_engi"
	cyborg_icon_override = CYBORG_ICON_NINJA
	model_select_icon = "ninjaborg"
	model_select_alternate_icon = 'modular_skyrat/modules/borgs/icons/screen_cyborg.dmi'
	model_traits = list(TRAIT_PUSHIMMUNE, TRAIT_NOFLASH)
	model_traits = list(TRAIT_NEGATES_GRAVITY)
	hat_offset = -4
	canDispose = TRUE
	borg_skins = list(
		"Saboteur" = list(SKIN_ICON_STATE = "ninja_engi", SKIN_ICON = CYBORG_ICON_NINJA),
		"Medical" = list(SKIN_ICON_STATE = "ninja_medical", SKIN_ICON = CYBORG_ICON_NINJA),
		"Assault" = list(SKIN_ICON_STATE = "ninja_sec", SKIN_ICON = CYBORG_ICON_NINJA),
		"Heavy" = list(SKIN_ICON_STATE = "ninjaheavy", SKIN_ICON = CYBORG_ICON_NINJA),
		"Miss M" = list(SKIN_ICON_STATE = "missm_ninja", SKIN_ICON = CYBORG_ICON_NINJA),
		"Spider" = list(SKIN_ICON_STATE = "ninjaspider", SKIN_ICON = CYBORG_ICON_NINJA)
	)

/obj/item/robot_model/ninja_saboteur/do_transform_animation()
	. = ..()
	to_chat(loc, span_userdanger("While you have picked the saboteur model, that doesn't mean you are allowed to sabotage the station by delaminating the supermatter or opening all the doors to the armory, you should still ahelp to ask the permission to do that and the reason for it."))
