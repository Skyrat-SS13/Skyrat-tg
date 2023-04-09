/**
 * Basic Spacepod Equipment
 *
 * These things are basically upgrades for spacepods. You can have interesting and unique hardware on a spacepod.
 */
/obj/item/spacepod_equipment
	name = "error"
	icon = 'modular_skyrat/modules/spacepods/icons/parts.dmi'
	w_class = WEIGHT_CLASS_GIGANTIC
	flags_1 = CONDUCT_1
	/// The spacepod we are attached to.
	var/obj/spacepod/spacepod
	/// The slot in which we take
	var/slot = SPACEPOD_SLOT_MISC
	/// How much space this equipment takes up
	var/slot_space = 1
	/// What actions should we give the user?
	var/list/actions_to_give = list()
	/// The icon that we will overlay onto the pod.
	var/overlay_icon = 'modular_skyrat/modules/spacepods/icons/pod2x2.dmi'
	/// The icon state of the overlayed weapon.
	var/overlay_icon_state

/obj/item/spacepod_equipment/Destroy(force)
	spacepod = null
	return ..()

/obj/item/spacepod_equipment/proc/on_install(obj/spacepod/attaching_spacepod)
	spacepod = attaching_spacepod

/**
 * on uninstall
 *
 * Called when some piece of equipment is uninstalled.
 *
 * Forced: This should FORCE the uninstall and clear anything required.
 */
/obj/item/spacepod_equipment/proc/on_uninstall(obj/spacepod/detatching_spacepod, forced)
	spacepod = null

/**
 * can_install
 *
 * Basic install handler, performs checks before returning TRUE or FALSE
 */
/obj/item/spacepod_equipment/proc/can_install(obj/spacepod/attaching_spacepod, mob/user)
	return TRUE

/**
 * can_uninstall
 *
 * Basic uninstall handler, place any unique behaviour here, return true or false.
 *
 * forced: This will FORCE the item to uninstall
 */
/obj/item/spacepod_equipment/proc/can_uninstall(obj/spacepod/detatching_spacepod, mob/user, forced)
	return TRUE


/**
 * Cargo Systems
 */
/obj/item/spacepod_equipment/cargo
	name = "pod cargo"
	desc = "You shouldn't be seeing this"
	icon_state = "cargo_blank"
	slot = SPACEPOD_SLOT_CARGO

/obj/item/spacepod_equipment/cargo/large// this one holds large crates and shit
	name = "spacepod crate storage system"
	desc = "A heavy duty storage system for spacepods. Holds one crate."
	icon_state = "cargo_crate"
	var/obj/storage = null
	var/storage_type = /obj/structure/closet/crate

/obj/item/spacepod_equipment/cargo/large/on_install(obj/spacepod/attaching_spacepod)
	. = ..()
	RegisterSignal(attaching_spacepod, COMSIG_MOUSEDROPPED_ONTO, .proc/spacepod_mousedrop)
	attaching_spacepod.cargo_bays += src

/obj/item/spacepod_equipment/cargo/large/on_uninstall(obj/spacepod/detatching_spacepod, forced)
	. = ..()
	if(forced)
		unload_cargo()
	UnregisterSignal(detatching_spacepod, COMSIG_MOUSEDROPPED_ONTO)
	detatching_spacepod.cargo_bays -= src

/obj/item/spacepod_equipment/cargo/large/can_uninstall(obj/spacepod/detatching_spacepod, mob/user, forced)
	if(forced)
		return TRUE
	if(storage)
		to_chat(user, span_warning("Unload the cargo first!"))
		return FALSE
	return ..()

/obj/item/spacepod_equipment/cargo/large/proc/unload_cargo()
	if(storage)
		storage.forceMove(get_turf(src))
		storage = null

/obj/item/spacepod_equipment/cargo/large/proc/spacepod_mousedrop(obj/spacepod/attaching_spacepod, obj/inserting_item, mob/user)
	SIGNAL_HANDLER
	INVOKE_ASYNC(src, .proc/spacepod_mousedrop_async, attaching_spacepod, inserting_item, user)

/obj/item/spacepod_equipment/cargo/large/proc/spacepod_mousedrop_async(obj/spacepod/attaching_spacepod, obj/inserting_item, mob/user)
	if(attaching_spacepod.check_occupant(user))
		return FALSE
	if(istype(inserting_item, storage_type) && attaching_spacepod.Adjacent(inserting_item)) // For loading ore boxes
		if(!storage)
			to_chat(user, span_notice("You begin loading [inserting_item] into [attaching_spacepod]'s [src]"))
			if(do_after(user, 4 SECONDS, inserting_item))
				storage = inserting_item
				inserting_item.forceMove(src)
				to_chat(user, span_notice("You load [inserting_item] into [attaching_spacepod]'s [src]!"))
			else
				to_chat(user, span_warning("You fail to load [inserting_item] into [attaching_spacepod]'s [src]"))
		else
			to_chat(user, span_warning("[attaching_spacepod] already has \an [storage]"))
		return TRUE
	return FALSE

/obj/item/spacepod_equipment/cargo/large/ore
	name = "spacepod ore storage system"
	desc = "An ore storage system for spacepods. Scoops up any ore you drive over. Needs to be loaded with an ore box to work"
	icon_state = "cargo_ore"
	storage_type = /obj/structure/ore_box

/obj/item/spacepod_equipment/cargo/large/ore/on_install(obj/spacepod/attaching_spacepod)
	..()
	RegisterSignal(attaching_spacepod, COMSIG_MOVABLE_MOVED, .proc/spacepod_moved)

/obj/item/spacepod_equipment/cargo/large/ore/on_uninstall(obj/spacepod/detatching_spacepod, forced)
	. = ..()
	UnregisterSignal(detatching_spacepod, COMSIG_MOVABLE_MOVED)


/obj/item/spacepod_equipment/cargo/large/ore/proc/spacepod_moved(obj/spacepod/attaching_spacepod)
	SIGNAL_HANDLER
	if(storage)
		for(var/turf/iterating_turf in attaching_spacepod.locs)
			for(var/obj/item/stack/ore in iterating_turf)
				ore.forceMove(storage)

/obj/item/spacepod_equipment/cargo/chair
	name = "passenger seat"
	desc = "A passenger seat for a spacepod."
	icon_state = "sec_cargo_chair"
	// How many occupant slots this chair adds.
	var/occupant_mod = 1
	// What slot we add to
	var/occupant_slot = SPACEPOD_RIDER_TYPE_PASSENGER


/obj/item/spacepod_equipment/cargo/chair/on_install(obj/spacepod/attaching_spacepod)
	. = ..()
	attaching_spacepod.occupant_slots[occupant_slot] += occupant_mod

/obj/item/spacepod_equipment/cargo/chair/on_uninstall(obj/spacepod/detatching_spacepod, forced)
	. = ..()
	if(forced)
		detatching_spacepod.remove_all_riders(forced = forced)
	detatching_spacepod.occupant_slots[occupant_slot] -= occupant_mod

/obj/item/spacepod_equipment/cargo/chair/can_uninstall(obj/spacepod/detatching_spacepod, mob/user, forced)
	. = ..()
	if(forced)
		return TRUE
	if(LAZYLEN(detatching_spacepod.get_all_occupants_by_type(SPACEPOD_RIDER_TYPE_PASSENGER)) > (LAZYLEN(detatching_spacepod[occupant_slot]) - occupant_mod))
		to_chat(user, span_warning("You can't remove an occupied seat! Remove the occupant first."))
		return FALSE
	return ..()

/**
 * Weapon Systems
 */


/obj/item/spacepod_equipment/weaponry
	name = "broken weapon"
	slot = SPACEPOD_SLOT_WEAPON
	/// The projectile type that we fire
	var/projectile_type
	/// How much energy each shot costs the battery.
	var/shot_cost = 0
	/// How many shots we fire in one button click.
	var/burst_fire = 1
	/// The delay between burstfire shots
	var/burst_fire_delay = 0.2 SECONDS
	/// The sound we make when firing.
	var/fire_sound
	/// How loud is the fire sound.
	var/fire_volume = 50
	/// The delay between firing.
	var/fire_delay = 1.5 SECONDS
	overlay_icon_state = "pod_weapon_laser"

/obj/item/spacepod_equipment/weaponry/on_install(obj/spacepod/attaching_spacepod, override_slot)
	. = ..()
	if(!override_slot)
		override_slot = pick(attaching_spacepod.get_free_weapon_slots())
	attaching_spacepod.equipment[SPACEPOD_SLOT_WEAPON][src] = override_slot
	attaching_spacepod.update_icon()


/obj/item/spacepod_equipment/weaponry/proc/fire_weapon(target, x_offset, y_offset)
	if(spacepod.next_firetime > world.time)
		to_chat(usr, span_warning("Your weapons are recharging."))
		playsound(src, 'sound/weapons/gun/general/dry_fire.ogg', 30, TRUE)
		return
	if(!spacepod.cell || !spacepod.cell.use(shot_cost))
		to_chat(usr, span_warning("Insufficient charge to fire the weapons!"))
		playsound(src, 'sound/weapons/gun/general/dry_fire.ogg', 30, TRUE)
		return
	spacepod.next_firetime = world.time + fire_delay
	for(var/i in 1 to burst_fire)
		addtimer(CALLBACK(src, PROC_REF(actually_fire_weapons), target, x_offset, y_offset), burst_fire_delay * i)

/**
 * actually fire weapons
 *
 * This exists so that we can use timers instead of sleep() (cringe)
 */
/obj/item/spacepod_equipment/weaponry/proc/actually_fire_weapons(target, x_offset, y_offset)
	spacepod.fire_projectile(projectile_type, target, x_offset, y_offset)
	playsound(src, fire_sound, 50, TRUE)

/obj/item/spacepod_equipment/weaponry/disabler
	name = "\improper Armadyne S1 Disabler"
	desc = "A weak disabler system for space pods, fires disabler beams."
	icon_state = "weapon_taser"
	projectile_type = /obj/projectile/beam/disabler
	shot_cost = 100
	fire_sound = 'sound/weapons/taser2.ogg'
	overlay_icon = 'modular_skyrat/modules/spacepods/icons/pod2x2.dmi'
	overlay_icon_state = "pod_weapon_disabler"

/obj/item/spacepod_equipment/weaponry/burst_disabler
	name = "\improper Armadyne S3 BURST Disabler"
	desc = "A weak disabler system for space pods, this one fires 3 at a time."
	icon_state = "weapon_burst_taser"
	projectile_type = /obj/projectile/beam/disabler
	shot_cost = 300
	burst_fire = 3
	fire_sound = 'sound/weapons/taser2.ogg'
	fire_delay = 30
	overlay_icon = 'modular_skyrat/modules/spacepods/icons/pod2x2.dmi'
	overlay_icon_state = "pod_weapon_disabler"

/obj/item/spacepod_equipment/weaponry/laser
	name = "\improper Armadyne MK1 'Photon Cannon' Laser System"
	desc = "A weak laser system for space pods, fires concentrated bursts of energy."
	icon_state = "weapon_laser"
	projectile_type = /obj/projectile/beam/laser
	shot_cost = 200
	fire_sound = 'sound/weapons/Laser.ogg'
	overlay_icon = 'modular_skyrat/modules/spacepods/icons/pod2x2.dmi'
	overlay_icon_state = "pod_weapon_laser"

/obj/item/spacepod_equipment/weaponry/burst_laser
	name = "\improper Armadyne MK1 'Photon Cannon' Burst Laser System"
	desc = "A weak laser system for space pods, fires concentrated bursts of energy. This one fires 3 at once."
	icon_state = "weapon_laser"
	projectile_type = /obj/projectile/beam/laser
	shot_cost = 600
	burst_fire = 3
	fire_sound = 'sound/weapons/Laser.ogg'
	overlay_icon = 'modular_skyrat/modules/spacepods/icons/pod2x2.dmi'
	overlay_icon_state = "pod_weapon_laser"


/obj/item/spacepod_equipment/weaponry/pulse
	name = "\improper NT-9 'Pulse' Disruptor"
	desc = "An incredibly powerful pulse weapon system for pods, fires concentrated impulse rounds."
	icon_state = "weapon_pulse"
	projectile_type = /obj/projectile/beam/pulse
	shot_cost = 1000
	fire_sound = 'modular_skyrat/modules/aesthetics/guns/sound/pulse.ogg'
	overlay_icon = 'modular_skyrat/modules/spacepods/icons/pod2x2.dmi'
	overlay_icon_state = "pod_weapon_pulse"

// MINING LASERS
/obj/item/spacepod_equipment/weaponry/basic_pod_ka
	name = "\improper MINEALOT 'Basic' Kinetic Accelerator"
	desc = "A weak kinetic accelerator for space pods, fires bursts of energy that cut through rock."
	icon_state = "pod_taser"
	projectile_type = /obj/projectile/kinetic/pod
	shot_cost = 50
	fire_delay = 14
	fire_sound = 'sound/weapons/Kenetic_accel.ogg'

/obj/item/spacepod_equipment/weaponry/pod_ka
	name = "\improper MINEALOT 'Better' Kinetic Accelerator"
	desc = "A kinetic accelerator system for space pods, fires bursts of energy that cut through rock."
	icon_state = "pod_m_laser"
	projectile_type = /obj/projectile/kinetic/pod/regular
	shot_cost = 50
	fire_delay = 10
	fire_sound = 'sound/weapons/Kenetic_accel.ogg'

/obj/projectile/kinetic/pod
	range = 4

/obj/projectile/kinetic/pod/regular
	damage = 50
	pressure_decrease = 0.5

/obj/item/spacepod_equipment/weaponry/plasma_cutter
	name = "\improper SEEGSON MK1 Plasma Cutter"
	desc = "A plasma cutter system for space pods. It is capable of expelling concentrated plasma bursts to mine or cut off xeno limbs!"
	icon_state = "pod_p_cutter"
	projectile_type = /obj/projectile/plasma
	shot_cost = 150
	fire_delay = 10
	fire_sound = 'sound/weapons/plasma_cutter.ogg'
	overlay_icon = 'modular_skyrat/modules/spacepods/icons/pod2x2.dmi'
	overlay_icon_state = "pod_weapon_plasma"

/obj/item/spacepod_equipment/weaponry/plasma_cutter/adv
	name = "\improper SEEGSON MK2 Plasma Cutter"
	desc = "An enhanced plasma cutter system for space pods. It is capable of expelling concentrated plasma bursts to mine or cut off xeno faces!"
	icon_state = "pod_ap_cutter"
	projectile_type = /obj/projectile/plasma/adv
	shot_cost = 50
	fire_delay = 5

/**
 * Thruster Types
 *
 * A pods thrusters dictate how fast it can go. Really that simple.
 */

/obj/item/spacepod_equipment/thruster
	name = "\improper Rolls-Royce RS-200 Sublight Thrusters"
	desc = "The R-200 series of sublight thrusters are as basic as you can get, they aren't very fast."
	icon_state = "thrusters"
	slot = SPACEPOD_SLOT_THRUSTER
	/// The max speed that the pod can move forwards. In tiles per second.
	var/max_forward_speed = 2
	/// The max speed that the pod can move backwards. In tiles per second.
	var/max_backwards_speed = 1
	/// The max speed that the pod can move sidways. In tiles per second.
	var/max_sideways_speed = 0.5

/obj/item/spacepod_equipment/thruster/on_install(obj/spacepod/attaching_spacepod)
	. = ..()
	var/datum/component/physics/physics_component = attaching_spacepod.GetComponent(/datum/component/physics)
	physics_component.forward_maxthrust = max_forward_speed
	physics_component.backward_maxthrust = max_backwards_speed
	physics_component.side_maxthrust = max_sideways_speed

/obj/item/spacepod_equipment/thruster/on_uninstall(obj/spacepod/detatching_spacepod, forced)
	. = ..()
	var/datum/component/physics/physics_component = detatching_spacepod.GetComponent(/datum/component/physics)
	physics_component.forward_maxthrust = 0
	physics_component.backward_maxthrust = 0
	physics_component.side_maxthrust = 0

/obj/item/spacepod_equipment/thruster/upgraded
	name = "\improper Rolls-Royce RS-400 Sublight Thrusters"
	desc = "The R-400 series of sublight thrusters provide a slightly better power output of the smaller R-200 series."
	max_forward_speed = 4
	max_backwards_speed = 2
	max_sideways_speed = 1

/obj/item/spacepod_equipment/thruster/mk9
	name = "\improper SAB-R Mark 9 Superlight Impulse Thrust System"
	desc = "These bad boys make your shuttle go really really fast."
	max_forward_speed = 6
	max_backwards_speed = 3
	max_sideways_speed = 2

/**
 * Lights
 *
 * Dictates what kind of lights the pod will have.
 */

/obj/item/spacepod_equipment/lights
	name = "\improper SEETECH Light System"
	desc = "Lights for a spacepod, they allow you to see where you are going. In theory."
	icon_state = "lights"
	slot = SPACEPOD_SLOT_LIGHT
	/// The color of the light
	var/color_to_set = COLOR_WHITE

/obj/item/spacepod_equipment/thruster/on_uninstall(obj/spacepod/detatching_spacepod, forced)
	. = ..()
	detatching_spacepod.set_light_on(FALSE)

/obj/item/spacepod_equipment/lights/military
	name = "military pod light system"
	color_to_set = "#BBF093"

/obj/item/spacepod_equipment/lights/security
	name = "security pod light system"
	color_to_set = COLOR_BLUE

/obj/item/spacepod_equipment/lights/syndicate
	name = "syndicate pod light system"
	color_to_set = COLOR_RED

/obj/item/spacepod_equipment/lights/custom
	name = "\improper SEETECH Custom Light System"
	desc = "Lights for a spacepod, you can use a screwdriver on this to change the color of the lights."

/obj/item/spacepod_equipment/lights/custom/screwdriver_act(mob/living/user, obj/item/tool)
	var/new_color = input(user, "Please select your new projectile color", "Laser color", color_to_set) as null|color
	if(!new_color)
		return
	color_to_set = new_color
	tool.play_tool_sound(src, 100)


/**
 * Misc Systems
 */

/obj/item/spacepod_equipment/tracker
	name = "spacepod tracking system"
	desc = "A tracking device for spacepods."
	icon_state = "pod_locator"

/obj/item/spacepod_equipment/teleport
	name = "\improper SEEGSON Quantum Entangloporter"
	desc = "Enables faster than light travel using a quantum entangloporter."
	icon_state = "cargo_blank"

/obj/item/spacepod_equipment/rcs_upgrade
	name = "\improper RCS Vector Thrust Modulator"
	desc = "Enables better control of the spacepod by allowing constant RCS course corrections."
	icon_state = "cargo_blank"

/**
 * Lock Systems
 */
/obj/item/spacepod_equipment/lock
	name = "pod lock"
	desc = "You shouldn't be seeing this"
	slot = SPACEPOD_SLOT_LOCK

/obj/item/spacepod_equipment/lock/on_install(obj/spacepod/attaching_spacepod)
	..()
	RegisterSignal(attaching_spacepod, COMSIG_PARENT_ATTACKBY, .proc/spacepod_attackby)

/obj/item/spacepod_equipment/lock/on_uninstall(obj/spacepod/detatching_spacepod, forced)
	. = ..()
	UnregisterSignal(detatching_spacepod, COMSIG_PARENT_ATTACKBY)
	detatching_spacepod.locked = FALSE


/obj/item/spacepod_equipment/lock/proc/spacepod_attackby(obj/spacepod/attaching_spacepod, I, mob/user)
	SIGNAL_HANDLER
	return FALSE

// Key and Tumbler System
/obj/item/spacepod_equipment/lock/keyed
	name = "\improper Sasterlock Tumbler Locking System"
	desc = "A locking system to stop podjacking. This version uses a standalone key."
	icon_state = "lock_tumbler"
	/// Our unique ID identifier, to prevent duplicate locks.
	var/static/id_source = 0
	/// The required key.id to unlock the shuttle.
	var/key_id = null

/obj/item/spacepod_equipment/lock/keyed/Initialize()
	. = ..()
	if(key_id == null)
		key_id = ++id_source

/obj/item/spacepod_equipment/lock/keyed/spacepod_attackby(obj/spacepod/attaching_spacepod, obj/item/I, mob/user)
	if(istype(I, /obj/item/spacepod_key))
		var/obj/item/spacepod_key/key = I
		if(key.id == key_id)
			attaching_spacepod.toggle_locked(user)
			return
		else
			to_chat(user, span_warning("This is the wrong key!"))
		return TRUE
	return FALSE

/obj/item/spacepod_equipment/lock/keyed/attackby(obj/item/attacking_item, mob/user)
	if(istype(attacking_item, /obj/item/spacepod_key))
		var/obj/item/spacepod_key/key = attacking_item
		if(key.id == null)
			key.id = key_id
			to_chat(user, span_notice("You grind the blank key to fit the lock."))
		else
			to_chat(user, span_warning("This key is already ground!"))
	else
		..()

/obj/item/spacepod_equipment/lock/keyed/sec
	key_id = "security spacepod"

/obj/item/spacepod_equipment/lock/keyed/military
	key_id = "military spacepod"

// The key
/obj/item/spacepod_key
	name = "spacepod key"
	desc = "A key for a spacepod lock."
	icon = 'modular_skyrat/modules/spacepods/icons/parts.dmi'
	icon_state = "podkey"
	w_class = WEIGHT_CLASS_TINY
	/// Our unique key ID, this is what the spacepod lock system checks to unlock/lock.
	var/id = null

/obj/item/spacepod_key/sec
	name = "security spacepod key"
	desc = "Unlocks the security spacepod. Probably best kept out of assistant hands."
	id = "security spacepod"

/obj/item/spacepod_key/military
	name = "military spacepod key"
	desc = "Unlocks the military spacepod."
	id = "military spacepod"

/obj/item/device/lock_buster
	name = "pod lock buster"
	desc = "Destroys a podlock in mere seconds once applied. Waranty void if used."
	icon = 'modular_skyrat/modules/spacepods/icons/parts.dmi'
	icon_state = "lock_buster_on"




