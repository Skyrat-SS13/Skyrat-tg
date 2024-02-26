#define SHIBARI_TIGHTNESS_LOW (1<<0)
#define SHIBARI_TIGHTNESS_MED (1<<1)
#define SHIBARI_TIGHTNESS_HIGH (1<<2)

/obj/item/clothing/under/shibari
	strip_delay = 100
	can_adjust = FALSE
	body_parts_covered = NONE
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION|STYLE_TAUR_ALL
	item_flags = DROPDEL
	greyscale_colors = "#bd8fcf"
	has_sensor = NO_SENSORS

	///Tightness of the ropes can be low, medium and hard. This var works as multiplier for arousal and pleasure recieved while wearing this item
	var/tightness = SHIBARI_TIGHTNESS_LOW

	///should this clothing item use the emissive system
	var/glow = FALSE

/obj/item/clothing/under/shibari/update_overlays()
	. = ..()
	if(glow)
		. += emissive_appearance(icon, icon_state, src, alpha = alpha)

/obj/item/clothing/under/shibari/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(glow)
		. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = standing.alpha)

/obj/item/clothing/under/shibari/Destroy(force)
	STOP_PROCESSING(SSobj, src)

	for(var/obj/item in contents)
		item.forceMove(get_turf(src))
	if(!ishuman(loc))
		return ..()
	var/mob/living/carbon/human/hooman = loc
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.remove_status_effect(/datum/status_effect/ropebunny)
	return ..()

/obj/item/clothing/under/shibari/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ATTACK_HAND, PROC_REF(handle_take_off), user)


/obj/item/clothing/under/shibari/proc/handle_take_off(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, PROC_REF(handle_take_off_async), user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/clothing/under/shibari/proc/handle_take_off_async(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/hooman = user
	if(do_after(hooman, HAS_TRAIT(hooman, TRAIT_RIGGER) ? 2 SECONDS : 10 SECONDS, target = src))
		dropped(user)

/obj/item/clothing/under/shibari/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/under/shibari/AltClick(mob/user)
	. = ..()
	if(!ishuman(loc))
		return
	var/mob/living/carbon/human/hooman = loc
	if(user == hooman)
		return
	switch(tightness)
		if(SHIBARI_TIGHTNESS_LOW)
			tightness = SHIBARI_TIGHTNESS_MED
		if(SHIBARI_TIGHTNESS_MED)
			tightness = SHIBARI_TIGHTNESS_HIGH
		if(SHIBARI_TIGHTNESS_HIGH)
			tightness = SHIBARI_TIGHTNESS_LOW

/obj/item/clothing/under/shibari/process(seconds_per_tick)
	if(!ishuman(loc))
		return PROCESS_KILL
	var/mob/living/carbon/human/hooman = loc
	//If our client decides to disable their pref mid "roleplaying" for some reason
	if(!hooman?.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		src.forceMove(get_turf(src))
		src.dropped(hooman)
		return PROCESS_KILL
	if(tightness == SHIBARI_TIGHTNESS_LOW && hooman.arousal < 15)
		hooman.adjust_arousal(0.6 * seconds_per_tick)
	if(tightness == SHIBARI_TIGHTNESS_MED && hooman.arousal < 25)
		hooman.adjust_arousal(0.6 * seconds_per_tick)
	if(tightness == SHIBARI_TIGHTNESS_HIGH && hooman.arousal < 30)
		hooman.adjust_arousal(0.6 * seconds_per_tick)

//stuff to apply processing on equip and add mood event for perverts
/obj/item/clothing/under/shibari/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/hooman = user
	if(src == hooman.w_uniform)
		START_PROCESSING(SSobj, src)
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.apply_status_effect(/datum/status_effect/ropebunny)

//same stuff as above but for dropping item
/obj/item/clothing/under/shibari/dropped(mob/user, slot)
	if(!ishuman(user))
		return ..()
	var/mob/living/carbon/human/hooman = user
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.remove_status_effect(/datum/status_effect/ropebunny)
	return..()

/obj/item/clothing/under/shibari/torso
	name = "shibari ropes"
	desc = "Nice looking rope bondage."
	icon_state = "shibari_body"

	greyscale_config = /datum/greyscale_config/shibari/body
	greyscale_config_worn = /datum/greyscale_config/shibari/body/worn
	greyscale_config_worn_digi = /datum/greyscale_config/shibari/body/worn/digi
	greyscale_config_worn_taur_snake = /datum/greyscale_config/shibari/body/worn/taur_snake
	greyscale_config_worn_taur_paw = /datum/greyscale_config/shibari/body/worn/taur_paw
	greyscale_config_worn_taur_hoof = /datum/greyscale_config/shibari/body/worn/taur_hoof
	greyscale_colors = "#bd8fcf"

//processing stuff
/obj/item/clothing/under/shibari/torso/process(seconds_per_tick)
	. = ..()
	if(. == PROCESS_KILL)
		return PROCESS_KILL
	var/mob/living/carbon/human/hooman = loc
	if(tightness == SHIBARI_TIGHTNESS_HIGH && hooman.pain < 25)
		hooman.adjust_pain(0.6 * seconds_per_tick)

/obj/item/clothing/under/shibari/groin
	name = "crotch rope shibari"
	desc = "A rope that teases the wearer's genitals."
	icon_state = "shibari_groin"

	greyscale_config = /datum/greyscale_config/shibari/groin
	greyscale_config_worn = /datum/greyscale_config/shibari/groin/worn
	greyscale_config_worn_digi = /datum/greyscale_config/shibari/groin/worn/digi
	greyscale_config_worn_taur_snake = /datum/greyscale_config/shibari/groin/worn/taur_snake
	greyscale_config_worn_taur_paw = /datum/greyscale_config/shibari/groin/worn/taur_paw
	greyscale_config_worn_taur_hoof = /datum/greyscale_config/shibari/groin/worn/taur_hoof
	greyscale_colors = "#bd8fcf"

//stuff to apply processing on equip and add mood event for perverts
/obj/item/clothing/under/shibari/groin/equipped(mob/living/user, slot)
	var/mob/living/carbon/human/hooman = user
	slowdown = hooman?.bodyshape & BODYSHAPE_TAUR ? 4 : 0
	return..()

//processing stuff
/obj/item/clothing/under/shibari/groin/process(seconds_per_tick)
	. = ..()
	if(. == PROCESS_KILL)
		return PROCESS_KILL
	var/mob/living/carbon/human/hooman = loc
	if(tightness == SHIBARI_TIGHTNESS_LOW && hooman.pleasure < 20)
		hooman.adjust_pleasure(0.6 * seconds_per_tick)
	if(tightness == SHIBARI_TIGHTNESS_MED && hooman.pleasure < 60)
		hooman.adjust_pleasure(0.6 * seconds_per_tick)
	if(tightness == SHIBARI_TIGHTNESS_HIGH)
		hooman.adjust_pleasure(0.6 * seconds_per_tick)

/obj/item/clothing/under/shibari/full
	name = "shibari fullbody ropes"
	desc = "Bondage ropes that cover the whole body."
	icon_state = "shibari_fullbody"

	greyscale_config = /datum/greyscale_config/shibari/fullbody
	greyscale_config_worn = /datum/greyscale_config/shibari/fullbody/worn
	greyscale_config_worn_digi = /datum/greyscale_config/shibari/fullbody/worn/digi
	greyscale_config_worn_taur_snake = /datum/greyscale_config/shibari/fullbody/worn/taur_snake
	greyscale_config_worn_taur_paw = /datum/greyscale_config/shibari/fullbody/worn/taur_paw
	greyscale_config_worn_taur_hoof = /datum/greyscale_config/shibari/fullbody/worn/taur_hoof
	greyscale_colors = "#bd8fcf#bd8fcf"

//processing stuff
/obj/item/clothing/under/shibari/full/process(seconds_per_tick)
	. = ..()
	if(. == PROCESS_KILL)
		return PROCESS_KILL
	var/mob/living/carbon/human/hooman = loc
	if(tightness == SHIBARI_TIGHTNESS_LOW && hooman.pleasure< 20)
		hooman.adjust_pleasure(0.6 * seconds_per_tick)
	if(tightness == SHIBARI_TIGHTNESS_MED && hooman.pleasure < 60)
		hooman.adjust_pleasure(0.6 * seconds_per_tick)
	if(tightness == SHIBARI_TIGHTNESS_HIGH)
		hooman.adjust_pleasure(0.6 * seconds_per_tick)
		if(hooman.pain < 40)
			hooman.adjust_pain(0.6 * seconds_per_tick)

#undef SHIBARI_TIGHTNESS_LOW
#undef SHIBARI_TIGHTNESS_MED
#undef SHIBARI_TIGHTNESS_HIGH

