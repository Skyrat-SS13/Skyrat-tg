///Mail goodie list.
#define GUN_MAIL_LIST list(	/obj/item/gun_maintenance_supplies,\
							/obj/item/bedsheet/patriot,\
							/obj/item/clothing/mask/gas/hecu2,\
							/obj/item/storage/backpack/industrial/cin_surplus/random_color,\
							/obj/item/storage/belt/military/cin_surplus/random_color,\
							/obj/item/toy/gun,\
							/obj/item/toy/ammo/gun,\
							)

///Gun you get on spawn.
#define STARTER_GUN_LIST list(/obj/item/gun/ballistic/automatic/pistol/g17,\
							/obj/item/gun/ballistic/automatic/pistol/mk58,\
							/obj/item/gun/ballistic/automatic/pistol/pdh/peacekeeper,\
							/obj/item/gun/ballistic/automatic/dozer,\
							/obj/item/gun/ballistic/automatic/pistol/cfa_snub,\
							)

/datum/quirk/item_quirk/gun_nut
	name = "Gun Nut"
	desc = "You own a firearm, presumably for self defense or boasting about how cool it is; and you thought it's such a good idea to bring it on station with you."
	icon = FA_ICON_GUN
	value = 6
	mob_trait = TRAIT_GUN_NUT
	quirk_flags = QUIRK_HUMAN_ONLY|QUIRK_HIDE_FROM_SCAN
	gain_text = span_notice("Man, I sure do love guns!")
	lose_text = span_danger("Maybe having a gun isn't that a good idea...") //man so stupid
	medical_record_text = "Patient has passed a psychological evaluation and has been authorised with firearms and ammunition handling." //shouldn't show up anyways so whatever
	mail_goodies = GUN_MAIL_LIST

/datum/quirk/item_quirk/gun_nut/add_unique(client/client_source)
	var/mob/living/carbon/human/gun_nut = quirk_holder
	var/obj/item/storage/toolbox/guncase/gun_nut/new_case = new(src)
	new_case.desc = "[gun_nut.real_name]'s personalised safe weapon storage."
	give_item_to_holder(new_case, list(LOCATION_BACKPACK = ITEM_SLOT_BACKPACK, LOCATION_HANDS = ITEM_SLOT_HANDS))

/obj/item/storage/toolbox/guncase/gun_nut
	name = "personal gun case"
	desc = "Used for safe storaging of guns."
	icon_state = "lockbox"
	var/obj/item/gun/ballistic/gun = null
	extra_to_spawn = null

/obj/item/storage/toolbox/guncase/gun_nut/Initialize()
	gun = pick(STARTER_GUN_LIST)
	weapon_to_spawn = gun
	extra_to_spawn = gun.accepted_magazine_type
	. = ..()
	atom_storage.max_specific_storage = WEIGHT_CLASS_NORMAL
	atom_storage.max_total_storage = 9
	atom_storage.max_slots = 4
