/obj/item/clothing/head/helmet/stormtrooper
	name = "stormtrooper helmet"
	desc = "A shiny white helmet with some very narrow holes for the users eyes."
	icon = 'modular_skyrat/modules/stormtrooper/icons/items.dmi'
	worn_icon = 'modular_skyrat/modules/stormtrooper/icons/head.dmi'
	icon_state = "stormtrooper_helmet"
	armor = list(MELEE = 40, BULLET = 30, LASER = 50, ENERGY = 40, BOMB = 25, BIO = 0, RAD = 0, FIRE = 50, ACID = 50, WOUND = 10)
	strip_delay = 80
	mutant_variants = NONE

/obj/item/clothing/suit/armor/stormtrooper
	name = "stormtrooper suit"
	desc = "A shiny white armoured suit, looks like it'd be good for deflecting blaster fire."
	icon_state = "stormtrooper_suit"
	icon = 'modular_skyrat/modules/stormtrooper/icons/items.dmi'
	worn_icon = 'modular_skyrat/modules/stormtrooper/icons/suit.dmi'
	body_parts_covered = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	cold_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	heat_protection = CHEST|GROIN|LEGS|FEET|ARMS|HANDS
	armor = list(MELEE = 40, BULLET = 30, LASER = 50, ENERGY = 40, BOMB = 25, BIO = 0, RAD = 0, FIRE = 80, ACID = 80, WOUND = 20)
	clothing_flags = BLOCKS_SHOVE_KNOCKDOWN
	strip_delay = 80
	mutant_variants = NONE

/obj/item/clothing/shoes/combat/stormtrooper
	name = "stormtrooper boots"
	desc = "A pair of white boots."
	icon = 'modular_skyrat/modules/stormtrooper/icons/items.dmi'
	worn_icon = 'modular_skyrat/modules/stormtrooper/icons/feet.dmi'
	icon_state = "stormtrooper_boots"
	armor = list(MELEE = 15, BULLET = 20, LASER = 20, ENERGY = 20, BOMB = 20, BIO = 10, RAD = 0, FIRE = 60, ACID = 35)
	strip_delay = 80
	mutant_variants = NONE

/obj/item/clothing/shoes/combat/stormtrooper/ComponentInitialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/master_files/sound/effects/suitstep1.ogg'=1,'modular_skyrat/master_files/sound/effects/suitstep2.ogg'=1), 50, falloff_exponent = 20)

/obj/item/clothing/gloves/combat/peacekeeper/stormtrooper
	name = "stormtrooper gloves"
	desc = "White gloves with some limited reflective armor."
	icon = 'modular_skyrat/modules/stormtrooper/icons/items.dmi'
	worn_icon = 'modular_skyrat/modules/stormtrooper/icons/hands.dmi'
	icon_state = "stormtrooper_gloves"
	worn_icon_state = "stormtrooper_gloves"

