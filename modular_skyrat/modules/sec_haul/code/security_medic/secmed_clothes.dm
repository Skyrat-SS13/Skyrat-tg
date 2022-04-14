/obj/item/clothing/suit/toggle/labcoat/security_medic
	name = "security medic's labcoat"
	icon_state = "secmed_labcoat"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 50, ACID = 50, WOUND = 10)
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/gun, /obj/item/storage/medkit)

/obj/item/clothing/suit/toggle/labcoat/security_medic/blue
	icon_state = "secmed_labcoat_blue"
	worn_icon_state = "secmed_labcoat_blue"

/obj/item/clothing/suit/hazardvest/security_medic
	name = "security medic's vest"
	desc = "A lightweight vest worn by the Security Medic."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "secmed_vest"
	worn_icon_state = "secmed_vest"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/gun, /obj/item/storage/medkit)
	armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 50, ACID = 50, WOUND = 10)

/obj/item/clothing/suit/hazardvest/security_medic/blue
	icon_state = "secmed_vest_blue"
	worn_icon_state = "secmed_vest_blue"

/obj/item/clothing/suit/armor/vest/peacekeeper/security_medic
	name = "security medic's armor vest"
	desc = "A security medic's armor vest, with little pockets for little things."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "secmed_armor"
	worn_icon_state = "secmed_armor"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/gun, /obj/item/storage/medkit)

/obj/item/clothing/under/rank/security/peacekeeper/security_medic
	name = "security medics's uniform"
	desc = "A lightly armored uniform worn by Nanotrasen's Asset Protection Medical Corps."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/uniforms.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/uniform.dmi'
	worn_icon_digi = 'modular_skyrat/master_files/icons/mob/clothing/uniform_digi.dmi'
	icon_state = "security_medic_jumpsuit"

/obj/item/clothing/under/rank/security/peacekeeper/security_medic/alternate
	name = "security medics's turtleneck"
	desc = "A comfy turtleneck with a white armband, denoting the wearer as a security medic."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/under/security.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/under/security.dmi'
	icon_state = "security_medic_turtleneck"

/obj/item/clothing/under/rank/security/peacekeeper/security_medic/skirt
	name = "security medics's skirtleneck"
	desc = "A comfy turtleneck with a white armband and brown skirt, denoting the wearer as a security medic."
	icon_state = "security_medic_turtleneck_skirt"

/obj/item/clothing/head/beret/sec/peacekeeper/security_medic
	name = "security medic's beret"
	desc = "A robust beret with the medical insignia emblazoned on it. Uses reinforced fabric to offer sufficient protection."
	greyscale_colors = "#3F3C40#870E12"
	icon_state = "beret_badge_med"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/clothing/head/helmet/sec/peacekeeper/security_medic
	name = "security medic's helmet"
	desc = "A standard issue combat helmet for security medics. Has decent tensile strength and armor. Keep your head down."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	worn_icon_state = "secmed_helmet"
	icon_state = "secmed_helmet"
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION_NO_NEW_ICON

/obj/item/storage/belt/security/medic
	name = "security medic's belt"
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
	name = "security medic's belt"
	worn_icon_state = "belt_medic_alt"
	icon_state = "belt_medic_alt"
