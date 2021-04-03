/obj/item/gun_hud_attachment
	name = "Optical Hud Upgrade"
	desc = "A sleek optical hud for displaying information about the tool it's attached to. Attach this to any ballistic automatic gun, energy gun or welder!"
	icon = 'icons/obj/improvised.dmi'
	icon_state = "kitsuitcase"
	custom_materials = list(/datum/material/iron = 10000, /datum/material/glass = 2000)

/datum/design/gun_hud_attachment
	name = "Optical Hud Kit"
	desc = "A sleek optical hud for displaying information about the tool it's attached to. Attach this to any ballistic automatic gun, energy gun or welder!"
	id = "gun_hud"
	build_type = AUTOLATHE | PROTOLATHE | AWAY_LATHE
	materials = list(/datum/material/iron = 10000, /datum/material/gold = 2000)
	build_path = /obj/item/weaponcrafting/gunkit/temperature
	category = list("Weapons")

/obj/item/gun_hud_attachment/attack_obj(obj/O, mob/living/user, params)
	. = ..()
	if(!istype(O, /obj/item/gun/ballistic) && !istype(O, /obj/item/gun/energy) && !istype(O, /obj/item/weldingtool))
		to_chat(user, "<span class='warning'>[src] is not compatable with [O]!</span>")
		return
	O.AddComponent(/datum/component/ammo_hud)
	to_chat(user, "<span class='notice'>You install [src] on [O]!</span>")
	qdel(src)
