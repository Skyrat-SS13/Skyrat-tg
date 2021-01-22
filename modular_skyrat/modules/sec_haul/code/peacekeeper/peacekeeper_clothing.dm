
//PEACEKEEPER HELMET
/obj/item/clothing/head/helmet/sec/peacekeeper
	name = "peacekeeper helmet"
	desc = "A standard issue combat helmet for peacekeeper operators. Has decent tensile strength and armor. Keep your head down."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_helmets.dmi'
	icon_state = "peacekeeper_helmet"
	worn_icon_state = "peacekeeper"
	mutant_variants = NONE
	var/visor = TRUE

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

/obj/item/clothing/under/rank/security/peacekeeper/tactical
	name = "tactical peacekeeper uniform"
	desc = "A tactical peackeeper uniform, we'll get em boys."
	icon_state = "peacekeeper_tac"
	armor = list(MELEE = 15, BULLET = 5, LASER = 5, ENERGY = 5, BOMB = 0, BIO = 0, RAD = 0, FIRE = 30, ACID = 30, WOUND = 10)

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
/obj/item/clothing/gloves/combat/peacekeeper
	name = "peacekeeper gloves"
	desc = "These tactical gloves are fireproof and electrically insulated."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_gloves.dmi'
	icon_state = "peacekeeper_gloves"
	worn_icon_state = "peacekeeper"
	cut_type = null

/obj/item/clothing/gloves/tackler/peacekeeper
	name = "peacekeeper gripper gloves"
	desc = "Special gloves that manipulate the blood vessels in the wearer's hands, granting them the ability to launch headfirst into walls."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_gloves.dmi'
	icon_state = "peacekeeper_gripper_gloves"
	inhand_icon_state = "peacekeeper"

/obj/item/clothing/gloves/krav_maga/sec/peacekeeper
	name = "peacekeeper krav maga gloves"
	desc = "These gloves can teach you to perform Krav Maga using nanochips."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_gloves.dmi'
	icon_state = "peacekeeper_gripper_gloves"

//PEACEKEEPER BELTS
/obj/item/storage/belt/security/peacekeeper
	name = "peacekeeper belt"
	desc = "Can hold security gear like handcuffs and flashes. Has a holster for a gun."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_belts.dmi'
	icon_state = "peacekeeperbelt"
	worn_icon_state = "peacekeeperbelt"
	content_overlays = TRUE

/obj/item/storage/belt/security/peacekeeper/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 5
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.set_holdable(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/melee/baton,
		/obj/item/melee/classic_baton,
		/obj/item/grenade,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_box,
		/obj/item/food/donut,
		/obj/item/kitchen/knife/combat,
		/obj/item/flashlight/seclite,
		/obj/item/melee/classic_baton/telescopic,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/holosign_creator/security
		))

/obj/item/storage/belt/security/peacekeeper/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	update_icon()

/obj/item/storage/belt/security/webbing/peacekeeper
	name = "peacekeeper webbing"
	desc = "Unique and versatile chest rig, can hold security gear."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_belts.dmi'
	icon_state = "peacekeeper_webbing"
	worn_icon_state = "peacekeeper_webbing"
	content_overlays = FALSE
	custom_premium_price = PAYCHECK_HARD * 3

/obj/item/storage/belt/security/webbing/peacekeeper/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 7
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.set_holdable(list(
		/obj/item/gun/ballistic/automatic/pistol,
		/obj/item/melee/baton,
		/obj/item/melee/classic_baton,
		/obj/item/grenade,
		/obj/item/reagent_containers/spray/pepper,
		/obj/item/restraints/handcuffs,
		/obj/item/assembly/flash/handheld,
		/obj/item/clothing/glasses,
		/obj/item/ammo_casing/shotgun,
		/obj/item/ammo_box,
		/obj/item/food/donut,
		/obj/item/kitchen/knife/combat,
		/obj/item/flashlight/seclite,
		/obj/item/melee/classic_baton/telescopic,
		/obj/item/radio,
		/obj/item/clothing/gloves,
		/obj/item/restraints/legcuffs/bola,
		/obj/item/holosign_creator/security
		))

//BOOTS
/obj/item/clothing/shoes/combat/peacekeeper
	name = "peacekeeper boots"
	desc = "High speed, low drag combat boots."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_boots.dmi'
	worn_icon_digi = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_boots_digi.dmi'
	icon_state = "peacekeeper_boots"
	inhand_icon_state = "jackboots"
	worn_icon_state = "peacekeeper"

//OVERRIDES
/obj/item/clothing/suit/armor/riot
	name = "peacekeeper riotsuit"
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	worn_icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/clothing/peacekeeper_armors.dmi'
	icon_state = "peacekeeper_riot"

