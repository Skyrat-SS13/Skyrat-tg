/**
 * The base object for the quantum server
 */
/obj/machinery/quantum_server
	name = "quantum server"

	circuit = /obj/item/circuitboard/machine/quantum_server
	density = TRUE
	desc = "A hulking computational machine designed to fabricate virtual domains."
	icon = 'icons/obj/machines/bitrunning.dmi'
	base_icon_state = "qserver"
	icon_state = "qserver"
	/// Affects server cooldown efficiency
	var/capacitor_coefficient = 1
	/// The loaded map template, map_template/virtual_domain
	var/datum/lazy_template/virtual_domain/generated_domain
	/// If the current domain was a random selection
	var/domain_randomized = FALSE
	/// Prevents multiple user actions. Handled by loading domains and cooldowns
	var/is_ready = TRUE
	/// Chance multipled by threat to spawn a glitch
	var/glitch_chance = 0.05
	/// Current plugged in users
	var/list/datum/weakref/avatar_connection_refs = list()
	/// Cached list of mutable mobs in zone for cybercops
	var/list/datum/weakref/mutation_candidate_refs = list()
	/// Any ghosts that have spawned in
	var/list/datum/weakref/spawned_threat_refs = list()
	/// Scales loot with extra players
	var/multiplayer_bonus = 1.1
	///The radio the console can speak into
	var/obj/item/radio/radio
	/// The amount of points in the system, used to purchase maps
	var/points = 0
	/// Keeps track of the number of times someone has built a hololadder
	var/retries_spent = 0
	/// Changes how much info is available on the domain
	var/scanner_tier = 1
	/// Length of time it takes for the server to cool down after resetting. Here to give runners downtime so their faces don't get stuck like that
	var/server_cooldown_time = 3 MINUTES
	/// Applies bonuses to rewards etc
	var/servo_bonus = 0
	/// Determines the glitches available to spawn, builds with completion
	var/threat = 0
	/// The turfs we can place a hololadder on.
	var/turf/exit_turfs = list()
	/// Determines if we broadcast to entertainment monitors or not
	var/broadcasting = FALSE
	/// Cooldown between being able to toggle broadcasting
	COOLDOWN_DECLARE(broadcast_toggle_cd)

/obj/machinery/quantum_server/post_machine_initialize()
	. = ..()

	radio = new(src)
	radio.keyslot = new /obj/item/encryptionkey/headset_cargo()
	radio.set_listening(FALSE)
	radio.recalculateChannels()

	RegisterSignals(src, list(COMSIG_MACHINERY_BROKEN, COMSIG_MACHINERY_POWER_LOST), PROC_REF(on_broken))
	RegisterSignal(src, COMSIG_QDELETING, PROC_REF(on_delete))

/obj/machinery/quantum_server/Destroy(force)
	. = ..()

	mutation_candidate_refs.Cut()
	avatar_connection_refs.Cut()
	spawned_threat_refs.Cut()
	QDEL_NULL(exit_turfs)
	QDEL_NULL(generated_domain)
	QDEL_NULL(radio)

/obj/machinery/quantum_server/examine(mob/user)
	. = ..()

	. += span_infoplain("Can be resource intensive to run. Ensure adequate power supply.")

	if(capacitor_coefficient < 1)
		. += span_infoplain("Its coolant capacity reduces cooldown time by [(1 - capacitor_coefficient) * 100]%.")

	if(servo_bonus > 0.2)
		. += span_infoplain("Its manipulation potential is increasing rewards by [servo_bonus]x.")
		. += span_infoplain("Injury from unsafe ejection reduced [servo_bonus * 100]%.")

	if(!is_ready)
		. += span_notice("It is currently cooling down. Give it a few moments.")

/obj/machinery/quantum_server/emag_act(mob/user, obj/item/card/emag/emag_card)
	. = ..()

	if(obj_flags & EMAGGED)
		return

	obj_flags |= EMAGGED
	glitch_chance = 0.09

	add_overlay(mutable_appearance('icons/obj/machines/bitrunning.dmi', "emag_overlay"))
	balloon_alert(user, "system jailbroken...")
	playsound(src, 'sound/effects/sparks1.ogg', 35, vary = TRUE)

/obj/machinery/quantum_server/update_appearance(updates)
	if(isnull(generated_domain) || !is_operational)
		set_light(l_on = FALSE)
		return ..()

	set_light(l_range = 2, l_power = 1.5, l_color = is_ready ? LIGHT_COLOR_BABY_BLUE : LIGHT_COLOR_FIRE, l_on = TRUE)
	return ..()

/obj/machinery/quantum_server/update_icon_state()
	if(isnull(generated_domain) || !is_operational)
		icon_state = base_icon_state
		return ..()

	icon_state = "[base_icon_state]_[is_ready ? "on" : "off"]"
	return ..()

/obj/machinery/quantum_server/attackby(obj/item/weapon, mob/user, params)
	. = ..()
	if(istype(weapon, /obj/item/bitrunning_debug))
		obj_flags |= EMAGGED
		glitch_chance = 0.5
		capacitor_coefficient = 0.01
		points = 100

/obj/machinery/quantum_server/crowbar_act(mob/living/user, obj/item/crowbar)
	. = ..()

	if(!is_ready)
		balloon_alert(user, "it's scalding hot!")
		return TRUE
	if(length(avatar_connection_refs))
		balloon_alert(user, "all clients must disconnect!")
		return TRUE
	if(default_deconstruction_crowbar(crowbar))
		return TRUE
	return FALSE

/obj/machinery/quantum_server/screwdriver_act(mob/living/user, obj/item/screwdriver)
	. = ..()

	if(!is_ready)
		balloon_alert(user, "it's scalding hot!")
		return TRUE
	if(default_deconstruction_screwdriver(user, "[base_icon_state]_panel", icon_state, screwdriver))
		return TRUE
	return FALSE

/obj/machinery/quantum_server/RefreshParts()
	var/capacitor_rating = 1.15
	var/datum/stock_part/capacitor/cap = locate() in component_parts
	capacitor_rating -= cap.tier * 0.15

	capacitor_coefficient = capacitor_rating

	var/datum/stock_part/scanning_module/scanner = locate() in component_parts
	if(scanner)
		scanner_tier = scanner.tier

	var/servo_rating = 0
	for(var/datum/stock_part/servo/servo in component_parts)
		servo_rating += servo.tier * 0.1

	servo_bonus = servo_rating

	return ..()
