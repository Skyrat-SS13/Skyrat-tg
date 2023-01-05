/obj/item/clothing/ears/fancy_headphones
	name = "fancy headphones"
	desc = ""
	icon = 'modular_skyrat/master_files/icons/obj/clothing/accessories.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/ears.dmi'
	lefthand_file = 'modular_skyrat/master_files/icons/mob/inhands/equipment/ears_lefthand.dmi'
	righthand_file = 'modular_skyrat/master_files/icons/mob/inhands/equipment/ears_righthand.dmi'
	icon_state = "headphones"
	inhand_icon_state = "headphones"
	slot_flags = ITEM_SLOT_EARS | ITEM_SLOT_HEAD | ITEM_SLOT_NECK		//Fluff item, put it whereever you want!
	actions_types = list(/datum/action/item_action/toggle_headphones)
	var/mutable_appearance/music_overlay
	var/headphones_on = FALSE
	custom_price = 150

/obj/item/clothing/ears/fancy_headphones/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	music_overlay = mutable_appearance('modular_skyrat/master_files/icons/effects/overlay_effects.dmi', "jamming", ABOVE_MOB_LAYER)

/obj/item/clothing/ears/fancy_headphones/proc/toggle(mob/living/carbon/owner)
	headphones_on = !headphones_on
	if(headphones_on)
		owner.add_overlay(music_overlay)
	else
		owner.cut_overlay(music_overlay)
	owner.balloon_alert(owner, "music [headphones_on? "on" : "off"]")

/obj/item/clothing/ears/fancy_headphones/dropped(mob/living/carbon/owner)
	. = ..()
	if(headphones_on)
		headphones_on = !headphones_on
		owner.cut_overlay(music_overlay)
		owner.balloon_alert(owner, "music off")

/datum/action/item_action/fancy_headphones
	name = "Toggle Headphones"
	desc = "UNTZ UNTZ UNTZ"

/datum/action/item_action/toggle_headphones/Trigger(trigger_flags)
	var/obj/item/clothing/ears/fancy_headphones/headphones = target
	if(istype(headphones))
		headphones.toggle(owner)
