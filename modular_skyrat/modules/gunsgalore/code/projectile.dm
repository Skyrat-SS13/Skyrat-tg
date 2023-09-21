
/**
 * Called when the projectile hits something
 *
 * @params
 * target - thing hit
 * blocked - percentage of hit blocked
 * pierce_hit - are we piercing through or regular hitting
 */
/obj/projectile/proc/on_hit(atom/target, blocked = FALSE, pierce_hit)
	if(fired_from)
		SEND_SIGNAL(fired_from, COMSIG_PROJECTILE_ON_HIT, firer, target, Angle)
	// i know that this is probably more with wands and gun mods in mind, but it's a bit silly that the projectile on_hit signal doesn't ping the projectile itself.
	// maybe we care what the projectile thinks! See about combining these via args some time when it's not 5AM
	var/hit_limb_zone
	if(isliving(target))
		var/mob/living/L = target
		hit_limb_zone = L.check_hit_limb_zone_name(def_zone)
	SEND_SIGNAL(src, COMSIG_PROJECTILE_SELF_ON_HIT, firer, target, Angle, hit_limb_zone)

	if(QDELETED(src)) // in case one of the above signals deleted the projectile for whatever reason
		return
	var/turf/target_turf = get_turf(target)

	var/hitx
	var/hity
	if(target == original)
		hitx = target.pixel_x + p_x - 16
		hity = target.pixel_y + p_y - 16
	else
		hitx = target.pixel_x + rand(-8, 8)
		hity = target.pixel_y + rand(-8, 8)

	var/impact_sound
	if(hitsound)
		impact_sound = hitsound
	else
		impact_sound = target.impact_sound
		get_sfx()
	playsound(src, get_sfx_skyrat(impact_sound), vol_by_damage(), TRUE, -1)

	if(damage > 0 && (damage_type == BRUTE || damage_type == BURN) && iswallturf(target_turf) && prob(75))
		var/turf/closed/wall/target_wall = target_turf
		if(impact_effect_type && !hitscan)
			new impact_effect_type(target_wall, hitx, hity)

		target_wall.add_dent(WALL_DENT_SHOT, hitx, hity)

		return BULLET_ACT_HIT

	if(!isliving(target))
		if(impact_effect_type && !hitscan)
			new impact_effect_type(target_turf, hitx, hity)
		return BULLET_ACT_HIT

	var/mob/living/living_target = target

	if(blocked != 100) // not completely blocked
		var/obj/item/bodypart/hit_bodypart = living_target.get_bodypart(hit_limb_zone)
		if (damage)
			if (living_target.blood_volume && damage_type == BRUTE && (isnull(hit_bodypart) || hit_bodypart.can_bleed()))
				var/splatter_dir = dir
				if(starting)
					splatter_dir = get_dir(starting, target_turf)
				if(isalien(living_target))
					new /obj/effect/temp_visual/dir_setting/bloodsplatter/xenosplatter(target_turf, splatter_dir)
				else
					new /obj/effect/temp_visual/dir_setting/bloodsplatter(target_turf, splatter_dir)
				if(prob(33))
					living_target.add_splatter_floor(target_turf)
			else if (!isnull(hit_bodypart) && (hit_bodypart.biological_state & (BIO_METAL|BIO_WIRED)))
				var/random_damage_mult = RANDOM_DECIMAL(0.85, 1.15) // SOMETIMES you can get more or less sparks
				var/damage_dealt = ((damage / (1 - (blocked / 100))) * random_damage_mult)
				var/spark_amount = round((damage_dealt / PROJECTILE_DAMAGE_PER_ROBOTIC_SPARK))
				if (spark_amount > 0)
					do_sparks(spark_amount, FALSE, living_target)
		else if(impact_effect_type && !hitscan)
			new impact_effect_type(target_turf, hitx, hity)

		var/organ_hit_text = ""
		if(hit_limb_zone)
			organ_hit_text = " in \the [parse_zone(hit_limb_zone)]"
		else if(suppressed && suppressed != SUPPRESSED_VERY)
			to_chat(living_target, span_userdanger("You're shot by \a [src][organ_hit_text]!"))
		else
			living_target.visible_message(span_danger("[living_target] is hit by \a [src][organ_hit_text]!"), \
					span_userdanger("You're hit by \a [src][organ_hit_text]!"), null, COMBAT_MESSAGE_RANGE)
		living_target.on_hit(src)

	var/reagent_note
	if(reagents?.reagent_list)
		reagent_note = "REAGENTS: [pretty_string_from_reagent_list(reagents.reagent_list)]"

	if(ismob(firer))
		log_combat(firer, living_target, "shot", src, reagent_note)
		return BULLET_ACT_HIT

	if(isvehicle(firer))
		var/obj/vehicle/firing_vehicle = firer
		var/list/logging_mobs = firing_vehicle.return_controllers_with_flag(VEHICLE_CONTROL_EQUIPMENT)
		if(!LAZYLEN(logging_mobs))
			logging_mobs = firing_vehicle.return_drivers()
		for(var/mob/logged_mob as anything in logging_mobs)
			log_combat(logged_mob, living_target, "shot", src, "from inside [firing_vehicle][logging_mobs.len > 1 ? " with multiple occupants" : null][reagent_note ? " and contained [reagent_note]" : null]")
		return BULLET_ACT_HIT

	living_target.log_message("has been shot by [firer] with [src][reagent_note ? " containing [reagent_note]" : null]", LOG_ATTACK, color="orange")
	return BULLET_ACT_HIT
