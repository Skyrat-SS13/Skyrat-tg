#define SUNBEAM_OBLITERATION_RANGE_FIRE 2
#define SUNBEAM_OBLITERATION_RANGE_FLATTEN 1
#define SUNBEAM_OBLITERATION_COOLDOWN 0.2 SECONDS

/obj/effect/sunbeam
	name = "\improper ICARUS Sunbeam"
	desc = "A beam of light from the sun."
	icon = 'modular_skyrat/modules/assault_operatives/icons/sunbeam.dmi'
	icon_state = "sunray_splash"
	throwforce = 100
	move_force = INFINITY
	move_resist = INFINITY
	pull_force = INFINITY
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1
	movement_type = PHASING | FLYING
	plane = MASSIVE_OBJ_PLANE
	plane = ABOVE_LIGHTING_PLANE
	light_range = 6
	light_color = "#ffbf10"
	/// A reference to the target we will move towards
	var/atom/target_atom
	/// How much do we offset the mid beam?
	var/beam_offset_y = 32
	/// Our sound loop.
	var/datum/looping_sound/sunbeam/soundloop
	/// Our obliteration cooldown.
	var/obliteration_cooldown = SUNBEAM_OBLITERATION_COOLDOWN
	var/obliteration_range_fire = SUNBEAM_OBLITERATION_RANGE_FIRE
	var/obliteration_range_flatten = SUNBEAM_OBLITERATION_RANGE_FLATTEN

	COOLDOWN_DECLARE(oblirerate_cooldown)

/obj/effect/sunbeam/Initialize(mapload, atom/target, obliteration_cooldown_override, obliteration_range_fire_override, obliteration_range_flatten_override)
	. = ..()
	if(target)
		target_atom = target
	if(obliteration_cooldown_override)
		obliteration_cooldown = obliteration_cooldown_override
	if(obliteration_range_fire_override)
		obliteration_range_fire = obliteration_range_fire_override
	if(obliteration_range_flatten_override)
		obliteration_range_flatten = obliteration_range_flatten_override

	START_PROCESSING(SSfastprocess, src)
	update_appearance()
	notify_ghosts("An ICARUS sunbeam has been launched! [target_atom ? "Towards: [target_atom.name]" : ""]", source = new_key, action = NOTIFY_ORBIT, header = "Something's Interesting!")
	soundloop = new(src, TRUE)
	playsound(src, 'modular_skyrat/modules/assault_operatives/sound/sunbeam_fire.ogg', 100, FALSE, 20)

/obj/effect/sunbeam/Destroy(force)
	QDEL_NULL(soundloop)
	return ..()

/obj/effect/sunbeam/update_overlays()
	. = ..()
	for(var/i in 1 to 16)
		var/mutable_appearance/beam_overlay = mutable_appearance(icon, "sunray")
		beam_overlay.pixel_y = beam_offset_y * i
		. += beam_overlay

/obj/effect/sunbeam/process(delta_time)
	if(target_atom)
		step_towards(src, target_atom)

	if(COOLDOWN_FINISHED(src, oblirerate_cooldown))
		obliterate()

/obj/effect/sunbeam/proc/obliterate()
	if(obliteration_range_fire)
		for(var/turf/open/turf_to_incinerate in circle_range(src, obliteration_range_fire))
			turf_to_incinerate.hotspot_expose(5500)
			new /obj/effect/hotspot(turf_to_incinerate)

	if(obliteration_range_flatten)
		for(var/atom/atom_to_obliterate in circle_range(src, obliteration_range_flatten))
			if(isclosedturf(atom_to_obliterate))
				SSexplosions.highturf += atom_to_obliterate
				continue

			if(isfloorturf(atom_to_obliterate))
				var/turf/open/floor/open_turf = atom_to_obliterate
				if(open_turf.turf_flags & CAN_DECAY_BREAK_1)
					open_turf.break_tile_to_plating()

			if(isobj(atom_to_obliterate))
				var/obj/object_to_obliterate = atom_to_obliterate
				object_to_obliterate.take_damage(INFINITY, BRUTE, NONE, TRUE, dir, INFINITY)
				continue

			if(isliving(atom_to_obliterate))
				var/mob/living/mob_to_obliterate = atom_to_obliterate
				mob_to_obliterate.apply_damage(200, BURN)
				continue

	COOLDOWN_START(src, oblirerate_cooldown, obliteration_cooldown)

/datum/looping_sound/sunbeam
	mid_sounds = list('modular_skyrat/modules/assault_operatives/sound/sunbeam_loop.ogg' = 1)
	mid_length = 6.7 SECONDS
	volume = 100
	extra_range = 25

/client/proc/spawn_sunbeam(mob/living/target_mob in GLOB.mob_living_list)
	set category = "Admin.Fun"
	set name = "Spawn Sunbeam"
	set desc = "Spawns an ICARUS sunbeam at your location and sends it towards a target."

	if(!target_mob)
		return

	var/edit_ranges = tgui_alert(usr, "Change beam specifications?", "Beam Specifications", list("No", "Yes"))

	if(edit_ranges == "Yes")
		var/edit_range_fire = tgui_input_number(usr, "Fire range in tiles", "Fire Range", SUNBEAM_OBLITERATION_RANGE_FIRE, 20, 0)
		var/edit_range_flatten = tgui_input_number(usr, "Flatten range in tiles", "Flatten Range", SUNBEAM_OBLITERATION_RANGE_FLATTEN, 20, 0)
		var/edit_cooldown = tgui_input_number(usr, "Cooldown in seconds", "Cooldown", SUNBEAM_OBLITERATION_COOLDOWN, 20, 0)

		new /obj/effect/sunbeam(usr, target_mob, edit_cooldown, edit_range_fire, edit_range_flatten)
		return

	new /obj/effect/sunbeam(usr, target_mob)

#undef SUNBEAM_OBLITERATION_COOLDOWN
#undef SUNBEAM_OBLITERATION_RANGE_FIRE
#undef SUNBEAM_OBLITERATION_RANGE_FLATTEN
