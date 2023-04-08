
/obj/item/clothing/under/rank/spacepod_pilot
	name = "pilot uniform"
	icon_state = "spacepod_pilot"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	alt_covers_chest = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/gloves/color/black/spacepod_pilot
	name = "pilot gloves"
	desc = "These gloves make you fly better."
	icon_state = "combat"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'

/obj/item/clothing/head/spacepod_pilot
	name = "pilot cap"
	desc = "A cap for those that enjoy the ai-... SPACE."
	icon_state = "pilot_cap"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	strip_delay = 60
	armor_type = /datum/armor/head_helmet

	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON


/obj/item/storage/belt/security/webbing/peacekeeper/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded(src)
	update_appearance()
