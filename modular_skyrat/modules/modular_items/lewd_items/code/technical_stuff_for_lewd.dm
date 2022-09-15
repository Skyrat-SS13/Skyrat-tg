// Moved from my old interactions file 'cause skyrats already did interactions

#define REQUIRE_NONE 0
#define REQUIRE_EXPOSED 1
#define REQUIRE_UNEXPOSED 2
#define REQUIRE_ANY 3

/mob/living/carbon/human
	var/has_penis = FALSE
	var/has_vagina = FALSE
	var/has_breasts = FALSE
	var/has_anus = FALSE

/*
*	Looping sound for vibrating stuff
*/

/datum/looping_sound/vibrator
	start_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	start_length = 1
	mid_sounds = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	mid_length = 1
	end_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bzzz-loop-1.ogg'
	falloff_distance = 1
	falloff_exponent = 5
	extra_range = SILENCED_SOUND_EXTRARANGE
	ignore_walls = FALSE

/datum/looping_sound/vibrator/low
	volume = 80

/datum/looping_sound/vibrator/medium
	volume = 90

/datum/looping_sound/vibrator/high
	volume = 100

/*
*	Boxes for vending machine, to spawn stuff with important cheap tools in pack
*/

// Milking machine
/obj/item/storage/box/milking_kit
	name = "DIY milking machine kit"
	desc = "Contains everything you need to build your own milking machine!"

/obj/item/storage/box/milking_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/milking_machine/constructionkit = 1)
	generate_items_inside(items_inside, src)

// X-Stand
/obj/item/storage/box/xstand_kit
	name = "DIY x-stand kit"
	desc = "Contains everything you need to build your own X-stand!"

/obj/item/storage/box/xstand_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/x_stand_kit = 1)
	generate_items_inside(items_inside, src)

// BDSM bed
/obj/item/storage/box/bdsmbed_kit
	name = "DIY BDSM bed kit"
	desc = "Contains everything you need to build your own BDSM bed!"

/obj/item/storage/box/bdsmbed_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/bdsm_bed_kit = 1)
	generate_items_inside(items_inside, src)

// Striptease pole
/obj/item/storage/box/strippole_kit
	name = "DIY stripper pole kit"
	desc = "Contains everything you need to build your own stripper pole!"

/obj/item/storage/box/strippole_kit/PopulateContents()
	var/static/items_inside = list(
		/obj/item/polepack = 1)
	generate_items_inside(items_inside, src)

// Shibari stand
/obj/item/storage/box/shibari_stand
	name = "DIY shibari stand kit"
	desc = "Contains everything you need to build your own shibari stand!"

/obj/item/storage/box/shibari_stand/PopulateContents()
	var/static/items_inside = list(
		/obj/item/shibari_stand_kit = 1,
		/obj/item/paper/shibari_kit_instructions = 1)
	generate_items_inside(items_inside, src)

// Paper instructions for shibari kit

/obj/item/paper/shibari_kit_instructions
	default_raw_text = "Hello! Congratulations on your purchase of the shibari kit by LustWish! Some newbies may get confused by our ropes, so we prepared a small instructions for you! First of all, you have to have a wrench to construct the stand itself. Secondly, you can use screwdrivers to change the color of your shibari stand. Just replace the plastic fittings! Thirdly, if you want to tie somebody to a bondage stand you need to fully tie their body, on both groin and chest!. To do that you need to use rope on body and then on groin of character, then you can just buckle them to the stand like any chair. Don't forget to have some ropes on your hand to actually tie them to the stand, as there's no ropes included with it! And that's it!"

/*
*	This code is supposed to be placed in "code/modules/mob/living/carbon/human/inventory.dm"
*	If you are nice person you can transfer this part of code to it, but i didn't for modularisation reasons
*/

/mob/living/carbon/human/resist_restraints()
	if(gloves?.breakouttime)
		changeNext_move(CLICK_CD_BREAKOUT)
		last_special = world.time + CLICK_CD_BREAKOUT
		cuff_resist(gloves)
	else
		..()

/*
*	I needed this code for ballgag, because it doesn't muzzle, it kinda voxbox
*	wearer for moaning. So i really need it, don't touch or whole ballgag will be broken
*	for ballgag mute audible emotes
*	adding is_ballgagged() proc here. Hope won't break anything important.
*	This is kinda shitcode, but they said don't touch main code or they will break my knees.
*	i love my knees, please merge.
*	more shitcode can be found in code/datums/emotes.dm
*	in /datum/emote/proc/select_message_type(mob/user, intentional) proc. Sorry for that, i had no other choise.
*/

//false for default
/mob/proc/is_ballgagged()
	return FALSE

/mob/living/carbon/is_ballgagged()
	return(istype(src.wear_mask, /obj/item/clothing/mask/ballgag) || istype(src.wear_mask, /obj/item/clothing/head/helmet/space/deprivation_helmet))

//proc for condoms. Need to prevent cum appearing on the floor.
/mob/proc/wear_condom()
	return FALSE

/mob/living/carbon/human/wear_condom()
	. = ..()
	if(.)
		return TRUE
	if(penis != null && istype(penis, /obj/item/clothing/sextoy/condom))
		return TRUE
	return FALSE

/*
*	This shouldn't be put anywhere, get your dirty hands off!
*	For dancing pole
*/

/atom
	var/pseudo_z_axis

/atom/proc/get_fake_z()
	return pseudo_z_axis

/obj/structure/table
	pseudo_z_axis = 8

/turf/open/get_fake_z()
	var/objschecked
	for(var/obj/structure/structurestocheck in contents)
		objschecked++
		if(structurestocheck.pseudo_z_axis)
			return structurestocheck.pseudo_z_axis
		if(objschecked >= 25)
			break
	return pseudo_z_axis

/mob/living/Move(atom/newloc, direct)
	. = ..()
	if(.)
		pseudo_z_axis = newloc.get_fake_z()
		pixel_z = pseudo_z_axis

/*
*	INVENTORY SYSTEM EXTENTION
*/

// SLOT GROUP HELPERS
#define ITEM_SLOT_ERP_INSERTABLE (LEWD_SLOT_VAGINA|LEWD_SLOT_ANUS)
#define ITEM_SLOT_ERP_ATTACHABLE (LEWD_SLOT_NIPPLES|LEWD_SLOT_PENIS)

// Just by analogy with the TG code. No ideas for what this is.
/mob/proc/update_inv_vagina()
	return
/mob/proc/update_inv_anus()
	return
/mob/proc/update_inv_nipples()
	return
/mob/proc/update_inv_penis()
	return
/// Helper proc for calling all the lewd slot update_inv_ procs.
/mob/proc/update_inv_lewd()
	update_inv_vagina()
	update_inv_anus()
	update_inv_nipples()
	update_inv_penis()

// Add variables for slots to the Carbon class
/mob/living/carbon/human
	var/obj/item/vagina = null
	var/obj/item/anus = null
	var/obj/item/nipples = null
	var/obj/item/penis = null

/*
* SEXTOY CLOTH TYPE
*/

/obj/item/clothing/sextoy
	name = "sextoy"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi'
	equip_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bang1.ogg'
	drop_sound = 'modular_skyrat/modules/modular_items/lewd_items/sounds/bang2.ogg'
	pickup_sound =  'sound/items/handling/cloth_pickup.ogg'
	var/lewd_slot_flags = NONE

/obj/item/clothing/sextoy/dropped(mob/user)
	..()

	update_appearance()
	if(!ishuman(loc))
		return

	var/mob/living/carbon/human/holder = loc
	holder.update_inv_lewd()
	holder.fan_hud_set_fandom()

/// A check to confirm if you can open the toy's color/design radial menu
/obj/item/clothing/sextoy/proc/check_menu(mob/living/user)
	if(!istype(user))
		return FALSE
	if(user.incapacitated())
		return FALSE
	return TRUE

/*
*	STRIPPING ERP SYSTEM EXTENTION
*/

// Extends default proc check for hidden ears for supporting our sleepbag and catsuit to
/datum/sprite_accessory/ears/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	// First lets proc default code
	. = ..()
	if(!.) // If true, ears already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden frills for supporting our sleepbag and catsuit to
/datum/sprite_accessory/frills/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	. = ..()
	if(!.) // If true, frills already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden head accessory for supporting our sleepbag and catsuit to
/datum/sprite_accessory/head_accessory/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	. = ..()
	if(!.) // If true, head accessory already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden horns for supporting our sleepbag and catsuit to
/datum/sprite_accessory/horns/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	. = ..()
	if(!.) // If true, horns already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden antenna for supporting our sleepbag and catsuit to
/datum/sprite_accessory/antenna/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	. = ..()
	if(!.) // If true, antenna already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden moth antenna for supporting our sleepbag and catsuit to
/datum/sprite_accessory/moth_antennae/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	. = ..()
	if(!.) // If true, moth antenna already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden skrell hair for supporting our sleepbag and catsuit to
/datum/sprite_accessory/skrell_hair/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	. = ..()
	if(!.) // If true, skrell hair already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			if(sleeping_bag.state_thing == "inflated")
				return TRUE
			return FALSE
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return FALSE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden skrell hair for supporting our sleepbag and catsuit to
/datum/sprite_accessory/tails/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	. = ..()
	if(!.) // If true, tail already hidden
		if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
			// var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
			// if(sleeping_bag.state_thing == "inflated")
			// 	return TRUE
			return TRUE /* return FALSE */
		else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
			return TRUE
		return FALSE
	return TRUE // Return TRUE if superfuncitons already retuns TRUE

// Extends default proc check for hidden wings for supporting our sleepbag and catsuit to
/datum/sprite_accessory/wings/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	. = ..()
	if(.)
		return TRUE
	if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		return TRUE
	return FALSE

/mob/living/carbon/human/set_handcuffed(new_value)
	if(wear_suit && istype(wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		return FALSE
	..()

/datum/sprite_accessory/xenodorsal/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		return TRUE
	else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
		return TRUE
	return FALSE

/datum/sprite_accessory/xenohead/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/HD)
	if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
		if(sleeping_bag.state_thing == "inflated")
			return TRUE
		return FALSE
	else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit/))
		return FALSE
	return FALSE

/datum/preference/toggle/erp/sex_toy/apply_to_client_updated(client/client, value)
	. = ..()
	if(!client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		if(ishuman(client.mob))
			var/mob/living/carbon/human/target = client.mob
			if(target.vagina != null)
				target.dropItemToGround(target.vagina, TRUE, target.loc, TRUE, FALSE, TRUE)
			if(target.anus != null)
				target.dropItemToGround(target.anus, TRUE, target.loc, TRUE, FALSE, TRUE)
			if(target.nipples != null)
				target.dropItemToGround(target.nipples, TRUE, target.loc, TRUE, FALSE, TRUE)
			if(target.penis != null)
				target.dropItemToGround(target.penis, TRUE, target.loc, TRUE, FALSE, TRUE)


	client.mob.hud_used.hidden_inventory_update(client.mob)
	client.mob.hud_used.persistent_inventory_update(client.mob)

/// If the item this is called in, is in a genital slot of the target
/obj/item/proc/is_in_genital(mob/living/carbon/human/the_guy)
	return (src == the_guy.penis || src == the_guy.vagina || src == the_guy.anus || src == the_guy.nipples)

/// Used to add a cum decal to the floor while transferring viruses and DNA to it
/mob/living/proc/add_cum_splatter_floor(turf/the_turf, female = FALSE)
	if(!the_turf)
		the_turf = get_turf(src)

	var/selected_type = female ? /obj/effect/decal/cleanable/cum/femcum : /obj/effect/decal/cleanable/cum
	var/atom/stain = new selected_type(the_turf, get_static_viruses())

	stain.transfer_mob_blood_dna(src) //I'm not adding a new forensics category for cumstains
