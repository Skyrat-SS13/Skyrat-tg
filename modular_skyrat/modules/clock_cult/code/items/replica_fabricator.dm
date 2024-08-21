#define BRASS_POWER_COST 10 JOULES
#define REGULAR_POWER_COST (BRASS_POWER_COST / 2)

/obj/item/clockwork/replica_fabricator
	name = "replica fabricator"
	desc = "A strange, brass device with many twisting cogs and vents."
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	lefthand_file = 'modular_skyrat/modules/clock_cult/icons/weapons/clockwork_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/clock_cult/icons/weapons/clockwork_righthand.dmi'
	icon_state = "replica_fabricator"
	/// How much power this has. 5 generated per sheet inserted, one sheet of bronze costs 10, one floor tile costs 15, one wall costs 20
	var/power = 0
	/// How much power this can contain at most. By default, is 2 stacks of regular materials or 1 stack of brass
	var/max_power = 500 JOULES
	/// List of things that the fabricator can build for the radial menu
	var/static/list/crafting_possibilities = list(
		"floor" = image(icon = 'icons/turf/floors.dmi', icon_state = "clockwork_floor"),
		"wall" = image(icon = 'icons/turf/walls/clockwork_wall.dmi', icon_state = "clockwork_wall-0"),
		"wall gear" = image(icon = 'icons/obj/structures.dmi', icon_state = "wall_gear"),
		"window" = image(icon = 'icons/obj/smooth_structures/clockwork_window.dmi', icon_state = "clockwork_window-0"),
		"airlock" = image(icon = 'icons/obj/doors/airlocks/clockwork/pinion_airlock.dmi', icon_state = "closed"),
		"glass airlock" = image(icon = 'icons/obj/doors/airlocks/clockwork/pinion_airlock.dmi', icon_state = "construction"),
	)
	/// List of initialized fabrication datums, created on Initialize
	var/static/list/fabrication_datums = list()
	/// Ref to the datum we have selected currently
	var/datum/replica_fabricator_output/selected_output


/obj/item/clockwork/replica_fabricator/Initialize(mapload)
	. = ..()
	if(!length(fabrication_datums))
		create_fabrication_list()

/obj/item/clockwork/replica_fabricator/Destroy(force)
	selected_output = null
	return ..()

/obj/item/clockwork/replica_fabricator/examine(mob/user)
	. = ..()
	if(IS_CLOCK(user))
		. += "[span_brass("Current power: ")][span_clockyellow("[power]")] [span_brass("J / ")][span_clockyellow("[max_power]")] [span_brass("J.")]"
		. += span_brass("Use on brass to convert it into power.")
		. += span_brass("Use on other materials to convert them into power, but less efficiently.")
		. += span_brass("<b>Use</b> in-hand to select what to fabricate.")
		. += span_brass("<b>Right Click</b> in-hand to fabricate bronze sheets.")


/obj/item/clockwork/replica_fabricator/interact_with_atom(atom/interacting_with, mob/living/user, list/modifiers)
	if(!IS_CLOCK(user))
		return NONE

	if(istype(interacting_with, /obj/item/stack/sheet)) // If it's an item, handle it seperately
		attempt_convert_materials(interacting_with, user)
		return ITEM_INTERACT_SUCCESS

	if(!selected_output || !isopenturf(interacting_with)) // Now we handle objects
		return ITEM_INTERACT_BLOCKING

	var/turf/creation_turf = get_turf(interacting_with)

	if(locate(selected_output.to_create_path) in creation_turf)
		to_chat(user, span_clockyellow("There is already one of these on this tile!"))
		return ITEM_INTERACT_BLOCKING

	if(power < selected_output.cost)
		to_chat(user, span_clockyellow("[src] needs at least [selected_output.cost]W of power to create this."))
		return ITEM_INTERACT_BLOCKING

	var/obj/effect/temp_visual/ratvar/constructing_effect/effect = new(creation_turf, selected_output.creation_delay)

	if(!do_after(user, selected_output.creation_delay, interacting_with))
		qdel(effect)
		return ITEM_INTERACT_BLOCKING

	if(power < selected_output.cost) // Just in case
		return ITEM_INTERACT_BLOCKING

	power -= selected_output.cost

	var/atom/created

	if(selected_output.to_create_path)
		created = new selected_output.to_create_path(get_turf(interacting_with))

	selected_output.on_create(created, creation_turf, user)
	return ITEM_INTERACT_SUCCESS


/obj/item/clockwork/replica_fabricator/attackby(obj/item/attacking_item, mob/user, params)
	. = ..()
	if(!IS_CLOCK(user))
		return

	attempt_convert_materials(attacking_item, user)


/obj/item/clockwork/replica_fabricator/attack_self_secondary(mob/user, modifiers)
	. = ..()
	if(!IS_CLOCK(user))
		return

	if(power < BRASS_POWER_COST)
		to_chat(user, span_clockyellow("You need at least [display_energy(BRASS_POWER_COST)] of power to fabricate bronze."))
		return

	var/sheets = tgui_input_number(user, "How many sheets do you want to fabricate?", "Sheet Fabrication", 0, round(power / BRASS_POWER_COST), 0)
	if(!sheets)
		return

	power -= sheets * BRASS_POWER_COST

	var/obj/item/stack/sheet/bronze/sheet_stack = new(null, sheets)
	user.put_in_hands(sheet_stack)
	playsound(src, 'sound/machines/click.ogg', 50, 1)
	to_chat(user, span_clockyellow("You fabricate [sheets] bronze."))


/obj/item/clockwork/replica_fabricator/attack_self(mob/user, modifiers)
	. = ..()
	var/choice = show_radial_menu(user, src, crafting_possibilities, radius = 36, custom_check = PROC_REF(check_menu), require_near = TRUE)

	if(!choice)
		return

	selected_output = fabrication_datums[choice]


/// Standard confirmation for the radial menu proc
/obj/item/clockwork/replica_fabricator/proc/check_menu(mob/user)
	if(!istype(user))
		return FALSE

	if(user.incapacitated())
		return FALSE

	return TRUE

/// Attempt to convert the targeted item into power, if it's a sheet item
/obj/item/clockwork/replica_fabricator/proc/attempt_convert_materials(atom/attacking_item, mob/user)
	if(power >= max_power)
		to_chat(user, span_clockyellow("[src] is already at maximum power!"))
		return

	if(istype(attacking_item, /obj/item/stack/sheet/bronze))
		var/obj/item/stack/bronze_stack = attacking_item

		if((power + bronze_stack.amount * BRASS_POWER_COST) > max_power)
			var/amount_to_take = clamp(round((max_power - power) / BRASS_POWER_COST), 0, bronze_stack.amount)

			if(!amount_to_take)
				to_chat(user, span_clockyellow("[src] can't be powered further using this!"))
				return

			bronze_stack.use(amount_to_take)
			power += amount_to_take * BRASS_POWER_COST

		else
			power += bronze_stack.amount * BRASS_POWER_COST
			qdel(bronze_stack)

		playsound(src, 'sound/machines/click.ogg', 50, 1)
		to_chat(user, span_clockyellow("You convert [bronze_stack.amount] bronze into [bronze_stack.amount * BRASS_POWER_COST] watts of power."))

		return TRUE

	else if(istype(attacking_item, /obj/item/stack/sheet))
		var/obj/item/stack/stack = attacking_item

		if((power + stack.amount * REGULAR_POWER_COST) > max_power)
			var/amount_to_take = clamp(round((max_power - power) / REGULAR_POWER_COST), 0, stack.amount)

			if(!amount_to_take)
				to_chat(user, span_clockyellow("[src] can't be powered further using this!"))
				return

			stack.use(amount_to_take)
			power += amount_to_take * REGULAR_POWER_COST

		else
			power += stack.amount * REGULAR_POWER_COST
			qdel(stack)

		playsound(src, 'sound/machines/click.ogg', 50, 1)
		to_chat(user, span_clockyellow("You convert [stack.amount] [stack.name] into [stack.amount * REGULAR_POWER_COST] watts of power."))

		return TRUE

	return FALSE

/// Creates the list of initialized fabricator datums, done once on init
/obj/item/clockwork/replica_fabricator/proc/create_fabrication_list()
	for(var/type in subtypesof(/datum/replica_fabricator_output))
		var/datum/replica_fabricator_output/output_ref = new type
		fabrication_datums[output_ref.name] = output_ref


/datum/replica_fabricator_output
	/// Name of the output
	var/name = "parent"
	/// Power cost of the output
	var/cost = 0
	/// Typepath to spawn
	var/to_create_path
	/// How long the creation actionbar is
	var/creation_delay = 1 SECONDS


/// Any extra actions that need to be taken when an object is created
/datum/replica_fabricator_output/proc/on_create(atom/created_atom, turf/creation_turf, mob/creator)
	SHOULD_CALL_PARENT(TRUE)
	playsound(creation_turf, 'modular_skyrat/modules/clock_cult/sound/machinery/integration_cog_install.ogg', 50, 1) // better sound?
	to_chat(creator, span_clockyellow("You create \an [name] for [display_energy(cost)] of power."))


/datum/replica_fabricator_output/brass_floor
	name = "floor"
	cost = BRASS_POWER_COST * 0.25 // 1/4th the cost, since one sheet = 4 floor tiles


/datum/replica_fabricator_output/brass_floor/on_create(obj/created_object, turf/creation_turf, mob/creator)
	creation_turf.ChangeTurf(/turf/open/floor/bronze)

	new /obj/effect/temp_visual/ratvar/floor(creation_turf)
	new /obj/effect/temp_visual/ratvar/beam(creation_turf)
	return ..()


/datum/replica_fabricator_output/brass_wall
	name = "wall"
	cost = BRASS_POWER_COST * 4
	creation_delay = 2.5 SECONDS


/datum/replica_fabricator_output/brass_wall/on_create(obj/created_object, turf/creation_turf, mob/creator)
	creation_turf.ChangeTurf(/turf/closed/wall/mineral/bronze)

	new /obj/effect/temp_visual/ratvar/wall(creation_turf)
	new /obj/effect/temp_visual/ratvar/beam(creation_turf)
	return ..()


/datum/replica_fabricator_output/wall_gear
	name = "wall gear"
	cost = BRASS_POWER_COST * 2
	to_create_path = /obj/structure/girder/bronze
	creation_delay = 1.5 SECONDS


/datum/replica_fabricator_output/wall_gear/on_create(obj/created_object, turf/creation_turf, mob/creator)
	new /obj/effect/temp_visual/ratvar/gear(creation_turf)
	new /obj/effect/temp_visual/ratvar/beam(creation_turf)
	return ..()


/datum/replica_fabricator_output/brass_window
	name = "window"
	cost = BRASS_POWER_COST * 2
	to_create_path = /obj/structure/window/bronze/fulltile
	creation_delay = 2.5 SECONDS


/datum/replica_fabricator_output/brass_window/on_create(obj/created_object, turf/creation_turf, mob/creator)
	new /obj/effect/temp_visual/ratvar/window(creation_turf)
	new /obj/effect/temp_visual/ratvar/beam(creation_turf)
	return ..()


/datum/replica_fabricator_output/pinion_airlock
	name = "airlock"
	cost = BRASS_POWER_COST * 5 // Breaking it only gets 2 but this is the exception to the rule of equivalent exchange, due to all the small parts inside
	to_create_path = /obj/machinery/door/airlock/bronze/clock
	creation_delay = 4 SECONDS


/datum/replica_fabricator_output/pinion_airlock/on_create(obj/created_object, turf/creation_turf, mob/creator)
	new /obj/effect/temp_visual/ratvar/door(creation_turf)
	new /obj/effect/temp_visual/ratvar/beam(creation_turf)
	return ..()


/datum/replica_fabricator_output/pinion_airlock/glass
	name = "glass airlock"
	to_create_path = /obj/machinery/door/airlock/bronze/clock/glass


#undef BRASS_POWER_COST
#undef REGULAR_POWER_COST
