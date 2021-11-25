/obj/item/robot_model
	var/icon/cyborg_icon_override
	var/sleeper_overlay
	var/cyborg_pixel_offset
	var/model_select_alternate_icon
	/// Traits unique to this model, i.e. having a unique dead sprite, being wide or being small enough to reject shrinker modules. Leverages defines in code\__DEFINES\~skyrat_defines\robot_defines.dm
	var/list/model_features = list()

/obj/item/robot_model/proc/update_dogborg()
	var/mob/living/silicon/robot/cyborg = robot || loc
	if (!istype(robot))
		return
	if (model_features && (R_TRAIT_WIDE in model_features))
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
	"Default" = list(SKIN_ICON_STATE = "robot", SKIN_FEATURES = list(R_TRAIT_SMALL)),
		"Marina" = list(SKIN_ICON_STATE = "marinasd", SKIN_ICON = R_ICON_STANDARD, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK)),
		"Heavy" = list(SKIN_ICON_STATE = "heavysd", SKIN_ICON = R_ICON_STANDARD, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK)),
		"Eyebot" = list(SKIN_ICON_STATE = "eyebotsd", SKIN_ICON = R_ICON_STANDARD, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)),
		"Robot" = list(SKIN_ICON_STATE = "robot_old", SKIN_ICON = R_ICON_STANDARD, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK)),
		"Bootyborg" = list(SKIN_ICON_STATE = "bootysd", SKIN_ICON = R_ICON_STANDARD),
		"Male Bootyborg" = list(SKIN_ICON_STATE = "male_bootysd", SKIN_ICON = R_ICON_STANDARD),
		"Protectron" = list(SKIN_ICON_STATE = "protectron_standard", SKIN_ICON = R_ICON_STANDARD),
		"Miss M" = list(SKIN_ICON_STATE = "missm_sd", SKIN_ICON = R_ICON_STANDARD),
		"Partyhound" = list(SKIN_ICON_STATE = "k69", SKIN_ICON = R_ICON_SERVICE_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)) //SLEEPER_OVERLAY = "k9sleeper"
	)

//SERVICE
/obj/item/robot_model/service/skyrat
	name = "Skyrat Service"
	special_light_key = null
	borg_skins = list(
		"Waitress" = list(SKIN_ICON_STATE = "service_f", SKIN_LIGHT_KEY = "service"),
		"Butler" = list(SKIN_ICON_STATE = "service_m", SKIN_LIGHT_KEY = "service"),
		"Bro" = list(SKIN_ICON_STATE = "brobot", SKIN_LIGHT_KEY = "service"),
		"Can" = list(SKIN_ICON_STATE = "kent", SKIN_LIGHT_KEY = "medical", SKIN_HAT_OFFSET = 3),
		"Tophat" = list(SKIN_ICON_STATE = "tophat", SKIN_HAT_OFFSET = INFINITY),
		"Sleek" = list(SKIN_ICON_STATE = "sleekserv", SKIN_ICON = R_ICON_SERVICE),
		"Heavy" = list(SKIN_ICON_STATE = "heavyserv", SKIN_ICON = R_ICON_SERVICE),
		"Bootyborg" = list(SKIN_ICON_STATE = "bootyservice", SKIN_ICON = R_ICON_SERVICE),
		"Male Bootyborg" = list(SKIN_ICON_STATE = "male_bootyservice", SKIN_ICON = R_ICON_SERVICE),
		"Protectron" = list(SKIN_ICON_STATE = "protectron_service", SKIN_ICON = R_ICON_SERVICE),
		"Miss M" = list(SKIN_ICON_STATE = "missm_service", SKIN_ICON = R_ICON_SERVICE),
		"Zoomba" = list(SKIN_ICON_STATE = "zoomba_green", SKIN_ICON = R_ICON_SERVICE, SKIN_FEATURES = list(model_features = R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)),
		"Mech" = list(SKIN_ICON_STATE = "lloyd", SKIN_ICON = R_ICON_SERVICE),
		"Handy" = list(SKIN_ICON_STATE = "handy-service", SKIN_ICON = R_ICON_SERVICE),
		"Darkhound" = list(SKIN_ICON_STATE = "k50", SKIN_ICON = R_ICON_SERVICE_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)), //SLEEPER_OVERLAY = "ksleeper"
		"Vale" = list(SKIN_ICON_STATE = "valeserv", SKIN_ICON = R_ICON_SERVICE_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)), //SLEEPER_OVERLAY = "valeservsleeper"
		"ValeDark" = list(SKIN_ICON_STATE = "valeservdark", SKIN_ICON = R_ICON_SERVICE_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)), //SLEEPER_OVERLAY = "valeservsleeper"
		"Partyhound" = list(SKIN_ICON_STATE = "k69", SKIN_ICON = R_ICON_SERVICE_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)), //SLEEPER_OVERLAY = "k9sleeper"
		"Borgi" = list(SKIN_ICON_STATE = "borgi-serv", SKIN_ICON = R_ICON_SERVICE_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)), //SLEEPER_OVERLAY = "borgi-sleeper"
	)

//MINING
/obj/item/robot_model/miner/skyrat
	name = "Skyrat Miner"
	special_light_key = null
	borg_skins = list(
		"Lavaland" = list(SKIN_ICON_STATE = "miner"),
		"Asteroid" = list(SKIN_ICON_STATE = "minerOLD", SKIN_LIGHT_KEY = "miner"),
		"Droid" = list(SKIN_ICON_STATE = "miner", SKIN_ICON = R_ICON_MINING, SKIN_HAT_OFFSET = 4),
		"Sleek" = list(SKIN_ICON_STATE = "sleekmin", SKIN_ICON = R_ICON_MINING),
		"Can" = list(SKIN_ICON_STATE = "canmin", SKIN_ICON = R_ICON_MINING),
		"Marina" = list(SKIN_ICON_STATE = "marinamin", SKIN_ICON = R_ICON_MINING),
		"Spider" = list(SKIN_ICON_STATE = "spidermin", SKIN_ICON = R_ICON_MINING),
		"Heavy" = list(SKIN_ICON_STATE = "heavymin", SKIN_ICON = R_ICON_MINING),
		"Bootyborg" = list(SKIN_ICON_STATE = "bootyminer", SKIN_ICON = R_ICON_MINING),
		"Male Bootyborg" = list(SKIN_ICON_STATE = "male_bootyminer", SKIN_ICON = R_ICON_MINING),
		"Protectron" = list(SKIN_ICON_STATE = "protectron_miner", SKIN_ICON = R_ICON_MINING),
		"Miss M" = list(SKIN_ICON_STATE = "missm_miner", SKIN_ICON = R_ICON_MINING),
		"Mech" = list(SKIN_ICON_STATE = "ishimura", SKIN_ICON = R_ICON_MINING),
		"Drone" = list(SKIN_ICON_STATE = "miningdrone", SKIN_ICON = R_ICON_MINING, SKIN_FEATURES = list(R_TRAIT_SMALL)),
		"Zoomba" = list(SKIN_ICON_STATE = "zoomba_miner", SKIN_ICON = R_ICON_MINING, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)),
		"Blade" = list(SKIN_ICON_STATE = "blade", SKIN_ICON = R_ICON_MINING_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)), //SLEEPER_OVERLAY = "bladesleeper"
		"Vale" = list(SKIN_ICON_STATE = "valemine", SKIN_ICON = R_ICON_MINING_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)), //SLEEPER_OVERLAY = "valeminesleeper"
		"Drake" = list(SKIN_ICON_STATE = "drakemine", SKIN_ICON = R_ICON_MINING_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)), //SLEEPER_OVERLAY = "drakeminesleeper"
		"Hound" = list(SKIN_ICON_STATE = "cargohound", SKIN_ICON = R_ICON_MINING_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)), //SLEEPER_OVERLAY = "cargohound-sleeper"
		"Darkhound" = list(SKIN_ICON_STATE = "cargohounddark", SKIN_ICON = R_ICON_MINING_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)), //SLEEPER_OVERLAY = "cargohounddark-sleeper"
		"Otie" = list(SKIN_ICON_STATE = "otiec", SKIN_ICON = R_ICON_MINING_WIDE, SKIN_FEATURES = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)) //SLEEPER_OVERLAY = "otiec_sleeper"
	)

//SYNDICATE
/obj/item/robot_model/syndicatejack
	name = "Syndicate"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/sight/thermal,
		/obj/item/extinguisher,
		/obj/item/weldingtool/electric,
		/obj/item/screwdriver/nuke,
		/obj/item/wrench/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
		/obj/item/lightreplacer/cyborg,
		/obj/item/stack/sheet/iron,
		/obj/item/stack/sheet/glass,
		/obj/item/stack/sheet/rglass/cyborg,
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
	magpulsing = TRUE
	hat_offset = INFINITY
	canDispose = TRUE
	borg_skins = list(
		"Saboteur" = list(SKIN_ICON_STATE = "synd_engi", SKIN_ICON = 'icons/mob/robots.dmi'),
		"Medical" = list(SKIN_ICON_STATE = "synd_medical", SKIN_ICON = 'icons/mob/robots.dmi'),
		"Assault" = list(SKIN_ICON_STATE = "synd_sec", SKIN_ICON = 'icons/mob/robots.dmi'),
		"Heavy" = list(SKIN_ICON_STATE = "syndieheavy", SKIN_ICON = R_ICON_SYNDIE),
		"Miss M" = list(SKIN_ICON_STATE = "missm_syndie", SKIN_ICON = R_ICON_SYNDIE),
		"Spider" = list(SKIN_ICON_STATE = "spidersyndi", SKIN_ICON = R_ICON_SYNDIE),
		"Booty Striker" = list(SKIN_ICON_STATE = "bootynukie", SKIN_ICON = R_ICON_SYNDIE),
		"Booty Syndicate" = list(SKIN_ICON_STATE = "bootysyndie", SKIN_ICON = R_ICON_SYNDIE),
		"Male Booty Striker" = list(SKIN_ICON_STATE = "male_bootynukie", SKIN_ICON = R_ICON_SYNDIE),
		"Male Booty Syndicate" = list(SKIN_ICON_STATE = "male_bootysyndie", SKIN_ICON = R_ICON_SYNDIE),
		"Mech" = list(SKIN_ICON_STATE = "chesty", SKIN_ICON = R_ICON_SYNDIE)
	)

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
	cyborg_icon_override = R_ICON_NINJA
	model_select_icon = "ninjaborg"
	model_select_alternate_icon = 'modular_skyrat/modules/altborgs/icons/screen_cyborg.dmi'
	model_traits = list(TRAIT_PUSHIMMUNE, TRAIT_NOFLASH) //No more charging them with a flash and thinking it is a good idea
	hat_offset = 3
	borg_skins = list(
		"Saboteur" = list(SKIN_ICON_STATE = "ninja_engi", SKIN_ICON = R_ICON_NINJA),
		"Medical" = list(SKIN_ICON_STATE = "ninja_medical", SKIN_ICON = R_ICON_NINJA),
		"Assault" = list(SKIN_ICON_STATE = "ninja_sec", SKIN_ICON = R_ICON_NINJA),
		"Heavy" = list(SKIN_ICON_STATE = "ninjaheavy", SKIN_ICON = R_ICON_NINJA),
		"Miss m" = list(SKIN_ICON_STATE = "missm_ninja", SKIN_ICON = R_ICON_NINJA),
		"Spider" = list(SKIN_ICON_STATE = "ninjaspider", SKIN_ICON = R_ICON_NINJA),
		"BootyBorg" = list(SKIN_ICON_STATE = "bootyninja", SKIN_ICON = R_ICON_NINJA),
		"Male Bootyborg" = list(SKIN_ICON_STATE = "male_bootyninja", SKIN_ICON = R_ICON_NINJA)
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
		/obj/item/roller/robo,
		/obj/item/card/emag,
		/obj/item/crowbar/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/stack/medical/gauze,
		/obj/item/gun/medbeam,
		/obj/item/borg/apparatus/organ_storage,
		/obj/item/surgical_processor
		)
	cyborg_base_icon = "ninja_medical"
	cyborg_icon_override = R_ICON_NINJA
	model_select_icon = "ninjaborg"
	model_select_alternate_icon = 'modular_skyrat/modules/altborgs/icons/screen_cyborg.dmi'

/obj/item/robot_model/ninja_saboteur
	name = "Spider Clan Saboteur"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/borg/sight/thermal,
		/obj/item/construction/rcd/borg/syndicate,
		/obj/item/pipe_dispenser,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/extinguisher,
		/obj/item/weldingtool/electric,
		/obj/item/screwdriver/nuke,
		/obj/item/wrench/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
		/obj/item/stack/sheet/iron,
		/obj/item/stack/sheet/glass,
		/obj/item/stack/sheet/rglass/cyborg,
		/obj/item/stack/rods/cyborg,
		/obj/item/dest_tagger/borg,
		/obj/item/stamp/chameleon,
		/obj/item/card/emag,
		/obj/item/stack/cable_coil,
		/obj/item/borg_shapeshifter
		)
	cyborg_base_icon = "ninja_engi"
	cyborg_icon_override = R_ICON_NINJA
	model_select_icon = "ninjaborg"
	model_select_alternate_icon = 'modular_skyrat/modules/altborgs/icons/screen_cyborg.dmi'
	model_traits = list(TRAIT_PUSHIMMUNE, TRAIT_NOFLASH)
	magpulsing = TRUE
	hat_offset = -4
	canDispose = TRUE
	borg_skins = list(
		"Saboteur" = list(SKIN_ICON_STATE = "ninja_engi", SKIN_ICON = R_ICON_NINJA),
		"Medical" = list(SKIN_ICON_STATE = "ninja_medical", SKIN_ICON = R_ICON_NINJA),
		"Assault" = list(SKIN_ICON_STATE = "ninja_sec", SKIN_ICON = R_ICON_NINJA),
		"Heavy" = list(SKIN_ICON_STATE = "ninjaheavy", SKIN_ICON = R_ICON_NINJA),
		"Miss M" = list(SKIN_ICON_STATE = "missm_ninja", SKIN_ICON = R_ICON_NINJA),
		"Spider" = list(SKIN_ICON_STATE = "ninjaspider", SKIN_ICON = R_ICON_NINJA),
		"BootyBorg" = list(SKIN_ICON_STATE = "bootyninja", SKIN_ICON = R_ICON_NINJA),
		"Male Bootyborg" = list(SKIN_ICON_STATE = "male_bootyninja", SKIN_ICON = R_ICON_NINJA)
	)

/obj/item/robot_model/ninja_saboteur/do_transform_animation()
	. = ..()
	to_chat(loc, span_userdanger("While you have picked the saboteur model, that doesn't mean you are allowed to sabotage the station by delaminating the supermatter or opening all the doors to the armory, you should still ahelp to ask the permission to do that and the reason for it."))
