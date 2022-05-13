/obj/structure/strange_rocks
	name = "strange rocks"
	desc = "Strange rocks protrude from the ground. Perhaps they are part of something larger?"
	icon = 'icons/obj/flora/rocks.dmi'
	icon_state = "lavarocks3"
	anchored = TRUE
	var/list/content  = list(/obj/effect/spawner/random/trash/garbage = 6, /obj/item/artifact/codex = 4, )
	var/obj/item/T

/obj/structure/strange_rocks/attackby(obj/item/W, mob/user, params)
	if (istype(W, /obj/item/archaeological_tools))
		to_chat(user, "You have begun to investigate strange rocks.")
		playsound(src, "sound/effects/shovel_dig.ogg", 30, TRUE)
		if(do_after(user, 10))
			var/R = rand(1,2)
			switch (R)
				if(1)
					if(LAZYLEN(content))
						T = pick_weight(content)
						new T(get_turf(src))
				if(2)
					to_chat(user, "There doesn't seem to be anything here. Or you accidentally grinded something into dust.")
			playsound(src, "sound/effects/shovel_dig.ogg", 30, TRUE)
			Destroy()

/obj/item/archaeological_tools
	name = "archaeological tools"
	desc = "A set of brushes, tweezers, and hammers designed to extract treasures from beneath the age-old dirt"
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/xenoarchaeology.dmi'
	icon_state = "tools"

//I was never able to get the scanner effect to work properly. If anyone can, I would be very grateful. Until then, I will leave the scanner code as a future project.
/obj/item/t_scanner/archaeological_scanner
	name = "archaeological scanner"
	desc = "Archaeological scanner to quickly find excavation candidates... Wait, what!? Nanotrazen made a scanner out of our old PDAs!?"
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/xenoarchaeology.dmi'
	icon_state = "scanner"
	on = FALSE
	inhand_icon_state = "scanner"
	worn_icon_state = "scanner"
	lefthand_file = 'icons/mob/inhands/misc/devices_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/misc/devices_righthand.dmi'
	var/cooldown = 35
	var/current_cooldown = 0
	var/range = 7

/obj/item/t_scanner/archaeological_scanner/toggle_on()
	on = !on
	if(on)
		icon_state = "scanner-on"
		START_PROCESSING(SSobj, src)
	else
		icon_state = "scanner"
		STOP_PROCESSING(SSobj, src)

/obj/item/t_scanner/archaeological_scanner/scan()
	if(current_cooldown <= world.time)
		current_cooldown = world.time + cooldown
		var/turf/t = get_turf(src)
		scan_pulse(t, range)

/obj/item/t_scanner/archaeological_scanner/proc/scan_pulse(turf/T, range = world.view)
	var/list/rocks = list()
	for(var/obj/structure/strange_rocks/scanned in range(range, T))
		if(istype(scanned, /obj/structure/strange_rocks))
			rocks += scanned
	if(LAZYLEN(rocks))
		for(var/obj/structure/strange_rocks/R in rocks)
			var/obj/effect/temp_visual/strange_rocks_overlay/old = locate(/obj/effect/temp_visual/strange_rocks_overlay) in R
			if(old)
				qdel(old)
			new /obj/effect/temp_visual/mining_overlay(R)

/obj/effect/temp_visual/strange_rocks_overlay
	plane = FULLSCREEN_PLANE
	layer = FLASH_LAYER
	icon = 'icons/obj/flora/rocks.dmi'
	appearance_flags = 0
	duration = 35

/obj/effect/temp_visual/strange_rocks_overlay/Initialize(mapload)
	. = ..()
	animate(src, alpha = 0, time = duration, easing = EASE_IN)

/obj/item/artifact
	icon = 'modular_skyrat/modules/expeditionary-corps/icons/artifact.dmi'
	//By default, all artifacts are contaminated with age-old dust. They can be restored.
	var/restored = FALSE
	//To learn more about the artifact, we will have to dissect
	var/known_desc
	var/unknown_desc
	var/researched = FALSE

//By default, it will assign a description of the artifact based on the fact that it is not known
/obj/item/artifact/Initialize(mapload)
	. = ..()
	desc = unknown_desc

/obj/item/artifact/attackby(obj/item/W, mob/user, params)
	. = ..()
	if (istype(W, /obj/item/archaeological_tools))
		if(!restored)
			to_chat(user, "You start restoring an artifact.")
			if(do_after(user, 50))
				icon += "_restored"
				restored = TRUE
		else
			to_chat(user, "The artifact does not need to be restored.")

//The code in which the description will change if the artifact is globally known. The code is not ready yet.
/obj/item/artifact/examine(mob/user)
	. = ..()
	desc = known_desc

/obj/item/artifact/codex
	name = "codex"
	icon_state = "codex"
	unknown_desc = "Some kind of plank. It looks fragile and light. Looks like ceramic."
	known_desc = "One of the Atlantean data banks. The information stored in it, unfortunately, is fragmented. Valuable as a decoration or collector's item."

//Necessary to assign a random icon
/obj/item/artifact/codex/Initialize(mapload)
	. = ..()
	icon_state += num2text(rand(1,5))
