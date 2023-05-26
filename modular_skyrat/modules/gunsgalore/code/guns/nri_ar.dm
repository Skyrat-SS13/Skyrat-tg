/obj/item/gun/ballistic/automatic/nri_ar
	name = "\improper KV-62 carbine"
	desc = "A modified version of the most iconic human firearm ever made, re-engineered for better weight, handling, and accuracy, chambered in the NRI's 5.6mm ammo. 'НРИ - Оборонная Коллегия' is etched on the bolt."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_guns40x32.dmi'
	icon_state = "nri_ar"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_righthand.dmi'
	inhand_icon_state = "nri_ar"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	mag_type = /obj/item/ammo_box/magazine/nri_ar
	fire_delay = 2
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_back.dmi'
	worn_icon_state = "nri_ar"
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/ar2_fire.ogg'
	rack_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ar2_cock.ogg'
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ar2_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ar2_magin.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ar2_magout.ogg'
	alt_icons = TRUE
	empty_alarm = TRUE

/obj/item/gun/ballistic/automatic/nri_ar/Initialize(mapload)
	. = ..()

	AddComponent(/datum/component/automatic_fire, fire_delay)

/obj/item/gun/ballistic/automatic/nri_ar/give_manufacturer_examine()
	AddComponent(/datum/component/manufacturer_examine, COMPANY_IZHEVSK)

/obj/item/ammo_box/magazine/nri_ar
	name = "\improper Krinkov magazine"
	desc = "A double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_items.dmi'
	icon_state = "nri_ar"
	ammo_type = /obj/item/ammo_casing/realistic/a56x40
	caliber = "a56x40"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/nri_ar/ricochet
	name = "krinkov magazine (MATCH)"
	desc = "A double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'. Contains highly ricocheting ammunition."
	icon_state = "nri_ar_ricochet"
	ammo_type = /obj/item/ammo_casing/realistic/a56x40/ricochet

/obj/item/ammo_box/magazine/nri_ar/fire
	name = "krinkov magazine (INCENDIARY)"
	desc = "A double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'. Contains incendiary ammunition."
	icon_state = "nri_ar_fire"
	ammo_type = /obj/item/ammo_casing/realistic/a56x40/fire

/obj/item/ammo_box/magazine/nri_ar/ap
	name = "krinkov magazine (ARMOR PIERCING)"
	desc = "A double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'. Contains armor-piercing ammunition."
	icon_state = "nri_ar_ap"
	ammo_type = /obj/item/ammo_casing/realistic/a56x40/ap

/obj/item/ammo_box/magazine/nri_ar/emp
	name = "krinkov magazine (EMP)"
	desc = "A double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'. Contains ion ammunition, good for disrupting electronics and wrecking mechas."
	icon_state = "nri_ar_emp"
	ammo_type = /obj/item/ammo_casing/realistic/a56x40/emp

/obj/item/ammo_box/magazine/nri_ar/rubber
	name = "krinkov magazine (RUBBER)"
	desc = "A double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'. Contains less-than-lethal rubber ammunition."
	icon_state = "nri_ar_rubber"
	ammo_type = /obj/item/ammo_casing/realistic/a56x40/civilian/rubber

/obj/item/ammo_box/magazine/nri_ar/banana
	name = "\improper Krinkov extended magazine"
	desc = "An extended double-stack magazine able to hold 45 rounds of 5.6x40mm ammunition."
	max_ammo = 45

/obj/item/ammo_box/magazine/nri_ar/civvie
	name = "\improper Sabel magazine"
	desc = "A shortened double-stack magazine able to hold 15 rounds of civilian-grade 5.6mm ammo."
	icon_state = "nri_ar_civ"
	max_ammo = 15
	ammo_type = /obj/item/ammo_casing/realistic/a56x40/civilian

/obj/item/gun/ballistic/automatic/nri_ar/civvie
	name = "\improper Sabel-42 carbine"
	desc = "A timeless human design of a carbine chambered in the NRI's 5.6mm ammo. The internal modifications made to the firearm in order to accommodate for non-military use made it incompatible with conventional munitions and gave it the inability to fire fully automatic. It's purpose-built to fire low-grade civilian ammo, anything stronger would obliterate the rifling and render the firearm useless."
	icon_state = "nri_ar_civ"
	inhand_icon_state = "nri_ar_civ"
	mag_type = /obj/item/ammo_box/magazine/nri_ar/civvie
	burst_size = 1
	fire_delay = 5
	actions_types = list()
	dual_wield_spread = 15
	spread = 5
	worn_icon_state = "nri_ar_civ"
	recoil = 0.2
