/obj/item/clothing/suit/toggle/labcoat/security_medic
	name = "security medic's labcoat"
	icon_state = "secmed_labcoat"
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	mutant_variants = NONE
	armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 50, ACID = 50, WOUND = 10)
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/gun, /obj/item/storage/medkit)

/obj/item/clothing/suit/hazardvest/security_medic
	name = "security medic's vest"
	desc = "A lightweight vest worn by the Security Medic."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "secmed_vest"
	worn_icon_state = "secmed_vest"
	mutant_variants = NONE
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/gun, /obj/item/storage/medkit)
	armor = list(MELEE = 35, BULLET = 30, LASER = 30, ENERGY = 40, BOMB = 25, BIO = 0, FIRE = 50, ACID = 50, WOUND = 10)

/obj/item/clothing/suit/armor/vest/peacekeeper/security_medic
	name = "security medic's armor vest"
	desc = "A security medic's armor vest, with little pockets for little things."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/suits.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/suit.dmi'
	icon_state = "secmed_armor"
	worn_icon_state = "secmed_armor"
	mutant_variants = NONE
	allowed = list(/obj/item/analyzer, /obj/item/stack/medical, /obj/item/dnainjector, /obj/item/reagent_containers/dropper, /obj/item/reagent_containers/syringe, /obj/item/reagent_containers/hypospray, /obj/item/healthanalyzer, /obj/item/flashlight, /obj/item/reagent_containers/glass/bottle, /obj/item/reagent_containers/glass/beaker, /obj/item/reagent_containers/pill, /obj/item/storage/pill_bottle, /obj/item/paper, /obj/item/melee/baton/telescopic, /obj/item/soap, /obj/item/tank/internals/emergency_oxygen, /obj/item/gun, /obj/item/storage/medkit)

/obj/item/clothing/suit/armor/vest/peacekeeper/security_medic/lopland //For the newest iteration
	desc = "A standard security vest with hi-vis identifiers to show the wearer is a security medic. That, or a target."
	icon_state = "secmed_armor_hivis"
	worn_icon_state = "secmed_armor_hivis"

/obj/item/clothing/suit/armor/vest/peacekeeper/security_medic/lopland/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", alpha = src.alpha)

/obj/item/clothing/under/rank/security/peacekeeper/security_medic
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
	mutant_variants = NONE

/obj/item/clothing/head/helmet/sec/peacekeeper/security_medic
	name = "security medic's helmet"
	desc = "A standard issue combat helmet for security medics. Has decent tensile strength and armor. Keep your head down."
	icon = 'modular_skyrat/master_files/icons/obj/clothing/hats.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/head.dmi'
	worn_icon_state = "secmed_helmet"
	icon_state = "secmed_helmet"
	mutant_variants = NONE

/obj/item/clothing/head/helmet/sec/peacekeeper/security_medic/lopland //For the newest iteration
	desc = "A standard issue combat helmet with hi-vis symbols taped on, for security medics. Has decent tensile strength and armor. Keep your head down."
	icon_state = "secmed_helmet_hivis"
	worn_icon_state = "secmed_helmet_hivis"

/obj/item/clothing/head/helmet/sec/peacekeeper/security_medic/lopland/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(!isinhands)
		. += emissive_appearance(icon_file, "[icon_state]-emissive", alpha = src.alpha)
