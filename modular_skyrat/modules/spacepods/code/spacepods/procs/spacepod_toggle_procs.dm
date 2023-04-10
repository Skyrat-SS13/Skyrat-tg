// TOGGLES

/**
 * Togggle weapon lock
 *
 * Toggles the weapon lock systems of the pod.
 */
/obj/spacepod/proc/toggle_weapon_lock(mob/user)
	weapon_safety = !weapon_safety
	to_chat_to_riders(SPACEPOD_RIDER_TYPE_PILOT, span_notice("Weapon lock is now [weapon_safety ? "on" : "off"]."))

/**
 * toggle lights
 *
 * Toggles the spacepod lights and sets them accordingly, if a light system is present.
 */
/obj/spacepod/proc/toggle_lights(mob/user)
	if(!LAZYLEN(equipment[SPACEPOD_SLOT_LIGHT]))
		to_chat(user, span_warning("No lights installed!"))
		return

	var/obj/item/spacepod_equipment/lights/light_equipment = equipment[SPACEPOD_SLOT_LIGHT][1]
	light_color = light_equipment.color_to_set
	light_toggle = !light_toggle
	if(light_toggle)
		set_light_on(TRUE)
	else
		set_light_on(FALSE)
	to_chat(user, "Lights toggled [light_toggle ? "on" : "off"].")

/**
 * Toggle breaks
 *
 * Toggles vector braking systems.
 */
/obj/spacepod/proc/toggle_brakes(mob/user)
	brakes = !brakes
	to_chat(user, span_notice("You toggle the brakes [brakes ? "on" : "off"]."))

/**
 * Toggle gyroscope
 *
 * Toggles gyroscope.
 */
/obj/spacepod/proc/toggle_gyroscope(mob/user)
	gyroscope_enabled = !gyroscope_enabled
	to_chat(user, span_notice("You toggle the gyroscope [gyroscope_enabled ? "on" : "off"]."))
/**
 * toggle lock
 *
 * Toggles the lock provoding there is a lock.
 */
/obj/spacepod/proc/toggle_locked(mob/user)
	if(!LAZYLEN(equipment[SPACEPOD_SLOT_LOCK]))
		to_chat(user, span_warning("[src] has no locking mechanism."))
		locked = FALSE //Should never be false without a lock, but if it somehow happens, that will force an unlock.
	else
		locked = !locked
		to_chat(user, span_warning("You [locked ? "lock" : "unlock"] the doors."))

/**
 * toggle doors
 *
 * Toggles near by doors and checks items.
 */
/obj/spacepod/proc/toggle_doors(mob/user)
	for(var/obj/machinery/door/poddoor/multi_tile/P in orange(3,src))
		for(var/mob/living/carbon/human/O in contents)
			if(P.check_access(O.get_active_held_item()) || P.check_access(O.wear_id))
				if(P.density)
					P.open()
					return TRUE
				else
					P.close()
					return TRUE
		to_chat(user, span_warning("Access denied."))
		return

	to_chat(user, span_warning("You are not close to any pod doors."))

/**
 * mute alarm
 *
 * Mutes the alarm and prevents it from starting. Provides feedback.
 */
/obj/spacepod/proc/mute_alarm(mob/user)
	alarm_muted = !alarm_muted
	play_alarm(FALSE)
	to_chat(user, span_notice("System alarm [alarm_muted ? "muted" : "enabled"]."))
