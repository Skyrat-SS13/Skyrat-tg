//MAKE IT WORK

/obj/item/clothing/sextoy/nipple_clamps
	name = "nipple clamps"
	desc = "For causing nipple pain."
	icon_state = "clamps"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	w_class = WEIGHT_CLASS_TINY
	lewd_slot_flags = LEWD_SLOT_NIPPLES
	/// What kind are the wearer's breasts?
	var/breast_type = null
	/// What size are the wearer's breasts?
	var/breast_size = null
	/// Mutable overlay containing the icon of the clamps
	var/mutable_appearance/clamps_overlay

//some stuff for making overlay of this item. Why? Because.
/obj/item/clothing/sextoy/nipple_clamps/worn_overlays(isinhands = FALSE)
	. = ..()
	if(!isinhands)
		. += clamps_overlay

/obj/item/clothing/sextoy/nipple_clamps/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

	update_icon_state()

	clamps_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi', "[initial(icon_state)]_[breast_type]_[breast_size]", -BODY_FRONT_UNDER_CLOTHES) //two arguments. Yes, all mob layer. Fuck person who was working on genitals, they're working wrong.ABOVE_NORMAL_TURF_LAYER

	update_icon()
	update_appearance()
	update_overlays()

/obj/item/clothing/sextoy/nipple_clamps/update_icon_state()
	. = ..()
	worn_icon_state = "[initial(icon_state)]_[breast_type]_[breast_size]"

/obj/item/clothing/sextoy/nipple_clamps/lewd_equipped(mob/living/carbon/human/user, slot, initial)
	. = ..()
	if(!istype(user))
		return
	var/obj/item/organ/external/genital/breasts/user_breast = user.get_organ_slot(ORGAN_SLOT_BREASTS)

	if(src == user.nipples)
		if(user_breast)
			breast_type = user_breast?.genital_type
			breast_size = user_breast?.genital_size
		else //character don't have tits, but male character should suffer too!
			breast_type = "pair"
			breast_size = 0

	update_icon_state()

	clamps_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi', "[initial(icon_state)]_[breast_type]_[breast_size]", -BODY_FRONT_UNDER_CLOTHES) //two arguments

	update_icon()
	update_appearance()
	update_overlays()

	if(src == user.nipples)
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/nipple_clamps/dropped(mob/user, silent)
	. = ..()
	STOP_PROCESSING(SSobj, src)
	breast_type = null
	breast_size = null

/obj/item/clothing/sextoy/nipple_clamps/process(seconds_per_tick)
	. = ..()
	var/mob/living/carbon/human/target = loc
	var/obj/item/organ/external/genital/breasts/target_breast = target.get_organ_slot(ORGAN_SLOT_BREASTS)
	if(!target || !target_breast)
		return
	target.adjust_arousal(1 * seconds_per_tick)
	if(target.pain < 27.5) //To prevent maxing pain by just pair of clamps.
		target.adjust_pain(1 * seconds_per_tick)

	if(target.arousal < 15)
		target.adjust_arousal(1 * seconds_per_tick)

	if(target_breast.aroused != AROUSAL_CANT)
		target_breast.aroused = AROUSAL_FULL //Clamps keeping nipples aroused
