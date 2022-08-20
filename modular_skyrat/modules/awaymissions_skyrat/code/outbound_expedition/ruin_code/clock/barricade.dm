/obj/structure/barricade/bronze
	name = "bronze gear"
	desc = "A large, bronze gear, too large to walk over."
	icon = 'modular_skyrat/modules/awaymissions_skyrat/icons/outbound_expedition/clock_cult.dmi'
	icon_state = "gear_barricade"
	max_integrity = 150

/obj/structure/barricade/bronze/make_debris()
	for(var/i in 1 to 2)
		new /obj/item/stack/sheet/bronze(get_turf(src))
