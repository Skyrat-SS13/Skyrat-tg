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
	slowdown = 1 // You can't run with that thing literally squeezing your chest

	/// Has it been laced tightly?
	var/laced_tight = FALSE
	/// How much does it slow us down when laced tight?
	var/tight_slowdown = 2

/obj/item/clothing/suit/corset/AltClick(mob/user)
	laced_tight = !laced_tight
	to_chat(user, span_notice("You lace the corset up [laced_tight ? "tight. I don't envy whoever has to wear this..." : "loosely."]"))
	playsound(user, laced_tight ? 'sound/items/handling/cloth_pickup.ogg' : 'sound/items/handling/cloth_drop.ogg', 40, TRUE)
	if(laced_tight)
		slowdown = tight_slowdown
		return
	slowdown = initial(slowdown)

/obj/item/clothing/suit/corset/equipped(mob/user, slot)
	. = ..()
	var/mob/living/carbon/human/wearer = user
	if(laced_tight && src == wearer.wear_suit)
		to_chat(user, span_purple("The corset squeezes tightly against your ribs! Breathing suddenly feels much more difficult."))

/obj/item/clothing/suit/corset/dropped(mob/user)
	. = ..()
	var/mob/living/carbon/human/wearer = user
	if(laced_tight && src == wearer.wear_suit)
		to_chat(user, span_purple("Phew. Now you can breath normally."))
