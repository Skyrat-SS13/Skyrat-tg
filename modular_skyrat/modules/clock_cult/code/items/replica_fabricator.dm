#define BRASS_POWER_COST 10
#define FLOOR_POWER_COST 15
#define WALL_POWER_COST 20

/obj/item/clockwork/replica_fabricator
	name = "replica fabricator"
	desc = "A strange, brass device with many twisting cogs and vents."
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	lefthand_file = 'modular_skyrat/modules/clock_cult/icons/weapons/clockwork_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/clock_cult/icons/weapons/clockwork_righthand.dmi'
	icon_state = "replica_fabricator"
	/// How much power this has. 5 generated per sheet inserted, one sheet of bronze costs 10, one floor tile costs 15, one wall costs 20
	var/power = 0

/obj/item/clockwork/replica_fabricator/examine(mob/user)
	. = ..()
	if(IS_CLOCK(user))
		. += "[span_brass("Current power: ")][span_clockyellow(power)][span_brass(".")]"
		. += span_brass("Use on brass to convert it into power.")
		. += span_brass("Use on other materials to convert them into power, but at less efficiency.")
		. += span_brass("Use on an empty floor to convert it to bronze for [FLOOR_POWER_COST]W/tile")
		. += span_brass("Use on a bronze floor to create a wall for [WALL_POWER_COST]W/wall")
		. += span_brass("Use in-hand to fabricate bronze sheets.")

/obj/item/clockwork/replica_fabricator/afterattack(atom/target, mob/user, proximity_flag, click_parameters)
	. = ..()
	if(!proximity_flag || !(IS_CLOCK(user)))
		return

	if(istype(target, /obj/item/stack/sheet/bronze))

		var/obj/item/stack/bronze_stack = target
		power += bronze_stack.amount * BRASS_POWER_COST

		playsound(src, 'sound/machines/click.ogg', 50, 1)
		to_chat(user, span_clockyellow("You convert [bronze_stack.amount] bronze into [bronze_stack.amount * BRASS_POWER_COST] watts of power."))
		qdel(bronze_stack)

	else if(istype(target, /obj/item/stack/sheet))

		var/obj/item/stack/stack = target
		var/power_to_generate = round(stack.amount * BRASS_POWER_COST / 2)
		power += power_to_generate

		playsound(src, 'sound/machines/click.ogg', 50, 1)
		to_chat(user, span_clockyellow("You convert [stack.amount] [stack] into [power_to_generate] watts of power."))
		qdel(target)

	else if(isopenturf(target) && !istype(target, /turf/open/floor/bronze))

		if(power < FLOOR_POWER_COST)
			to_chat(user, span_clockyellow("You need at least [FLOOR_POWER_COST] watts of power to do this."))
			return

		if(!do_after(user, 1.5 SECONDS, target))
			return

		if(power < FLOOR_POWER_COST) //checking again because there's a delay where shit could be fucked
			return

		var/turf/open/target_turf = target
		target_turf.ChangeTurf(/turf/open/floor/bronze)
		new /obj/effect/temp_visual/ratvar/floor(target_turf)
		new /obj/effect/temp_visual/ratvar/beam(target_turf)

		power -= FLOOR_POWER_COST
		to_chat(user, span_clockyellow("You convert a floor to bronze for [FLOOR_POWER_COST] watts of power."))
		playsound(src, 'sound/machines/clockcult/integration_cog_install.ogg', 50, 1) // thank you /tg/ for leaving these in the files

	else if(istype(target, /turf/open/floor/bronze))

		if(power < WALL_POWER_COST)
			to_chat(user, span_clockyellow("You need at least [WALL_POWER_COST] watts of power to do this."))
			return

		if(!do_after(user, 2.5 SECONDS, target))
			return

		if(power < WALL_POWER_COST)
			return

		var/turf/open/target_turf = target
		target_turf.ChangeTurf(/turf/closed/wall/mineral/bronze)
		new /obj/effect/temp_visual/ratvar/wall(target_turf)
		new /obj/effect/temp_visual/ratvar/beam(target_turf)

		power -= WALL_POWER_COST
		to_chat(user, span_clockyellow("You convert a floor to bronze for [WALL_POWER_COST] watts of power."))
		playsound(src, 'sound/machines/clockcult/integration_cog_install.ogg', 50, 1)


/obj/item/clockwork/replica_fabricator/attack_self(mob/user, modifiers)
	. = ..()
	if(power < BRASS_POWER_COST)
		to_chat(user, span_clockyellow("You need at least [BRASS_POWER_COST]W of power to fabricate bronze."))
		return

	var/sheets = tgui_input_number(user, "How many sheets do you want to fabricate?", "Sheet Fabrication", 0, round(power / BRASS_POWER_COST), 0)
	if(!sheets)
		return

	power -= sheets * BRASS_POWER_COST

	new /obj/item/stack/sheet/bronze(get_turf(src), sheets)
	playsound(src, 'sound/machines/click.ogg', 50, 1)
	to_chat(user, span_clockyellow("You fabricate [sheets] bronze."))

#undef BRASS_POWER_COST
#undef FLOOR_POWER_COST
#undef WALL_POWER_COST
