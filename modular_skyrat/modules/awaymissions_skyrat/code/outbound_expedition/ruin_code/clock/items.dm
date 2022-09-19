/obj/item/melee/bronze_spear
	name = "ancient spear"
	desc = "An ancient spear made of bronze. It looks highly mechanical."
	icon = 'icons/obj/weapons/items_and_weapons.dmi'
	icon_state = "ratvarian_spear"
	inhand_icon_state = "ratvarian_spear"
	lefthand_file = 'icons/mob/inhands/antag/clockwork_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/antag/clockwork_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	armour_penetration = 10
	force = 12
	sharpness = SHARP_POINTY
	w_class = WEIGHT_CLASS_HUGE
	attack_verb_continuous = list("stabs", "pokes", "slashes", "clocks")
	attack_verb_simple = list("stab", "poke", "slash", "clock")
	hitsound = 'sound/weapons/bladeslice.ogg'

/obj/item/toy/clockwork_watch/timestop //mistake? maybe
	name = "bronze watch"
	desc = "An old bronze watch that looks like it could come apart at any moment."
	/// How many uses left? Cannot recharge
	var/charges = 2

/obj/item/toy/clockwork_watch/timestop/attack_self(mob/user)
	if(!charges)
		to_chat(user, span_notice("[src] lightly hums, then stops."))
		return
	if("clock" in user.faction)
		to_chat(user, span_warning("You couldn't imagine using Ratvar's holy relic!"))
		return
	if(!(cooldown < world.time)) //upstream uses old way for the cooldown of this, forced to use it till it gets refactored
		return
	cooldown = world.time + 3 MINUTES
	balloon_alert(user, "twisting dial...")
	if(!do_after(user, 3 SECONDS, target = user))
		return
	new /obj/effect/timestop(get_turf(user), 2, 4 SECONDS, list(user))
	charges--

/obj/item/toy/clockwork_watch/timestop/examine(mob/user)
	. = ..()
	if(charges)
		. += span_info("You sense this has [charges] use[charges == 1 ? "" : "s"] left.")
	else
		. += span_info("The powers of this watch have left, the hands stopped forever.")
