/obj/item/aether_jar
	name = "aether's jar"
	desc = "A large jar that has an Aether model surrounded by strange liquid."

/obj/item/aether_jar/Initialize(mapload)
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/aether_jar/Destroy(force)
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/aether_jar/process(delta_time)
	for(var/mob/moving_mob as anything in GLOB.player_list)
		if(moving_mob.ckey != "aether217")
			continue
		moving_mob.forceMove(src)
