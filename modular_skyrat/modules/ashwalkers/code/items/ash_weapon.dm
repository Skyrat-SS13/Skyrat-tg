//ASH WEAPON
/obj/item/melee/macahuitl
	name = "ash macahuitl"
	desc = "A weapon that looks like it will leave really bad marks."
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing.dmi'
	lefthand_file = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_left.dmi'
	righthand_file = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_right.dmi'
	icon_state = "macahuitl"

	force = 15
	wound_bonus = 15
	bare_wound_bonus = 10

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/macahuitl
	name = "Ash Macahuitl"
	result = /obj/item/melee/macahuitl
	reqs = list(
		/obj/item/stack/sheet/bone = 2,
		/obj/item/stack/sheet/sinew = 2,
		/obj/item/stack/sheet/animalhide/goliath_hide = 2,
	)
	crafting_flags = CRAFT_CHECK_DENSITY | CRAFT_MUST_BE_LEARNED
	category = CAT_WEAPON_MELEE

/obj/item/kinetic_crusher/cursed
	name = "cursed ash carver"
	desc = "A horrible, alive-looking weapon that pulses every so often. The tendril created this monstrosity to mimic and compete with those who invade the land."
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_tools.dmi'
