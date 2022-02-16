/obj/item/gun/energy/disabler/upgraded/disgust // Digusting Disabler...
/obj/item/gun/energy/disabler/upgraded/disgust/Initialize(mapload)
	. = ..()
	var/ammo_to_load = /obj/item/ammo_casing/energy/disabler/skyrat/proto/disgust
	ammo_type += new ammo_to_load(src)
	name += " of [SHOT_DISGUST]"


/obj/item/gun/energy/disabler/upgraded/warcrime // Antag Item Template (Intended to buy this with TC)
/obj/item/gun/energy/disabler/upgraded/warcrime/Initialize(mapload)
	. = ..()
	var/ammo_to_load = /obj/item/ammo_casing/energy/disabler/skyrat/proto/warcrime
	ammo_type += new ammo_to_load(src)
	name += " of [SHOT_WARCRIME]"
