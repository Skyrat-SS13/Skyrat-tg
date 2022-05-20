/*
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
	if(!ishuman(loc))
		return ..()
	var/mob/living/carbon/human/hooman = loc
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.remove_status_effect(/datum/status_effect/ropebunny)
	return ..()

/obj/item/clothing/under/shibari/equipped(mob/user, slot)
	. = ..()
	RegisterSignal(src, COMSIG_ATOM_ATTACK_HAND, .proc/handle_take_off, user)


/obj/item/clothing/under/shibari/proc/handle_take_off(datum/source, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/handle_take_off_async, user)
	return COMPONENT_CANCEL_ATTACK_CHAIN

/obj/item/clothing/under/shibari/proc/handle_take_off_async(mob/user)
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/hooman = user
	if(do_after(hooman, HAS_TRAIT(hooman, TRAIT_RIGGER) ? 2 SECONDS : 10 SECONDS, target = src))
		dropped(user)

/obj/item/clothing/under/shibari/ComponentInitialize()
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

/obj/item/clothing/under/shibari/process(delta_time)
	if(!ishuman(loc))
		return PROCESS_KILL
	var/mob/living/carbon/human/hooman = loc
	//If our client decides to disable their pref mid "roleplaying" for some reason
	if(!hooman?.client?.prefs?.read_preference(/datum/preference/toggle/erp/sex_toy))
		src.forceMove(get_turf(src))
		src.dropped(hooman)
		return PROCESS_KILL
	if(tightness == SHIBARI_TIGHTNESS_LOW && hooman.arousal < 15)
		hooman.adjustArousal(0.6 * delta_time)
	if(tightness == SHIBARI_TIGHTNESS_MED && hooman.arousal < 25)
		hooman.adjustArousal(0.6 * delta_time)
	if(tightness == SHIBARI_TIGHTNESS_HIGH && hooman.arousal < 30)
		hooman.adjustArousal(0.6 * delta_time)

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

	greyscale_config = /datum/greyscale_config/shibari_clothes/body
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/body
	greyscale_config_worn_digi = /datum/greyscale_config/shibari_worn_digi/body
	greyscale_config_worn_taur_snake = /datum/greyscale_config/shibari_worn_taur_snake/body
	greyscale_config_worn_taur_paw = /datum/greyscale_config/shibari_worn_taur_paw/body
	greyscale_config_worn_taur_hoof = /datum/greyscale_config/shibari_worn_taur_hoof/body
	greyscale_colors = "#bd8fcf"

//processing stuff
/obj/item/clothing/under/shibari/torso/process(delta_time)
	. = ..()
	if(. == PROCESS_KILL)
		return PROCESS_KILL
	var/mob/living/carbon/human/hooman = loc
	if(tightness == SHIBARI_TIGHTNESS_HIGH && hooman.pain < 25)
		hooman.adjustPain(0.6 * delta_time)

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
	if(!hooman?.dna?.mutant_bodyparts["taur"])
		slowdown = 0
		return ..()
	var/datum/sprite_accessory/taur/taur_accessory = GLOB.sprite_accessories["taur"][hooman.dna.species.mutant_bodyparts["taur"][MUTANT_INDEX_NAME]]
	if(taur_accessory.hide_legs)
		slowdown = 4
	else
		slowdown = 0
	return..()

//processing stuff
/obj/item/clothing/under/shibari/groin/process(delta_time)
	. = ..()
	if(. == PROCESS_KILL)
		return PROCESS_KILL
	var/mob/living/carbon/human/hooman = loc
	if(tightness == SHIBARI_TIGHTNESS_LOW && hooman.pleasure < 20)
		hooman.adjustPleasure(0.6 * delta_time)
	if(tightness == SHIBARI_TIGHTNESS_MED && hooman.pleasure < 60)
		hooman.adjustPleasure(0.6 * delta_time)
	if(tightness == SHIBARI_TIGHTNESS_HIGH)
		hooman.adjustPleasure(0.6 * delta_time)

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
	. = ..()
	if(. == PROCESS_KILL)
		return PROCESS_KILL
	var/mob/living/carbon/human/hooman = loc
	if(tightness == SHIBARI_TIGHTNESS_LOW && hooman.pleasure< 20)
		hooman.adjustPleasure(0.6 * delta_time)
	if(tightness == SHIBARI_TIGHTNESS_MED && hooman.pleasure < 60)
		hooman.adjustPleasure(0.6 * delta_time)
	if(tightness == SHIBARI_TIGHTNESS_HIGH)
		hooman.adjustPleasure(0.6 * delta_time)
		if(hooman.pain < 40)
			hooman.adjustPain(0.6 * delta_time)

#undef SHIBARI_TIGHTNESS_LOW
#undef SHIBARI_TIGHTNESS_MED
#undef SHIBARI_TIGHTNESS_HIGH

*/
