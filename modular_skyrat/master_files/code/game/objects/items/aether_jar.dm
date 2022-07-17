/obj/item/aether_jar
	name = "aether's jar"
	desc = "A large jar that has an Aether model surrounded by strange liquid."

/obj/item/aether_jar/Initialize(mapload)
	. = ..()
	START_PROCESSING(src, SSobj)

/obj/item/aether_jar/Destroy(force)
	STOP_PROCESSING(src, SSobj)
	. = ..()

/obj/item/aether_jar/process(delta_time)
	for(var/mob/moving_mob in GLOB.clients)
		if(moving_mob.ckey != "aether217")
			continue
		moving_mob.forceMove(src)
