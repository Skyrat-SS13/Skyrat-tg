
/**
 * Maintenance Drone
 *
 * Small player controlled fixer-upper
 *
 * The maintenace drone is a ghost role with the objective to repair and
 * maintain the station.
 *
 * Featuring two dexterous hands, and a built in toolbox stocked with
 * tools.
 *
 * They have laws to prevent them from doing anything else.
 *
 */
/mob/living/basic/drone
	name = "Drone"
	desc = "A maintenance drone, an expendable robot built to perform station repairs."
	icon = 'icons/mob/silicon/drone.dmi'
	icon_state = "drone_maint_grey"
	icon_living = "drone_maint_grey"
	icon_dead = "drone_maint_dead"
	health = 45
	maxHealth = 45
	unsuitable_atmos_damage = 0
	unsuitable_cold_damage = 0
	unsuitable_heat_damage = 0
	speed = 0
	density = FALSE
	pass_flags = PASSTABLE | PASSMOB
	sight = SEE_TURFS | SEE_OBJS
	status_flags = (CANPUSH | CANSTUN | CANKNOCKDOWN)
	gender = NEUTER
	mob_biotypes = MOB_ROBOTIC
	speak_emote = list("chirps")
	speech_span = SPAN_ROBOT
	bubble_icon = "machine"
	initial_language_holder = /datum/language_holder/drone
	mob_size = MOB_SIZE_SMALL
	has_unlimited_silicon_privilege = TRUE
	damage_coeff = list(BRUTE = 1, BURN = 1, TOX = 0, STAMINA = 0, OXY = 0)
	hud_possible = list(DIAG_STAT_HUD, DIAG_HUD, ANTAG_HUD)
	unique_name = TRUE
	faction = list(FACTION_NEUTRAL,FACTION_SILICON,FACTION_TURRET)
	hud_type = /datum/hud/dextrous/drone
	// Going for a sort of pale green here
	lighting_cutoff_red = 30
	lighting_cutoff_green = 35
	lighting_cutoff_blue = 25
	can_be_held = TRUE
	worn_slot_flags = ITEM_SLOT_HEAD
	/// `TRUE` if we have picked our visual appearance, `FALSE` otherwise (default)
	var/picked = FALSE
	/// Stored drone color, restored when unhacked
	var/colour = "grey"
	var/list/drone_overlays[DRONE_TOTAL_LAYERS]
	/// Drone laws announced on spawn
	var/laws = \
	"1. You may not involve yourself in the matters of another being, even if such matters conflict with Law Two or Law Three, unless the other being is another Drone.\n"+\
	"2. You may not harm any being, regardless of intent or circumstance.\n"+\
	"3. Your goals are to actively build, maintain, repair, improve, and provide power to the best of your abilities within the facility that housed your activation." //for derelict drones so they don't go to station.
	/// Amount of damage sustained if hit by a heavy EMP pulse
	var/heavy_emp_damage = 25
	///Alarm listener datum, handes caring about alarm events and such
	var/datum/alarm_listener/listener
	/// Internal storage slot. Fits any item
	var/obj/item/internal_storage
	/// Headwear slot
	var/obj/item/head
	/// Default [/mob/living/basic/drone/var/internal_storage] item
	var/obj/item/default_storage = /obj/item/storage/drone_tools
	/// Default [/mob/living/basic/drone/var/head] item
	var/obj/item/default_headwear
	/**
	  * icon_state of drone from icons/mobs/drone.dmi
	  *
	  * Possible states are:
	  *
	  * - [MAINTDRONE]
	  * - [REPAIRDRONE]
	  * - [SCOUTDRONE]
	  * - [CLOCKDRONE]
	  */
	var/visualAppearance = MAINTDRONE
	/// Hacked state, see [/mob/living/basic/drone/proc/update_drone_hack]
	var/hacked = FALSE
	/// Whether this drone can be un-hacked. Used for subtypes that cannot be meaningfully "fixed".
	var/can_unhack = TRUE
	/// If we have laws to minimize bothering others. Enables or disables drone laws enforcement components (use [/mob/living/basic/drone/proc/set_shy] to set)
	var/shy = TRUE
	/// Flavor text announced to drones on [/mob/proc/Login]
	var/flavortext = \
	"\n<big><span class='warning'>DO NOT INTERFERE WITH THE ROUND AS A DRONE OR YOU WILL BE DRONE BANNED</span></big>\n"+\
	"<span class='notice'>Drones are a ghost role that are allowed to fix the station and build things. Interfering with the round as a drone is against the rules.</span>\n"+\
	"<span class='notice'>Actions that constitute interference include, but are not limited to:</span>\n"+\
	"<span class='notice'>     - Interacting with round critical objects (IDs, weapons, contraband, powersinks, bombs, etc.)</span>\n"+\
	"<span class='notice'>     - Interacting with living beings (communication, attacking, healing, etc.)</span>\n"+\
	"<span class='notice'>     - Interacting with non-living beings (dragging bodies, looting bodies, etc.)</span>\n"+\
	"<span class='warning'>These rules are at admin discretion and will be heavily enforced.</span>\n"+\
	"<span class='warning'><u>If you do not have the regular drone laws, follow your laws to the best of your ability.</u></span>\n"+\
	"<span class='notice'>Prefix your message with :b to speak in Drone Chat.</span>\n"
	/// blacklisted drone areas, direct
	var/list/drone_area_blacklist_flat = list(/area/station/engineering/atmos, /area/station/engineering/atmospherics_engine)
	/// blacklisted drone areas, recursive/includes descendants
	var/list/drone_area_blacklist_recursive = list(/area/station/engineering/supermatter)
	/// blacklisted drone machines, direct
	var/list/drone_machinery_blacklist_flat
	/// blacklisted drone machines, recursive/includes descendants
	var/list/drone_machinery_blacklist_recursive = list(
		/obj/machinery/airalarm,
		/obj/machinery/computer,
		/obj/machinery/modular_computer,
	)
	/// cancels out blacklisted machines, direct
	var/list/drone_machinery_whitelist_flat
	/// cancels out blacklisted machines, recursive/includes descendants
	var/list/drone_machinery_whitelist_recursive = list(
		/obj/machinery/computer/arcade,
		/obj/machinery/computer/monitor,
		/obj/machinery/computer/pod,
		/obj/machinery/computer/station_alert,
		/obj/machinery/computer/teleporter,
	)
	/// blacklisted drone machine typecache, compiled from [var/drone_machinery_blacklist_flat], [var/list/drone_machinery_blacklist_recursive], negated by their whitelist counterparts
	var/list/drone_machinery_blacklist_compiled
	/// whitelisted drone items, direct
	var/list/drone_item_whitelist_flat = list(
		/obj/item/chisel,
		/obj/item/crowbar/drone,
		/obj/item/screwdriver/drone,
		/obj/item/wrench/drone,
		/obj/item/weldingtool/drone,
		/obj/item/wirecutters/drone,
		/obj/item/multitool/drone,
		/obj/item/pipe_dispenser,
		/obj/item/t_scanner,
		/obj/item/analyzer,
		/obj/item/rack_parts,
	)
	/// whitelisted drone items, recursive/includes descendants
	var/list/drone_item_whitelist_recursive = list(
		/obj/item/airlock_painter,
		/obj/item/circuitboard,
		/obj/item/conveyor_switch_construct,
		/obj/item/electronics,
		/obj/item/light,
		/obj/item/pipe_meter,
		/obj/item/stack/cable_coil,
		/obj/item/stack/circuit_stack,
		/obj/item/stack/conveyor,
		/obj/item/stack/pipe_cleaner_coil,
		/obj/item/stack/rods,
		/obj/item/stack/sheet,
		/obj/item/stack/tile,
		/obj/item/stack/ducts,
		/obj/item/stock_parts,
		/obj/item/toner,
		/obj/item/wallframe,
		/obj/item/clothing/head,
		/obj/item/clothing/mask,
		/obj/item/storage/box/lights,
		/obj/item/lightreplacer,
		/obj/item/construction/rcd,
		/obj/item/rcd_ammo,
		/obj/item/rcd_upgrade,
		/obj/item/storage/part_replacer,
		/obj/item/soap,
		/obj/item/holosign_creator,
	)
	/// machines whitelisted from being shy with
	var/list/shy_machine_whitelist = list(
		/obj/machinery/atmospherics/components/unary/vent_pump,
		/obj/machinery/atmospherics/components/unary/vent_scrubber,
	)

/mob/living/basic/drone/Initialize(mapload)
	. = ..()
	GLOB.drones_list += src
	AddElement(/datum/element/dextrous, hud_type = hud_type)
	AddComponent(/datum/component/basic_inhands, y_offset = getItemPixelShiftY())
	AddComponent(/datum/component/simple_access, SSid_access.get_region_access_list(list(REGION_ALL_GLOBAL)))
	AddComponent(/datum/component/personal_crafting) // Kind of hard to be a drone and not be able to make tiles

	if(default_storage)
		var/obj/item/storage = new default_storage(src)
		equip_to_slot_or_del(storage, ITEM_SLOT_DEX_STORAGE)

	for(var/holiday_name in GLOB.holidays)
		var/datum/holiday/holiday_today = GLOB.holidays[holiday_name]
		var/obj/item/potential_hat = holiday_today.holiday_hat
		if(!isnull(potential_hat) && isnull(default_headwear)) //If our drone type doesn't start with a hat, we take the holiday one.
			default_headwear = potential_hat

	if(default_headwear)
		var/obj/item/new_hat = new default_headwear(src)
		equip_to_slot_or_del(new_hat, ITEM_SLOT_HEAD)

	shy_update()

	alert_drones(DRONE_NET_CONNECT)

	for(var/datum/atom_hud/data/diagnostic/diag_hud in GLOB.huds)
		diag_hud.add_atom_to_hud(src)

	add_traits(list(TRAIT_VENTCRAWLER_ALWAYS, TRAIT_NEGATES_GRAVITY, TRAIT_LITERATE, TRAIT_KNOW_ENGI_WIRES, TRAIT_ADVANCEDTOOLUSER), INNATE_TRAIT)

	listener = new(list(ALARM_ATMOS, ALARM_FIRE, ALARM_POWER), list(z))
	RegisterSignal(listener, COMSIG_ALARM_LISTENER_TRIGGERED, PROC_REF(alarm_triggered))
	RegisterSignal(listener, COMSIG_ALARM_LISTENER_CLEARED, PROC_REF(alarm_cleared))
	listener.RegisterSignal(src, COMSIG_LIVING_DEATH, TYPE_PROC_REF(/datum/alarm_listener, prevent_alarm_changes))
	listener.RegisterSignal(src, COMSIG_LIVING_REVIVE, TYPE_PROC_REF(/datum/alarm_listener, allow_alarm_changes))

/mob/living/basic/drone/med_hud_set_health()
	var/image/holder = hud_list[DIAG_HUD]
	var/icon/hud_icon = icon(icon, icon_state, dir)
	holder.pixel_y = hud_icon.Height() - world.icon_size
	holder.icon_state = "huddiag[RoundDiagBar(health/maxHealth)]"

/mob/living/basic/drone/med_hud_set_status()
	var/image/holder = hud_list[DIAG_STAT_HUD]
	var/icon/hud_icon = icon(icon, icon_state, dir)
	holder.pixel_y = hud_icon.Height() - world.icon_size
	if(stat == DEAD)
		holder.icon_state = "huddead2"
	else if(incapacitated())
		holder.icon_state = "hudoffline"
	else
		holder.icon_state = "hudstat"

/mob/living/basic/drone/Destroy()
	GLOB.drones_list -= src
	QDEL_NULL(listener)
	return ..()

/mob/living/basic/drone/Login()
	. = ..()
	if(!. || !client)
		return FALSE
	check_laws()

	if(flavortext)
		to_chat(src, "[flavortext]")

	if(!picked)
		pickVisualAppearance()

/mob/living/basic/drone/auto_deadmin_on_login()
	if(!client?.holder)
		return TRUE
	if(CONFIG_GET(flag/auto_deadmin_silicons) || (client.prefs?.toggles & DEADMIN_POSITION_SILICON))
		return client.holder.auto_deadmin()
	return ..()

/mob/living/basic/drone/death(gibbed)
	..(gibbed)
	if(internal_storage)
		dropItemToGround(internal_storage)
	if(head)
		dropItemToGround(head)

	alert_drones(DRONE_NET_DISCONNECT)


/mob/living/basic/drone/gib()
	dust()

/mob/living/basic/drone/get_butt_sprite()
	return icon('icons/mob/butts.dmi', BUTT_SPRITE_DRONE)

/mob/living/basic/drone/examine(mob/user)
	. = list("<span class='info'>This is [icon2html(src, user)] \a <b>[src]</b>!", EXAMINE_SECTION_BREAK) //SKYRAT EDIT CHANGE

	//Hands
	for(var/obj/item/held_thing in held_items)
		if(held_thing.item_flags & (ABSTRACT|EXAMINE_SKIP|HAND_ITEM))
			continue
		. += "It has [held_thing.get_examine_string(user)] in its [get_held_index_name(get_held_index_of_item(held_thing))]."

	//Internal storage
	if(internal_storage && !(internal_storage.item_flags & ABSTRACT))
		. += "It is holding [internal_storage.get_examine_string(user)] in its internal storage."

	//Cosmetic hat - provides no function other than looks
	if(head && !(head.item_flags & ABSTRACT))
		. += "It is wearing [head.get_examine_string(user)] on its head."

	//Braindead
	if(!client && stat != DEAD)
		. += "Its status LED is blinking at a steady rate."

	//Hacked
	if(hacked)
		. += span_warning("Its display is glowing red!")

	//Damaged
	if(health != maxHealth)
		if(health > maxHealth * 0.33) //Between maxHealth and about a third of maxHealth, between 30 and 10 for normal drones
			. += span_warning("Its screws are slightly loose.")
		else //otherwise, below about 33%
			. += span_boldwarning("Its screws are very loose!")

	//Dead
	if(stat == DEAD)
		if(client)
			. += span_deadsay("A message repeatedly flashes on its display: \"REBOOT -- REQUIRED\".")
		else
			. += span_deadsay("A message repeatedly flashes on its display: \"ERROR -- OFFLINE\".")
	. += "</span>"


/mob/living/basic/drone/assess_threat(judgement_criteria, lasercolor = "", datum/callback/weaponcheck=null) //Secbots won't hunt maintenance drones.
	return -10


/mob/living/basic/drone/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	Stun(70)
	to_chat(src, span_danger("<b>ER@%R: MME^RY CO#RU9T!</b> R&$b@0tin)..."))
	if(severity == 1)
		adjustBruteLoss(heavy_emp_damage)
		to_chat(src, span_userdanger("HeAV% DA%^MMA+G TO I/O CIR!%UUT!"))

/mob/living/basic/drone/proc/alarm_triggered(datum/source, alarm_type, area/source_area)
	SIGNAL_HANDLER
	to_chat(src, "--- [alarm_type] alarm detected in [source_area.name]!")

/mob/living/basic/drone/proc/alarm_cleared(datum/source, alarm_type, area/source_area)
	SIGNAL_HANDLER
	to_chat(src, "--- [alarm_type] alarm in [source_area.name] has been cleared.")

/mob/living/basic/drone/proc/blacklist_on_try_use_machine(datum/source, obj/machinery/machine)
	SIGNAL_HANDLER
	if(GLOB.drone_machine_blacklist_enabled && is_type_in_typecache(machine, drone_machinery_blacklist_compiled))
		to_chat(src, span_warning("Using [machine] could break your laws."))
		return COMPONENT_CANT_USE_MACHINE_INTERACT | COMPONENT_CANT_USE_MACHINE_TOOLS

/mob/living/basic/drone/proc/blacklist_on_try_wires_interact(datum/source, atom/machine)
	SIGNAL_HANDLER
	if(GLOB.drone_machine_blacklist_enabled && is_type_in_typecache(machine, drone_machinery_blacklist_compiled))
		to_chat(src, span_warning("Using [machine] could break your laws."))
		return COMPONENT_CANT_INTERACT_WIRES


/mob/living/basic/drone/proc/set_shy(new_shy)
	shy = new_shy
	shy_update()

/mob/living/basic/drone/proc/shy_update()
	var/list/drone_bad_areas = make_associative(drone_area_blacklist_flat) + typecacheof(drone_area_blacklist_recursive)
	var/list/drone_good_items = make_associative(drone_item_whitelist_flat) + typecacheof(drone_item_whitelist_recursive)

	var/list/drone_bad_machinery = make_associative(drone_machinery_blacklist_flat) + typecacheof(drone_machinery_blacklist_recursive)
	var/list/drone_good_machinery = LAZYCOPY(drone_machinery_whitelist_flat) + typecacheof(drone_machinery_whitelist_recursive) // not a valid typecache, only intended for negation against drone_bad_machinery
	drone_machinery_blacklist_compiled = drone_bad_machinery - drone_good_machinery

	var/static/list/not_shy_of = typecacheof(list(/mob/living/basic/drone, /mob/living/simple_animal/bot))
	if(shy)
		REMOVE_TRAIT(src, TRAIT_CAN_STRIP, DRONE_SHY_TRAIT) // To shy to touch someone elses hat
		ADD_TRAIT(src, TRAIT_PACIFISM, DRONE_SHY_TRAIT)
		LoadComponent(/datum/component/shy, mob_whitelist=not_shy_of, shy_range=3, message="Your laws prevent this action near %TARGET.", keyless_shy=FALSE, clientless_shy=TRUE, dead_shy=FALSE, dead_shy_immediate=TRUE, machine_whitelist=shy_machine_whitelist)
		LoadComponent(/datum/component/shy_in_room, drone_bad_areas, "Touching anything in %ROOM could break your laws.")
		LoadComponent(/datum/component/technoshy, 1 MINUTES, "%TARGET was touched by a being recently, using it could break your laws.")
		LoadComponent(/datum/component/itempicky, drone_good_items, "Using %TARGET could break your laws.")
		RegisterSignal(src, COMSIG_TRY_USE_MACHINE, PROC_REF(blacklist_on_try_use_machine))
		RegisterSignal(src, COMSIG_TRY_WIRES_INTERACT, PROC_REF(blacklist_on_try_wires_interact))
	else
		ADD_TRAIT(src, TRAIT_CAN_STRIP, DRONE_SHY_TRAIT) // ...I wonder if I can ware pants like a hat
		REMOVE_TRAIT(src, TRAIT_PACIFISM, DRONE_SHY_TRAIT)
		qdel(GetComponent(/datum/component/shy))
		qdel(GetComponent(/datum/component/shy_in_room))
		qdel(GetComponent(/datum/component/technoshy))
		qdel(GetComponent(/datum/component/itempicky))
		UnregisterSignal(src, list(COMSIG_TRY_USE_MACHINE, COMSIG_TRY_WIRES_INTERACT))

/mob/living/basic/drone/flash_act(intensity = 1, override_blindness_check = 0, affect_silicon = 0, visual = 0, type = /atom/movable/screen/fullscreen/flash, length = 25)
	if(affect_silicon)
		return ..()

/mob/living/basic/drone/bee_friendly()
	// Why would bees pay attention to drones?
	return TRUE

/mob/living/basic/drone/electrocute_act(shock_damage, source, siemens_coeff, flags = NONE)
	return FALSE //So they don't die trying to fix wiring
