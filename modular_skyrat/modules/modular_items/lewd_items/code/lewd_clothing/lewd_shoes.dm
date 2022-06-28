//heels item
/obj/item/clothing/shoes/latexheels
	name = "latex heels"
	desc = "Lace up before use. It's pretty difficult to walk in these while they are laced."
	icon_state = "latexheels"
	inhand_icon_state = "latexheels"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes_digi.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	supports_variations_flags = CLOTHING_DIGITIGRADE_VARIATION|STYLE_TAUR_ALL
	var/discomfort = 0
	var/message_sent = FALSE
	can_be_tied = FALSE
	strip_delay = 120
	slowdown = 0 //Removed slowdown while not laced

	/// Has it been laced tightly?
	var/laced_tight = FALSE

/obj/item/clothing/shoes/latexheels/AltClick(mob/user) //Added lacing and unlacing
	laced_tight = !laced_tight
	to_chat(user, span_notice("You [laced_tight ? "tighten" : "loosen"] the boots, making it far [laced_tight ? "harder" : "easier"] to walk."))
	playsound(user, laced_tight ? 'sound/items/handling/cloth_pickup.ogg' : 'sound/items/handling/cloth_drop.ogg', 40, TRUE)
	if(laced_tight)
		slowdown = 1
		user.update_equipment_speed_mods()
		return
	slowdown = initial(slowdown)
	user.update_equipment_speed_mods()

/obj/item/clothing/shoes/latexheels/examine(mob/user) // Added examine text for lacing and unlacing.
	. = ..()
	. += span_notice("Alt-Click to [laced_tight ? "unlace" : "lace"] the boots.")

//it takes time to put them off, do not touch
/obj/item/clothing/shoes/latexheels/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/affected_mob = user
		if(src == affected_mob.shoes)
			if(!do_after(affected_mob, 40, target = src))
				return
	. = ..()

//start processing
/obj/item/clothing/shoes/latexheels/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	if(src == affected_mob.shoes)
		START_PROCESSING(SSobj, src)
	affected_mob.update_inv_shoes()
	affected_mob.hud_used.hidden_inventory_update()
	message_sent = FALSE

//stop processing
/obj/item/clothing/shoes/latexheels/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	STOP_PROCESSING(SSobj, src)
	if(discomfort >= 80)
		to_chat(affected_mob, span_purple("The latex heels no longer hurt your feet."))
	discomfort = 0

// Heels pain processor
/obj/item/clothing/shoes/latexheels/process(delta_time)
	var/mob/living/carbon/human/affected_mob = loc
	if(discomfort <= 100 && affected_mob.body_position != LYING_DOWN)
		discomfort += 1
	if(discomfort >= 5 && affected_mob.body_position == LYING_DOWN)
		discomfort -= 5
		message_sent = FALSE

	//Discomfort milestone that slows you down more and tells you you're in pain.
	if(discomfort >= 100 && affected_mob.body_position != LYING_DOWN && message_sent == FALSE)
		if(HAS_TRAIT(affected_mob, TRAIT_MASOCHISM))
			to_chat(affected_mob, span_notice("These heels are causing my feet incredible pain... And I kind of like it!"))
		else
			to_chat(affected_mob, span_notice("These heels are really hurting my feet! Maybe I should lay down, because they're really slowing me down."))
		message_sent = TRUE
		slowdown = 2 //FYI this only updates when you take the shoes off and put back on because I can't update user.update_equipment_speed_mods within a process, I guess?
	//Randomly triggered message to add flavor
	if(discomfort >= 50 && affected_mob.body_position != LYING_DOWN)
		if(prob(5))
			to_chat(affected_mob, span_notice("The latex heels bite into your feet."))

//to make sound when we walking in this
/obj/item/clothing/shoes/latexheels/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/modules/modular_items/lewd_items/sounds/highheel1.ogg' = 1, 'modular_skyrat/modules/modular_items/lewd_items/sounds/highheel2.ogg' = 1), 70)


/*
*	LATEX SOCKS
*/

/obj/item/clothing/shoes/latex_socks
	name = "latex socks"
	desc = "A pair of shiny, split-toe socks made of some strange material."
	icon_state = "latexsocks"
	inhand_icon_state = "latexsocks"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes_digi.dmi'

//start processing
/obj/item/clothing/shoes/latex_socks/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/affected_mob = user
	affected_mob.update_inv_shoes()
	affected_mob.hud_used.hidden_inventory_update()

/*
*	DOMINA HEELS
*/

/obj/item/clothing/shoes/dominaheels //added for Kubic request
	name = "dominant heels"
	desc = "A pair of aesthetically pleasing heels."
	icon_state = "dominaheels"
	inhand_icon_state = "dominaheels"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_shoes.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_shoes_digi.dmi'
	equip_delay_other = 60
	strip_delay = 60
	slowdown = 1

//it takes time to put them off, do not touch
/obj/item/clothing/shoes/dominaheels/attack_hand(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/affected_mob = user
		if(src == affected_mob.shoes)
			if(!do_after(affected_mob, 20, target = src))
				return
	. = ..()

//to make sound when we walking in this
/obj/item/clothing/shoes/dominaheels/Initialize()
	. = ..()
	AddComponent(/datum/component/squeak, list('modular_skyrat/modules/modular_items/lewd_items/sounds/highheel1.ogg' = 1, 'modular_skyrat/modules/modular_items/lewd_items/sounds/highheel2.ogg' = 1), 70)
