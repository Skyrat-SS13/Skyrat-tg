// Snow, wood, sandbags, metal, plasteel

/obj/structure/deployable_barricade
	icon = 'modular_skyrat/modules/barricades/icons/barricade.dmi'
	anchored = TRUE
	density = TRUE
	layer = BELOW_OBJ_LAYER
	flags_1 = ON_BORDER_1
	max_integrity = 100
	///The type of stack the barricade dropped when disassembled if any.
	var/stack_type
	///The amount of stack dropped when disassembled at full health
	var/stack_amount = 5
	///to specify a non-zero amount of stack to drop when destroyed
	var/destroyed_stack_amount = 0
	var/base_acid_damage = 2
	///Whether things can be thrown over
	var/allow_thrown_objs = TRUE
	var/barricade_type = "barricade" //"metal", "plasteel", etc.
	///Whether this barricade has damaged states
	var/can_change_dmg_state = TRUE
	///Whether we can open/close this barrricade and thus go over it
	var/closed = FALSE
	///Can this barricade type be wired
	var/can_wire = FALSE
	///is this barriade wired?
	var/is_wired = FALSE

/obj/structure/deployable_barricade/Initialize(mapload)
	. = ..()
	update_icon()
	var/static/list/connections = list(
		COMSIG_ATOM_EXIT = .proc/on_try_exit
	)
	AddElement(/datum/element/connect_loc, connections)
	AddElement(/datum/element/climbable)
	RegisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED, .proc/run_integrity)

/obj/structure/deployable_barricade/proc/run_integrity()
	SIGNAL_HANDLER
	update_appearance()

/obj/structure/deployable_barricade/Destroy()
	UnregisterSignal(src, COMSIG_ATOM_INTEGRITY_CHANGED)
	return ..()

/obj/structure/deployable_barricade/examine(mob/user)
	. = ..()
	if(!is_wired && can_wire)
		. += span_info("Barbed wire could be added with some <b>cable</b>.")
	if(is_wired)
		. += span_info("It has barbed wire along the top.")

/obj/structure/deployable_barricade/proc/on_try_exit(datum/source, atom/movable/leaving, direction)
	SIGNAL_HANDLER

	if(leaving == src)
		return

	if(!(direction & dir))
		return

	if (!density)
		return

	if (leaving.throwing)
		return

	if (leaving.movement_type & (PHASING | FLYING | FLOATING))
		return

	if (leaving.move_force >= MOVE_FORCE_EXTREMELY_STRONG)
		return

	leaving.Bump(src)
	return COMPONENT_ATOM_BLOCK_EXIT

/obj/structure/deployable_barricade/CanPass(atom/movable/mover, border_dir)
	. = ..()

	if(istype(mover, /obj/projectile))
		if(!anchored)
			return TRUE
		if(closed)
			return TRUE
		var/obj/projectile/proj = mover
		if(proj.firer && Adjacent(proj.firer))
			return TRUE
		if(prob(25))
			return TRUE
		return FALSE

	if((border_dir & dir) && !closed)
		return . || mover.throwing || mover.movement_type & (FLYING | FLOATING)
	return TRUE

/obj/structure/deployable_barricade/attackby(obj/item/I, mob/living/user, params)
	if(istype(I, /obj/item/stack/cable_coil) && can_wire)
		var/obj/item/stack/S = I
		if(S.use(5))
			wire()
		else
			return
	else
		..()
		update_icon()

/obj/structure/deployable_barricade/attack_animal(mob/user)
	return attack_alien(user)

/obj/structure/deployable_barricade/proc/wire()
	can_wire = FALSE
	is_wired = TRUE
	modify_max_integrity(max_integrity + 50)
	update_icon()

/obj/structure/deployable_barricade/wirecutter_act(mob/living/user, obj/item/I)
	if(!is_wired)
		return FALSE

	user.visible_message(span_notice("[user] begins to remove the barbed wire on [src]."),
	span_notice("You start removing the barbed wire on [src]."))

	if(!do_after(user, 2 SECONDS, src))
		return TRUE

	playsound(src, 'sound/items/wirecutter.ogg', 25, TRUE)
	user.visible_message(span_notice("[user] removed the barbed wire on [src]."),
	span_notice("You removed the barbed wire on [src]."))
	modify_max_integrity(max_integrity - 50)
	can_wire = TRUE
	is_wired = FALSE
	update_icon()


/obj/structure/deployable_barricade/deconstruct(disassembled = TRUE)
	if(stack_type)
		var/stack_amt
		if(!disassembled && destroyed_stack_amount)
			stack_amt = destroyed_stack_amount
		else
			stack_amt = round(stack_amount * (get_integrity()/max_integrity)) //Get an amount of sheets back equivalent to remaining health. Obviously, fully destroyed means 0

		if(stack_amt)
			new stack_type (loc, stack_amt)
	return ..()

/obj/structure/deployable_barricade/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			visible_message(span_danger("[src] explodes!"))
			deconstruct(FALSE)
			return
		if(EXPLODE_HEAVY)
			take_damage(rand(33, 66))
		if(EXPLODE_LIGHT)
			take_damage(rand(10, 33))
	update_icon()

/obj/structure/deployable_barricade/setDir(newdir)
	. = ..()
	update_icon()

/obj/structure/deployable_barricade/update_icon()
	. = ..()
	var/damage_state
	var/percentage = (get_integrity() / max_integrity) * 100
	switch(percentage)
		if(-INFINITY to 25)
			damage_state = 3
		if(25 to 50)
			damage_state = 2
		if(50 to 75)
			damage_state = 1
		if(75 to INFINITY)
			damage_state = 0
	if(!closed)
		if(can_change_dmg_state)
			icon_state = "[barricade_type]_[damage_state]"
		else
			icon_state = "[barricade_type]"
		switch(dir)
			if(SOUTH)
				layer = ABOVE_MOB_LAYER
			if(NORTH)
				layer = initial(layer) - 0.01
			else
				layer = initial(layer)
		if(!anchored)
			layer = initial(layer)
	else
		if(can_change_dmg_state)
			icon_state = "[barricade_type]_closed_[damage_state]"
		else
			icon_state = "[barricade_type]_closed"
		layer = OBJ_LAYER

/obj/structure/deployable_barricade/update_overlays()
	. = ..()
	if(is_wired)
		if(!closed)
			. += image('modular_skyrat/modules/barricades/icons/barricade.dmi', icon_state = "[barricade_type]_wire")
		else
			. += image('modular_skyrat/modules/barricades/icons/barricade.dmi', icon_state = "[barricade_type]_closed_wire")

/obj/structure/deployable_barricade/verb/rotate()
	set name = "Rotate barricade counterclockwise <"
	set category = "Object"
	set src in oview(1)

	if(anchored)
		to_chat(usr, span_warning("It is secured to the floor, you can't turn it!"))
		return FALSE

	setDir(turn(dir, 90))

/obj/structure/deployable_barricade/verb/revrotate()
	set name = "Rotate barricade clockwise >"
	set category = "Object"
	set src in oview(1)

	if(anchored)
		to_chat(usr, span_warning("It is secured to the floor, you can't turn it!"))
		return FALSE

	setDir(turn(dir, 270))


/obj/structure/deployable_barricade/attack_hand_secondary(mob/user, list/modifiers)
	. = ..()
	if(anchored)
		to_chat(usr, span_warning("It is secured to the floor, you can't turn it!"))
		return FALSE

	setDir(turn(dir, 270))


/*----------------------*/
// SNOW
/*----------------------*/

/obj/structure/deployable_barricade/snow
	name = "snow barricade"
	desc = "A snowdrift, carefully rammed with palms up to a relatively solid state. The architect in your head believes that it is better than nothing. In principle, you agree with him."
	icon_state = "snow_0"
	barricade_type = "snow"
	max_integrity = 75
	stack_type = /obj/item/stack/sheet/mineral/snow
	stack_amount = 2
	destroyed_stack_amount = 0
	can_wire = FALSE

/*----------------------*/
// GUARD RAIL
/*----------------------*/

/obj/structure/deployable_barricade/guardrail
	name = "fencing"
	desc = "A small barricade made from metal posting, designed to stop you from going places you aren't supposed to."
	icon_state = "railing_0"
	max_integrity = 150
	armor = list(MELEE = 0, BULLET = 50, LASER = 50, ENERGY = 50, BOMB = 15, BIO = 100, FIRE = 100, ACID = 10)
	stack_type = /obj/item/stack/rods
	destroyed_stack_amount = 2
	barricade_type = "railing"
	allow_thrown_objs = FALSE
	can_wire = FALSE

/obj/structure/deployable_barricade/guardrail/update_icon()
	. = ..()
	if(dir == NORTH)
		pixel_y = 11

/*----------------------*/
// WOOD
/*----------------------*/

/obj/structure/deployable_barricade/wooden
	name = "wooden barricade"
	desc = "A wall hammered out of wooden planks may not even look very strong, but it still provides some protection."
	icon = 'modular_skyrat/modules/barricades/icons/barricade.dmi'
	icon_state = "wooden"
	max_integrity = 100
	layer = OBJ_LAYER
	stack_type = /obj/item/stack/sheet/mineral/wood
	stack_amount = 2
	destroyed_stack_amount = 1
	can_change_dmg_state = FALSE
	barricade_type = "wooden"
	can_wire = FALSE

/obj/structure/deployable_barricade/wooden/attackby(obj/item/I, mob/user, params)
	. = ..()
	if(istype(I, /obj/item/stack/sheet/mineral/wood))
		var/obj/item/stack/sheet/mineral/wood/D = I
		if(get_integrity() >= max_integrity)
			return

		if(D.get_amount() < 1)
			to_chat(user, span_warning("You need at least one board to repair [src]!"))
			return

		visible_message(span_notice("[user] begins to repair [src]."))

		if(!do_after(user,20, src) || get_integrity() >= max_integrity)
			return

		if(!D.use(1))
			return

		repair_damage(max_integrity)
		visible_message(span_notice("[user] repairs [src]."))


/*----------------------*/
// METAL
/*----------------------*/

#define BARRICADE_METAL_LOOSE 0
#define BARRICADE_METAL_ANCHORED 1
#define BARRICADE_METAL_FIRM 2

#define BARRICADE_TYPE_BOMB "explosion-proof armor"
#define BARRICADE_TYPE_MELEE "ballistic armor"
#define BARRICADE_TYPE_ACID "anti-acid armor"

#define BARRICADE_UPGRADE_REQUIRED_SHEETS 2

/obj/structure/deployable_barricade/metal
	name = "metal barricade"
	desc = "A durable and easily mounted barricade made from metal plates, often used for rapid fortification. Repairing it requires a welder."
	icon_state = "metal_0"
	max_integrity = 200
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 0, BIO = 100, FIRE = 80, ACID = 40)
	stack_type = /obj/item/stack/sheet/iron
	stack_amount = 2
	destroyed_stack_amount = 1
	barricade_type = "metal"
	can_wire = TRUE
	/// The type of quickdeploy we drop when folded up.
	var/portable_type = /obj/item/quickdeploy/barricade
	/// Build state of the barricade
	var/build_state = BARRICADE_METAL_FIRM
	/// The type of upgrade and corresponding overlay we have attached
	var/barricade_upgrade_type
	/// How many of our stack_type do we need to repair this?
	var/repair_amount = 2
	/// Can we be upgraded?
	var/can_upgrade = TRUE

/obj/structure/deployable_barricade/metal/AltClick(mob/user)
	if(portable_type)
		if(anchored)
			to_chat(user, span_warning("[src] cannot be folded up while anchored to the ground!"))
			return FALSE
		if(barricade_upgrade_type)
			to_chat(user, span_warning("[src] cannot be folded up with upgrades attached, remove them first!"))
			return FALSE
		if(get_integrity() < max_integrity)
			to_chat(user, span_warning("[src] cannot be folded up while damaged!"))
			return FALSE
		user.visible_message(span_notice("[user] starts folding [src] up!"), span_notice("You start folding [src] up!"))
		if(do_after(user, 5 SECONDS, src))
			if(QDELETED(src)) //Copied encase we change states.
				return
			if(anchored)
				to_chat(user, span_warning("[src] cannot be folded up while anchored to the ground!"))
				return FALSE
			if(barricade_upgrade_type)
				to_chat(user, span_warning("[src] cannot be folded up with upgrades attached, remove them first!"))
				return FALSE
			if(get_integrity() < max_integrity)
				to_chat(user, span_warning("[src] cannot be folded up while damaged!"))
				return FALSE
			user.visible_message(span_notice("[user] folds [src] up!"), span_notice("You neatly fold [src] up!"))
			playsound(src, 'sound/items/ratchet.ogg', 25, TRUE)
			fold_up()
			return TRUE
	return ..()

/obj/structure/deployable_barricade/metal/proc/fold_up()
	new portable_type(get_turf(src))
	qdel(src)

/obj/structure/deployable_barricade/metal/update_overlays()
	. = ..()
	if(!barricade_upgrade_type)
		return
	var/damage_state
	var/percentage = (get_integrity() / max_integrity) * 100
	switch(percentage)
		if(-INFINITY to 25)
			damage_state = 3
		if(25 to 50)
			damage_state = 2
		if(50 to 75)
			damage_state = 1
		if(75 to INFINITY)
			damage_state = 0
	switch(barricade_upgrade_type)
		if(BARRICADE_TYPE_BOMB)
			. += image('modular_skyrat/modules/barricades/icons/barricade.dmi', icon_state = "+explosive_upgrade_[damage_state]")
		if(BARRICADE_TYPE_MELEE)
			. += image('modular_skyrat/modules/barricades/icons/barricade.dmi', icon_state = "+brute_upgrade_[damage_state]")
		if(BARRICADE_TYPE_ACID)
			. += image('modular_skyrat/modules/barricades/icons/barricade.dmi', icon_state = "+burn_upgrade_[damage_state]")

/obj/structure/deployable_barricade/metal/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/stack/sheet/iron))
		var/obj/item/stack/sheet/iron/metal_sheets = I
		if(can_upgrade && get_integrity() > max_integrity * 0.3)
			return attempt_barricade_upgrade(I, user, params)

		if(metal_sheets.get_amount() < 2)
			to_chat(user, span_warning("You need at least two sheets of metal to repair [src]!"))
			return FALSE

		visible_message(span_notice("[user] begins to repair [src]."))

		if(!do_after(user, 2 SECONDS, src) || get_integrity() >= max_integrity)
			return FALSE

		if(!metal_sheets.use(2))
			return FALSE

		repair_damage(max_integrity * 0.3)
		visible_message(span_notice("[user] repairs [src]."))
	return ..()

/obj/structure/deployable_barricade/metal/proc/attempt_barricade_upgrade(obj/item/stack/sheet/iron/metal_sheets, mob/user, params)
	if(barricade_upgrade_type)
		to_chat(user, span_warning("[src] is already upgraded."))
		return FALSE
	if(get_integrity() < max_integrity)
		to_chat(user, span_warning("You cannot upgrade [src] until it has been repaired!"))
		return FALSE

	if(metal_sheets.get_amount() < BARRICADE_UPGRADE_REQUIRED_SHEETS)
		to_chat(user, span_warning("You need at least <b>[BARRICADE_UPGRADE_REQUIRED_SHEETS]</b> to upgrade [src]!"))
		return FALSE

	var/static/list/cade_types = list(BARRICADE_TYPE_BOMB = image(icon = 'modular_skyrat/modules/barricades/icons/barricade.dmi', icon_state = "explosive_obj"), BARRICADE_TYPE_MELEE = image(icon = 'modular_skyrat/modules/barricades/icons/barricade.dmi', icon_state = "brute_obj"), BARRICADE_TYPE_ACID = image(icon = 'modular_skyrat/modules/barricades/icons/barricade.dmi', icon_state = "burn_obj"))
	var/choice = show_radial_menu(user, src, cade_types, require_near = TRUE, tooltips = TRUE)

	user.visible_message(span_notice("[user] starts attaching [choice] to [src]."),
		span_notice("You start attaching [choice] to [src]."))
	if(!do_after(user, 2 SECONDS, src))
		return FALSE

	if(!metal_sheets.use(BARRICADE_UPGRADE_REQUIRED_SHEETS))
		return FALSE

	switch(choice)
		if(BARRICADE_TYPE_BOMB)
			armor = armor.modifyRating(bomb = 50)
		if(BARRICADE_TYPE_MELEE)
			armor = armor.modifyRating(melee = 30, bullet = 30)
		if(BARRICADE_TYPE_ACID)
			armor = armor.modifyRating(bio = 0, acid = 20)

	barricade_upgrade_type = choice

	user.visible_message(span_notice("[user] attaches[choice] to [src]."),
		span_notice("You attach [choice] to [src]."))

	playsound(src, 'sound/items/screwdriver.ogg', 25, TRUE)
	update_icon()

/obj/structure/deployable_barricade/metal/examine(mob/user)
	. = ..()
	switch(build_state)
		if(BARRICADE_METAL_FIRM)
			. += span_info("The cover plate is <b>screwed</b> in place.")
		if(BARRICADE_METAL_ANCHORED)
			. += span_info("The cover plate is <i>unscrewed</i>, but it is <b>bolted</b> to the ground.")
		if(BARRICADE_METAL_LOOSE)
			. += span_info("The anchor points are <i>unbolted</i>, use a <b>crowbar</b> to disassemble it.")

	if(barricade_upgrade_type)
		. += span_info("It has [barricade_upgrade_type] installed.")

	if(portable_type)
		. += span_info("Alt+click to fold it up into it's portable form.")

/obj/structure/deployable_barricade/metal/welder_act(mob/living/user, obj/item/I)
	var/obj/item/weldingtool/welding_tool = I

	if(!welding_tool.isOn())
		return FALSE

	if(get_integrity() <= max_integrity * 0.3)
		to_chat(user, span_warning("[src] is too damaged to be repaired with a welder!"))
		return TRUE

	if(get_integrity() >= max_integrity)
		to_chat(user, span_warning("[src] does not need repairing."))
		return TRUE

	user.visible_message(span_notice("[user] starts welding the damage on [src]."),
	span_notice("You start welding the damage on [src]."))
	playsound(src, 'sound/items/welder2.ogg', 25, TRUE)

	if(!do_after(user, 5 SECONDS, src))
		return TRUE

	if(get_integrity() <= max_integrity * 0.3 || get_integrity() >= max_integrity)
		return TRUE

	if(!welding_tool.use(2))
		to_chat(user, span_warning("Not enough fuel!"))
		return TRUE

	user.visible_message(span_notice("[user] welds the damage on [src]."),
	span_notice("You weld the damage on [src]."))
	repair_damage(150)
	update_icon()
	playsound(src, 'sound/items/welder2.ogg', 25, TRUE)
	return TRUE


/obj/structure/deployable_barricade/metal/screwdriver_act(mob/living/user, obj/item/I)
	switch(build_state)
		if(BARRICADE_METAL_ANCHORED) //Protection panel removed step. Screwdriver to put the panel back, wrench to unsecure the anchor bolts
			playsound(src, 'sound/items/screwdriver.ogg', 25, TRUE)
			if(!do_after(user, 1 SECONDS, src))
				return TRUE
			user.visible_message (span_notice ("[user] secures the panel on [src]."),
			span_notice ("You secure the panel on [src]."))
			build_state = BARRICADE_METAL_FIRM
			return TRUE

		if(BARRICADE_METAL_FIRM) //Fully constructed step. Use screwdriver to remove the protection panels to reveal the bolts
			playsound(src, 'sound/items/screwdriver.ogg', 25, TRUE)

			if(!do_after(user, 1 SECONDS, src))
				return TRUE

			user.visible_message (span_notice ("[user] removes the panel from[src]."),
			span_notice ("You remove the panel from [src], revealing some <b>bolts</b> beneath it."))
			build_state = BARRICADE_METAL_ANCHORED
			return TRUE


/obj/structure/deployable_barricade/metal/wrench_act(mob/living/user, obj/item/I)
	switch(build_state)
		if(BARRICADE_METAL_ANCHORED) //Protection panel removed step. Screwdriver to put the panel back, wrench to unsecure the anchor bolts
			playsound(src, 'sound/items/ratchet.ogg', 25, TRUE)
			if(!do_after(user, 1 SECONDS, src))
				return TRUE
			user.visible_message (span_notice ("[user] loosens the anchor bolts on [src]."),
			span_notice ("You loosen the anchor bolts on [src]."))
			build_state = BARRICADE_METAL_LOOSE
			anchored = FALSE
			modify_max_integrity(initial(max_integrity) * 0.5)
			update_icon() //unanchored changes layer
			return TRUE

		if(BARRICADE_METAL_LOOSE) //Anchor bolts loosened step. Apply crowbar to unseat the panel and take apart the whole thing. Apply wrench to resecure anchor bolts
			var/turf/mystery_turf = get_turf(src)
			if(!isopenturf(mystery_turf))
				to_chat(user, span_warning("You cannot install [src] here!"))
				return TRUE

			for(var/obj/structure/deployable_barricade/B in loc)
				if(B != src && B.dir == dir)
					to_chat(user, span_warning("There is already a barricade here."))
					return TRUE

			playsound(src, 'sound/items/ratchet.ogg', 25, TRUE)
			if(!do_after(user, 1 SECONDS, src))
				return TRUE

			user.visible_message(span_notice("[user] tightens the anchor bolts on [src]."),
			span_notice("You tighten the anchor bolts on [src]."))
			build_state = BARRICADE_METAL_ANCHORED
			anchored = TRUE
			modify_max_integrity(initial(max_integrity))
			update_icon() //unanchored changes layer
			return TRUE


/obj/structure/deployable_barricade/metal/crowbar_act(mob/living/user, obj/item/I)
	switch(build_state)
		if(BARRICADE_METAL_LOOSE) //Anchor bolts loosened step. Apply crowbar to unseat the panel and take apart the whole thing. Apply wrench to resecure anchor bolts
			user.visible_message(span_notice("[user] begins to disassemble [src]."),
			span_notice("You start to disassemble [src]."))

			playsound(src, 'sound/items/crowbar.ogg', 25, 1)
			if(!do_after(user, 5 SECONDS, src))
				return TRUE

			user.visible_message(span_notice("[user] disassembles [src]."),
			span_notice("You disassemble [src]."))
			playsound(src, 'sound/items/deconstruct.ogg', 25, 1)
			deconstruct(TRUE)
			return TRUE

		if(BARRICADE_METAL_FIRM)
			if(!barricade_upgrade_type) //Check to see if we actually have upgrades to remove.
				to_chat(user, span_warning("This barricade has no installed upgrades to remove!"))
				return TRUE

			user.visible_message(span_notice("[user] begins to detach the armor plates from [src]."),
			span_notice("You begin to detach the armor plates from [src]."))

			playsound(src, 'sound/items/crowbar.ogg', 25, 1)
			if(!do_after(user, 5 SECONDS, src))
				return TRUE

			user.visible_message(span_notice("[user] detaches the armor plates from [src]."),
			span_notice("You detach the armor plates from [src]."))
			playsound(src, 'sound/items/deconstruct.ogg', 25, 1)

			switch(barricade_upgrade_type)
				if(BARRICADE_TYPE_BOMB)
					armor = armor.modifyRating(bomb = -50)
				if(BARRICADE_TYPE_MELEE)
					armor = armor.modifyRating(melee = -30, bullet = -30)
				if(BARRICADE_TYPE_ACID)
					armor = armor.modifyRating(bio = 0, acid = -20)

			new /obj/item/stack/sheet/iron(loc, BARRICADE_UPGRADE_REQUIRED_SHEETS)
			barricade_upgrade_type = null
			update_icon()
			return TRUE


/obj/structure/deployable_barricade/metal/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			take_damage(rand(400, 600))
		if(EXPLODE_HEAVY)
			take_damage(rand(150, 350))
		if(EXPLODE_LIGHT)
			take_damage(rand(50, 100))

	update_icon()

#undef BARRICADE_TYPE_BOMB
#undef BARRICADE_TYPE_MELEE
#undef BARRICADE_TYPE_ACID
#undef BARRICADE_UPGRADE_REQUIRED_SHEETS


/*----------------------*/
// PLASTEEL
/*----------------------*/

/obj/structure/deployable_barricade/metal/plasteel
	name = "plasteel barricade"
	desc = "A strong plasteel barricade, it can be lowered if necessary. Use a welder to repair it."
	icon_state = "plasteel_closed_0"
	max_integrity = 500
	stack_type = /obj/item/stack/sheet/plasteel
	barricade_type = "plasteel"
	density = FALSE
	closed = TRUE
	can_upgrade = FALSE
	portable_type = /obj/item/quickdeploy/barricade/plasteel
	///Either we react with other cades next to us ie when opening or so
	var/linked = FALSE
	///Open/close delay, for customisation. And because I was asked to - won't customise anything myself.
	var/toggle_delay = 2 SECONDS

/obj/structure/deployable_barricade/metal/plasteel/crowbar_act(mob/living/user, obj/item/I)
	switch(build_state)
		if(BARRICADE_METAL_LOOSE) //Anchor bolts loosened step. Apply crowbar to unseat the panel and take apart the whole thing. Apply wrench to resecure anchor bolts
			user.visible_message(span_notice("[user] begins to disassemble [src]."),
			span_notice("You start to disassemble [src]."))

			playsound(src, 'sound/items/crowbar.ogg', 25, 1)
			if(!do_after(user, 5 SECONDS, src))
				return TRUE

			user.visible_message(span_notice("[user] disassembles [src]."),
			span_notice("You disassemble [src]."))
			playsound(src, 'sound/items/deconstruct.ogg', 25, 1)
			deconstruct(TRUE)
			return TRUE
		if(BARRICADE_METAL_FIRM)
			linked = !linked
			user.visible_message(span_notice("[user] has [linked ? "linked" : "unlinked" ] [src]."),
			span_notice("You [linked ? "link" : "unlink" ] [src]."))
			for(var/direction in GLOB.cardinals)
				for(var/obj/structure/deployable_barricade/metal/plasteel/cade in get_step(src, direction))
					cade.update_icon()
			update_icon()
			return TRUE

/obj/structure/deployable_barricade/metal/plasteel/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return

	if(do_after(user, toggle_delay, src))
		toggle_open(null, user)

/obj/structure/deployable_barricade/metal/plasteel/proc/toggle_open(state, mob/living/user)
	if(state == closed)
		return
	playsound(src, 'sound/items/ratchet.ogg', 25, 1)
	closed = !closed
	density = !density

	user?.visible_message(span_notice("[user] [closed ? "lowers" : "raises"] [src] ."),
		span_notice("You [closed ? "lower" : "raise"] [src]."))

	if(!linked)
		update_icon()
		return
	for(var/direction in GLOB.cardinals)
		for(var/obj/structure/deployable_barricade/metal/plasteel/cade in get_step(src, direction))
			if(((dir & (NORTH|SOUTH) && get_dir(src, cade) & (EAST|WEST)) || (dir & (EAST|WEST) && get_dir(src, cade) & (NORTH|SOUTH))) && dir == cade.dir && cade.linked)
				cade.toggle_open(closed)

	update_icon()

/obj/structure/deployable_barricade/metal/plasteel/update_overlays()
	. = ..()
	if(linked)
		for(var/direction in GLOB.cardinals)
			for(var/obj/structure/deployable_barricade/metal/plasteel/cade in get_step(src, direction))
				if(((dir & (NORTH|SOUTH) && get_dir(src, cade) & (EAST|WEST)) || (dir & (EAST|WEST) && get_dir(src, cade) & (NORTH|SOUTH))) && dir == cade.dir && cade.linked && cade.closed == closed)
					. += image('modular_skyrat/modules/barricades/icons/barricade.dmi', icon_state = "[barricade_type]_[closed ? "closed" : "open"]_connection_[get_dir(src, cade)]")

/obj/structure/deployable_barricade/metal/plasteel/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			take_damage(rand(450, 650))
		if(EXPLODE_HEAVY)
			take_damage(rand(200, 400))
		if(EXPLODE_LIGHT)
			take_damage(rand(50, 150))

	update_icon()

#undef BARRICADE_METAL_LOOSE
#undef BARRICADE_METAL_ANCHORED
#undef BARRICADE_METAL_FIRM

//An item thats meant to be a template for quickly deploying stuff like barricades
/obj/item/quickdeploy
	name = "C.U.C.K.S"
	desc = "Compact Universal Complex Kinetic Self-expanding Barricade. Great for deploying quick fortifications."
	icon = 'modular_skyrat/modules/barricades/icons/barricade.dmi'
	w_class = WEIGHT_CLASS_SMALL //While this is small, normal 50 stacks of metal is NORMAL so this is a bit on the bad space to cade ratio
	var/delay = 0 //Delay on deploying the thing
	var/atom/movable/thing_to_deploy = null

/obj/item/quickdeploy/examine(mob/user)
	. = ..()
	. += "This [src.name] is set up deploy [thing_to_deploy.name]."

/obj/item/quickdeploy/attack_self(mob/user)
	to_chat(user, span_notice("You start deploying [src] in front of you."))
	playsound(src, 'sound/items/ratchet.ogg', 25, 1)
	if(!do_after(usr, delay, src))
		return
	if(can_place(user)) //can_place() handles sending the error and success messages to the user
		var/obj/O = new thing_to_deploy(get_turf(user))
		O.setDir(user.dir)
		playsound(src, 'sound/items/ratchet.ogg', 25, TRUE)
		qdel(src)

/obj/item/quickdeploy/proc/can_place(mob/user)
	if(isnull(thing_to_deploy)) //Spaghetti or wrong type spawned
		to_chat(user, span_warning("Nothing happens... [src] must be defective."))
		return FALSE
	return TRUE

/obj/item/quickdeploy/barricade
	thing_to_deploy = /obj/structure/deployable_barricade/metal
	icon_state = "metal"
	delay = 3 SECONDS

/obj/item/quickdeploy/barricade/can_place(mob/user)
	. = ..()
	if(!.)
		return FALSE

	var/turf/mystery_turf = user.loc
	if(!isopenturf(mystery_turf))
		to_chat(user, span_warning("You cannot deploy [src] here!"))
		return FALSE

	var/turf/open/placement_loc = mystery_turf
	if(placement_loc.density) //We shouldn't be building here.
		to_chat(user, span_warning("You cannot deploy [src] here!"))
		return FALSE

	for(var/obj/thing in user.loc)
		if(!thing.density) //not dense, move on
			continue
		if(!(thing.flags_1 & ON_BORDER_1)) //dense and non-directional, end
			to_chat(user, span_warning("There is no room deploy [src] here."))
			return FALSE
		if(thing.dir != user.dir)
			continue
		to_chat(user, span_warning("There is no room deploy [src] here."))
		return FALSE
	to_chat(user, span_notice("You start deploying [src]..."))
	return TRUE

/obj/item/quickdeploy/barricade/plasteel
	thing_to_deploy = /obj/structure/deployable_barricade/metal/plasteel
	icon_state = "plasteel"

/obj/item/storage/barricade
	icon = 'modular_skyrat/modules/barricades/icons/barricade.dmi'
	name = "C.U.C.K.S box"
	desc = "Contains several deployable barricades."
	icon_state = "box_metal"
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/storage/barricade/Initialize(mapload)
	. = ..()
	atom_storage.max_total_storage = 21

/obj/item/storage/barricade/PopulateContents()
	for(var/i = 0, i < 3, i++)
		new /obj/item/quickdeploy/barricade/plasteel(src)
	for(var/i = 0, i < 9, i ++)
		new /obj/item/quickdeploy/barricade(src)
