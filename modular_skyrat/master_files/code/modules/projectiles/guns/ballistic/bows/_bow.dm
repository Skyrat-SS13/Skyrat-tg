/obj/item/gun/ballistic/bow
	item_flags = NEEDS_PERMIT
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL

/obj/item/gun/ballistic/bow/attack_self(mob/user)
	. = ..()
	if(chambered)
		playsound(src, 'modular_skyrat/modules/tribal_extended/sound/sound_weapons_bowdraw.ogg', 75, 0)
