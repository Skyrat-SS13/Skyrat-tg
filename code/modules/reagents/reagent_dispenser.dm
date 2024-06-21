#define REAGENT_SPILL_DIVISOR 200

/obj/structure/reagent_dispensers
	name = "Dispenser"
	desc = "..."
	icon = 'icons/obj/medical/chemical_tanks.dmi'
	icon_state = "water"
	density = TRUE
	anchored = FALSE
	pressure_resistance = 2*ONE_ATMOSPHERE
	max_integrity = 300
	/// In units, how much the dispenser can hold
	var/tank_volume = 1000
	/// The ID of the reagent that the dispenser uses
	var/reagent_id = /datum/reagent/water
	/// Can you turn this into a plumbing tank?
	var/can_be_tanked = TRUE
	/// Is this source self-replenishing?
	var/refilling = FALSE
	/// Can this dispenser be opened using a wrench?
	var/openable = FALSE
	/// Is this dispenser slowly leaking its reagent?
	var/leaking = FALSE
	/// How much reagent to leak
	var/amount_to_leak = 10
	/// An assembly attached to the tank - if this dispenser accepts_rig
	var/obj/item/assembly_holder/rig = null
	/// Whether this dispenser can be rigged with an assembly (and blown up with an igniter)
	var/accepts_rig = FALSE
	//overlay of attached assemblies
	var/mutable_appearance/assembliesoverlay
	/// The person who attached an assembly to this dispenser, for bomb logging purposes
	var/last_rigger = ""
	/// is it climbable? some of our wall-mounted dispensers should not have this
	var/climbable = FALSE

// This check is necessary for assemblies to automatically detect that we are compatible
/obj/structure/reagent_dispensers/IsSpecialAssembly()
	return accepts_rig

/obj/structure/reagent_dispensers/Destroy()
	QDEL_NULL(rig)
	return ..()

/**
 * rig_boom: Wrapper to log when a reagent_dispenser is set off by an assembly
 *
 */
/obj/structure/reagent_dispensers/proc/rig_boom()
	log_bomber(last_rigger, "rigged [src] exploded", src)
	boom()

/obj/structure/reagent_dispensers/Initialize(mapload)
	. = ..()

	if(icon_state == "water" && check_holidays(APRIL_FOOLS))
		icon_state = "water_fools"
	if(climbable)
		AddElement(/datum/element/climbable, climb_time = 4 SECONDS, climb_stun = 4 SECONDS)
		AddElement(/datum/element/elevation, pixel_shift = 14)

/obj/structure/reagent_dispensers/examine(mob/user)
	. = ..()
	if(can_be_tanked)
		. += span_notice("Use a sheet of iron to convert this into a plumbing-compatible tank.")
	if(openable)
		if(!leaking)
			. += span_notice("Its tap looks like it could be <b>wrenched</b> open.")
		else
			. += span_warning("Its tap is <b>wrenched</b> open!")
	if(accepts_rig && get_dist(user, src) <= 2)
		if(rig)
			. += span_warning("There is some kind of device <b>rigged</b> to the tank!")
		else
			. += span_notice("It looks like you could <b>rig</b> a device to the tank.")


/obj/structure/reagent_dispensers/take_damage(damage_amount, damage_type = BRUTE, damage_flag = 0, sound_effect = 1, attack_dir)
	. = ..()
	if(. && atom_integrity > 0)
		if(tank_volume && (damage_flag == BULLET || damage_flag == LASER))
			//SKYRAT EDIT CHANGE
			var/guaranteed_violent = (damage_flag == BULLET || damage_flag == LASER)
			boom(damage_type, guaranteed_violent)
			//SKYRAT EDIT END

/obj/structure/reagent_dispensers/attackby(obj/item/W, mob/user, params)
	if(W.is_refillable())
		return FALSE //so we can refill them via their afterattack.
	if(istype(W, /obj/item/assembly_holder) && accepts_rig)
		if(rig)
			balloon_alert(user, "another device is in the way!")
			return ..()
		var/obj/item/assembly_holder/holder = W
		if(!(locate(/obj/item/assembly/igniter) in holder.assemblies))
			return ..()

		user.balloon_alert_to_viewers("attaching rig...")
		add_fingerprint(user)
		if(!do_after(user, 2 SECONDS, target = src) || !user.transferItemToLoc(holder, src))
			return
		rig = holder
		holder.master = src
		holder.on_attach()
		assembliesoverlay = holder
		assembliesoverlay.pixel_x += 6
		assembliesoverlay.pixel_y += 1
		add_overlay(assembliesoverlay)
		RegisterSignal(src, COMSIG_IGNITER_ACTIVATE, PROC_REF(rig_boom))
		log_bomber(user, "attached [holder.name] to ", src)
		last_rigger = user
		user.balloon_alert_to_viewers("attached rig")
		return

	if(istype(W, /obj/item/stack/sheet/iron) && can_be_tanked)
		var/obj/item/stack/sheet/iron/metal_stack = W
		metal_stack.use(1)
		var/obj/structure/reagent_dispensers/plumbed/storage/new_tank = new /obj/structure/reagent_dispensers/plumbed/storage(drop_location())
		new_tank.reagents.maximum_volume = reagents.maximum_volume
		reagents.trans_to(new_tank, reagents.total_volume)
		new_tank.name = "stationary [name]"
		new_tank.update_appearance(UPDATE_OVERLAYS)
		new_tank.set_anchored(anchored)
		qdel(src)
		return FALSE

	return ..()

/obj/structure/reagent_dispensers/Exited(atom/movable/gone, direction)
	. = ..()
	if(gone == rig)
		rig = null

/obj/structure/reagent_dispensers/attack_hand(mob/user, list/modifiers)
	. = ..()
	if(. || !rig)
		return
	// mousetrap rigs only make sense if you can set them off, can't step on them
	// If you see a mousetrap-rigged fuel tank, just leave it alone
	rig.on_found()
	if(QDELETED(src))
		return
	user.balloon_alert_to_viewers("detaching rig...")
	if(!do_after(user, 2 SECONDS, target = src))
		return
	user.balloon_alert_to_viewers("detached rig")
	user.log_message("detached [rig] from [src].", LOG_GAME)
	if(!user.put_in_hands(rig))
		rig.forceMove(get_turf(user))
	rig = null
	last_rigger = null
	cut_overlays(assembliesoverlay)
	UnregisterSignal(src, COMSIG_IGNITER_ACTIVATE)

/obj/structure/reagent_dispensers/Initialize(mapload)
	create_reagents(tank_volume, DRAINABLE | AMOUNT_VISIBLE)
	if(reagent_id)
		reagents.add_reagent(reagent_id, tank_volume)
	. = ..()

/**
 * boom: Detonate a reagent dispenser.
 *
 * This is most dangerous for fuel tanks, which will explosion().
 * Other dispensers will scatter their contents within range.
 */
/obj/structure/reagent_dispensers/proc/boom(damage_type = BRUTE, guaranteed_violent = FALSE) //SKYRAT EDIT CHANGE
	if(QDELETED(src))
		return // little bit of sanity sauce before we wreck ourselves somehow
	var/datum/reagent/fuel/volatiles = reagents.has_reagent(/datum/reagent/fuel)
	var/fuel_amt = 0
	if(istype(volatiles) && volatiles.volume >= 25)
		fuel_amt = volatiles.volume
		reagents.del_reagent(/datum/reagent/fuel) // not actually used for the explosion
	if(reagents.total_volume)
		if(!fuel_amt)
			visible_message(span_danger("\The [src] ruptures!"))
		// Leave it up to future terrorists to figure out the best way to mix reagents with fuel for a useful boom here
		chem_splash(loc, null, 2 + (reagents.total_volume + fuel_amt) / 1000, list(reagents), extra_heat=(fuel_amt / 50),adminlog=(fuel_amt<25))

	if(fuel_amt) // with that done, actually explode
		visible_message(span_danger("\The [src] explodes!"))
		// old code for reference:
		// standard fuel tank = 1000 units = heavy_impact_range = 1, light_impact_range = 5, flame_range = 5
		// big fuel tank = 5000 units = devastation_range = 1, heavy_impact_range = 2, light_impact_range = 7, flame_range = 12
		// It did not account for how much fuel was actually in the tank at all, just the size of the tank.
		// I encourage others to better scale these numbers in the future.
		// As it stands this is a minor nerf in exchange for an easy bombing technique working that has been broken for a while.
		switch(fuel_amt)
			if(25 to 150)
				explosion(src, light_impact_range = 1, flame_range = 2)
			if(150 to 300)
				explosion(src, light_impact_range = 2, flame_range = 3)
			if(300 to 750)
				explosion(src, heavy_impact_range = 1, light_impact_range = 3, flame_range = 5)
			if(750 to 1500)
				explosion(src, heavy_impact_range = 1, light_impact_range = 4, flame_range = 6)
			if(1500 to INFINITY)
				explosion(src, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 6, flame_range = 8)
	qdel(src)

/obj/structure/reagent_dispensers/atom_deconstruct(disassembled = TRUE)
	if(!disassembled)
		boom()

/obj/structure/reagent_dispensers/proc/tank_leak()
	if(leaking && reagents && reagents.total_volume >= amount_to_leak)
		reagents.expose(get_turf(src), TOUCH, amount_to_leak / max(amount_to_leak, reagents.total_volume))
		reagents.remove_reagent(reagent_id, amount_to_leak)
		return TRUE
	return FALSE

/obj/structure/reagent_dispensers/proc/knock_down()
	var/datum/effect_system/fluid_spread/smoke/chem/smoke = new ()
	var/range = reagents.total_volume / REAGENT_SPILL_DIVISOR
	smoke.attach(drop_location())
	smoke.set_up(round(range), holder = drop_location(), location = drop_location(), carry = reagents, silent = FALSE)
	smoke.start(log = TRUE)
	reagents.clear_reagents()
	qdel(src)

/obj/structure/reagent_dispensers/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	if(!openable)
		return FALSE
	leaking = !leaking
	balloon_alert(user, "[leaking ? "opened" : "closed"] [src]'s tap")
	user.log_message("[leaking ? "opened" : "closed"] [src].", LOG_GAME)
	tank_leak()
	return ITEM_INTERACT_SUCCESS

/obj/structure/reagent_dispensers/Moved(atom/old_loc, movement_dir, forced, list/old_locs, momentum_change = TRUE)
	. = ..()
	tank_leak()

/obj/structure/reagent_dispensers/watertank
	name = "water tank"
	desc = "A water tank."
	icon_state = "water"
	openable = TRUE
	climbable = TRUE

/obj/structure/reagent_dispensers/watertank/high
	name = "high-capacity water tank"
	desc = "A highly pressurized water tank made to hold gargantuan amounts of water."
	icon_state = "water_high" //I was gonna clean my room...
	tank_volume = 3000

/obj/structure/reagent_dispensers/foamtank//SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "firefighting foam tank"
	desc = "A tank full of firefighting foam."
	icon_state = "foam"
	reagent_id = /datum/reagent/firefighting_foam
	tank_volume = 500
	openable = TRUE
	climbable = TRUE

/obj/structure/reagent_dispensers/fueltank//SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "fuel tank"
	desc = "A tank full of industrial welding fuel. Do not consume."
	icon_state = "fuel"
	reagent_id = /datum/reagent/fuel
	openable = TRUE
	accepts_rig = TRUE
	climbable = TRUE

/obj/structure/reagent_dispensers/fueltank/Initialize(mapload)
	. = ..()

	if(check_holidays(APRIL_FOOLS))
		icon_state = "fuel_fools"

/obj/structure/reagent_dispensers/fueltank/boom(damage_type = BRUTE, guaranteed_violent = FALSE) //SKYRAT EDIT CHANGE
	if(damage_type == BURN || guaranteed_violent)
		explosion(src, heavy_impact_range = 1, light_impact_range = 5, flame_range = 5)
		qdel(src)
	else
		. = ..()
	//SKYRAT EDIT END

/obj/structure/reagent_dispensers/fueltank/blob_act(obj/structure/blob/B)
	boom(guaranteed_violent = TRUE) //SKYRAT EDIT CHANGE

/obj/structure/reagent_dispensers/fueltank/ex_act()
	boom(guaranteed_violent = TRUE) //SKYRAT EDIT CHANGE
	return TRUE

/obj/structure/reagent_dispensers/fueltank/fire_act(exposed_temperature, exposed_volume)
	boom(guaranteed_violent = TRUE) //SKYRAT EDIT CHANGE

/obj/structure/reagent_dispensers/fueltank/zap_act(power, zap_flags)
	. = ..() //extend the zap
	if(ZAP_OBJ_DAMAGE & zap_flags)
		boom(guaranteed_violent = TRUE) //SKYRAT EDIT CHANGE

/obj/structure/reagent_dispensers/fueltank/bullet_act(obj/projectile/hitting_projectile)
	if(hitting_projectile.damage > 0 && ((hitting_projectile.damage_type == BURN) || (hitting_projectile.damage_type == BRUTE)))
		log_bomber(hitting_projectile.firer, "detonated a", src, "via projectile")
		boom(guaranteed_violent = TRUE) // SKYRAT EDIT CHANGE
		return hitting_projectile.on_hit(src, 0)

	// we override parent like this because otherwise we won't actually properly log the fact that a projectile caused this welding tank to explode.
	// if this sucks, feel free to change it, but make sure the damn thing will log. thanks.
	return ..()

/obj/structure/reagent_dispensers/fueltank/attackby(obj/item/I, mob/living/user, params)
	if(I.tool_behaviour == TOOL_WELDER)
		if(!reagents.has_reagent(/datum/reagent/fuel))
			to_chat(user, span_warning("[src] is out of fuel!"))
			return
		var/obj/item/weldingtool/W = I
		if(istype(W) && !W.welding)
			if(W.reagents.has_reagent(/datum/reagent/fuel, W.max_fuel))
				to_chat(user, span_warning("Your [W.name] is already full!"))
				return
			reagents.trans_to(W, W.max_fuel, transferred_by = user)
			user.visible_message(span_notice("[user] refills [user.p_their()] [W.name]."), span_notice("You refill [W]."))
			playsound(src, 'sound/effects/refill.ogg', 50, TRUE)
			W.update_appearance()
		else
			user.visible_message(span_danger("[user] catastrophically fails at refilling [user.p_their()] [I.name]!"), span_userdanger("That was stupid of you."))
			log_bomber(user, "detonated a", src, "via welding tool")
			boom(guaranteed_violent = TRUE) //SKYRAT EDIT CHANGE
		return

	return ..()

/obj/structure/reagent_dispensers/fueltank/large
	name = "high capacity fuel tank"
	desc = "A tank full of a high quantity of welding fuel. Keep away from open flames."
	icon_state = "fuel_high"
	tank_volume = 5000

/obj/structure/reagent_dispensers/fueltank/large/boom(damage_type = BRUTE, guaranteed_violent = FALSE) //SKYRAT EDIT CHANGE
	if(damage_type == BURN || guaranteed_violent)
		explosion(src, devastation_range = 1, heavy_impact_range = 2, light_impact_range = 7, flame_range = 12)
		qdel(src)
	else
		. = ..()
	//SKYRAT EDIT END

/// Wall mounted dispeners, like pepper spray or virus food. Not a normal tank, and shouldn't be able to be turned into a plumbed stationary one.
/obj/structure/reagent_dispensers/wall
	anchored = TRUE
	density = FALSE
	can_be_tanked = FALSE

/obj/structure/reagent_dispensers/wall/peppertank
	name = "pepper spray refiller"
	desc = "Contains condensed capsaicin for use in law \"enforcement.\""
	icon_state = "pepper"
	reagent_id = /datum/reagent/consumable/condensedcapsaicin

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/reagent_dispensers/wall/peppertank, 30)

/obj/structure/reagent_dispensers/wall/peppertank/Initialize(mapload)
	. = ..()
	if(prob(1))
		desc = "IT'S PEPPER TIME, BITCH!"
	find_and_hang_on_wall()

/obj/structure/reagent_dispensers/water_cooler//SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "liquid cooler"
	desc = "A machine that dispenses liquid to drink."
	icon = 'icons/obj/machines/vending.dmi'
	icon_state = "water_cooler"
	anchored = TRUE
	tank_volume = 500
	var/paper_cups = 25 //Paper cups left from the cooler

/obj/structure/reagent_dispensers/water_cooler/examine(mob/user)
	. = ..()
	if (paper_cups > 1)
		. += "There are [paper_cups] paper cups left."
	else if (paper_cups == 1)
		. += "There is one paper cup left."
	else
		. += "There are no paper cups left."

/obj/structure/reagent_dispensers/water_cooler/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(.)
		return
	if(!paper_cups)
		to_chat(user, span_warning("There aren't any cups left!"))
		return
	user.visible_message(span_notice("[user] takes a cup from [src]."), span_notice("You take a paper cup from [src]."))
	var/obj/item/reagent_containers/cup/glass/sillycup/S = new(get_turf(src))
	user.put_in_hands(S)
	paper_cups--

/obj/structure/reagent_dispensers/beerkeg
	name = "beer keg"
	desc = "Beer is liquid bread, it's good for you..."
	icon_state = "beer"
	reagent_id = /datum/reagent/consumable/ethanol/beer
	openable = TRUE

/obj/structure/reagent_dispensers/beerkeg/blob_act(obj/structure/blob/B)
	explosion(src, heavy_impact_range = 3, light_impact_range = 5, flame_range = 10, flash_range = 7)
	if(!QDELETED(src))
		qdel(src)

/obj/structure/reagent_dispensers/wall/virusfood
	name = "virus food dispenser"
	desc = "A dispenser of low-potency virus mutagenic."
	icon_state = "virus_food"
	reagent_id = /datum/reagent/consumable/virus_food

MAPPING_DIRECTIONAL_HELPERS(/obj/structure/reagent_dispensers/wall/virusfood, 30)

/obj/structure/reagent_dispensers/wall/virusfood/Initialize(mapload)
	. = ..()
	find_and_hang_on_wall()

/obj/structure/reagent_dispensers/cooking_oil
	name = "vat of cooking oil"
	desc = "A huge metal vat with a tap on the front. Filled with cooking oil for use in frying food."
	icon_state = "vat"
	anchored = TRUE
	reagent_id = /datum/reagent/consumable/nutriment/fat/oil
	openable = TRUE

/obj/structure/reagent_dispensers/servingdish
	name = "serving dish"
	desc = "A dish full of food slop for your bowl."
	icon = 'icons/obj/service/kitchen.dmi'
	icon_state = "serving"
	anchored = TRUE
	reagent_id = /datum/reagent/consumable/nutraslop

/obj/structure/reagent_dispensers/plumbed//SKYRAT EDIT - ICON OVERRIDDEN BY AESTHETICS - SEE MODULE
	name = "stationary water tank"
	anchored = TRUE
	icon_state = "water_stationary"
	desc = "A stationary, plumbed, water tank."
	can_be_tanked = FALSE

/obj/structure/reagent_dispensers/plumbed/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/plumbing/simple_supply)

/obj/structure/reagent_dispensers/plumbed/wrench_act(mob/living/user, obj/item/tool)
	. = ..()
	default_unfasten_wrench(user, tool)
	return ITEM_INTERACT_SUCCESS

/obj/structure/reagent_dispensers/plumbed/storage
	name = "stationary storage tank"
	icon_state = "tank_stationary"
	reagent_id = null //start empty

/obj/structure/reagent_dispensers/plumbed/storage/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/simple_rotation)


/obj/structure/reagent_dispensers/plumbed/storage/update_overlays()
	. = ..()
	if(!reagents)
		return

	if(!reagents.total_volume)
		return

	var/mutable_appearance/tank_color = mutable_appearance('icons/obj/medical/chemical_tanks.dmi', "tank_chem_overlay")
	tank_color.color = mix_color_from_reagents(reagents.reagent_list)
	. += tank_color

/obj/structure/reagent_dispensers/plumbed/fuel
	name = "stationary fuel tank"
	icon_state = "fuel_stationary"
	desc = "A stationary, plumbed, fuel tank."
	reagent_id = /datum/reagent/fuel
	accepts_rig = TRUE

#undef REAGENT_SPILL_DIVISOR
