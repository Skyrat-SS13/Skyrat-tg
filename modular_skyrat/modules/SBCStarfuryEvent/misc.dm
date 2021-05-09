/obj/machinery/porta_turret/syndicate/starfury
	shot_delay = 6
	armor = list("melee" = 60, "bullet" = 60, "laser" = 60, "energy" = 60, "bomb" = 80, "bio" = 0, "rad" = 0, "fire" = 90, "acid" = 90)

/obj/effect/turf_decal/starfury/one
	icon_state = "SBC1"

/obj/effect/turf_decal/starfury/two
	icon_state = "SBC2"

/obj/effect/turf_decal/starfury/three
	icon_state = "SBC3"

/obj/effect/turf_decal/starfury/four
	icon_state = "SBC4"

/obj/effect/turf_decal/starfury/five
	icon_state = "SBC5"

/obj/effect/turf_decal/starfury/six
	icon_state = "SBC6"

/obj/effect/turf_decal/starfury/seven
	icon_state = "SBC7"

/obj/effect/turf_decal/starfury/eight
	icon_state = "SBC8"

/obj/effect/turf_decal/starfury/nine
	icon_state = "SBC9"

/obj/effect/turf_decal/starfury/ten
	icon_state = "SBC10"

/obj/machinery/computer/shuttle/starfurybc
	name = "battle cruiser console"
	shuttleId = "starfury"
	icon_screen = "syndishuttle"
	icon_keyboard = "syndie_key"
	light_color = RED
	req_access = list(ACCESS_SYNDICATE)
	possible_destinations = "starfury_home;starfury_custom"

/obj/machinery/computer/camera_advanced/shuttle_docker/syndicate/starfurybc
	name = "battle cruiser navigation computer"
	desc = "Used to designate a precise transit location for the battle cruiser."
	shuttleId = "starfury"
	jumpto_ports = list("starfury_home" = 1, "syndicate_ne" = 1, "syndicate_nw" = 1, "syndicate_n" = 1, "syndicate_se" = 1, "syndicate_sw" = 1, "syndicate_s" = 1)
	shuttlePortId = "starfury_custom"
	view_range = 140
	x_offset = -14
	y_offset = 22
