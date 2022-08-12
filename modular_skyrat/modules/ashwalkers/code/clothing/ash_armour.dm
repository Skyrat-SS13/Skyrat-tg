//ASH CLOTHING
/obj/item/clothing/head/ash_headdress
	name = "ash headdress"
	desc = "A headdress that shows the dominance of the walkers of ash."
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_mob.dmi'
	icon_state = "headdress"
	supports_variations_flags = NONE

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_headdress
	name = "Ash Headdress"
	result = /obj/item/clothing/head/ash_headdress

/obj/item/clothing/head/ash_headdress/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2, /obj/item/stack/sheet/animalhide/goliath_hide, list(MELEE = 5, BULLET = 2, LASER = 2))

/obj/item/clothing/head/ash_headdress/winged
	name = "winged ash headdress"
	icon_state = "wing_headdress"

/datum/crafting_recipe/ash_headdress/winged
	name = "Winged Ash Headdress"
	result = /obj/item/clothing/head/ash_headdress/winged

/obj/item/clothing/under/costume/gladiator/ash_walker/ash_robes
	name = "ash robes"
	desc = "A set of hand-made robes. The bones still seem to have some muscle still attached."
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_mob.dmi'
	icon_state = "robes"

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_robes
	name = "Ash Robes"
	result = /obj/item/clothing/under/costume/gladiator/ash_walker/ash_robes

/obj/item/clothing/under/costume/gladiator/ash_walker/ash_robes/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2, /obj/item/stack/sheet/animalhide/goliath_hide, list(MELEE = 5, BULLET = 2, LASER = 2))

/obj/item/clothing/suit/ash_plates
	name = "ash combat plates"
	desc = "A combination of bones and hides, strung together by watcher sinew."
	icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing.dmi'
	worn_icon = 'modular_skyrat/modules/ashwalkers/icons/ashwalker_clothing_mob.dmi'
	icon_state = "combat_plates"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

	greyscale_colors = null
	greyscale_config = null
	greyscale_config_inhand_left = null
	greyscale_config_inhand_right = null
	greyscale_config_worn = null

/datum/crafting_recipe/ash_recipe/ash_plates
	name = "Ash Combat Plates"
	result = /obj/item/clothing/suit/ash_plates

/obj/item/clothing/suit/ash_plates/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/armor_plate, 2, /obj/item/stack/sheet/animalhide/goliath_hide, list(MELEE = 5, BULLET = 2, LASER = 2))

/obj/item/clothing/suit/ash_plates/decorated
	name = "decorated ash combat plates"
	icon_state = "dec_breastplate"

/datum/crafting_recipe/ash_recipe/ash_plates/decorated
	name = "Decorated Ash Combat Plates"
	result = /obj/item/clothing/suit/ash_plates/decorated
