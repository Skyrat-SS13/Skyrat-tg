//normal ball mittens
/obj/item/clothing/gloves/ball_mittens
	name = "ball mittens"
	desc = "A nice, comfortable pair of inflatable ball gloves."
	icon_state = "ballmittens"
	inhand_icon_state = null
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_gloves.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_gloves.dmi'
	breakouttime = 1 SECONDS

//That part allows reinforcing this item with handcuffs
/obj/item/clothing/gloves/ball_mittens/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(.)
		return
	if(!istype(attacking_item, /obj/item/restraints/handcuffs))
		return
	var/obj/item/clothing/gloves/ball_mittens_reinforced/reinforced_muffs = new
	remove_item_from_storage(user)
	user.put_in_hands(reinforced_muffs)
	to_chat(user, span_notice("You reinforced the belts on [src] with [attacking_item]."))
	qdel(attacking_item)
	qdel(src)
	return TRUE

//ball_mittens reinforced
/obj/item/clothing/gloves/ball_mittens_reinforced //We getting this item by using handcuffs on normal ball mittens
	name = "reinforced ball mittens"
	desc = "Do not put these on, it's REALLY hard to take them off! But they look so comfortable..."
	icon_state = "ballmittens"
	inhand_icon_state = null
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_gloves.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_gloves.dmi'
	clothing_flags = DANGEROUS_OBJECT
	breakouttime = 100 SECONDS //do not touch this, i beg you.

//latex gloves
/obj/item/clothing/gloves/latex_gloves
	name = "latex gloves"
	desc = "Awesome looking gloves that are satisfying to the touch."
	icon_state = "latexgloves"
	inhand_icon_state = "latex_gloves"
	w_class = WEIGHT_CLASS_SMALL
	icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/obj/lewd_clothing/lewd_gloves.dmi'
	worn_icon = 'modular_skyrat/modules/modular_items/lewd_items/icons/mob/lewd_clothing/lewd_gloves.dmi'
