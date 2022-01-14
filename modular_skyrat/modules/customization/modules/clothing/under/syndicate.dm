/obj/item/clothing/under/syndicate/drive
	name = "driver outfit"
	desc = "A non-descript pair of denim shirt and jeans."
	icon_state = "drive"
	inhand_icon_state = "b_suit"
	can_adjust = FALSE

/obj/item/clothing/suit/armor/vest/drive
	name = "driver jacket"
	desc = "A slim, white puffer jacket. Emblazoned on the back, is a big, ominous gold S. Perfect for the quiet types."
	icon_state = "drive"
	inhand_icon_state = "w_suit"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	body_parts_covered = CHEST|ARMS
	cold_protection = CHEST|ARMS
	min_cold_protection_temperature = FIRE_SUIT_MIN_TEMP_PROTECT

/obj/item/crowbar/drive_hammer
	name = "driving hammer"
	desc = "A weighted hammer. Looks like it'd be pretty good at breaking bones."
	icon_state = "hammer"
	icon = 'modular_skyrat/modules/aesthetics/tools/tools.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	inhand_icon_state = "crowbar"
	force = 25 // It's 15 TC
	throwforce = 20
	wound_bonus = 30 // haha, your bones
	bare_wound_bonus = 40
	block_chance = 25

/obj/item/clothing/gloves/combat/driving
	name = "driving gloves"
	desc = "Leather, knuckle-cut gloves perfect for gripping a steering wheel, or a hammer."
	icon_state = "aerostatic_gloves"
	inhand_icon_state = "aerostatic_gloves"
