
/atom/proc/get_necroshop()
	return null

/obj/machinery/marker/get_necroshop()
	return shop


/*
	Debug:
	The necroshop unfortunately sometimes bugs out and refuses to open for anyone. The exact cause is unknown, and no reproduction exists either

	As a stopgap measure, this verb will fix it
*/
/client/proc/fix_necroshop()
	set name = "Spawning Menu Fix"
	set desc = "Use if the necromorph spawning menu stops responding"
	set category = "Debug"

	for (var/obj/machinery/marker/M in world)
		QDEL_NULL(M.shop)
		M.shop = new(M)

	message_admins("[src] fixed the necromorph spawning menu")
