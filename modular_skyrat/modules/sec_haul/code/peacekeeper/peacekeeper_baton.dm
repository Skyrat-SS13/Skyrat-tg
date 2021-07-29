/obj/item/melee/classic_baton/peacekeeper
	name = "nightstick"
	desc = "A firm rubber truncheon, looks like it would knock the wind out of you."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	icon_state = "peacekeeper_baton"
	inhand_icon_state = "peacekeeper_baton"
	worn_icon_state = "classic_baton"
	lefthand_file = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/baton/peacekeeper_baton_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/baton/peacekeeper_baton_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 10
	w_class = WEIGHT_CLASS_NORMAL
	cooldown = 1.5 SECONDS

/obj/item/melee/baton/peacekeeper
	name = "stunstick"
	desc = "An upgraded version of the nightstick, this one has nasty electrical prongs on the end, batteries not included."
	icon = 'modular_skyrat/modules/sec_haul/icons/peacekeeper/peacekeeper_items.dmi'
	icon_state = "stunbaton"
	attack_verb_continuous = list("whaps")
	attack_verb_simple = list("whap")
	throw_stun_chance = 20
	cell_hit_cost = 1000
	attack_cooldown = 1.5 SECONDS
	stamina_loss_amt = 40

/obj/item/melee/classic_baton/peacekeeper/Initialize()
	. = ..()
	RegisterSignal(src, COMSIG_PARENT_ATTACKBY, .proc/convert)


/obj/item/melee/classic_baton/peacekeeper/Destroy()
	UnregisterSignal(src, COMSIG_PARENT_ATTACKBY)
	return ..()

/obj/item/conversion_kit/nightstick
	name = "nightstick conversion kit"
	desc = "A kit used to turn nightsticks into stunsticks."
	icon = 'icons/obj/storage.dmi'
	icon_state = "uk"
	custom_materials = list(/datum/material/iron = 10000, /datum/material/glass = 10000, /datum/material/silver = 10000)
	custom_price = PAYCHECK_HARD * 5

/obj/item/melee/classic_baton/peacekeeper/proc/convert(datum/source, obj/item/I, mob/user)
	SIGNAL_HANDLER

	if(istype(I,/obj/item/conversion_kit/nightstick))
		var/turf/T = get_turf(src)
		var/obj/item/melee/baton/peacekeeper/B = new /obj/item/melee/baton/peacekeeper (T)
		B.alpha = 20
		playsound(T, 'sound/items/drill_use.ogg', 80, TRUE, -1)
		animate(src, alpha = 0, time = 10)
		animate(B, alpha = 255, time = 10)
		qdel(I)
		qdel(src)

/datum/design/nightstick_upgrade
	name = "Nightstick Conversion Kit"
	desc = "A kit used to turn nightsticks into stunsticks."
	id = "nightstick_conversion"
	build_type = PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 10000, /datum/material/silver = 10000, /datum/material/diamond = 1000)
	build_path = /obj/item/conversion_kit/nightstick
	category = list("Weapons")
	departmental_flags = DEPARTMENTAL_FLAG_SECURITY
