/datum/species/snail
	name = "Snailperson"
	id = SPECIES_SNAIL
	/*SKYRAT EDIT - ORIGINAL
	species_traits = list(
		MUTCOLORS,
		NO_UNDERWEAR,
	)
	*/
	//SKYRAT EDIT - Snails deserve hair, and get to wear underwear, and have eye colour
	species_traits = list(
		MUTCOLORS,
		EYECOLOR,
		HAIR,
		FACEHAIR
	)
	inherent_traits = list(
		TRAIT_NO_SLIP_ALL,
		TRAIT_WATER_BREATHING, //SKYRAT EDIT - Roundstart Snails
	)

	coldmod = 0.5 //snails only come out when its cold and wet
	burnmod = 2
	speedmod = 6
	siemens_coeff = 2 //snails are mostly water
	liked_food = VEGETABLES | FRUIT | GROSS | RAW //SKYRAT EDIT - Roundstart Snails - Food Prefs
	disliked_food = DAIRY | ORANGES | SUGAR //SKYRAT EDIT: Roundstart Snails - As it turns out, you can't give a snail processed sugar or citrus.
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | RACE_SWAP
	sexes = FALSE //snails are hermaphrodites

	eyes_icon = 'modular_skyrat/modules/organs/icons/snail_eyes.dmi' // SKYRAT EDIT - Roundstart Snails
	mutanteyes = /obj/item/organ/internal/eyes/snail
	mutanttongue = /obj/item/organ/internal/tongue/snail
	mutantliver = /obj/item/organ/internal/liver/snail //SKYRAT EDIT - Roundstart Snails
	// exotic_blood = /datum/reagent/lube // SKYRAT EDIT REMOVAL: Roundstart Snails - No more lube

	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/snail,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/snail,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/snail,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/snail,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/snail,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/snail
	)

/datum/species/snail/handle_chemicals(datum/reagent/chem, mob/living/carbon/human/H, seconds_per_tick, times_fired)
	. = ..()
	if(istype(chem,/datum/reagent/consumable/salt))
		H.adjustFireLoss(2 * REM * seconds_per_tick)
		playsound(H, 'sound/weapons/sear.ogg', 30, TRUE)
		H.reagents.remove_reagent(chem.type, REAGENTS_METABOLISM * seconds_per_tick)
		return TRUE

/datum/species/snail/on_species_gain(mob/living/carbon/new_snailperson, datum/species/old_species, pref_load)
	. = ..()
	var/obj/item/storage/backpack/bag = new_snailperson.get_item_by_slot(ITEM_SLOT_BACK)
	if(!istype(bag, /obj/item/storage/backpack/snail))
		if(new_snailperson.dropItemToGround(bag)) //returns TRUE even if its null
			new_snailperson.equip_to_slot_or_del(new /obj/item/storage/backpack/snail(new_snailperson), ITEM_SLOT_BACK)
	new_snailperson.AddElement(/datum/element/snailcrawl)
	new_snailperson.update_icons() //SKYRAT EDIT: Roundstart Snails
	//if(ishuman(new_snailperson)) //SKYRAT EDIT: Snails don't have exotic blood here!
	//	update_mail_goodies(new_snailperson) //SKYRAT EDIT END

/datum/species/snail/on_species_loss(mob/living/carbon/former_snailperson, datum/species/new_species, pref_load)
	. = ..()
	former_snailperson.RemoveElement(/datum/element/snailcrawl)
	var/obj/item/storage/backpack/bag = former_snailperson.get_item_by_slot(ITEM_SLOT_BACK)
	if(istype(bag, /obj/item/storage/backpack/snail))
		bag.emptyStorage()
		former_snailperson.temporarilyRemoveItemFromInventory(bag, TRUE)
		qdel(bag)

/*/datum/species/snail/update_quirk_mail_goodies(mob/living/carbon/human/recipient, datum/quirk/quirk, list/mail_goodies = list()) //SKYRAT EDIT: Snails don't have exotic blood here!
	if(istype(quirk, /datum/quirk/blooddeficiency))
		mail_goodies += list(
			/obj/item/reagent_containers/blood/snail
		)
	return ..()*/ //SKYRAT EDIT END

/obj/item/storage/backpack/snail
	name = "snail shell"
	desc = "Worn by snails as armor and storage compartment."
	icon_state = "snailshell"
	inhand_icon_state = null
	lefthand_file = 'icons/mob/inhands/equipment/backpack_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/backpack_righthand.dmi'
	armor_type = /datum/armor/backpack_snail
	max_integrity = 200
	resistance_flags = FIRE_PROOF | ACID_PROOF
	//SKYRAT EDIT BEGIN - Roundstart Snails
	alternate_worn_layer = ABOVE_BODY_FRONT_LAYER //This makes them layer over tails like the cult backpack; some tails really shouldn't appear over them!
	uses_advanced_reskins = TRUE
	unique_reskin = list(
		"Conical Shell" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi',
			RESKIN_ICON_STATE = "coneshell",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "coneshell"
		),
		"Round Shell" = list(
			RESKIN_ICON = 'icons/obj/storage/backpack.dmi',
			RESKIN_ICON_STATE = "snailshell",
			RESKIN_WORN_ICON = 'icons/mob/clothing/back/backpack.dmi',
			RESKIN_WORN_ICON_STATE = "snailshell"
		),
		"Cinnamon Shell" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi',
			RESKIN_ICON_STATE = "cinnamonshell",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "cinnamonshell"
		),
		"Caramel Shell" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi',
			RESKIN_ICON_STATE = "caramelshell",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "caramelshell"
		),
		"Metal Shell" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi',
			RESKIN_ICON_STATE = "mechashell",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "mechashell"
		),
		"Pyramid Shell" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi',
			RESKIN_ICON_STATE = "pyramidshell",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "pyramidshell"
		),
		"Ivory Pyramid Shell" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi',
			RESKIN_ICON_STATE = "pyramidshellwhite",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "pyramidshellwhite"
		),
		"Spiral Shell" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi',
			RESKIN_ICON_STATE = "spiralshell",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "spiralshell"
		),
		"Ivory Spiral Shell" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi',
			RESKIN_ICON_STATE = "spiralshellwhite",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "spiralshellwhite"
		),
		"Rocky Shell" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi',
			RESKIN_ICON_STATE = "rockshell",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "rockshell"
		),
		"Ivory Rocky Shell" = list(
			RESKIN_ICON = 'modular_skyrat/master_files/icons/obj/clothing/backpacks.dmi',
			RESKIN_ICON_STATE = "rockshellwhite",
			RESKIN_WORN_ICON = 'modular_skyrat/master_files/icons/mob/clothing/back.dmi',
			RESKIN_WORN_ICON_STATE = "rockshellwhite"
		),
	)
	//SKYRAT EDIT END - Roundstart Snails

/datum/armor/backpack_snail
	melee = 40
	bullet = 30
	laser = 30
	energy = 10
	bomb = 25
	acid = 50

/obj/item/storage/backpack/snail/dropped(mob/user, silent)
	. = ..()
	emptyStorage()
	if(!QDELETED(src))
		qdel(src)

/obj/item/storage/backpack/snail/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, "snailshell")
