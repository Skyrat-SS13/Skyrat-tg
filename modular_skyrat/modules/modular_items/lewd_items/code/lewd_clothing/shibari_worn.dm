////////////////
//BODY BONDAGE//
////////////////

/obj/item/clothing/under/shibari_body
	name = "Shibari ropes"
	desc = "Nice looking rope bondage"
	icon_state = "shibari_body"
	//worn icons path stuff
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-hoof.dmi'
	//some unimportant vars
	can_adjust = FALSE
	body_parts_covered = NONE
	strip_delay = 100
	mutant_variants = STYLE_DIGITIGRADE|STYLE_TAUR_ALL
	//some important vars
	var/current_color = "pink"
	var/tight = "low" //can be low, medium and hard.

//customization stuff
/obj/item/clothing/under/shibari_body/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/clothing/under/shibari_body/Initialize()
	. = ..()
	update_icon_state()
	update_icon()

//unequip stuff for adding rope to hands
/obj/item/clothing/under/shibari_body/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/human/C = user
		if(src == C.w_uniform)
			if((do_after(C, 100, target = src)) && (!HAS_TRAIT(C, TRAIT_RIGGER)))
				var/obj/item/shibari_rope/R = new /obj/item/shibari_rope
				user.put_in_hands(R)
				qdel(src)

			if((do_after(C, 20, target = src)) && (HAS_TRAIT(C, TRAIT_RIGGER)))
				var/obj/item/shibari_rope/R = new /obj/item/shibari_rope
				user.put_in_hands(R)
				qdel(src)
		else
			return
	. = ..()

//stuff to apply processing on equip and add mood event for perverts
/obj/item/clothing/under/shibari_body/equipped(mob/user, slot)
	.=..()
	var/mob/living/carbon/human/C = user
	if(src == C.w_uniform)
		START_PROCESSING(SSobj, src)
	if(HAS_TRAIT(C, TRAIT_ROPEBUNNY))
		C.apply_status_effect(/datum/status_effect/ropebunny)

//same stuff as above but for dropping item
/obj/item/clothing/under/shibari_body/dropped(mob/user, slot)
	.=..()
	STOP_PROCESSING(SSobj, src)
	if(HAS_TRAIT(C, TRAIT_ROPEBUNNY))
		C.remove_status_effect(/datum/status_effect/ropebunny)

//processing stuff
/obj/item/clothing/under/shibari_body/process(delta_time)
	var/mob/living/carbon/human/U = loc
	if(tight == "low" && U.arousal < 15)
		U.adjustArousal(0.6 * delta_time)
	if(tight == "medium" && U.arousal < 25)
		U.adjustArousal(0.6 * delta_time)
	if(tight == "hard" && U.arousal < 30)
		U.adjustArousal(0.6 * delta_time)
		U.adjustPain(0.6 * delta_time)
		if(prob(10))
			U.adjustOxyLoss(5)

/////////////////
//GROIN BONDAGE//
/////////////////

/obj/item/clothing/under/shibari_groin
	name = "Crotch rope shibari"
	desc = "A rope that teases the wearer's genitals"
	icon_state = "shibari_groin"
	//worn icons path stuff
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-hoof.dmi'
	//some unimportant vars
	can_adjust = FALSE
	body_parts_covered = NONE
	strip_delay = 100
	mutant_variants = STYLE_DIGITIGRADE|STYLE_TAUR_ALL
	//some important vars
	var/current_color = "pink"
	var/tight = "low" //can be low, medium and hard.

//customization stuff
/obj/item/clothing/under/shibari_groin/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/clothing/under/shibari_groin/Initialize()
	. = ..()
	update_icon_state()
	update_icon()

//unequip stuff for adding rope to hands
/obj/item/clothing/under/shibari_groin/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/human/C = user
		if(src == C.w_uniform)
			if((do_after(C, 100, target = src)) && (!HAS_TRAIT(C, TRAIT_RIGGER)))
				var/obj/item/shibari_rope/R = new /obj/item/shibari_rope
				user.put_in_hands(R)
				qdel(src)

			if((do_after(C, 20, target = src)) && (HAS_TRAIT(C, TRAIT_RIGGER)))
				var/obj/item/shibari_rope/R = new /obj/item/shibari_rope
				user.put_in_hands(R)
				qdel(src)
		else
			return
	. = ..()

//stuff to apply processing on equip and add mood event for perverts
/obj/item/clothing/under/shibari_groin/equipped(mob/user, slot)
	.=..()
	var/mob/living/carbon/human/C = user
	if(src == C.w_uniform)
		START_PROCESSING(SSobj, src)
	if(HAS_TRAIT(C, TRAIT_ROPEBUNNY))
		C.apply_status_effect(/datum/status_effect/ropebunny)

//same stuff as above but for dropping item
/obj/item/clothing/under/shibari_groin/dropped(mob/user, slot)
	.=..()
	STOP_PROCESSING(SSobj, src)
	if(HAS_TRAIT(C, TRAIT_ROPEBUNNY))
		C.remove_status_effect(/datum/status_effect/ropebunny)

//processing stuff
/obj/item/clothing/under/shibari_groin/process(delta_time)
	var/mob/living/carbon/human/U = loc
	if(tight == "low" && U.arousal < 20)
		U.adjustArousal(0.6 * delta_time)
		U.adjustPleasure(0.6 * delta_time)
	if(tight == "medium" && U.arousal < 40)
		U.adjustArousal(0.6 * delta_time)
		U.adjustPleasure(0.6 * delta_time)
	if(tight == "hard" && U.arousal < 60)
		U.adjustArousal(0.6 * delta_time)
		U.adjustPleasure(0.6 * delta_time)

////////////////////
//FULLBODY BONDAGE//
////////////////////

/obj/item/clothing/under/shibari_fullbody
	name = "Shibari fullbody ropes"
	desc = "Bondage ropes that covers whole body"
	icon_state = "shibari_fullbody"
	//worn icons path stuff
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_uniform.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_uniform/lewd_uniform-hoof.dmi'
	//some unimportant vars
	can_adjust = FALSE
	body_parts_covered = NONE
	strip_delay = 100
	mutant_variants = STYLE_DIGITIGRADE|STYLE_TAUR_ALL
	//some important vars
	var/current_color = "pink"
	var/tight = "low" //can be low, medium and hard.

//customization stuff
/obj/item/clothing/under/shibari_fullbody/update_icon_state()
	. = ..()
	icon_state = "[initial(icon_state)]_[current_color]"
	inhand_icon_state = "[initial(icon_state)]_[current_color]"

/obj/item/clothing/under/shibari_fullbody/Initialize()
	. = ..()
	update_icon_state()
	update_icon()

//unequip stuff for adding rope to hands
/obj/item/clothing/under/shibari_fullbody/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/human/C = user
		if(src == C.w_uniform)
			if((do_after(C, 100, target = src)) && (!HAS_TRAIT(C, TRAIT_RIGGER)))
				var/obj/item/shibari_rope/R = new /obj/item/shibari_rope
				user.put_in_hands(R)
				qdel(src)

			if((do_after(C, 20, target = src)) && (HAS_TRAIT(C, TRAIT_RIGGER)))
				var/obj/item/shibari_rope/R = new /obj/item/shibari_rope
				user.put_in_hands(R)
				qdel(src)
		else
			return
	. = ..()

//stuff to apply processing on equip and add mood event for perverts
/obj/item/clothing/under/shibari_fullbody/equipped(mob/user, slot)
	.=..()
	var/mob/living/carbon/human/C = user
	if(src == C.w_uniform)
		START_PROCESSING(SSobj, src)
	if(HAS_TRAIT(C, TRAIT_ROPEBUNNY))
		C.apply_status_effect(/datum/status_effect/ropebunny)

//same stuff as above but for dropping item
/obj/item/clothing/under/shibari_fullbody/dropped(mob/user, slot)
	.=..()
	STOP_PROCESSING(SSobj, src)
	if(HAS_TRAIT(C, TRAIT_ROPEBUNNY))
		C.remove_status_effect(/datum/status_effect/ropebunny)

//processing stuff
/obj/item/clothing/under/shibari_fullbody/process(delta_time)
	var/mob/living/carbon/human/U = loc
	if(tight == "low" && U.arousal < 20)
		U.adjustArousal(0.6 * delta_time)
		U.adjustPleasure(0.6 * delta_time)
	if(tight == "medium" && U.arousal < 40)
		U.adjustArousal(0.6 * delta_time)
		U.adjustPleasure(0.6 * delta_time)
	if(tight == "hard" && U.arousal < 60)
		U.adjustArousal(0.6 * delta_time)
		U.adjustPleasure(0.6 * delta_time)
		U.adjustPain(0.6 * delta_time)
		if(prob(10))
			U.adjustOxyLoss(5)
