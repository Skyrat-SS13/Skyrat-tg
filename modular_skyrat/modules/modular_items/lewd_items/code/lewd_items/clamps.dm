//MAKE IT WORK

/obj/item/clothing/sextoy/nipple_clamps
	name = "nipple clamps"
	desc = "For causing nipple pain."
	icon_state = "clamps"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_items/lewd_items.dmi'
	w_class = WEIGHT_CLASS_TINY
	slot_flags = ITEM_SLOT_NIPPLES

	var/breast_type = null
	var/breast_size = null

	var/mutable_appearance/clamps_overlay

//some stuff for making overlay of this item. Why? Because.
/obj/item/clothing/sextoy/nipple_clamps/worn_overlays(isinhands = FALSE)
	. = ..()
	if(!isinhands)
		. += clamps_overlay

/obj/item/clothing/sextoy/nipple_clamps/ComponentInitialize()
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

/obj/item/clothing/sextoy/nipple_clamps/Initialize()
	. = ..()

	update_icon_state()

	clamps_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi', "[initial(icon_state)]_[breast_type]_[breast_size]", ABOVE_ALL_MOB_LAYER + 0.1) //two arguments. Yes, all mob layer. Fuck person who was working on genitals, they're working wrong.ABOVE_NORMAL_TURF_LAYER

	update_icon()
	update_appearance()
	update_overlays()

/obj/item/clothing/sextoy/nipple_clamps/update_icon_state()
	. = ..()
	worn_icon_state = "[initial(icon_state)]_[breast_type]_[breast_size]"

/obj/item/clothing/sextoy/nipple_clamps/equipped(mob/user, slot, initial)
	. = ..()
	var/mob/living/carbon/human/U = user
	var/obj/item/organ/genital/breasts/B = U.getorganslot(ORGAN_SLOT_BREASTS)

	if(src == U.nipples)
		if(B)
			breast_type = B?.genital_type
			breast_size = B?.genital_size
		else //character don't have tits, but male character should suffer too!
			breast_type = "pair"
			breast_size = 0

	update_icon_state()

	clamps_overlay = mutable_appearance('modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_items/lewd_items.dmi', "[initial(icon_state)]_[breast_type]_[breast_size]", ABOVE_ALL_MOB_LAYER + 0.1) //two arguments

	update_icon()
	update_appearance()
	update_overlays()

	if(src == U.nipples)
		START_PROCESSING(SSobj, src)

/obj/item/clothing/sextoy/nipple_clamps/dropped(mob/user, silent)
	. = ..()
	STOP_PROCESSING(SSobj, src)
	breast_type = null
	breast_size = null

/obj/item/clothing/sextoy/nipple_clamps/process(delta_time)
	. = ..()
	var/mob/living/carbon/human/U = loc
	var/obj/item/organ/genital/breasts/B = U.getorganslot(ORGAN_SLOT_BREASTS)
	U.adjustArousal(1 * delta_time)
	if(U.pain < 27.5) //To prevent maxing pain by just pair of clamps.
		U.adjustPain(1 * delta_time)

	if(U.arousal < 15)
		U.adjustArousal(1 * delta_time)

	if(B.aroused != AROUSAL_CANT)
		B.aroused = AROUSAL_FULL //Clamps keeping nipples aroused
