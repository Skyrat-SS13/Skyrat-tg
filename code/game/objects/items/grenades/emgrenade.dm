/obj/item/grenade/empgrenade //SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "classic EMP grenade"
	desc = "It is designed to wreak havoc on electronic systems."
	icon_state = "emp"
	inhand_icon_state = "emp"

/obj/item/grenade/empgrenade/detonate(mob/living/lanced_by)
	. = ..()
	if(!.)
		return

	update_mob()
	empulse(src, 4, 10)
	qdel(src)
