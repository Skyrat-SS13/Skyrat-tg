/obj/item/borg_shapeshifter
	name = "cyborg chameleon projector"
	icon = 'icons/obj/device.dmi'
	icon_state = "shield0"
	flags_1 = CONDUCT_1
	item_flags = NOBLUDGEON
	inhand_icon_state = "electronic"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	var/savedIcon
	var/savedBubbleIcon
	var/savedOverride
	var/savedPixelOffset
	var/savedModelName
	var/savedModelFeatures
	var/savedSpecialLightKey
	var/active = FALSE
	var/activationCost = 100
	var/activationUpkeep = 5
	var/disguise = null
	var/disguise_icon_override = null
	var/disguise_pixel_offset = 0
	/// Traits unique to this model (deadsprite, wide/dogborginess, etc.). Mirrors the definition in modular_skyrat\modules\altborgs\code\modules\mob\living\silicon\robot\robot_model.dm
	var/list/disguise_model_features = list()
	var/disguise_special_light_key = null
	var/mob/listeningTo
	var/list/signalCache = list( // list here all signals that should break the camouflage
			COMSIG_PARENT_ATTACKBY,
			COMSIG_ATOM_ATTACK_HAND,
			COMSIG_MOVABLE_IMPACT_ZONE,
			COMSIG_ATOM_BULLET_ACT,
			COMSIG_ATOM_EX_ACT,
			COMSIG_ATOM_FIRE_ACT,
			COMSIG_ATOM_EMP_ACT,
			)
	var/mob/living/silicon/robot/user // needed for process()
	var/animation_playing = FALSE
	var/list/borgmodels = list(
							"(Standard) Default",
							"(Standard) Heavy",
							"(Standard) Sleek",
							"(Standard) Marina",
							"(Standard) Robot",
							"(Standard) Eyebot",
							"(Standard) Bootyborg",
							"(Standard) Protectron",
							"(Standard) Miss M",
							"(Medical) Default",
							"(Medical) Heavy",
							"(Medical) Sleek",
							"(Medical) Marina",
							"(Medical) Droid",
							"(Medical) Eyebot",
							"(Medical) Medihound",
							"(Medical) Medihound Dark",
							"(Medical) Vale",
							"(Engineering) Default",
							"(Engineering) Default - Treads",
							"(Engineering) Loader",
							"(Engineering) Handy",
							"(Engineering) Sleek",
							"(Engineering) Can",
							"(Engineering) Marina",
							"(Engineering) Spider",
							"(Engineering) Heavy",
							"(Engineering) Bootyborg",
							"(Engineering) Protectron",
							"(Engineering) Miss M",
							"(Miner) Lavaland",
							"(Miner) Asteroid",
							"(Miner) Droid",
							"(Miner) Sleek",
							"(Miner) Marina",
							"(Miner) Can",
							"(Miner) Heavy",
							"(Miner) Bootyborg",
							"(Miner) Protectron",
							"(Miner) Miss M",
							"(Service) Waitress",
							"(Service) Butler",
							"(Service) Bro",
							"(Service) Can",
							"(Service) Tophat",
							"(Service) Sleek",
							"(Service) Heavy",
							"(Service) Bootyborg",
							"(Service) Protectron",
							"(Service) Miss M",
							"(Janitor) Default",
							"(Janitor) Marina",
							"(Janitor) Sleek",
							"(Janitor) Can",
							"(Janitor) Bootyborg",
							"(Janitor) Protectron",
							"(Janitor) Miss M")

/obj/item/borg_shapeshifter/Initialize()
	. = ..()

/obj/item/borg_shapeshifter/Destroy()
	listeningTo = null
	return ..()

/obj/item/borg_shapeshifter/dropped(mob/user)
	. = ..()
	disrupt(user)

/obj/item/borg_shapeshifter/equipped(mob/user)
	. = ..()
	disrupt(user)

/**
  * check_menu: Checks if we are allowed to interact with a radial menu
  *
  * Arguments:
  * * user The mob interacting with a menu
  */
/obj/item/borg_shapeshifter/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated() || !user.Adjacent(src))
		return FALSE
	return TRUE

/obj/item/borg_shapeshifter/attack_self(mob/living/silicon/robot/user)
	if (user && user.cell && user.cell.charge >  activationCost)
		if (isturf(user.loc))
			toggle(user)
		else
			to_chat(user, span_warning("You can't use [src] while inside something!"))
	else
		to_chat(user, span_warning("You need at least [activationCost] charge in your cell to use [src]!"))

/obj/item/borg_shapeshifter/proc/toggle(mob/living/silicon/robot/user)
	if(active)
		playsound(src, 'sound/effects/pop.ogg', 100, TRUE, -6)
		to_chat(user, span_notice("You deactivate \the [src]."))
		deactivate(user)
	else
		if(animation_playing)
			to_chat(user, span_notice("\the [src] is recharging."))
			return
		var/mob/living/silicon/robot/R = loc
		var/static/list/model_icons = sort_list(list(
		"Standard" = image(icon = 'icons/mob/robots.dmi', icon_state = "robot"),
		"Medical" = image(icon = 'icons/mob/robots.dmi', icon_state = "medical"),
		"Engineer" = image(icon = 'icons/mob/robots.dmi', icon_state = "engineer"),
		"Security" = image(icon = 'icons/mob/robots.dmi', icon_state = "sec"),
		"Service" = image(icon = 'icons/mob/robots.dmi', icon_state = "service_f"),
		"Miner" = image(icon = 'icons/mob/robots.dmi', icon_state = "miner"),
		"Peacekeeper" = image(icon = 'icons/mob/robots.dmi', icon_state = "peace"),
		"Clown" = image(icon = 'icons/mob/robots.dmi', icon_state = "clown"),
		"Syndicate" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_sec"),
		"Spider Clan" = image(icon = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi', icon_state = "ninja_engi")
		))
		var/model_selection = show_radial_menu(R, R , model_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
		if(!model_selection)
			return FALSE

		switch(model_selection)
			if("Standard")
				var/static/list/standard_icons = sort_list(list(
					"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "robot"),
					"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "marinasd"),
					"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "heavysd"),
					"Eyebot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "eyebotsd"),
					"Robot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "robot_old"),
					"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "bootysd"),
					"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "male_bootysd"),
					"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "protectron_standard"),
					"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots.dmi', icon_state = "missm_sd")
				))
				var/list/L = list("Fabulous" = "k69")
				for(var/a in L)
					var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi', icon_state = L[a])
					wide.pixel_x = -16
					standard_icons[a] = wide
				standard_icons = sort_list(standard_icons)
				var/borg_icon = show_radial_menu(R, R , standard_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
				if(!borg_icon)
					return FALSE
				switch(borg_icon)
					if("Default")
						disguise = "robot"
						disguise_icon_override = 'icons/mob/robots.dmi'
						disguise_model_features = list(R_TRAIT_SMALL)
					if("Marina")
						disguise = "marinasd"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK)
					if("Heavy")
						disguise = "heavysd"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK)
					if("Eyebot")
						disguise = "eyebotsd"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
					if("Robot")
						disguise = "robot_old"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK)
					if("Bootyborg")
						disguise = "bootysd"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
					if("Male Bootyborg")
						disguise = "male_bootysd"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
					if("Protectron")
						disguise = "protectron_standard"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
					if("Miss M")
						disguise = "missm_sd"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
					//Dogborgs
					if("Fabulous")
						disguise = "k69"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					else
						return FALSE

			if("Medical")
				var/static/list/med_icons = list(
					"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "medical"),
					"Droid" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "medical"),
					"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "sleekmed"),
					"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "marinamed"),
					"Eyebot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "eyebotmed"),
					"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "heavymed"),
					"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "bootymedical"),
					"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "male_bootymedical"),
					"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "protectron_medical"),
					"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "missm_med"),
					"Qualified Doctor" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "qualified_doctor"),
					"Zoomba" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "zoomba_med"),
					"Arachne" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "arachne"),
					"Insekt" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "insekt-Med"),
					"Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi', icon_state = "gibbs")
				)
				var/list/L = list("Medihound" = "medihound", "Medihound Dark" = "medihounddark", "Vale" = "valemed",  "Drake" = "drakemed", "Borgi" = "borgi-medi")
				for(var/a in L)
					var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_med.dmi', icon_state = L[a])
					wide.pixel_x = -16
					med_icons[a] = wide
				med_icons = sort_list(med_icons)
				var/borg_icon = show_radial_menu(R, R , med_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
				if(!borg_icon)
					return FALSE
				switch(borg_icon)
					if("Default")
						disguise = "medical"
						disguise_icon_override = 'icons/mob/robots.dmi'
						disguise_model_features = list(R_TRAIT_SMALL)
					if("Droid")
						disguise = "medical"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					if("Sleek")
						disguise = "sleekmed"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					if("Marina")
						disguise = "marinamed"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					if("Eyebot")
						disguise = "eyebotmed"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
					if("Heavy")
						disguise = "heavymed"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					if("Bootyborg")
						disguise = "bootymedical"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					if("Male Bootyborg")
						disguise = "male_bootymedical"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					if("Protectron")
						disguise = "protectron_medical"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					if("Miss M")
						disguise = "missm_med"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					if("Qualified Doctor")
						disguise = "qualified_doctor"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					if("Zoomba")
						disguise = "zoomba_med"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
					if("Arachne")
						disguise = "arachne"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					if("Insekt")
						disguise = "insekt-Med"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					if("Mech")
						disguise = "gibbs"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_med.dmi'
					//Dogborgs
					if("Medihound")
						disguise = "medihound"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_med.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Medihound Dark")
						disguise = "medihounddark"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_med.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Vale")
						disguise = "valemed"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_med.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Drake")
						disguise = "drakemed"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_med.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Borgi")
						disguise = "borgi-medi"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_med.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)
					else
						return FALSE

			if("Engineer")
				var/static/list/engi_icons = list(
					"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "engineer"),
					"Default - Treads" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "engi-tread"),
					"Loader" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "loaderborg"),
					"Handy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "handyeng"),
					"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "sleekeng"),
					"Can" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "caneng"),
					"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "marinaeng"),
					"Spider" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "spidereng"),
					"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "heavyeng"),
					"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "bootyeng"), //Skyrat change
					"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "male_bootyeng"),
					"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "protectron_eng"),
					"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "missm_eng"),
					"Zoomba" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "zoomba_engi"),
					"Eyebot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "eyeboteng"),
					"Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "conagher"),
					"Wide" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi', icon_state = "wide-engi")
				)
				var/list/L = list("Pup Dozer" = "pupdozer", "Vale" = "valeeng", "Hound" = "engihound", "Darkhound" = "engihounddark", "Drake" = "drakeeng", "Borgi" = "borgi-eng")
				for(var/a in L)
					var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi', icon_state = L[a])
					wide.pixel_x = -16
					engi_icons[a] = wide
				engi_icons = sort_list(engi_icons)
				var/borg_icon = show_radial_menu(R, R , engi_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
				if(!borg_icon)
					return FALSE
				switch(borg_icon)
					if("Default")
						disguise = "engineer"
						disguise_icon_override = 'icons/mob/robots.dmi'
						disguise_model_features = list(R_TRAIT_SMALL)
					if("Zoomba")
						disguise = "zoomba_engi"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
					if("Default - Treads")
						disguise = "engi-tread"
						disguise_special_light_key = "engineer"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Loader")
						disguise = "loaderborg"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK)
					if("Handy")
						disguise = "handyeng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Sleek")
						disguise = "sleekeng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Can")
						disguise = "caneng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Marina")
						disguise = "marinaeng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Spider")
						disguise = "spidereng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Heavy")
						disguise = "heavyeng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Bootyborg")
						disguise = "bootyeng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Male Bootyborg")
						disguise = "male_bootyeng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Protectron")
						disguise = "protectron_eng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Miss M")
						disguise = "missm_eng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Eyebot")
						disguise = "eyeboteng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
					if("Mech")
						disguise = "conagher"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					if("Wide")
						disguise = "wide-engi"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_eng.dmi'
					//Dogborgs
					if("Pup Dozer")
						disguise = "pupdozer"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Vale")
						disguise = "valeeng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Alina")
						disguise = "alina-eng"
						disguise_special_light_key = "alina"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Drake")
						disguise = "drakeeng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Hound")
						disguise = "engihound"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Darkhound")
						disguise = "engihounddark"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Borgi")
						disguise = "borgi-eng"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_eng.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)
					else
						return FALSE
			if("Security")
				var/static/list/sec_icons = list(
					"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "sec"),
					"Default - Treads" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "sec-tread"),
					"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "sleeksec"),
					"Can" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "cansec"),
					"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "marinasec"),
					"Spider" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "spidersec"),
					"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "heavysec"),
					"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "bootysecurity"), //Skyrat change
					"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "male_bootysecurity"),
					"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "protectron_security"),
					"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "missm_security"),
					"Zoomba" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "zoomba_sec"),
					"Eyebot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "eyebotsec"),
					"Insekt" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "insekt-Sec"),
					"Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi', icon_state = "woody")
				)
				var/list/L = list("Hound" = "k9", "Vale" = "valesec", "Darkhound" = "k9dark", "Otie" = "oties", "Drake" = "drakesec", "Borgi" = "borgi-sec")
				for(var/a in L)
					var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi', icon_state = L[a])
					wide.pixel_x = -16
					sec_icons[a] = wide
				sec_icons = sort_list(sec_icons)
				var/borg_icon = show_radial_menu(R, R , sec_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
				if(!borg_icon)
					return FALSE
				switch(borg_icon)
					if("Default")
						disguise = "sec"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("Zoomba")
						disguise = "zoomba_sec"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
					if("Default - Treads")
						disguise = "sec-tread"
						disguise_special_light_key = "sec"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
					if("Sleek")
						disguise = "sleeksec"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
					if("Marina")
						disguise = "marinasec"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
					if("Can")
						disguise = "cansec"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
					if("Spider")
						disguise = "spidersec"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
					if("Heavy")
						disguise = "heavysec"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
					if("Bootyborg") //Skyrat change
						disguise = "bootysecurity"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
					if("Male Bootyborg")
						disguise = "male_bootysecurity"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
					if("Protectron")
						disguise = "protectron_security"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
					if("Miss M")
						disguise = "missm_security"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_sec.dmi'
					//Dogborgs
					if("Hound")
						disguise = "k9"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Alina")
						disguise = "alina-sec"
						disguise_special_light_key = "alina"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Darkhound")
						disguise = "k9dark"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Vale")
						disguise = "valesec"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Drake")
						disguise = "drakesec"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Otie")
						disguise = "oties"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Borgi")
						disguise = "borgi-sec"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_sec.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)
					else
						return FALSE
			if("Service")
				var/static/list/service_icons = list(
					"(Service) Waitress" = image(icon = 'icons/mob/robots.dmi', icon_state = "service_f"),
					"(Service) Butler" = image(icon = 'icons/mob/robots.dmi', icon_state = "service_m"),
					"(Service) Bro" = image(icon = 'icons/mob/robots.dmi', icon_state = "brobot"),
					"(Service) Can" = image(icon = 'icons/mob/robots.dmi', icon_state = "kent"),
					"(Service) Tophat" = image(icon = 'icons/mob/robots.dmi', icon_state = "tophat"),
					"(Service) Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "sleekserv"),
					"(Service) Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "heavyserv"),
					"(Service) Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "bootyservice"),
					"(Service) Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "male_bootyservice"),
					"(Service) Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "protectron_service"),
					"(Service) Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "missm_service"),
					"(Service) Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "lloyd"),
					"(Service) Handy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi', icon_state = "handy-service"),

					"(Janitor) Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "janitor"),
					"(Janitor) Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "marinajan"),
					"(Janitor) Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "sleekjan"),
					"(Janitor) Can" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "canjan"),
					"(Janitor) Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "bootyjanitor"),
					"(Janitor) Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "male_bootyjanitor"),
					"(Janitor) Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "protectron_janitor"),
					"(Janitor) Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "missm_janitor"),
					"(Janitor) Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "heavyres"),
					"(Janitor) Zoomba" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "zoomba_jani"),
					"(Janitor) Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "flynn"),
					"(Janitor) Eyebot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "eyebotjani"),
					"(Janitor) Insekt" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "insekt-Sci"),
					"(Janitor) Wide" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "wide-jani"),
					"(Janitor) Spider" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_jani.dmi', icon_state = "spidersci"),
				)
				var/list/L = list("(Service) Darkhound" = "k50", "(Service) Vale" = "valeserv", "(Service) ValeDark" = "valeservdark", "(Service) Borgi" = "borgi-serv",  "(Service) Partyhound" = "k69", "(Service) Borgi" = "borgi-serv", "(Janitor) Scrubpuppy" = "scrubpup", "(Janitor) Otie" = "otiej", "(Janitor) Drake" = "drakejanit", "(Janitor) Vale" = "J9", "(Janitor) Borgi" = "borgi-jani")
				for(var/a in L)
					var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi', icon_state = L[a])
					wide.pixel_x = -16
					service_icons[a] = wide
				service_icons = sort_list(service_icons)
				var/borg_icon = show_radial_menu(R, R , service_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
				if(!borg_icon)
					return FALSE
				switch(borg_icon)
					if("(Service) Waitress")
						disguise = "service_f"
						disguise_special_light_key = "service"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("(Service) Butler")
						disguise = "service_m"
						disguise_special_light_key = "service"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("(Service) Bro")
						disguise = "brobot"
						disguise_special_light_key = "service"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("(Service) Can")
						disguise = "kent"
						disguise_special_light_key = "medical"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("(Service) Tophat")
						disguise = "tophat"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("(Service) Sleek")
						disguise = "sleekserv"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
					if("(Service) Heavy")
						disguise = "heavyserv"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
					if("(Service) Bootyborg")
						disguise = "bootyservice"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
					if("(Service) Male Bootyborg")
						disguise = "male_bootyservice"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
					if("(Service) Protectron")
						disguise = "protectron_service"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
					if("(Service) Miss M")
						disguise = "missm_service"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
					if("(Service) Mech")
						disguise = "lloyd"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'
					if("(Service) Handy")
						disguise = "handy-service"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_serv.dmi'

					if("(Janitor) Default")
						disguise = "janitor"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("(Janitor) Marina")
						disguise = "marinajan"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
					if("(Janitor) Sleek")
						disguise = "sleekjan"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
					if("(Janitor) Can")
						disguise = "canjan"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
					if("(Janitor) Heavy")
						disguise = "heavyres"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
					if("(Janitor) Zoomba")
						disguise = "zoomba_jani"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
					if("(Janitor) Bootyborg")
						disguise = "bootyjanitor"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
					if("(Janitor) Male Bootyborg")
						disguise = "male_bootyjanitor"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
					if("(Janitor) Protectron")
						disguise = "protectron_janitor"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'
					if("(Janitor) Miss M")
						disguise = "missm_janitor"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots.dmi'

					//Dogborgs
					if("(Service) Darkhound")
						disguise = "k50"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("(Service) Vale")
						disguise = "valeserv"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("(Service) Partyhound")
						disguise = "k69"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("(Service) ValeDark")
						disguise = "valeservdark"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("(Service) Borgi")
						disguise = "borgi-serv"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_serv.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)

					if("(Janitor) Drake")
						disguise = "drakejanit"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("(Janitor) Otie")
						disguise = "otiej"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("(Janitor) Scrubpuppy")
						disguise = "scrubpup"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("(Janitor) Vale")
						disguise = "J9"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("(Janitor) Borgi")
						disguise = "borgi-jani"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_jani.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)
					else
						return FALSE
			if("Miner")
				var/static/list/mining_icons = list(
					"Lavaland" = image(icon = 'icons/mob/robots.dmi', icon_state = "miner"),
					"Asteroid" = image(icon = 'icons/mob/robots.dmi', icon_state = "minerOLD"),
					"Droid" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "miner"),
					"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "sleekmin"),
					"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "marinamin"),
					"Can" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "canmin"),
					"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "heavymin"),
					"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "bootyminer"),
					"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "male_bootyminer"),
					"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "protectron_miner"),
					"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "missm_miner"),
					"Zoomba" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "zoomba_miner"),
					"Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "ishimura"),
					"Drone" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi', icon_state = "miningdrone")
				)
				var/list/L = list("Blade" = "blade", "Vale" = "valemine", "Drake" = "drakemine", "Hound" = "cargohound", "Darkhound" = "cargohounddark")
				for(var/a in L)
					var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi', icon_state = L[a])
					wide.pixel_x = -16
					mining_icons[a] = wide
				mining_icons = sort_list(mining_icons)
				var/borg_icon = show_radial_menu(R, R , mining_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
				if(!borg_icon)
					return FALSE
				switch(borg_icon)
					if("Lavaland")
						disguise = "miner"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("Asteroid")
						disguise = "minerOLD"
						disguise_special_light_key = "miner"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("Droid")
						disguise = "miner"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
					if("Sleek")
						disguise = "sleekmin"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
					if("Can")
						disguise = "canmin"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
					if("Marina")
						disguise = "marinamin"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
					if("Spider")
						disguise = "spidermin"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
					if("Heavy")
						disguise = "heavymin"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
					if("Bootyborg")
						disguise = "bootyminer"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
					if("Male Bootyborg")
						disguise = "male_bootyminer"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
					if("Protectron")
						disguise = "protectron_miner"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
					if("Miss M")
						disguise = "missm_miner"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
					if("Zoomba")
						disguise = "zoomba_miner"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_SMALL)
					if("Mech")
						disguise = "ishimura"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
					if("Drone")
						disguise = "miningdrone"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_mine.dmi'
						disguise_model_features = list(R_TRAIT_SMALL)
					//Dogborgs
					if("Drake")
						disguise = "drakemine"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Blade")
						disguise = "blade"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Vale")
						disguise = "valemine"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Hound")
						disguise = "cargohound"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Darkhound")
						disguise = "cargohounddark"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_mine.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					else
						return FALSE
			if("Peacekeeper")
				var/static/list/peace_icons = sort_list(list(
					"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "peace"),
					"Spider" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "whitespider"),
					"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "sleekpeace"),
					"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "marinapeace"),
					"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "bootypeace"),
					"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "male_bootypeace"),
					"Protectron" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "protectron_peacekeeper"),
					"Insekt" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "insekt-Default"),
					"Omni" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi', icon_state = "omoikane")
					))
				var/list/L = list("Drake" = "drakepeace", "Borgi" = "borgi")
				for(var/a in L)
					var/image/wide = image(icon = 'modular_skyrat/modules/altborgs/icons/widerobot_pk.dmi', icon_state = L[a])
					wide.pixel_x = -16
					peace_icons[a] = wide
				peace_icons = sort_list(peace_icons)
				var/borg_icon = show_radial_menu(R, R , peace_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
				if(!borg_icon)
					return FALSE
				switch(borg_icon)
					if("Default")
						disguise = "peace"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("Sleek")
						disguise = "sleekpeace"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK)
					if("Spider")
						disguise = "whitespider"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
						disguise_model_features = list(R_TRAIT_SMALL)
					if("Marina")
						disguise = "marinapeace"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK)
					if("Bootyborg")
						disguise = "bootypeace"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
					if("Male Bootyborg")
						disguise = "male_bootypeace"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
					if("Protectron")
						disguise = "protectron_peacekeeper"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
					if("Insekt")
						disguise = "insekt-Default"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
					if("Omni")
						disguise = "omoikane"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_pk.dmi'
						disguise_model_features = list(R_TRAIT_SMALL) //No tennis-ball shaped disguised cyborgs.
					//Dogborgs
					if("Drake")
						disguise = "drakepeace"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_pk.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE)
					if("Borgi")
						disguise = "borgi"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/widerobot_pk.dmi'
						disguise_pixel_offset = -16
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK, R_TRAIT_WIDE, R_TRAIT_SMALL)
					else
						return FALSE
			if("Clown")
				var/static/list/clown_icons = sort_list(list(
					"Default" = image(icon = 'icons/mob/robots.dmi', icon_state = "clown"),
					"Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "bootyclown"),
					"Male Bootyborg" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "male_bootyclown"),
					"Marina" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "marina_mommy"),
					"Garish" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "garish"),
					"Robot" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "clownbot"),
					"Sleek" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi', icon_state = "clownman")
				))
				var/borg_icon = show_radial_menu(R, R , clown_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
				if(!borg_icon)
					return FALSE
				switch(borg_icon)
					if("Default")
						disguise = "clown"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("Bootyborg")
						disguise = "bootyclown"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
					if("Male Bootyborg")
						disguise = "male_bootyclown"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
					if("Marina")
						disguise = "marina_mommy"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK)
					if("Garish")
						disguise = "garish"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
					if("Robot")
						disguise = "clownbot"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
					if("Sleek")
						disguise = "clownman"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_clown.dmi'
						disguise_model_features = list(R_TRAIT_UNIQUEWRECK)
					else
						return FALSE
			if("Syndicate")
				var/static/list/syndicatejack_icons = sort_list(list(
					"Saboteur" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_engi"),
					"Medical" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_medical"),
					"Assault" = image(icon = 'icons/mob/robots.dmi', icon_state = "synd_sec"),
					"Heavy" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "syndieheavy"),
					"Miss M" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "missm_syndie"),
					"Spider" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "spidersyndi"),
					"Booty Striker" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "bootynukie"),
					"Booty Syndicate" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "bootysyndie"),
					"Male Booty Striker" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "male_bootynukie"),
					"Male Booty Syndicate" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "male_bootysyndie"),
					"Mech" = image(icon = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi', icon_state = "chesty")
				))
				var/borg_icon = show_radial_menu(R, R , syndicatejack_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
				if(!borg_icon)
					return FALSE
				switch(borg_icon)
					if("Saboteur")
						disguise = "synd_engi"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("Medical")
						disguise = "synd_medical"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("Assault")
						disguise = "synd_sec"
						disguise_icon_override = 'icons/mob/robots.dmi'
					if("Heavy")
						disguise = "syndieheavy"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
					if("Miss M")
						disguise = "missm_syndie"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
					if("Spider")
						disguise = "spidersyndi"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
					if("Booty Striker")
						disguise = "bootynukie"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
					if("Booty Syndicate")
						disguise = "bootysyndie"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
					if("Male Booty Striker")
						disguise = "male_bootynukie"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
					if("Male Booty Syndicate")
						disguise = "male_bootysyndie"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
					if("Mech")
						disguise = "chesty"
						disguise_icon_override = 'modular_skyrat/modules/altborgs/icons/robots_syndi.dmi'
					else
						return FALSE
			if("Spider Clan")
				var/static/list/ninja_icons = sort_list(list(
					"Saboteur" = image(icon = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi', icon_state = "ninja_engi"),
					"Medical" = image(icon = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi', icon_state = "ninja_medical"),
					"Assault" = image(icon = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi', icon_state = "ninja_sec"),
					"Heavy" = image(icon = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi', icon_state = "ninjaheavy"),
					"Miss M" = image(icon = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi', icon_state = "missm_ninja"),
					"Spider" = image(icon = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi', icon_state = "ninjaspider"),
					"BootyBorg" = image(icon = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi', icon_state = "bootyninja"),
					"Male Bootyborg" = image(icon = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi', icon_state = "male_bootyninja")
				))
				var/borg_icon = show_radial_menu(R, R , ninja_icons, custom_check = CALLBACK(src, .proc/check_menu, R), radius = 42, require_near = TRUE)
				if(!borg_icon)
					return FALSE
				switch(borg_icon)
					if("Saboteur")
						disguise = "ninja_engi"
						disguise_icon_override = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi'
					if("Medical")
						disguise = "ninja_medical"
						disguise_icon_override = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi'
					if("Assault")
						disguise = "ninja_sec"
						disguise_icon_override = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi'
					if("Heavy")
						disguise = "ninjaheavy"
						disguise_icon_override = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi'
					if("Miss M")
						disguise = "missm_ninja"
						disguise_icon_override = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi'
					if("Spider")
						disguise = "ninjaspider"
						disguise_icon_override = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi'
					if("BootyBorg")
						disguise = "bootyninja"
						disguise_icon_override = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi'
					if("Male Bootyborg")
						disguise = "male_bootyninja"
						disguise_icon_override = 'modular_skyrat/modules/specborg/icons/moreborgs.dmi'
					//Dogborgs
					else
						return FALSE

			else
				return FALSE

		animation_playing = TRUE
		to_chat(user, span_notice("You activate \the [src]."))
		playsound(src, 'sound/effects/seedling_chargeup.ogg', 100, TRUE, -6)
		var/start = user.filters.len
		var/X,Y,rsq,i,f
		for(i=1, i<=7, ++i)
			do
				X = 60*rand() - 30
				Y = 60*rand() - 30
				rsq = X*X + Y*Y
			while(rsq<100 || rsq>900)
			user.filters += filter(type="wave", x=X, y=Y, size=rand()*2.5+0.5, offset=rand())
		for(i=1, i<=7, ++i)
			f = user.filters[start+i]
			animate(f, offset=f:offset, time=0, loop=3, flags=ANIMATION_PARALLEL)
			animate(offset=f:offset-1, time=rand()*20+10)
		if (do_after(user, 50, target=user) && user.cell.use(activationCost))
			playsound(src, 'sound/effects/bamf.ogg', 100, TRUE, -6)
			to_chat(user, span_notice("You are now disguised."))
			activate(user, model_selection)
		else
			to_chat(user, span_warning("The chameleon field fizzles."))
			do_sparks(3, FALSE, user)
			for(i=1, i<=min(7, user.filters.len), ++i) // removing filters that are animating does nothing, we gotta stop the animations first
				f = user.filters[start+i]
				animate(f)
		user.filters = null
		animation_playing = FALSE

/obj/item/borg_shapeshifter/process()
	if (user)
		if (!user.cell || !user.cell.use(activationUpkeep))
			disrupt(user)
	else
		return PROCESS_KILL

/obj/item/borg_shapeshifter/proc/activate(mob/living/silicon/robot/user, disguiseModelName)
	START_PROCESSING(SSobj, src)
	src.user = user
	savedIcon = user.model.cyborg_base_icon
	savedBubbleIcon = user.bubble_icon //tf is that
	savedOverride = user.model.cyborg_icon_override
	savedPixelOffset = user.model.cyborg_pixel_offset
	savedModelName = user.model.name
	savedModelFeatures = user.model.model_features
	savedSpecialLightKey = user.model.special_light_key
	user.model.name = disguiseModelName
	user.model.cyborg_base_icon = disguise
	user.model.cyborg_icon_override = disguise_icon_override
	user.model.cyborg_pixel_offset = disguise_pixel_offset
	user.model.model_features = disguise_model_features
	user.model.special_light_key = disguise_special_light_key
	user.bubble_icon = "robot"
	active = TRUE
	user.update_icons()

	if(listeningTo == user)
		return
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
	RegisterSignal(user, signalCache, .proc/disrupt)
	listeningTo = user

	if(savedPixelOffset == null)
		savedPixelOffset = 0

/obj/item/borg_shapeshifter/proc/deactivate(mob/living/silicon/robot/user)
	STOP_PROCESSING(SSobj, src)
	if(listeningTo)
		UnregisterSignal(listeningTo, signalCache)
		listeningTo = null
	do_sparks(5, FALSE, user)
	user.model.name = savedModelName
	user.model.cyborg_base_icon = savedIcon
	user.model.cyborg_icon_override = savedOverride
	user.model.cyborg_pixel_offset = savedPixelOffset
	user.model.model_features = savedModelFeatures
	user.model.special_light_key = savedSpecialLightKey
	user.bubble_icon = savedBubbleIcon
	active = FALSE
	user.update_icons()
	disguise_pixel_offset = 0
	src.user = user

/obj/item/borg_shapeshifter/proc/disrupt(mob/living/silicon/robot/user)
	SIGNAL_HANDLER
	if(active)
		to_chat(user, span_danger("Your chameleon field deactivates."))
		deactivate(user)
