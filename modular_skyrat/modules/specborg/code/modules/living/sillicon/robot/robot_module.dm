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
	cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
	model_select_icon = "ninjaborg"
	model_select_alternate_icon = 'modular_skyrat/modules/specborg/icons/hud/screen_cyborg.dmi'
	model_traits = list(TRAIT_PUSHIMMUNE, TRAIT_NOFLASH) //No more charging them with a flash and thinking it is a good idea
	hat_offset = 3

/obj/item/robot_model/ninja/rebuild_modules()
	..()
	var/mob/living/silicon/robot/Ninja = loc
	Ninja.faction  -= "silicon" //ai turrets hostile against assault and medical

/obj/item/robot_model/ninja/remove_module(obj/item/I, delete_after)
	..()
	var/mob/living/silicon/robot/Ninja = loc
	Ninja.faction += "silicon"

/obj/item/robot_model/ninja/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/ninja_icons = sort_list(list(
		"Saboteur" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "ninja_engi"),
		"Medical" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "ninja_medical"),
		"Assault" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "ninja_sec"),
		"Heavy" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "ninjaheavy"),
		"Miss M" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "missm_ninja"),
		"Spider" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "ninjaspider"),
		"BootyBorg" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "bootyninja"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "male_bootyninja"),
		))
	var/ninja_icon = show_radial_menu(cyborg, cyborg , ninja_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	switch(ninja_icon)
		if("Saboteur")
			cyborg_base_icon = "ninja_engi"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Medical")
			cyborg_base_icon = "ninja_medical"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Assault")
			cyborg_base_icon = "ninja_sec"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Heavy")
			cyborg_base_icon = "ninjaheavy"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Miss m")
			cyborg_base_icon = "missm_ninja"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Spider")
			cyborg_base_icon = "ninjaspider"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("BootyBorg")
			cyborg_base_icon = "bootyninja"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootyninja"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		//Dogborgs

		else
			return FALSE
	return ..()

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
	cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
	model_select_icon = "ninjaborg"
	model_select_alternate_icon = 'modular_skyrat/modules/specborg/icons/hud/screen_cyborg.dmi'

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
	cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
	model_select_icon = "ninjaborg"
	model_select_alternate_icon = 'modular_skyrat/modules/specborg/icons/hud/screen_cyborg.dmi'
	model_traits = list(TRAIT_PUSHIMMUNE, TRAIT_NOFLASH)
	magpulsing = TRUE
	hat_offset = -4
	canDispose = TRUE

/obj/item/robot_model/ninja_saboteur/do_transform_animation()
	..()
	to_chat(loc, "<span class='userdanger'>While you have picked the saboteur model, that doesn't mean you are allowed to sabotage the station by delaminating the supermatter or opening all the doors to the armory, you should still ahelp to ask the permission to do that and the reason for it.</span>")


/obj/item/robot_model/ninja_saboteur/be_transformed_to(obj/item/robot_model/old_model)
	var/mob/living/silicon/robot/cyborg = loc
	var/static/list/ninja_icons = sort_list(list(
		"Saboteur" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "ninja_engi"),
		"Medical" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "ninja_medical"),
		"Assault" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "ninja_sec"),
		"Heavy" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "ninjaheavy"),
		"Miss M" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "missm_ninja"),
		"Spider" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "ninjaspider"),
		"BootyBorg" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "bootyninja"),
		"Male Bootyborg" = image(icon = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi', icon_state = "male_bootyninja"),
		))
	var/ninja_icon = show_radial_menu(cyborg, cyborg , ninja_icons, custom_check = CALLBACK(src, .proc/check_menu, cyborg, old_model), radius = 42, require_near = TRUE)
	switch(ninja_icon)
		if("Saboteur")
			cyborg_base_icon = "ninja_engi"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Medical")
			cyborg_base_icon = "ninja_medical"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Assault")
			cyborg_base_icon = "ninja_sec"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Heavy")
			cyborg_base_icon = "ninjaheavy"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Miss M")
			cyborg_base_icon = "missm_ninja"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Spider")
			cyborg_base_icon = "ninjaspider"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("BootyBorg")
			cyborg_base_icon = "bootyninja"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		if("Male Bootyborg")
			cyborg_base_icon = "male_bootyninja"
			cyborg_icon_override = 'modular_skyrat/modules/specborg/icons/mob/moreborgs.dmi'
		//Dogborgs

		else
			return FALSE
	return ..()
