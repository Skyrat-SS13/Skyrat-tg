/datum/sprite_accessory/proc/lewd_is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart, hide_if_catsuit = TRUE, hide_if_sleeping_bag = TRUE)
	if(target_human.wear_suit && istype(target_human.wear_suit, /obj/item/clothing/suit/straight_jacket/kinky_sleepbag))
		var/obj/item/clothing/suit/straight_jacket/kinky_sleepbag/sleeping_bag = target_human.wear_suit
		if(sleeping_bag.state_thing == "inflated")
			return hide_if_sleeping_bag
		return FALSE
	else if(target_human.w_uniform && istype(target_human.w_uniform, /obj/item/clothing/under/misc/latex_catsuit))
		return hide_if_catsuit
	return FALSE

// Extends default proc check for hidden ears for supporting our sleepbag and catsuit too
/datum/sprite_accessory/ears/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart)
	// First lets proc default code
	. = ..()
	if(!.) // If true, ears already hidden
		return lewd_is_hidden(target_human, bodypart)

// Extends default proc check for hidden frills for supporting our sleepbag and catsuit too
/datum/sprite_accessory/frills/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart)
	. = ..()
	if(!.) // If true, frills already hidden
		return lewd_is_hidden(target_human, bodypart)

// Extends default proc check for hidden head accessory for supporting our sleepbag and catsuit too
/datum/sprite_accessory/head_accessory/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart)
	. = ..()
	if(!.) // If true, head accessory already hidden
		return lewd_is_hidden(target_human, bodypart)

// Extends default proc check for hidden horns for supporting our sleepbag and catsuit too
/datum/sprite_accessory/horns/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart)
	. = ..()
	if(!.) // If true, horns already hidden
		return lewd_is_hidden(target_human, bodypart)

// Extends default proc check for hidden antenna for supporting our sleepbag and catsuit too
/datum/sprite_accessory/antenna/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart)
	. = ..()
	if(!.) // If true, antenna already hidden
		return lewd_is_hidden(target_human, bodypart)

// Extends default proc check for hidden moth antenna for supporting our sleepbag and catsuit too
/datum/sprite_accessory/moth_antennae/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart)
	. = ..()
	if(!.) // If true, moth antenna already hidden
		return lewd_is_hidden(target_human, bodypart)

// Extends default proc check for hidden skrell hair for supporting our sleepbag and catsuit too
/datum/sprite_accessory/skrell_hair/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart)
	. = ..()
	if(!.) // If true, skrell hair already hidden
		return lewd_is_hidden(target_human, bodypart)

// Extends default proc check for hidden skrell hair for supporting our sleepbag and catsuit too
/datum/sprite_accessory/tails/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart)
	. = ..()
	if(!.) // If true, tail already hidden
		return lewd_is_hidden(target_human, bodypart, hide_if_catsuit = FALSE)

/datum/sprite_accessory/xenodorsal/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart)
	. = ..()
	if(!.)
		return lewd_is_hidden(target_human, bodypart)

/datum/sprite_accessory/xenohead/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart)
	. = ..()
	if(!.)
		return lewd_is_hidden(target_human, bodypart, hide_if_catsuit = FALSE, hide_if_sleeping_bag = FALSE)

// Extends default proc check for hidden wings for supporting our sleepbag and catsuit too
/datum/sprite_accessory/wings/is_hidden(mob/living/carbon/human/target_human, obj/item/bodypart/bodypart)
	. = ..()
	if(!.)
		return lewd_is_hidden(target_human, bodypart)

