/obj/item/clothing/shoes/shibari_legs
	name = "shibari legs bondage"
	desc = "Bondage ropes that cover legs."
	icon_state = "shibari_legs"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes_digi.dmi'
	body_parts_covered = NONE
	strip_delay = 100
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION|STYLE_TAUR_ALL
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
		. += emissive_appearance(icon, icon_state, src, alpha = 100)

/obj/item/clothing/shoes/shibari_legs/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(glow)
		. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = 100)


/obj/item/clothing/shoes/shibari_legs/Destroy()
	for(var/obj/item in contents)
		item.forceMove(get_turf(src))
	if(!ishuman(loc))
		return ..()
	var/mob/living/carbon/human/hooman = loc
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.remove_status_effect(/datum/status_effect/ropebunny)
	return..()

/obj/item/clothing/shoes/shibari_legs/Initialize(mapload)
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
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/hooman = user
	if(do_after(hooman, HAS_TRAIT(hooman, TRAIT_RIGGER) ? 2 SECONDS : 10 SECONDS, target = src))
		dropped(user)

//stuff to apply mood event for perverts
/obj/item/clothing/shoes/shibari_legs/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/hooman = user
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.apply_status_effect(/datum/status_effect/ropebunny)

//same stuff as above but for dropping item
/obj/item/clothing/shoes/shibari_legs/dropped(mob/user, slot)
	if(!ishuman(user))
		return ..()
	var/mob/living/carbon/human/hooman = user
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.remove_status_effect(/datum/status_effect/ropebunny)
	return ..()
