/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic
	name = "security medic labcoat"
	icon_state = "secmed_labcoat" //Icon located in modular_skyrat/master_files/icons/(obj or mob)/clothing/suits/labcoat.dmi
	blood_overlay_type = "armor"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor_type = /datum/armor/skyrat_security_medic

/datum/armor/skyrat_security_medic
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/Initialize(mapload)
	. = ..()
	allowed += list(
		/obj/item/flashlight,
		/obj/item/gun,
		/obj/item/melee/baton/telescopic,
		/obj/item/storage/medkit
		)

/obj/item/clothing/suit/toggle/labcoat/skyrat/security_medic/blue
	icon_state = "secmed_labcoat_blue"

/obj/item/clothing/suit/hazardvest/security_medic
	name = "security medic vest"
	desc = "A lightweight vest worn by the Security Medic."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "secmed_vest"
	worn_icon_state = "secmed_vest"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight, /obj/item/reagent_containers/cup/bottle, /obj/item/reagent_containers/cup/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/gun, /obj/item/storage/medkit)
	armor_type = /datum/armor/hazardvest_security_medic

/datum/armor/hazardvest_security_medic
	melee = 35
	bullet = 30
	laser = 30
	energy = 40
	bomb = 25
	fire = 50
	acid = 50
	wound = 10

/obj/item/clothing/suit/hazardvest/security_medic/blue
	icon_state = "secmed_vest_blue"
	worn_icon_state = "secmed_vest_blue"

/obj/item/clothing/suit/armor/vest/peacekeeper/security_medic
	name = "security medic armor vest"
	desc = "A security medic's armor vest, with little pockets for little things."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "secmed_armor"
	worn_icon_state = "secmed_armor"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight, /obj/item/reagent_containers/cup/bottle, /obj/item/reagent_containers/cup/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/gun, /obj/item/storage/medkit)

/obj/item/clothing/under/rank/security/peacekeeper/security_medic/alternate
	name = "security medic uniform"
	desc = "A lightly armored uniform worn by Nanotrasen's Asset Protection Medical Corps."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "security_medic_jumpsuit"

/obj/item/clothing/under/rank/security/peacekeeper/security_medic
	name = "security medic turtleneck"
	desc = "A comfy turtleneck with a white armband, denoting the wearer as a security medic."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "security_medic_turtleneck"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION

/obj/item/clothing/under/rank/security/peacekeeper/security_medic/skirt
	name = "security medic skirtleneck"
	desc = "A comfy turtleneck with a white armband and brown skirt, denoting the wearer as a security medic."
	icon_state = "security_medic_turtleneck_skirt"
	body_parts_covered = CHEST|GROIN|ARMS
	female_sprite_flags = FEMALE_UNIFORM_TOP_ONLY
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/beret/sec/peacekeeper/security_medic
	name = "security medic beret"
	desc = "A robust beret with the medical insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	greyscale_colors = "#3F3C40#870E12"
	icon_state = "beret_badge_med"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/helmet/sec/peacekeeper/security_medic
	name = "security medic helmet"
	desc = "A standard issue combat helmet for security medics. Has decent tensile strength and armor. Keep your head down."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/head/helmet.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head/helmet.dmi'
	icon_state = "secmed_helmet"
	base_icon_state = "secmed_helmet"
	can_toggle = FALSE
	actions_types = null
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/storage/belt/security/medic
	name = "security medic belt"
	desc = "A fancy looking security belt emblazoned with markings of the security medic. Sadly only holds security gear."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/belts.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/belt.dmi'
	worn_icon_state = "belt_medic"
	icon_state = "belt_medic"

/obj/item/storage/belt/security/medic/full/PopulateContents()
	new /obj/item/reagent_containers/spray/pepper(src)
	new /obj/item/restraints/handcuffs(src)
	new /obj/item/grenade/flashbang(src)
	new /obj/item/assembly/flash/handheld(src)
	new /obj/item/melee/baton/security/loaded(src)
	update_appearance()

/obj/item/storage/belt/security/medic/alternate
	name = "security medic belt"
	worn_icon_state = "belt_medic_alt"
	icon_state = "belt_medic_alt"
