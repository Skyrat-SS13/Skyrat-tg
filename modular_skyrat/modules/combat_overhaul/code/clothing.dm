#define REQUIRED_REPAIR_STACK 5
#define REPAIR_TIME 20 SECONDS
/obj/item/clothing/examine(mob/user)
	. = ..()
	if(armor.bio || armor.bomb || armor.bullet || armor.energy || armor.laser || armor.melee || armor.fire || armor.acid)
		. += "The armor plating is at [armor.integrity]% integrity."

/obj/item/clothing/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/sheet/iron) && (armor.bio || armor.bomb || armor.bullet || armor.energy || armor.laser || armor.melee || armor.fire || armor.acid))
		var/obj/item/stack/sheet/iron/iron_stack = attacking_item
		if(!iron_stack.use(REQUIRED_REPAIR_STACK))
			to_chat(user, span_danger("Not enough metal to repair the armor plating!"))
		if(do_after(user, REPAIR_TIME, src))
			to_chat(user, span_notice("You repair the armor plating."))
			armor.integrity = 100
