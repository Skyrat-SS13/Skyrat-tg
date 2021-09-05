/obj/item/storage/excavation_pick_set
	name = "excavation pick set"
	desc = "A surprisingly compact leather case for a set of excavation picks."
	icon_state = "wallet"

/obj/item/storage/excavation_pick_set/ComponentInitialize()
	. = ..()
	var/datum/component/storage/STR = GetComponent(/datum/component/storage)
	STR.max_items = 6
	STR.max_w_class = WEIGHT_CLASS_NORMAL
	STR.set_holdable(list(/obj/item/excavation_pick))

/obj/item/storage/excavation_pick_set/full/PopulateContents()
	new /obj/item/excavation_pick/brush(src)
	new /obj/item/excavation_pick/pick2(src)
	new /obj/item/excavation_pick/pick3(src)
	new /obj/item/excavation_pick/pick4(src)
	new /obj/item/excavation_pick/pick5(src)
	new /obj/item/excavation_pick/hand_pick(src)

/obj/item/excavation_pick
	name = "excavation pick"
	desc = "Small archeological tool, used for precise excavation."
	icon = 'icons/excavation/excavation_tools.dmi'
	icon_state = "pick1"
	w_class = WEIGHT_CLASS_SMALL
	usesound = list('sound/items/screwdriver.ogg')
	force = 3
	var/dig_depth = 5
	var/dig_speed = 1 SECONDS

/obj/item/excavation_pick/brush
	name = "1 cm brush"
	icon_state = "pick_brush"
	usesound = list('sound/weapons/thudswoosh.ogg')
	dig_depth = 1

/obj/item/excavation_pick/pick2
	name = "2 cm pick"
	icon_state = "pick2"
	dig_depth = 2

/obj/item/excavation_pick/pick3
	name = "3 cm pick"
	icon_state = "pick3"
	dig_depth = 3

/obj/item/excavation_pick/pick4
	name = "4 cm pick"
	icon_state = "pick4"
	dig_depth = 4

/obj/item/excavation_pick/pick5
	name = "5 cm pick"
	icon_state = "pick5"
	dig_depth = 5

/obj/item/excavation_pick/hand_pick
	name = "hand pickaxe"
	desc = "A smaller, more precise version of the pickaxe. Will dig 10 centimeters in."
	w_class = WEIGHT_CLASS_NORMAL
	dig_speed = 2 SECONDS
	icon_state = "pick_hand"
	force = 7
	usesound = list('sound/effects/picaxe1.ogg', 'sound/effects/picaxe2.ogg', 'sound/effects/picaxe3.ogg')
	dig_depth = 10

/obj/item/excavation_measuring_tape
	name = "measuring tape"
	desc = "A coiled metallic tape used to check dimensions and lengths."
	icon = 'icons/excavation/excavation_tools.dmi'
	icon_state = "measuring"
	w_class = WEIGHT_CLASS_SMALL

/obj/item/excavation_depth_scanner
	name = "depth analysis scanner"
	desc = "Used to check spatial depth and density of rock outcroppings."
	icon = 'icons/excavation/excavation_tools.dmi'
	icon_state = "depthscanner"
	w_class = WEIGHT_CLASS_SMALL

#define LOCATOR_COOLDOWN 4 SECONDS

/obj/item/excavation_locator
	name = "dig site locator"
	desc = "A scanner that checks surrounding location for hidden curiosities."
	icon = 'icons/excavation/excavation_tools.dmi'
	icon_state = "digsitelocator"
	w_class = WEIGHT_CLASS_SMALL
	var/next_fire = 0

/obj/item/excavation_locator/attack_self(mob/user)
	if(!user.client)
		return
	if(next_fire <= world.time)
		next_fire = world.time + LOCATOR_COOLDOWN
		do_scan(user)

/obj/item/excavation_locator/proc/do_scan(mob/user)
	var/turf/T = get_turf(user)
	var/list/minerals = list()
	for(var/turf/MT in view(T, world.view))
		if(MT.GetComponent(/datum/component/digsite))
			minerals += MT
	if(length(minerals))
		for(var/i in minerals)
			var/turf/M = i
			new /obj/effect/temp_visual/strange_rock_overlay(M)
	else
		to_chat(user,"<span class='warning'>No curiosities detected.</span>")

#undef LOCATOR_COOLDOWN

/obj/effect/temp_visual/strange_rock_overlay
	plane = FULLSCREEN_PLANE
	layer = FLASH_LAYER
	icon = 'icons/excavation/strange_rock.dmi'
	icon_state = "strange"
	appearance_flags = 0
	duration = 35

/obj/effect/temp_visual/strange_rock_overlay/Initialize()
	. = ..()
	animate(src, alpha = 0, time = duration, easing = EASE_IN)
