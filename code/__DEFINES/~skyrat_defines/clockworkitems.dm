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