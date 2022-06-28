#define TIGHT_SLOWDOWN 1
/obj/item/clothing/suit/corset
	name = "corset"
	desc = "A tight latex corset. How can anybody fit in THAT?"
	icon_state = "corset"
	inhand_icon_state = "corset"
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_suits.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits.dmi'
	worn_icon_digi = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-digi.dmi'
	worn_icon_taur_snake = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-snake.dmi'
	worn_icon_taur_paw = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-paw.dmi'
	worn_icon_taur_hoof = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_suit/lewd_suits-hoof.dmi'
	lefthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_left.dmi'
	righthand_file = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_inhands/lewd_inhand_right.dmi'
	body_parts_covered = CHEST

	/// Has it been laced tightly?
	var/laced_tight = FALSE

/obj/item/clothing/suit/corset/AltClick(mob/user)
	laced_tight = !laced_tight
	to_chat(user, span_notice("You [laced_tight ? "tighten" : "loosen"] [src], making it far [laced_tight ? "harder" : "easier"] to breathe."))
	playsound(user, laced_tight ? 'sound/items/handling/cloth_pickup.ogg' : 'sound/items/handling/cloth_drop.ogg', 40, TRUE)
	if(laced_tight)
		slowdown = TIGHT_SLOWDOWN
		user.update_equipment_speed_mods()
		return
	slowdown = 0 //Resets slowdown to 0 if unlaced
	user.update_equipment_speed_mods()

/obj/item/clothing/suit/corset/equipped(mob/living/carbon/human/user, slot)
	. = ..()
	if(laced_tight && src == user.wear_suit)
		to_chat(user, span_purple("The corset squeezes tightly against your ribs! Breathing suddenly feels much more difficult."))

/obj/item/clothing/suit/corset/dropped(mob/living/carbon/human/user)
	. = ..()
	if(laced_tight && src == user.wear_suit)
		to_chat(user, span_purple("Phew. Now you can breathe normally."))

/obj/item/clothing/suit/corset/examine(mob/user)
	. = ..()
	. += span_notice("<b>Alt-Click</b> to [laced_tight ? "unlace" : "lace"] [src].")
#undef TIGHT_SLOWDOWN
