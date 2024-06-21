
//Hydraulic clamp, Kill clamp, Extinguisher, RCD, Cable layer.


/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp
	name = "hydraulic clamp"
	desc = "Equipment for engineering exosuits. Lifts objects and loads them into cargo."
	icon_state = "mecha_clamp"
	equip_cooldown = 15
	energy_drain = 0.01 * STANDARD_CELL_CHARGE
	tool_behaviour = TOOL_RETRACTOR
	range = MECHA_MELEE
	toolspeed = 0.8
	harmful = TRUE
	mech_flags = EXOSUIT_MODULE_RIPLEY
	///Bool for whether we beat the hell out of things we punch (and tear off their arms)
	var/killer_clamp = TRUE
	///How much base damage this clamp does
	var/clamp_damage = 20
	///Var for the chassis we are attached to, needed to access ripley contents and such
	var/obj/vehicle/sealed/mecha/ripley/cargo_holder
	///Audio for using the hydraulic clamp
	var/clampsound = 'sound/mecha/hydraulic.ogg'
	///Chassis but typed for the cargo_hold var
	var/obj/vehicle/sealed/mecha/ripley/workmech

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/attach(obj/vehicle/sealed/mecha/new_mecha)
	. = ..()
	workmech = chassis
	ADD_TRAIT(chassis, TRAIT_OREBOX_FUNCTIONAL, TRAIT_MECH_EQUIPMENT(type))

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/detach(atom/moveto)
	REMOVE_TRAIT(chassis, TRAIT_OREBOX_FUNCTIONAL, TRAIT_MECH_EQUIPMENT(type))
	workmech = null
	return ..()

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/action(mob/living/source, atom/target, list/modifiers)
	if(!action_checks(target))
		return
	if(!workmech.cargo_hold)
		CRASH("Mech [chassis] has a clamp device, but no internal storage. This should be impossible.")
	if(ismecha(target))
		var/obj/vehicle/sealed/mecha/M = target
		var/have_ammo
		for(var/obj/item/mecha_ammo/box in workmech.cargo_hold.contents)
			if(istype(box, /obj/item/mecha_ammo) && box.rounds)
				have_ammo = TRUE
				if(M.ammo_resupply(box, source, TRUE))
					return
		if(have_ammo)
			to_chat(source, "No further supplies can be provided to [M].")
		else
			to_chat(source, "No providable supplies found in cargo hold")

	else if(isobj(target))
		var/obj/clamptarget = target
		if(istype(clamptarget, /obj/machinery/door/firedoor))
			var/obj/machinery/door/firedoor/targetfiredoor = clamptarget
			playsound(chassis, clampsound, 50, FALSE, -6)
			targetfiredoor.try_to_crowbar(src, source)
			return
		if(istype(clamptarget, /obj/machinery/door/airlock/))
			var/obj/machinery/door/airlock/targetairlock = clamptarget
			playsound(chassis, clampsound, 50, FALSE, -6)
			targetairlock.try_to_crowbar(src, source, TRUE)
			return
		if(clamptarget.anchored)
			to_chat(source, "[icon2html(src, source)][span_warning("[target] is firmly secured!")]")
			return
		if(workmech.cargo_hold.contents.len >= workmech.cargo_hold.cargo_capacity)
			to_chat(source, "[icon2html(src, source)][span_warning("Not enough room in cargo compartment!")]")
			return
		playsound(chassis, clampsound, 50, FALSE, -6)
		chassis.visible_message(span_notice("[chassis] lifts [target] and starts to load it into cargo compartment."))
		clamptarget.set_anchored(TRUE)
		if(!do_after_cooldown(target, source))
			clamptarget.set_anchored(initial(clamptarget.anchored))
			return
		clamptarget.forceMove(workmech.cargo_hold)
		clamptarget.set_anchored(FALSE)
		if(!chassis.ore_box && istype(clamptarget, /obj/structure/ore_box))
			chassis.ore_box = clamptarget
		to_chat(source, "[icon2html(src, source)][span_notice("[target] successfully loaded.")]")
		log_message("Loaded [clamptarget]. Cargo compartment capacity: [workmech.cargo_hold.cargo_capacity - workmech.cargo_hold.contents.len]", LOG_MECHA)

	else if(isliving(target))
		var/mob/living/M = target
		if(M.stat == DEAD)
			return

		if(!source.combat_mode)
			step_away(M,chassis)
			if(killer_clamp)
				target.visible_message(span_danger("[chassis] tosses [target] like a piece of paper!"), \
					span_userdanger("[chassis] tosses you like a piece of paper!"))
			else
				to_chat(source, "[icon2html(src, source)][span_notice("You push [target] out of the way.")]")
				chassis.visible_message(span_notice("[chassis] pushes [target] out of the way."), \
				span_notice("[chassis] pushes you aside."))
			return ..()

		/*else if(LAZYACCESS(modifiers, RIGHT_CLICK) && iscarbon(M))//meme clamp here
			if(!killer_clamp)
				to_chat(source, span_notice("You longingly wish to tear [M]'s arms off."))
				return
			var/mob/living/carbon/C = target
			var/torn_off = FALSE
			var/obj/item/bodypart/affected = C.get_bodypart(BODY_ZONE_L_ARM)
			if(affected != null)
				affected.dismember(damtype)
				torn_off = TRUE
			affected = C.get_bodypart(BODY_ZONE_R_ARM)
			if(affected != null)
				affected.dismember(damtype)
				torn_off = TRUE
			if(!torn_off)
				to_chat(source, span_notice("[M]'s arms are already torn off, you must find a challenger worthy of the kill clamp!"))
				return
			playsound(src, get_dismember_sound(), 80, TRUE)
			target.visible_message(span_danger("[chassis] rips [target]'s arms off!"), \
						span_userdanger("[chassis] rips your arms off!"))
			log_combat(source, M, "removed both arms with a real clamp,", "[name]", "(COMBAT MODE: [uppertext(source.combat_mode)] (DAMTYPE: [uppertext(damtype)])")
			return ..()
*/	// SKYRAT REMOVAL - No instant arm-removals.
		M.take_overall_damage(clamp_damage)
		if(!M) //get gibbed stoopid
			return
		M.adjustOxyLoss(round(clamp_damage/2))
		M.updatehealth()
		target.visible_message(span_danger("[chassis] squeezes [target]!"), \
							span_userdanger("[chassis] squeezes you!"),\
							span_hear("You hear something crack."))
		log_combat(source, M, "attacked", "[name]", "(Combat mode: [source.combat_mode ? "On" : "Off"]) (DAMTYPE: [uppertext(damtype)])")
	return ..()



//This is pretty much just for the death-ripley
/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/kill
	name = "\improper KILL CLAMP"
	desc = "They won't know what clamped them! This time for real!"
	killer_clamp = TRUE

/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/kill/fake//harmless fake for pranks
	desc = "They won't know what clamped them!"
	energy_drain = 0
	clamp_damage = 0
	killer_clamp = FALSE

/obj/item/mecha_parts/mecha_equipment/extinguisher
	name = "exosuit extinguisher"
	desc = "Equipment for engineering exosuits. A rapid-firing high capacity fire extinguisher."
	icon_state = "mecha_exting"
	equip_cooldown = 5
	energy_drain = 0
	equipment_slot = MECHA_UTILITY
	range = MECHA_MELEE|MECHA_RANGED
	mech_flags = EXOSUIT_MODULE_WORKING
	///Minimum amount of reagent needed to activate.
	var/required_amount = 80

/obj/item/mecha_parts/mecha_equipment/extinguisher/Initialize(mapload)
	. = ..()
	create_reagents(400)
	reagents.add_reagent(/datum/reagent/water, 400)

/obj/item/mecha_parts/mecha_equipment/extinguisher/proc/spray_extinguisher(mob/user)
	if(reagents.total_volume < required_amount)
		return

	for(var/turf/targetturf in RANGE_TURFS(1, chassis))
		var/obj/effect/particle_effect/water/extinguisher/water = new /obj/effect/particle_effect/water/extinguisher(targetturf)
		var/datum/reagents/water_reagents = new /datum/reagents(required_amount/8) //required_amount/8, because the water usage is split between eight sprays. As of this comment, required_amount/8 = 10u each.
		water.reagents = water_reagents
		water_reagents.my_atom = water
		reagents.trans_to(water, required_amount / 8)
		water.move_at(get_step(chassis, get_dir(targetturf, chassis)), 2, 4) //Target is the tile opposite of the mech as the starting turf.

	playsound(chassis, 'sound/effects/extinguish.ogg', 75, TRUE, -3)


/**
 * Handles attemted refills of the extinguisher.
 *
 * The mech can only refill an extinguisher that is in front of it.
 * Only water tank objects can be used.
 */
/obj/item/mecha_parts/mecha_equipment/extinguisher/proc/attempt_refill(mob/user)
	if(reagents.maximum_volume == reagents.total_volume)
		return
	var/turf/in_front = get_step(chassis, chassis.dir)
	var/obj/structure/reagent_dispensers/watertank/refill_source = locate(/obj/structure/reagent_dispensers/watertank) in in_front
	if(!refill_source)
		to_chat(user, span_notice("Refill failed. No compatible tank found."))
		return
	if(!refill_source.reagents?.total_volume)
		to_chat(user, span_notice("Refill failed. Source tank empty."))
		return

	refill_source.reagents.trans_to(src, reagents.maximum_volume)
	playsound(chassis, 'sound/effects/refill.ogg', 50, TRUE, -6)

/obj/item/mecha_parts/mecha_equipment/extinguisher/get_snowflake_data()
	return list(
		"snowflake_id" = MECHA_SNOWFLAKE_ID_EXTINGUISHER,
		"reagents" = reagents.total_volume,
		"total_reagents" = reagents.maximum_volume,
		"reagents_required" = required_amount,
	)

/obj/item/mecha_parts/mecha_equipment/extinguisher/handle_ui_act(action, list/params)
	switch(action)
		if("activate")
			spray_extinguisher(usr)
			return TRUE
		if("refill")
			attempt_refill(usr)
			return TRUE

/obj/item/mecha_parts/mecha_equipment/rcd
	name = "mounted RCD"
	desc = "An exosuit-mounted Rapid Construction Device."
	icon_state = "mecha_rcd"
	equip_cooldown = 0 // internal RCD already handles it
	energy_drain = 0 // internal RCD handles power consumption based on matter use
	range = MECHA_MELEE|MECHA_RANGED
	item_flags = NO_MAT_REDEMPTION
	///Maximum range the RCD can construct at.
	var/rcd_range = 3
	///Whether or not to deconstruct instead.
	var/deconstruct_active = FALSE
	///The type of internal RCD this equipment uses.
	var/rcd_type = /obj/item/construction/rcd/exosuit
	///The internal RCD item used by this equipment.
	var/obj/item/construction/rcd/internal_rcd

/obj/item/mecha_parts/mecha_equipment/rcd/Initialize(mapload)
	. = ..()
	internal_rcd = new rcd_type(src)
	GLOB.rcd_list += src

/obj/item/mecha_parts/mecha_equipment/rcd/Destroy()
	GLOB.rcd_list -= src
	qdel(internal_rcd)
	return ..()

/obj/item/mecha_parts/mecha_equipment/rcd/get_snowflake_data()
	return list(
		"snowflake_id" = MECHA_SNOWFLAKE_ID_RCD,
		"scan_ready" = COOLDOWN_FINISHED(internal_rcd, destructive_scan_cooldown),
		"deconstructing" = deconstruct_active,
		"mode" = internal_rcd.design_title,
	)

/// Set the RCD's owner when attaching and detaching it
/obj/item/mecha_parts/mecha_equipment/rcd/attach(obj/vehicle/sealed/mecha/new_mecha, attach_right)
	internal_rcd.owner = new_mecha
	return ..()

/obj/item/mecha_parts/mecha_equipment/rcd/detach(atom/moveto)
	internal_rcd.owner = null
	return ..()

/obj/item/mecha_parts/mecha_equipment/rcd/handle_ui_act(action, list/params)
	switch(action)
		if("rcd_scan")
			if(!COOLDOWN_FINISHED(internal_rcd, destructive_scan_cooldown))
				return FALSE
			rcd_scan(internal_rcd)
			COOLDOWN_START(internal_rcd, destructive_scan_cooldown, RCD_DESTRUCTIVE_SCAN_COOLDOWN)
			return TRUE
		if("toggle_deconstruct")
			deconstruct_active = !deconstruct_active
			return TRUE
		if("change_mode")
			for(var/mob/driver as anything in chassis.return_drivers())
				internal_rcd.ui_interact(driver)
			return TRUE

/obj/item/mecha_parts/mecha_equipment/rcd/action(mob/source, atom/target, list/modifiers)
	if(!action_checks(target))
		return
	if(get_dist(chassis, target) > rcd_range)
		balloon_alert(source, "out of range!")
		return
	if(!internal_rcd) // if it somehow went missing
		internal_rcd = new rcd_type(src)
		stack_trace("Exosuit-mounted RCD had no internal RCD!")
	..() // do this now because the do_after can take a while
	var/construction_mode = internal_rcd.mode
	if(deconstruct_active) // deconstruct isn't in the RCD menu so switch it to deconstruct mode and set it back when it's done
		internal_rcd.mode = RCD_DECONSTRUCT
	internal_rcd.rcd_create(target, source)
	internal_rcd.mode = construction_mode
	return TRUE

/obj/item/mecha_parts/mecha_equipment/rcd/attackby(obj/item/attacking_item, mob/user, params)
	if(istype(attacking_item, /obj/item/rcd_upgrade))
		internal_rcd.install_upgrade(attacking_item, user)
		return
	return ..()

//Dunno where else to put this so shrug
/obj/item/mecha_parts/mecha_equipment/ripleyupgrade
	name = "Ripley MK-II Conversion Kit"
	desc = "A pressurized canopy attachment kit for an Autonomous Power Loader Unit \"Ripley\" MK-I exosuit, to convert it to the slower, but space-worthy MK-II design. This kit cannot be removed, once applied."
	icon_state = "ripleyupgrade"
	mech_flags = EXOSUIT_MODULE_RIPLEY
	var/result = /obj/vehicle/sealed/mecha/ripley/mk2

/obj/item/mecha_parts/mecha_equipment/ripleyupgrade/can_attach(obj/vehicle/sealed/mecha/ripley/mecha, attach_right = FALSE, mob/user)
	if(mecha.type != /obj/vehicle/sealed/mecha/ripley)
		to_chat(user, span_warning("This conversion kit can only be applied to APLU MK-I models."))
		return FALSE
	var/obj/vehicle/sealed/mecha/ripley/workmech = mecha
	if(LAZYLEN(workmech.cargo_hold))
		to_chat(user, span_warning("[mecha]'s cargo hold must be empty before this conversion kit can be applied."))
		return FALSE
	if(!(mecha.mecha_flags & PANEL_OPEN)) //non-removable upgrade, so lets make sure the pilot or owner has their say.
		to_chat(user, span_warning("[mecha] panel must be open in order to allow this conversion kit."))
		return FALSE
	if(LAZYLEN(mecha.occupants)) //We're actualy making a new mech and swapping things over, it might get weird if players are involved
		to_chat(user, span_warning("[mecha] must be unoccupied before this conversion kit can be applied."))
		return FALSE
	if(!mecha.cell) //Turns out things break if the cell is missing
		to_chat(user, span_warning("The conversion process requires a cell installed."))
		return FALSE
	return TRUE

/obj/item/mecha_parts/mecha_equipment/ripleyupgrade/attach(obj/vehicle/sealed/mecha/markone, attach_right = FALSE)
	var/obj/vehicle/sealed/mecha/newmech = new result(get_turf(markone),1)
	if(!newmech)
		return
	QDEL_NULL(newmech.cell)
	if (markone.cell)
		newmech.cell = markone.cell
		markone.cell.forceMove(newmech)
		markone.cell = null
	QDEL_NULL(newmech.scanmod)
	if (markone.scanmod)
		newmech.scanmod = markone.scanmod
		markone.scanmod.forceMove(newmech)
		markone.scanmod = null
	QDEL_NULL(newmech.capacitor)
	if (markone.capacitor)
		newmech.capacitor = markone.capacitor
		markone.capacitor.forceMove(newmech)
		markone.capacitor = null
	QDEL_NULL(newmech.servo)
	if (markone.servo)
		newmech.servo = markone.servo
		markone.servo.forceMove(newmech)
		markone.servo = null
	newmech.update_part_values()
	for(var/obj/item/mecha_parts/mecha_equipment/equipment in markone.flat_equipment) //Move the equipment over...
		if(istype(equipment, /obj/item/mecha_parts/mecha_equipment/ejector))
			continue //the new mech already has one.
		var/righthandgun = markone.equip_by_category[MECHA_R_ARM] == equipment
		equipment.detach(newmech)
		equipment.attach(newmech, righthandgun)
	newmech.dna_lock = markone.dna_lock
	newmech.mecha_flags |= markone.mecha_flags & ~initial(markone.mecha_flags) // transfer any non-inherent flags like PANEL_OPEN and LIGHTS_ON
	newmech.set_light_on(newmech.mecha_flags & LIGHTS_ON) // in case the lights were on
	newmech.strafe = markone.strafe
	//Integ set to the same percentage integ as the old mecha, rounded to be whole number
	newmech.update_integrity(round((markone.get_integrity() / markone.max_integrity) * newmech.get_integrity()))
	if(markone.name != initial(markone.name))
		newmech.name = markone.name
	markone.wreckage = FALSE
	if(HAS_TRAIT(markone, TRAIT_MECHA_CREATED_NORMALLY))
		ADD_TRAIT(newmech, TRAIT_MECHA_CREATED_NORMALLY, newmech)
	qdel(markone)
	playsound(get_turf(newmech),'sound/items/ratchet.ogg',50,TRUE)

/obj/item/mecha_parts/mecha_equipment/ripleyupgrade/paddy
	name = "Paddy Conversion Kit"
	desc = "A hardpoint modification kit for an Autonomous Power Loader Unit \"Ripley\" MK-I exosuit, to convert it to the Paddy lightweight security design. This kit cannot be removed, once applied."
	icon_state = "paddyupgrade"
	mech_flags = EXOSUIT_MODULE_RIPLEY
	result = /obj/vehicle/sealed/mecha/ripley/paddy

/obj/item/mecha_parts/mecha_equipment/ripleyupgrade/paddy/can_attach(obj/vehicle/sealed/mecha/ripley/mecha, attach_right = FALSE, mob/user)
	if(mecha.equip_by_category[MECHA_L_ARM] || mecha.equip_by_category[MECHA_R_ARM]) //Paddys can't use RIPLEY-type equipment
		to_chat(user, span_warning("This kit cannot be applied with hardpoint equipment attached."))
		return FALSE
	return ..()
