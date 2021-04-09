GLOBAL_LIST_INIT(brass_recipes, list ( \
	new/datum/stack_recipe("wall gear", /obj/structure/destructible/clockwork/wall_gear, 2, time = 20, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("brass grille", /obj/structure/grille/ratvar, 2, time=20, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("brass fulltile window", /obj/structure/window/reinforced/clockwork/fulltile/unanchored, 4, time=10, on_floor = TRUE, window_checks=TRUE), \
	new/datum/stack_recipe("brass directional window", /obj/structure/window/reinforced/clockwork/unanchored, 2, time=10, on_floor = TRUE, window_checks=TRUE), \
	new/datum/stack_recipe("brass windoor", /obj/machinery/door/window/clockwork, 5, time=40, on_floor = TRUE, window_checks=TRUE), \
	null, \
	new/datum/stack_recipe("pinion airlock", /obj/machinery/door/airlock/clockwork, 5, time=40, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("pinion windowed airlock", /obj/machinery/door/airlock/clockwork/glass, 5, time=40, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("brass chair", /obj/structure/chair/brass, 1, time=40, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("brass table frame", /obj/structure/table_frame/brass, 1, time=40, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("lever", /obj/item/wallframe/clocktrap/lever, 1, time=40, one_per_turf = FALSE, on_floor = FALSE), \
	new/datum/stack_recipe("timer", /obj/item/wallframe/clocktrap/delay, 1, time=40, one_per_turf = FALSE, on_floor = FALSE), \
	new/datum/stack_recipe("pressure sensor", /obj/structure/destructible/clockwork/trap/pressure_sensor, 4, time=40, one_per_turf = TRUE, on_floor = TRUE), \
	null, \
	new/datum/stack_recipe("brass skewer", /obj/structure/destructible/clockwork/trap/skewer, 12, time=40, one_per_turf = TRUE, on_floor = TRUE), \
	new/datum/stack_recipe("brass flipper", /obj/structure/destructible/clockwork/trap/flipper, 10, time=40, one_per_turf = TRUE, on_floor = TRUE), \
))
//NEVER EVER DO THIS UNLESS YOU HAVE A SPECIFIC ISSUE
/obj/item/clothing/suit/armor/vest/clockwork
	name = "brass armor"
	desc = "A strong, brass suit worn by the soldiers of the Ratvarian armies."
	icon = 'modular_skyrat/modules/clockworkcult/icons/obj/clothing/clockwork_garb.dmi'
	icon_state = "clockwork_cuirass"
	armor = list("melee" = 50, "bullet" = 60, "laser" = 30, "energy" = 80, "bomb" = 80, "bio" = 100, "rad" = 100, "fire" = 100, "acid" = 100)
	slowdown = 0.6
	resistance_flags = FIRE_PROOF | ACID_PROOF
	w_class = WEIGHT_CLASS_BULKY
	body_parts_covered = CHEST|GROIN|LEGS|ARMS
	allowed = list(/obj/item/clockwork, /obj/item/stack/tile/brass, /obj/item/twohanded/clockwork, /obj/item/gun/ballistic/bow/clockwork)

/obj/item/clothing/suit/armor/vest/clockwork/equipped(mob/living/user, slot)
	. = ..()
	if(!is_servant_of_ratvar(user))
		to_chat(user, "<span class='userdanger'>You feel a shock of energy surge through your body!</span>")
		user.dropItemToGround(src, TRUE)
		var/mob/living/carbon/C = user
		if(ishuman(C))
			var/mob/living/carbon/human/H = C
			H.electrocution_animation(20)
		C.jitteriness += 1000
		C.do_jitter_animation(C.jitteriness)
		C.stuttering += 1
		spawn(20)
		if(C)
			C.jitteriness = max(C.jitteriness - 990, 10)


