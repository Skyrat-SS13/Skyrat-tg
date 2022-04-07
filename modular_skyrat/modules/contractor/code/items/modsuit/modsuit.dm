
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

/obj/item/mod/control/pre_equipped/contractor/upgraded
	applied_cell = /obj/item/stock_parts/cell/bluespace
	initial_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/jetpack,
		/obj/item/mod/module/dna_lock,
		/obj/item/mod/module/holster,
		/obj/item/mod/module/baton_holster/preloaded,
	)

/obj/item/mod/control/pre_equipped/contractor/upgraded/adminbus
	initial_modules = list(
		/obj/item/mod/module/storage/syndicate,
		/obj/item/mod/module/jetpack/advanced,
		/obj/item/mod/module/springlock/contractor,
		/obj/item/mod/module/baton_holster/preloaded,
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
	update_flags()

/obj/item/mod/control/update_appearance(updates)
	for(var/obj/item/mod/module/chameleon/module as anything in modules)
		if(!istype(module))
			continue
		if(!module)
			return ..()
		if(module.on)
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

// For the prefs menu
/obj/item/mod/control/pre_equipped/syndicate_empty/contractor
	theme = /datum/mod_theme/contractor
