/obj/item/gun_hud_attachment
	name = "Optical Hud Upgrade"
	desc = "A sleek optical hud for displaying information about the tool it's attached to. Attach this to any ballistic automatic gun, energy gun or welder. Slap this with whatever you're trying to upgrade!"
	icon = 'icons/obj/improvised.dmi'
	icon_state = "kitsuitcase"
	custom_materials = list(/datum/material/iron = 10000, /datum/material/glass = 2000)

/datum/design/gun_hud_attachment
	name = "Optical Hud Kit"
	desc = "A sleek optical hud for displaying information about the tool it's attached to. Attach this to any ballistic automatic gun, energy gun or welder!"
	id = "gun_hud"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 10000, /datum/material/glass = 2000)
	build_path = /obj/item/gun_hud_attachment
	category = list("initial", "Security", "Weapons")

/obj/item/gun_hud_attachment/attacked_by(obj/item/I, mob/living/user)
	. = ..()
	if(!istype(I, /obj/item/gun/ballistic) && !istype(I, /obj/item/gun/energy) && !istype(I, /obj/item/weldingtool))
		to_chat(user, "<span class='warning'>[src] is not compatable with [I]!</span>")
		return
	I.AddComponent(/datum/component/ammo_hud)
	to_chat(user, "<span class='notice'>You install [src] on [I]!</span>")
	qdel(src)

