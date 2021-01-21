
//PEACEKEEPER HELMET
/obj/item/clothing/head/helmet/sec/peacekeeper
	name = "peacekeeper helmet"
	desc = "A standard issue combat helmet for peacekeeper operators. Has decent tensile strength and armor. Keep your head down."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_helmets.dmi'
	icon_state = "peacekeeper_helmet"
	worn_icon_state = "peacekeeper"
	mutant_variants = NONE

/obj/item/clothing/head/beret/sec/peacekeeper
	name = "security peacekeeper beret"
	desc = "A robust beret with the peacekeeper insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_helmets.dmi'
	icon_state = "peacekeeper_beret"
	mutant_variants = NONE

/obj/item/clothing/head/beret/sec/peacekeeper/white
	icon_state = "peacekeeper_beret_white"

/obj/item/clothing/head/hos/beret/peacekeeper
	name = "head of security's peacekeeper beret"
	desc = "A special beret with the Head of Security's insignia emblazoned on it. A symbol of excellence, a badge of courage, a mark of distinction."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_helmets.dmi'
	icon_state = "peacekeeper_beret_hos"
	mutant_variants = NONE

/obj/item/clothing/head/beret/sec/navywarden/peacekeeper
	name = "warden's peacekeeper beret"
	desc = "A special beret with the Warden's insignia emblazoned on it. For wardens with class."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_helmets.dmi'
	icon_state = "peacekeeper_beret_warden"
	mutant_variants = NONE

/obj/item/clothing/glasses/hud/security/sunglasses/peacekeeper
	name = "peacekeeper hud glasses"
	icon_state = "peacekeeperglasses"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_helmets.dmi'
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'

//PEACEKEEPER UNIFORM
/obj/item/clothing/under/rank/security/peacekeeper
	name = "peacekeeper uniform"
	desc = "A sleek white peackeeper uniform, made to a price."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms_digi.dmi'
	icon_state = "peacekeeper"
	armor = list(MELEE = 10, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 30, ACID = 30, WOUND = 10) //Don't worry, these are copies.
	can_adjust = TRUE
	sensor_mode = SENSOR_COORDS
	random_sensor = FALSE

/obj/item/clothing/under/rank/security/peacekeeper/blue
	name = "blue peacekeeper uniform"
	icon_state = "rsecurity"
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/sol/peacekeeper_uniforms.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/sol/peacekeeper_uniforms_digi.dmi'

/obj/item/clothing/under/rank/security/warden/peacekeeper
	name = "peacekeeper wardens suit"
	desc = "A formal security suit for officers complete with Nanotrasen belt buckle."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms_digi.dmi'
	icon_state = "peacekeeper_warden"
	inhand_icon_state = "peacekeeper_warden"

/obj/item/clothing/under/rank/security/warden
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/sol/peacekeeper_uniforms.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/sol/peacekeeper_uniforms_digi.dmi'

/obj/item/clothing/under/rank/security/head_of_security/peacekeeper
	name = "head of security's peacekeeper jumpsuit"
	desc = "A security jumpsuit decorated for those few with the dedication to achieve the position of Head of Security."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_uniforms_digi.dmi'
	icon_state = "peacekeeper_hos"
	inhand_icon_state = "peacekeeper_hos"

/obj/item/clothing/under/rank/security/head_of_security
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/sol/peacekeeper_uniforms.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/sol/peacekeeper_uniforms_digi.dmi'

//PEACEKEEPER ARMOR
/obj/item/clothing/suit/armor/vest/peacekeeper
	name = "peacekeeper armor vest"
	desc = "A standard issue peacekeeper armor vest, versatile, lightweight, and most importantly, cheap."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	icon_state = "peacekeeper_armor"
	worn_icon_state = "peacekeeper"
	mutant_variants = NONE

/obj/item/clothing/suit/armor/vest/peacekeeper/black
	name = "black peacekeeper vest"
	icon_state = "peacekeeper_black"
	worn_icon_state = "peacekeeper_black"

/obj/item/clothing/suit/armor/hos/trenchcoat/peacekeeper
	name = "armored peacekeeper trenchcoat"
	desc = "A trenchcoat enhanced with a special lightweight kevlar. The epitome of tactical plainclothes."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	icon_state = "peacekeeper_trench_hos"
	inhand_icon_state = "hostrench"
	mutant_variants = NONE

/obj/item/clothing/suit/armor/vest/warden/peacekeeper
	name = "warden's peacekeeper jacket"
	desc = "A white jacket with blue  rank pips and body armor strapped on top."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	icon_state = "peacekeeper_trench_warden"
	mutant_variants = NONE

/obj/item/clothing/suit/hooded/wintercoat/security/peacekeeper
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/suit.dmi'
	icon_state = "coatpeacekeeper"
	inhand_icon_state = "coatpeacekeeper"
	hoodtype = /obj/item/clothing/head/hooded/winterhood/security/peacekeeper

/obj/item/clothing/head/hooded/winterhood/security/peacekeeper
	icon = 'modular_skyrat/modules/customization/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/modules/customization/icons/mob/clothing/head.dmi'
	icon_state = "winterhood_peacekeeper"

//PEACEKEEPER GLOVES
/obj/item/clothing/gloves/color/black/peacekeeper
	name = "peacekeeper gloves"
	desc = "These gloves are clearly made to a price, but, they are fire resistant!"
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_gloves.dmi'
	icon_state = "peacekeeper_gloves"
	worn_icon_state = "peacekeeper"
	cut_type = null

//OVERRIDES
/obj/item/clothing/suit/armor/riot
	name = "peacekeeper riotsuit"
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	icon_state = "peacekeeper_riot"

