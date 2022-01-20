

#define SHIBARI_TIGHTNESS_LOW (1<<0)
#define SHIBARI_TIGHTNESS_MED (1<<1)
#define SHIBARI_TIGHTNESS_HIGH (1<<2)

/obj/item/clothing/under/shibari
	strip_delay = 100
	can_adjust = FALSE
	body_parts_covered = NONE
	mutant_variants = STYLE_DIGITIGRADE|STYLE_TAUR_ALL
	item_flags = DROPDEL
	greyscale_colors = "#bd8fcf"

	///Tightness of the ropes can be low, medium and hard. This var works as multiplier for arousal and pleasure recieved while wearing this item
	var/tightness = SHIBARI_TIGHTNESS_LOW
	///Rope amount yielded from this apparel
	var/rope_amount = 1

	///should this clothing item use the emissive system
	var/glow = FALSE

/obj/item/clothing/under/shibari/update_overlays()
	. = ..()
	if(glow)
		. += emissive_appearance(icon, icon_state, alpha = alpha)

/obj/item/clothing/under/shibari/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(glow)
		. += emissive_appearance(standing.icon, standing.icon_state, alpha = standing.alpha)

/obj/item/clothing/under/shibari/Destroy(force)
	STOP_PROCESSING(SSobj, src)

	for(var/obj/item in contents)
		item.forceMove(get_turf(src))
	if(ishuman(loc))
		var/mob/living/carbon/human/hooman = loc
		if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
			hooman.remove_status_effect(/datum/status_effect/ropebunny)
	. = ..()

/obj/item/clothing/under/shibari/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ATTACK_HAND, .proc/handle_take_off, user)


/obj/item/clothing/under/shibari/proc/handle_take_off(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/handle_take_off_async, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/clothing/under/shibari/proc/handle_take_off_async(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/hooman = user
		if(do_after(hooman, HAS_TRAIT(hooman, TRAIT_RIGGER) ? 2 SECONDS : 10 SECONDS, target = src))
			dropped(user)

/obj/item/clothing/under/shibari/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/under/shibari/AltClick(mob/user)
	. = ..()
	if(ishuman(loc))
		var/mob/living/carbon/human/hooman = loc
		if(user != hooman)
			switch(tightness)
				if(SHIBARI_TIGHTNESS_LOW)
					tightness = SHIBARI_TIGHTNESS_MED
				if(SHIBARI_TIGHTNESS_MED)
					tightness = SHIBARI_TIGHTNESS_HIGH
				if(SHIBARI_TIGHTNESS_HIGH)
					tightness = SHIBARI_TIGHTNESS_LOW

/obj/item/clothing/under/shibari/process(delta_time)
	if(ishuman(loc))
		var/mob/living/carbon/human/hooman = loc
		if(tightness == SHIBARI_TIGHTNESS_LOW && hooman.arousal < 15)
			hooman.adjustArousal(0.6 * delta_time)
		if(tightness == SHIBARI_TIGHTNESS_MED && hooman.arousal < 25)
			hooman.adjustArousal(0.6 * delta_time)
		if(tightness == SHIBARI_TIGHTNESS_HIGH && hooman.arousal < 30)
			hooman.adjustArousal(0.6 * delta_time)
	else
		return PROCESS_KILL

//stuff to apply processing on equip and add mood event for perverts
/obj/item/clothing/under/shibari/equipped(mob/user, slot)
	.=..()
	if(ishuman(user))
		var/mob/living/carbon/human/hooman = user
		if(src == hooman.w_uniform)
			START_PROCESSING(SSobj, src)
		if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
			hooman.apply_status_effect(/datum/status_effect/ropebunny)

//same stuff as above but for dropping item
/obj/item/clothing/under/shibari/dropped(mob/user, slot)
	if(ishuman(user))
		var/mob/living/carbon/human/hooman = user
		if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
			hooman.remove_status_effect(/datum/status_effect/ropebunny)
	. = ..()

/obj/item/clothing/under/shibari/torso
	name = "shibari ropes"
	desc = "Nice looking rope bondage."
	icon_state = "shibari_body"

	greyscale_config = /datum/greyscale_config/shibari_clothes/body
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/body
	greyscale_config_worn_digi = /datum/greyscale_config/shibari_worn_digi/body
	greyscale_config_worn_taur_snake = /datum/greyscale_config/shibari_worn_taur_snake/body
	greyscale_config_worn_taur_paw = /datum/greyscale_config/shibari_worn_taur_paw/body
	greyscale_config_worn_taur_hoof = /datum/greyscale_config/shibari_worn_taur_hoof/body
	greyscale_colors = "#bd8fcf"

//processing stuff
/obj/item/clothing/under/shibari/torso/process(delta_time)
	if(ishuman(loc))
		var/mob/living/carbon/human/hooman = loc
		if(tightness == SHIBARI_TIGHTNESS_HIGH && hooman.pain < 30)
			if(hooman.pain < 25)
				hooman.adjustPain(0.6 * delta_time)
	else
		return PROCESS_KILL

/obj/item/clothing/under/shibari/groin
	name = "crotch rope shibari"
	desc = "A rope that teases the wearer's genitals."
	icon_state = "shibari_groin"

	greyscale_config = /datum/greyscale_config/shibari_clothes/groin
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/groin
	greyscale_config_worn_digi = /datum/greyscale_config/shibari_worn_digi/groin
	greyscale_config_worn_taur_snake = /datum/greyscale_config/shibari_worn_taur_snake/groin
	greyscale_config_worn_taur_paw = /datum/greyscale_config/shibari_worn_taur_paw/groin
	greyscale_config_worn_taur_hoof = /datum/greyscale_config/shibari_worn_taur_hoof/groin
	greyscale_colors = "#bd8fcf"

//stuff to apply processing on equip and add mood event for perverts
/obj/item/clothing/under/shibari/groin/equipped(mob/user, slot)
	var/mob/living/carbon/human/hooman = user
	if(hooman?.dna?.mutant_bodyparts["taur"])
		slowdown = 4
	else
		slowdown = 0
	. = ..()

//processing stuff
/obj/item/clothing/under/shibari/groin/process(delta_time)
	if(ishuman(loc))
		var/mob/living/carbon/human/hooman = loc
		if(tightness == SHIBARI_TIGHTNESS_LOW && hooman.pleasure < 20)
			hooman.adjustPleasure(0.6 * delta_time)
		if(tightness == SHIBARI_TIGHTNESS_MED && hooman.pleasure < 60)
			hooman.adjustPleasure(0.6 * delta_time)
		if(tightness == SHIBARI_TIGHTNESS_HIGH)
			hooman.adjustPleasure(0.6 * delta_time)
	else
		return PROCESS_KILL

/obj/item/clothing/under/shibari/full
	name = "shibari fullbody ropes"
	desc = "Bondage ropes that covers whole body"
	icon_state = "shibari_fullbody"
	rope_amount = 2

	greyscale_config = /datum/greyscale_config/shibari_clothes/fullbody
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/fullbody
	greyscale_config_worn_digi = /datum/greyscale_config/shibari_worn_digi/fullbody
	greyscale_config_worn_taur_snake = /datum/greyscale_config/shibari_worn_taur_snake/fullbody
	greyscale_config_worn_taur_paw = /datum/greyscale_config/shibari_worn_taur_paw/fullbody
	greyscale_config_worn_taur_hoof = /datum/greyscale_config/shibari_worn_taur_hoof/fullbody
	greyscale_colors = "#bd8fcf#bd8fcf"

//processing stuff
/obj/item/clothing/under/shibari/full/process(delta_time)
	if(ishuman(loc))
		var/mob/living/carbon/human/hooman = loc
		if(tightness == SHIBARI_TIGHTNESS_LOW && hooman.pleasure< 20)
			hooman.adjustPleasure(0.6 * delta_time)
		if(tightness == SHIBARI_TIGHTNESS_MED && hooman.pleasure < 60)
			hooman.adjustPleasure(0.6 * delta_time)
		if(tightness == SHIBARI_TIGHTNESS_HIGH)
			hooman.adjustPleasure(0.6 * delta_time)
			if(hooman.pain < 40)
				hooman.adjustPain(0.6 * delta_time)
	else
		return PROCESS_KILL

/obj/item/clothing/gloves/shibari_hands
	name = "shibari arms bondage"
	desc = "Bondage ropes that cover arms."
	icon_state = "shibari_arms"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_gloves.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_gloves.dmi'
	body_parts_covered = NONE
	strip_delay = 100
	item_flags = DROPDEL

	greyscale_config = /datum/greyscale_config/shibari_clothes/hands
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/hands
	greyscale_colors = "#bd8fcf"

	///should this clothing item use the emissive system
	var/glow = FALSE

/obj/item/clothing/gloves/shibari_hands/update_overlays()
	. = ..()
	if(glow)
		. += emissive_appearance(icon, icon_state, alpha = 100)

/obj/item/clothing/gloves/shibari_hands/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(glow)
		. += emissive_appearance(standing.icon, standing.icon_state, alpha = 100)

/obj/item/clothing/gloves/shibari_hands/Destroy()
	if(ishuman(loc))
		var/mob/living/carbon/human/hooman = loc
		if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
			hooman.remove_status_effect(/datum/status_effect/ropebunny)
	for(var/obj/item in contents)
		item.forceMove(get_turf(src))
	. = ..()

/obj/item/clothing/gloves/shibari_hands/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ATTACK_HAND, .proc/handle_take_off, user)


/obj/item/clothing/gloves/shibari_hands/proc/handle_take_off(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/handle_take_off_async, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/clothing/gloves/shibari_hands/proc/handle_take_off_async(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/hooman = user
		if(do_after(hooman, HAS_TRAIT(hooman, TRAIT_RIGGER) ? 2 SECONDS : 10 SECONDS, target = src))
			dropped(user)


/obj/item/clothing/gloves/shibari_hands/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//stuff to apply mood event for perverts
/obj/item/clothing/gloves/shibari_hands/equipped(mob/user, slot)
	.=..()
	if(ishuman(user))
		var/mob/living/carbon/human/hooman = user
		if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
			hooman.apply_status_effect(/datum/status_effect/ropebunny)

//same stuff as above but for dropping item
/obj/item/clothing/gloves/shibari_hands/dropped(mob/user, slot)
	if(ishuman(user))
		var/mob/living/carbon/human/hooman = user
		if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
			hooman.remove_status_effect(/datum/status_effect/ropebunny)
	. = ..()

/obj/item/clothing/shoes/shibari_legs
	name = "shibari legs bondage"
	desc = "Bondage ropes that cover legs."
	icon_state = "shibari_legs"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes_digi.dmi'
	body_parts_covered = NONE
	strip_delay = 100
	mutant_variants = STYLE_DIGITIGRADE|STYLE_TAUR_ALL
	slowdown = 4
	item_flags = DROPDEL|IGNORE_DIGITIGRADE

	greyscale_config = /datum/greyscale_config/shibari_clothes/legs
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/legs
	greyscale_config_worn_digi = /datum/greyscale_config/shibari_worn_digi/legs
	greyscale_colors = "#bd8fcf"

	///should this clothing item use the emissive system
	var/glow = FALSE

/obj/item/clothing/shoes/shibari_legs/update_overlays()
	. = ..()
	if(glow)
		. += emissive_appearance(icon, icon_state, alpha = 100)

/obj/item/clothing/shoes/shibari_legs/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(glow)
		. += emissive_appearance(standing.icon, standing.icon_state, alpha = 100)


/obj/item/clothing/shoes/shibari_legs/Destroy()
	if(ishuman(loc))
		var/mob/living/carbon/human/hooman = loc
		if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
			hooman.remove_status_effect(/datum/status_effect/ropebunny)
	for(var/obj/item in contents)
		item.forceMove(get_turf(src))
	. = ..()

/obj/item/clothing/shoes/shibari_legs/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/shoes/shibari_legs/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ATTACK_HAND, .proc/handle_take_off, user)


/obj/item/clothing/shoes/shibari_legs/proc/handle_take_off(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/handle_take_off_async, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/clothing/shoes/shibari_legs/proc/handle_take_off_async(mob/user)
	if(ishuman(user))
		var/mob/living/carbon/human/hooman = user
		if(do_after(hooman, HAS_TRAIT(hooman, TRAIT_RIGGER) ? 2 SECONDS : 10 SECONDS, target = src))
			dropped(user)

//stuff to apply mood event for perverts
/obj/item/clothing/shoes/shibari_legs/equipped(mob/user, slot)
	.=..()
	if(ishuman(user))
		var/mob/living/carbon/human/hooman = user
		if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
			hooman.apply_status_effect(/datum/status_effect/ropebunny)

//same stuff as above but for dropping item
/obj/item/clothing/shoes/shibari_legs/dropped(mob/user, slot)
	if(ishuman(user))
		var/mob/living/carbon/human/hooman = user
		if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
			hooman.remove_status_effect(/datum/status_effect/ropebunny)
	. = ..()

#undef SHIBARI_TIGHTNESS_LOW
#undef SHIBARI_TIGHTNESS_MED
#undef SHIBARI_TIGHTNESS_HIGH
