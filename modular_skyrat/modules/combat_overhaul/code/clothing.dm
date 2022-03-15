#define REQUIRED_REPAIR_STACK 5
#define REPAIR_TIME 30 SECONDS

/obj/item/clothing
	// Our armor integrity, if we have any.
	var/armor_integrity = 100

/obj/item/clothing/examine(mob/user)
	. = ..()
	if(armor.bio || armor.bomb || armor.bullet || armor.energy || armor.laser || armor.melee || armor.fire || armor.acid)
		. += "The armor plating is at [armor_integrity]% integrity."

/obj/item/clothing/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/stack/sheet/iron) && (armor.bio || armor.bomb || armor.bullet || armor.energy || armor.laser || armor.melee || armor.fire || armor.acid))
		if(armor_integrity >= 100)
			to_chat(user, span_danger("[src] does not need repaired!"))
			return
		var/obj/item/stack/sheet/iron/iron_stack = attacking_item
		if(!iron_stack.use(REQUIRED_REPAIR_STACK))
			to_chat(user, span_danger("You don't have enough of [attacking_item] to repair [src]'s armor plating!"))
			return
		if(do_after(user, REPAIR_TIME, src))
			to_chat(user, span_notice("You repair [src]'s armor plating."))
			armor_integrity = 100
			return
	return ..()

/**
 * This is our main proc to get the armor rating while taking into account the integrity of the clothing item.
 */
/obj/item/clothing/proc/get_armor_rating(damage_type, ignore_integrity)
	return ignore_integrity ? armor.getRating(damage_type) : armor.getRating(damage_type) / 100 * armor_integrity

/obj/item/clothing/proc/degrade_armor(damage, damage_type)
	if(armor.getRating(damage_type) <= 0) // If the rating type has no armor, don't damage it.
		return
	armor_integrity = clamp(armor_integrity - damage / 10, 0, 100)

#undef REQUIRED_REPAIR_STACK
#undef REPAIR_TIME
