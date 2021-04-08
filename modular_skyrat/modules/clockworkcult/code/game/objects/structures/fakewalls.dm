/obj/structure/falsewall/brass
	name = "clockwork wall"
	desc = "A huge chunk of warm metal. The clanging of machinery emanates from within."
	icon = 'icons/turf/walls/clockwork_wall.dmi'
	icon_state = "clockwork_wall"
	resistance_flags = FIRE_PROOF | ACID_PROOF
	mineral_amount = 1
	canSmoothWith = list(/obj/effect/clockwork/overlay/wall, /obj/structure/falsewall/brass)
	girder_type = /obj/structure/girder/bronze
	walltype = /turf/closed/wall/clockwork
	mineral = /obj/item/stack/tile/brass

/obj/structure/falsewall/brass/New(loc)
	..()
	var/turf/T = get_turf(src)
	new /obj/effect/temp_visual/ratvar/wall/false(T)
	new /obj/effect/temp_visual/ratvar/beam/falsewall(T)

/obj/structure/falsewall/brass/Destroy()
	return ..()

