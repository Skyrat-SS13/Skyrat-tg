
/obj/item/mod/control/pre_equipped/contractor
	worn_icon = 'modular_skyrat/modules/contractor/icons/worn_modsuit.dmi'
	icon = 'modular_skyrat/modules/contractor/icons/modsuit.dmi'
	theme = /datum/mod_theme/contractor
	applied_cell = /obj/item/stock_parts/cell/hyper
	initial_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/tether,
		/obj/item/mod/module/flashlight,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/holster,
	)

// For the record: modularity makes me want to die
/obj/item/mod/control/pre_equipped/contractor/Initialize(mapload, new_theme, new_skin, new_core)
	. = ..()
	mod_parts = list()
	helmet.mod = null
	chestplate.mod = null
	gauntlets.mod = null
	boots.mod = null
	qdel(helmet)
	qdel(chestplate)
	qdel(gauntlets)
	qdel(boots)
	helmet = new /obj/item/clothing/head/mod/contractor(src)
	helmet.mod = src
	mod_parts += helmet
	chestplate = new /obj/item/clothing/suit/mod/contractor(src)
	chestplate.mod = src
	chestplate.allowed = theme.allowed_suit_storage.Copy()
	mod_parts += chestplate
	gauntlets = new /obj/item/clothing/gloves/mod/contractor(src)
	gauntlets.mod = src
	mod_parts += gauntlets
	boots = new /obj/item/clothing/shoes/mod/contractor(src)
	boots.mod = src
	mod_parts += boots
	var/list/all_parts = mod_parts.Copy() + src
	for(var/obj/item/piece as anything in all_parts)
		piece.name = "[theme.name] [piece.name]"
		piece.desc = "[piece.desc] [theme.desc]"
		piece.armor = getArmor(arglist(theme.armor))
		piece.resistance_flags = theme.resistance_flags
		piece.flags_1 |= theme.atom_flags //flags like initialization or admin spawning are here, so we cant set, have to add
		piece.heat_protection = NONE
		piece.cold_protection = NONE
		piece.max_heat_protection_temperature = theme.max_heat_protection_temperature
		piece.min_cold_protection_temperature = theme.min_cold_protection_temperature
		piece.permeability_coefficient = theme.permeability_coefficient
		piece.siemens_coefficient = theme.siemens_coefficient
		piece.icon_state = "[skin]-[initial(piece.icon_state)]"

/datum/mod_theme/contractor
	name = "contractor"
	desc = "A top-tier MODSuit developed with cooperation of Cybersun Industries and the Gorlex Marauders, a favorite of Syndicate Contractors."
	extended_desc = "A rare depart from the Syndicate's usual color scheme, the Contractor MODsuit is produced and manufactured \
		for specialty contractors. The build is a streamlined layering consisting of shaped Plastitanium, \
		and composite ceramic, while the under suit is lined with a lightweight Kevlar and durathread hybrid weave \
		to provide ample protection to the user where the plating doesn't, with an illegal onboard electric powered \
		ablative shield module to provide resistance against conventional energy firearms. \
		In addition, it has an in-built chameleon system, allowing you to disguise the suit while undeployed. \
		A small tag hangs off of it reading; 'Property of the Gorlex Marauders, with assistance from Cybersun Industries. \
		All rights reserved, tampering with suit will void warranty."
	default_skin = "contractor"
	armor = list(MELEE = 40, BULLET = 50, LASER = 30, ENERGY = 40, BOMB = 30, BIO = 30, FIRE = 80, ACID = 85)
	atom_flags = PREVENT_CONTENTS_EXPLOSION_1
	max_heat_protection_temperature = FIRE_SUIT_MAX_TEMP_PROTECT
	siemens_coefficient = 0
	slowdown_inactive = 1
	slowdown_active = 0.5
	ui_theme = "syndicate"
	inbuilt_modules = list(/obj/item/mod/module/armor_booster/contractor, /obj/item/mod/module/chameleon)
	allowed_suit_storage = list(
		/obj/item/flashlight,
		/obj/item/tank/internals,
		/obj/item/ammo_box,
		/obj/item/ammo_casing,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash,
		/obj/item/melee/baton,
		/obj/item/melee/energy/sword,
		/obj/item/shield/energy,
	)
	skins = list(
		"contractor" = list(
			HELMET_LAYER = NECK_LAYER,
			HELMET_FLAGS = list(
				UNSEALED_CLOTHING = SNUG_FIT,
				SEALED_CLOTHING = THICKMATERIAL|STOPSPRESSUREDAMAGE,
				UNSEALED_INVISIBILITY = HIDEFACIALHAIR,
				SEALED_INVISIBILITY = HIDEMASK|HIDEEARS|HIDEEYES|HIDEFACE|HIDEHAIR|HIDESNOUT,
				SEALED_COVER = HEADCOVERSMOUTH|HEADCOVERSEYES|PEPPERPROOF,
			),
			CHESTPLATE_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
			),
			GAUNTLETS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
			),
			BOOTS_FLAGS = list(
				UNSEALED_CLOTHING = THICKMATERIAL,
				SEALED_CLOTHING = STOPSPRESSUREDAMAGE,
			),
		),
	)


/obj/item/mod/module/chameleon
	name = "MOD chameleon module"
	desc = "An illegal module that lets you disguise your MODsuit as any other kind with the help of chameleon technology. However, due to technological challenges, the module only functions when the MODsuit is undeployed."
	icon_state = "chameleon"
	icon = 'modular_skyrat/modules/contractor/icons/modsuit_modules.dmi'
	module_type = MODULE_USABLE
	active_power_cost = DEFAULT_CHARGE_DRAIN * 0.25
	removable = FALSE
	incompatible_modules = list(/obj/item/mod/module/chameleon)
	cooldown_time = 0.5 SECONDS
	/// All of these below are the stored MODsuit original stats
	var/chameleon_type = /obj/item/mod/control
	var/chameleon_name
	var/chameleon_desc
	var/chameleon_icon_state
	var/chameleon_icon
	var/chameleon_worn_icon
	var/chameleon_left
	var/chameleon_right
	/// MODsuit controllers that aren't allowed
	var/list/chameleon_blacklist = list()
	/// List of MODsuits that can be used
	var/list/chameleon_list = list()
	/// If the module's in use or not
	var/on = FALSE

/obj/item/mod/module/chameleon/on_select()
	if(!length(chameleon_list))
		init_chameleon_list()
	for(var/obj/item/part as anything in mod.mod_parts)
		if(!(part.loc == mod.wearer))
			continue
		balloon_alert(mod.wearer, "parts cannot be deployed to use this!")
		playsound(mod, 'sound/machines/scanbuzz.ogg', 25, TRUE, SILENCED_SOUND_EXTRARANGE)
		return FALSE
	on_use()
	SEND_SIGNAL(mod, COMSIG_MOD_MODULE_SELECTED, src)

/obj/item/mod/module/chameleon/on_use()
	var/obj/item/picked_item
	var/picked_name = tgui_input_list(mod.wearer, "Select [chameleon_name] to change into", "Chameleon Settings", sort_list(chameleon_list, /proc/cmp_typepaths_asc))
	if(isnull(picked_name) || isnull(chameleon_list[picked_name]))
		return
	picked_item = chameleon_list[picked_name]
	update_look(mod.wearer, picked_item)

/obj/item/mod/module/chameleon/on_install()
	chameleon_name = initial(mod.name)
	chameleon_desc = initial(mod.name)
	chameleon_icon_state = "[mod.skin]-[initial(mod.icon_state)]"
	chameleon_icon = mod.icon
	chameleon_worn_icon = initial(mod.worn_icon)
	chameleon_left = initial(mod.lefthand_file)
	chameleon_right = initial(mod.righthand_file)
	RegisterSignal(mod, COMSIG_MOD_ACTIVATE, .proc/reset_chameleon)

/obj/item/mod/module/chameleon/on_uninstall()
	UnregisterSignal(mod, COMSIG_MOD_ACTIVATE)
	reset_chameleon()

/obj/item/mod/module/chameleon/proc/reset_chameleon()
	if(on)
		balloon_alert(mod.wearer, "chameleon module disabled!")
	on = FALSE
	mod.name = chameleon_name
	mod.desc = chameleon_desc
	mod.icon_state = chameleon_icon_state
	mod.icon = chameleon_icon
	mod.worn_icon = chameleon_worn_icon
	mod.lefthand_file = chameleon_left
	mod.righthand_file = chameleon_right

/obj/item/mod/module/chameleon/proc/update_look(mob/living/user, obj/item/picked_item)
	if(!isliving(user))
		return
	if(user.stat != CONSCIOUS)
		return

	update_item(picked_item)
	var/obj/item/thing = mod
	thing.update_slot_icon()
	on = TRUE

/obj/item/mod/module/chameleon/proc/update_item(obj/item/picked_item)
	var/obj/item/mod/control/modsuit = new picked_item()
	mod.name = modsuit.name
	mod.desc = modsuit.desc
	mod.icon_state = modsuit.icon_state
	mod.worn_icon = modsuit.worn_icon
	mod.lefthand_file = modsuit.lefthand_file
	mod.righthand_file = modsuit.righthand_file
	if(modsuit.greyscale_colors)
		if(modsuit.greyscale_config_worn)
			mod.worn_icon = SSgreyscale.GetColoredIconByType(modsuit.greyscale_config_worn, modsuit.greyscale_colors)
		if(modsuit.greyscale_config_inhand_left)
			mod.lefthand_file = SSgreyscale.GetColoredIconByType(modsuit.greyscale_config_inhand_left, modsuit.greyscale_colors)
		if(modsuit.greyscale_config_inhand_right)
			mod.righthand_file = SSgreyscale.GetColoredIconByType(modsuit.greyscale_config_inhand_right, modsuit.greyscale_colors)
	mod.worn_icon_state = modsuit.worn_icon_state
	mod.inhand_icon_state = modsuit.inhand_icon_state
	if(modsuit.greyscale_config && modsuit.greyscale_colors)
		mod.icon = SSgreyscale.GetColoredIconByType(modsuit.greyscale_config, modsuit.greyscale_colors)
	else
		mod.icon = modsuit.icon
	update_slot_icon()
	qdel(modsuit)

/obj/item/mod/module/chameleon/proc/init_chameleon_list()
	for(var/obj/item/modsuit as anything in typesof(chameleon_type))
		if(chameleon_blacklist[modsuit] || (initial(modsuit.item_flags) & ABSTRACT) || !initial(modsuit.icon_state))
			continue
		var/chameleon_item_name = "[modsuit]"
		chameleon_list[chameleon_item_name] = modsuit

/obj/item/mod/module/chameleon/Initialize(mapload)
	. = ..()
	init_chameleon_list()

/obj/item/mod/module/armor_booster/contractor // Much flatter distribution because contractor suit gets a shitton of armor already
	armor_values = list(MELEE = 20, BULLET = 20, LASER = 20, ENERGY = 20)
	added_slowdown = 0.5 //Bulky as shit

/obj/item/mod/control/update_appearance(updates)
	var/obj/item/mod/module/chameleon/chameleon_module = modules.Find(/obj/item/mod/module/chameleon)
	if(!chameleon_module)
		return ..()
	if(chameleon_module.on)
		return

	return ..()

// I absolutely fuckin hate having to do this
/obj/item/clothing/head/mod/contractor
	worn_icon = 'modular_skyrat/modules/contractor/icons/worn_modsuit.dmi'
	icon = 'modular_skyrat/modules/contractor/icons/modsuit.dmi'

/obj/item/clothing/suit/mod/contractor
	worn_icon = 'modular_skyrat/modules/contractor/icons/worn_modsuit.dmi'
	icon = 'modular_skyrat/modules/contractor/icons/modsuit.dmi'

/obj/item/clothing/gloves/mod/contractor
	worn_icon = 'modular_skyrat/modules/contractor/icons/worn_modsuit.dmi'
	icon = 'modular_skyrat/modules/contractor/icons/modsuit.dmi'

/obj/item/clothing/shoes/mod/contractor
	worn_icon = 'modular_skyrat/modules/contractor/icons/worn_modsuit.dmi'
	icon = 'modular_skyrat/modules/contractor/icons/modsuit.dmi'
