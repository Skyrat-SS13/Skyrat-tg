///This file houses the antigravity boots item.
/obj/item/clothing/shoes/antigrav_boots
	icon = 'modular_skyrat/master_files/icons/obj/clothing/shoes.dmi'
	worn_icon = 'modular_skyrat/master_files/icons/mob/clothing/feet.dmi'
	desc = "The QM's 'special' boots. Control Click to toggle anti-gravity functions."
	name = "anti-gravity boots"
	icon_state = "walkboots" //Haha funny reused sprite
	var/enabled_antigravity = FALSE

/obj/item/clothing/shoes/antigrav_boots/equipped(mob/user, slot)
	. = ..()
	if(!slot == ITEM_SLOT_FEET)
		return
	if(enabled_antigravity)
		user.AddElement(/datum/element/forced_gravity, 0)

/obj/item/clothing/shoes/antigrav_boots/dropped(mob/user)
	. = ..()
	user.RemoveElement(/datum/element/forced_gravity, 0)

/obj/item/clothing/shoes/antigrav_boots/CtrlClick(mob/living/user)
	if(!isliving(user))
		return
	if(user.get_active_held_item() != src)
		to_chat(user, "<span class='warning'>You must hold the [src] in your hand to do this!</span>")
		return
	if (enabled_antigravity)
		to_chat(user, "<span class='notice'>You switch off the antigravity!</span>")
		enabled_antigravity = FALSE
	else
		to_chat(user, "<span class='notice'>You switch on the antigravity!</span>")
		enabled_antigravity = TRUE
