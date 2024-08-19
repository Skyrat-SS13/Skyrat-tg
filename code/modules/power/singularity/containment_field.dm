

/obj/machinery/field/containment
	name = "containment field"
	desc = "An energy field."
	icon = 'icons/obj/machines/engine/singularity.dmi' // SKYRAT EDIT CHANGE - ICON OVERRIDDEN IN SKYRAT AESTHETICS - SEE MODULE
	icon_state = "Contain_F"
	density = FALSE
	move_resist = INFINITY
	resistance_flags = INDESTRUCTIBLE | LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	use_power = NO_POWER_USE
	interaction_flags_atom = NONE
	interaction_flags_machine = NONE
	can_atmos_pass = ATMOS_PASS_NO
	light_range = 4
	layer = ABOVE_OBJ_LAYER
	explosion_block = INFINITY
	///First of the generators producing the containment field
	var/obj/machinery/field/generator/field_gen_1 = null
	///Second of the generators producing the containment field
	var/obj/machinery/field/generator/field_gen_2 = null

/obj/machinery/field/containment/Initialize(mapload)
	AddElement(/datum/element/blocks_explosives)
	. = ..()
	air_update_turf(TRUE, TRUE)
	RegisterSignal(src, COMSIG_ATOM_SINGULARITY_TRY_MOVE, PROC_REF(block_singularity))
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	AddElement(/datum/element/give_turf_traits, string_list(list(TRAIT_CONTAINMENT_FIELD)))

/obj/machinery/field/containment/Destroy()
	if(field_gen_1)
		field_gen_1.fields -= src
		field_gen_1 = null
	if(field_gen_2)
		field_gen_2.fields -= src
		field_gen_2 = null
	can_atmos_pass = ATMOS_PASS_YES
	air_update_turf(TRUE, FALSE)
	return ..()

//ATTACK HAND IGNORING PARENT RETURN VALUE
/obj/machinery/field/containment/attack_hand(mob/user, list/modifiers)
	if(get_dist(src, user) > 1)
		return FALSE
	else
		shock(user)
		return TRUE

/obj/machinery/field/containment/attackby(obj/item/W, mob/user, params)
	shock(user)
	return TRUE

/obj/machinery/field/containment/play_attack_sound(damage_amount, damage_type = BRUTE, damage_flag = 0)
	switch(damage_type)
		if(BURN)
			playsound(loc, 'sound/effects/empulse.ogg', 75, TRUE)
		if(BRUTE)
			playsound(loc, 'sound/effects/empulse.ogg', 75, TRUE)

/obj/machinery/field/containment/blob_act(obj/structure/blob/B)
	return FALSE

/obj/machinery/field/containment/ex_act(severity, target)
	return FALSE

/obj/machinery/field/containment/attack_animal(mob/living/simple_animal/user, list/modifiers)
	if(!field_gen_1 || !field_gen_2)
		qdel(src)
		return
	if(ismegafauna(user))
		user.visible_message(span_warning("[user] glows fiercely as the containment field flickers out!"))
		field_gen_1.calc_power(INFINITY) //rip that 'containment' field
		user.adjustHealth(-user.obj_damage)
	else
		return ..()

/obj/machinery/field/containment/proc/on_entered(datum/source, atom/movable/considered_atom)
	SIGNAL_HANDLER
	if(isliving(considered_atom))
		var/mob/living/living_moving_through_field = considered_atom
		if(!living_moving_through_field.incorporeal_move)
			shock(considered_atom)

	if(ismachinery(considered_atom) || isstructure(considered_atom) || ismecha(considered_atom))
		bump_field(considered_atom)

/obj/machinery/field/containment/proc/set_master(master1,master2)
	if(!master1 || !master2)
		return FALSE
	field_gen_1 = master1
	field_gen_2 = master2
	return TRUE

/obj/machinery/field/containment/proc/block_singularity()
	SIGNAL_HANDLER

	return SINGULARITY_TRY_MOVE_BLOCK

/obj/machinery/field/containment/shock(mob/living/user)
	if(!field_gen_1 || !field_gen_2)
		qdel(src)
		return FALSE
	..()

/obj/machinery/field/containment/Move()
	qdel(src)
	return FALSE


// Abstract Field Class
// Used for overriding certain procs

/obj/machinery/field
	///Used to add a delay between shocks. In some cases this used to crash servers by spawning hundreds of sparks every second.
	var/has_shocked = FALSE

/obj/machinery/field/Bumped(atom/movable/mover)
	if(has_shocked)
		return
	if(isliving(mover))
		shock(mover)
		return
	if(ismachinery(mover) || isstructure(mover) || isvehicle(mover))
		bump_field(mover)
		return


/obj/machinery/field/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(has_shocked || isliving(mover) || ismachinery(mover) || isstructure(mover) || ismecha(mover))
		return FALSE

/obj/machinery/field/proc/shock(mob/living/user)
	var/shock_damage = min(rand(30,40),rand(30,40))

	if(iscarbon(user))
		user.Paralyze(10 SECONDS)
		user.electrocute_act(shock_damage, src, 1)

	else if(issilicon(user))
		if(prob(20))
			user.Stun(40)
		user.take_overall_damage(burn = shock_damage)
		user.visible_message(span_danger("[user.name] is shocked by the [src.name]!"), \
		span_userdanger("Energy pulse detected, system damaged!"), \
		span_hear("You hear an electrical crack."))

	user.updatehealth()
	bump_field(user)

/obj/machinery/field/proc/clear_shock()
	has_shocked = FALSE

/obj/machinery/field/proc/bump_field(atom/movable/considered_atom as mob|obj)
	if(has_shocked)
		return FALSE
	has_shocked = TRUE
	do_sparks(5, TRUE, considered_atom.loc)
	var/atom/target = get_edge_target_turf(considered_atom, get_dir(src, get_step_away(considered_atom, src)))
	if(isliving(considered_atom))
		to_chat(considered_atom, span_userdanger("The field repels you with tremendous force!"))
	playsound(src, 'sound/effects/gravhit.ogg', 50, TRUE)
	considered_atom.throw_at(target, 200, 4)
	addtimer(CALLBACK(src, PROC_REF(clear_shock)), 0.5 SECONDS)
