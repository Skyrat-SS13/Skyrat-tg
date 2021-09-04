/datum/overmap_object/shuttle/proc/DoShieldImpactEffect(soundname, soundvol = 30, shake_duration, shake_strength = 3)
	var/list/all_affected_mobs = GetAllClientMobs()
	for(var/i in all_affected_mobs)
		var/mob/affected_mob = i
		if(soundname)
			affected_mob.playsound_local(affected_mob, soundname, soundvol, TRUE)
		if(shake_duration)
			shake_camera(affected_mob, shake_duration, shake_strength)

/datum/overmap_object/shuttle/proc/inform_shields_up()
	if(last_shield_change_state + 3 SECONDS < world.time)
		DoShieldImpactEffect('sound/mecha/mech_shield_raise.ogg', 50)
	last_shield_change_state = world.time
	my_visual.update_appearance()
	return

/datum/overmap_object/shuttle/proc/inform_shields_down()
	if(last_shield_change_state + 3 SECONDS < world.time)
		DoShieldImpactEffect('sound/mecha/mech_shield_drop.ogg', 50)
	last_shield_change_state = world.time
	my_visual.update_appearance()
	return

/datum/overmap_object/shuttle/proc/TurnShieldsOff()
	for(var/i in shield_extensions)
		var/datum/shuttle_extension/shield/shield = i
		shield.turn_off()

/datum/overmap_object/shuttle/proc/TurnShieldsOn()
	for(var/i in shield_extensions)
		var/datum/shuttle_extension/shield/shield = i
		shield.turn_on()

//Whether any of the shields are engaged
/datum/overmap_object/shuttle/proc/IsShieldOn()
	for(var/i in shield_extensions)
		var/datum/shuttle_extension/shield/shield = i
		if(shield.on)
			return TRUE
	return FALSE

/datum/overmap_object/shuttle/proc/IsShieldFunctioning()
	for(var/i in shield_extensions)
		var/datum/shuttle_extension/shield/shield = i
		if(shield.is_functioning())
			return TRUE
	return FALSE

/datum/overmap_object/shuttle/proc/HasShield()
	for(var/i in shield_extensions)
		var/datum/shuttle_extension/shield/shield = i
		if(shield.current_shield)
			return TRUE
	return FALSE

/datum/overmap_object/shuttle/proc/GetShieldPercent()
	var/current_count = 0
	var/max_count = 0
	for(var/i in shield_extensions)
		var/datum/shuttle_extension/shield/shield = i
		current_count += shield.current_shield
		max_count += shield.maximum_shield
	if(!current_count || !max_count)
		return 0
	return (current_count / max_count)

//Attempts to absorb damage across the shields, returns how much damage wasn't absorbed and got through
/datum/overmap_object/shuttle/proc/AbsorbShield(damage)
	for(var/i in shield_extensions)
		if(!damage)
			break
		var/damage_took_here = damage
		var/datum/shuttle_extension/shield/shield = i
		if(!shield.current_shield)
			continue
		if(damage_took_here > shield.current_shield)
			damage_took_here = shield.current_shield
		shield.take_damage(damage_took_here)
		damage -= damage_took_here
	return damage
