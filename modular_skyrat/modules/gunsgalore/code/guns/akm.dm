/obj/item/gun/ballistic/automatic/akm
	name = "\improper Krinkov carbine"
	desc = "A timeless human design of a carbine chambered in the NRI's 5.6mm ammo. A weapon so simple that even a child could use it - and they often did."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_guns40x32.dmi'
	icon_state = "akm"
	lefthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_righthand.dmi'
	inhand_icon_state = "akm"
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	w_class = WEIGHT_CLASS_BULKY
	weapon_weight = WEAPON_HEAVY
	mag_type = /obj/item/ammo_box/magazine/akm
	can_suppress = FALSE
	burst_size = 3
	fire_delay = 2
	worn_icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_back.dmi'
	worn_icon_state = "akm"
	fire_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/fire/akm_fire.ogg'
	rack_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ltrifle_cock.ogg'
	load_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ltrifle_magin.ogg'
	load_empty_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ltrifle_magin.ogg'
	eject_sound = 'modular_skyrat/modules/gunsgalore/sound/guns/interact/ltrifle_magout.ogg'
	alt_icons = TRUE
	dirt_modifier = 0.75
	company_flag = COMPANY_IZHEVSK

/obj/item/ammo_box/magazine/akm
	name = "\improper Krinkov magazine"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'."
	icon = 'modular_skyrat/modules/gunsgalore/icons/guns/gunsgalore_items.dmi'
	icon_state = "akm"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39
	caliber = "a762x39"
	max_ammo = 30
	multiple_sprites = AMMO_BOX_FULL_EMPTY

/obj/item/ammo_box/magazine/akm/ricochet
	name = "krinkov magazine (MATCH)"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'. Contains highly ricocheting ammunition."
	icon_state = "akm_ricochet"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/ricochet

/obj/item/ammo_box/magazine/akm/fire
	name = "krinkov magazine (INCENDIARY)"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'. Contains incendiary ammunition."
	icon_state = "akm_fire"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/fire

/obj/item/ammo_box/magazine/akm/ap
	name = "krinkov magazine (ARMOR PIERCING)"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'. Contains armor-piercing ammunition."
	icon_state = "akm_ap"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/ap

/obj/item/ammo_box/magazine/akm/emp
	name = "krinkov magazine (EMP)"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'. Contains ion ammunition, good for disrupting electronics and wrecking mechas."
	icon_state = "akm_emp"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/emp

/obj/item/ammo_box/magazine/akm/rubber
	name = "krinkov magazine (RUBBER)"
	desc = "a banana-shaped double-stack magazine able to hold 30 rounds of 5.6mm ammo. It's said that in the early days of SolFed's spread, Spanish colony rebels often referred to these as 'Goat Horns'. Contains less-than-lethal rubber ammunition."
	icon_state = "akm_rubber"
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/civilian/rubber

/obj/item/ammo_box/magazine/akm/banana
	name = "\improper Krinkov extended magazine"
	desc = "a banana-shaped double-stack magazine able to hold 45 rounds of 5.6x40mm ammunition. It's meant to be used on a light machine gun, but it's just a longer Krinkov magazine."
	max_ammo = 45

/obj/item/ammo_box/magazine/akm/civvie
	name = "\improper Sabel magazine"
	desc = "a shortened double-stack magazine able to hold 15 rounds of civilian-grade 5.6mm ammo."
	icon_state = "akm_civ"
	max_ammo = 15
	ammo_type = /obj/item/ammo_casing/realistic/a762x39/civilian

/obj/item/gun/ballistic/automatic/akm/modern
	name = "\improper Bubba's Krinkov"
	desc = "A modified version of the most iconic human firearm ever made. Most of the original parts are gone in favor of aftermarket replacements."
	icon_state = "akm_modern"
	inhand_icon_state = "akm"
	worn_icon_state = "akm"
	fire_delay = 1

/obj/item/gun/ballistic/automatic/akm/civvie
	name = "\improper Sabel-42 carbine"
	desc = "A timeless human design of a carbine chambered in the NRI's 5.6mm ammo. The internal modifications made to the firearm in order to accommodate for non-military use made it incompatible with conventional munitions and gave it the inability to fire fully automatic. It's purpose-built to fire low-grade civilian ammo, anything stronger would obliterate the rifling and render the firearm useless."
	icon_state = "akm_civ"
	inhand_icon_state = "akm_civ"
	fire_select_modes = list(SELECT_SEMI_AUTOMATIC)
	mag_type = /obj/item/ammo_box/magazine/akm/civvie
	burst_size = 1
	fire_delay = 5
	dual_wield_spread = 15
	spread = 5
	worn_icon_state = "akm_civ"
	dirt_modifier = 1
	recoil = 0.2

/obj/item/gun/ballistic/automatic/akm/nri
	name = "\improper KV-62 carbine"
	desc = "A modified version of the most iconic human firearm ever made, re-engineered for better weight, handling, and accuracy, chambered in the NRI's 5.6mm ammo. 'НРИ - Оборонная Коллегия' is etched on the bolt."
	icon_state = "akm_nri"
	inhand_icon_state = "akm_nri"
	worn_icon_state = "akm_nri"
	dirt_modifier = 0.6
	can_suppress = TRUE
