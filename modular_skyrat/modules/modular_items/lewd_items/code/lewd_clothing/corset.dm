/obj/item/clothing/suit/corset
	name = "corset"
	desc = "A tight latex corset. How can anybody fit in THAT?"
	inhand_icon_state = "corset"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_suits.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-hoof.dmi'
	icon_state = "corset"
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	body_parts_covered = CHEST
	strip_delay = 200
	slowdown = 1 //you can't run with that thing literally squeezing your chest
	var/corset_laced_hard = FALSE

/obj/item/clothing/suit/corset/AltClick(mob/user)
	corset_laced_hard = !corset_laced_hard
	to_chat(user, span_notice("You lace the corset up [corset_laced_hard ? "tight. I don't envy whoever has to wear this..." : "loosely."]"))
	playsound(user, corset_laced_hard ? 'sound/items/handling/cloth_pickup.ogg' : 'sound/items/handling/cloth_drop.ogg', 40, TRUE)
	switch(corset_laced_hard)
		if(TRUE)
			slowdown = 2
		if(FALSE)
			slowdown = 1

//message when equipping that thing.
/obj/item/clothing/suit/corset/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/C = user
	if(src == C.wear_suit)
		if(corset_laced_hard == TRUE)
			to_chat(user, span_purple("The corset squeezes tightly against your ribs! Breathing suddenly feels much more difficult."))
	else
		return

//message when unequipping that thing
/obj/item/clothing/suit/corset/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/human/C = user
	if(corset_laced_hard == TRUE && src == C.wear_suit)
		to_chat(user, span_purple("Phew. Now you can breath normally."))
