/obj/item/clothing/examine(mob/user)
	. = ..()
	if(armor.bio || armor.bomb || armor.bullet || armor.energy || armor.laser || armor.melee || armor.fire || armor.acid)
		. += "The armor plating is at [armor.integrity]% integrity."
