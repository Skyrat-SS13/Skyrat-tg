
/obj/item/clothing/shoes/jackboots/tan
	name = "tan combat boots"
	desc = "High speed, low drag combat boots."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	icon_state = "tanboots"
	inhand_icon_state = "tanboots"

/obj/item/clothing/under/rank/utility_tan
	name = "tan utility uniform"
	icon_state = "tanutility"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	alt_covers_chest = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/storage/belt/military/tan
	name = "tan chest rig"
	desc = "A set of tactical webbing."
	icon_state = "webbing_tan"
	worn_icon_state = "webbing_tan"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'

/obj/item/clothing/gloves/color/tan
	name = "tan gloves"
	desc = "These gloves are fire-resistant."
	icon_state = "black"
	cold_protection = HANDS
	min_cold_protection_temperature = GLOVES_MIN_TEMP_PROTECT
	heat_protection = HANDS
	max_heat_protection_temperature = GLOVES_MAX_TEMP_PROTECT
	resistance_flags = NONE
	icon_state = "gloves_tan"
	worn_icon_state = "gloves_tan"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/gloves.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/hands.dmi'

/obj/item/clothing/head/helmet/tan
	name = "tan helmet"
	desc = "A robust helmet."
	icon_state = "tanhelmet"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'

	supports_variations_flags = CLOTHING_SNOUTED_VARIATION_NO_NEW_ICON


/obj/item/clothing/suit/armor/vest/tan
	name = "tan armor vest"
	desc = "An armored vest that provides decent protection against most types of damage."
	icon_state = "tanarmor"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|GROIN|ARMS
	cold_protection = CHEST|GROIN|ARMS
	heat_protection = CHEST|GROIN|ARMS
	dog_fashion = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON


/obj/item/clothing/glasses/sunglasses/swat
	name = "swat goggles"
	desc = "Combat goggles providing decent eye protection."
	icon_state = "swat_goggles"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/glasses.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/eyes.dmi'
