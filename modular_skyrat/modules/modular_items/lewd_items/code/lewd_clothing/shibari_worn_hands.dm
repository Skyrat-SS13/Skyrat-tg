/obj/item/clothing/gloves/shibari_hands
	name = "shibari arms bondage"
	desc = "Bondage ropes that cover arms."
	icon_state = "shibari_arms"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_gloves.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_gloves.dmi'
	body_parts_covered = NONE
	//strip_delay = 100
	breakouttime = 5 SECONDS
	item_flags = DROPDEL

	greyscale_config = /datum/greyscale_config/shibari_clothes/hands
	greyscale_config_worn = /datum/greyscale_config/shibari_worn/hands
	greyscale_colors = "#bd8fcf"

	///should this clothing item use the emissive system
	var/glow = FALSE

/obj/item/clothing/gloves/shibari_hands/update_overlays()
	. = ..()
	if(glow)
		. += emissive_appearance(icon, icon_state, src, alpha = 100)

/obj/item/clothing/gloves/shibari_hands/worn_overlays(mutable_appearance/standing, isinhands, icon_file)
	. = ..()
	if(glow)
		. += emissive_appearance(standing.icon, standing.icon_state, src, alpha = 100)

/obj/item/clothing/gloves/shibari_hands/Destroy()
	for(var/obj/item in contents)
		item.forceMove(get_turf(src))
	if(!ishuman(loc))
		return ..()
	var/mob/living/carbon/human/hooman = loc
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.remove_status_effect(/datum/status_effect/ropebunny)
	return ..()

/obj/item/clothing/gloves/shibari_hands/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)

//stuff to apply mood event for perverts
/obj/item/clothing/gloves/shibari_hands/equipped(mob/user, slot)
	. = ..()
	if(!ishuman(user))
		return
	var/mob/living/carbon/human/hooman = user
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.apply_status_effect(/datum/status_effect/ropebunny)

//same stuff as above but for dropping item
/obj/item/clothing/gloves/shibari_hands/dropped(mob/user, slot)
	if(!ishuman(user))
		return ..()
	var/mob/living/carbon/human/hooman = user
	if(HAS_TRAIT(hooman, TRAIT_ROPEBUNNY))
		hooman.remove_status_effect(/datum/status_effect/ropebunny)
	return ..()
