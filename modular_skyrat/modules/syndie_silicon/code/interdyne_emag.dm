/obj/item/card/emag/interdyne
	name = "interdyne artificial intelligence override"
	special_desc = "A modified ID card used to override silicon for use on the DS-2 and Interdyne stations. Do not bite."

/obj/item/card/emag/interdyne/can_emag(atom/target, mob/user)
	if(ispath(target.type, /mob/living/silicon/ai))
		return TRUE
	return ..()
