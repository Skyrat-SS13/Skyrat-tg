/client/proc/spawn_mob_spawner()
	set category = "Admin.Fun"
	set name = "Spawn mob spawner"
	set desc = "Spawns a mob spawner structure below the user."

	holder?.spawn_mob_spawner()

/datum/admins/proc/spawn_mob_spawner(chosen_mob as text)
	if(!check_rights(R_SPAWN))
		return

	var/chosen = pick_closest_path(chosen_mob, make_types_fancy(subtypesof(/mob/living)))

	if (!chosen)
		chosen = /mob/living/simple_animal/hostile/zombie

	var/list/settings = list(
		"mainsettings" = list(
			"mob_to_spawn" = list("desc" = "Mob to spawn", "type" = "datum", "path" = "/mob/living", "subtypesonly" = TRUE, "value" = chosen),
			"max_mobs" = list("desc" = "Max mobs", "type" = "number", "value" = 5),
			"spawn_cooldown" = list("desc" = "Spawn cooldown", "type" = "number", "value" = 5 SECONDS),
			"regenerate_time" = list("desc" = "Regenerate time", "type" = "number", "value" = 5 MINUTES),
			"retaliate_cooldown" = list("desc" = "Retaliate cooldown", "type" = "number", "value" = 10 SECONDS),
			"nest_icon" = list("desc" = "Nest icon", "type" = "string", "value" = "nest"),
			"spawn" = list("desc" = "Spawn nest", "type" = "button", "callback" = CALLBACK(src, .proc/spawn_it), "value" = "Spawn"),
		)
	)

	var/list/returned_prefs = presentpreflikepicker(usr, "Spawn mob spawner", "Spawn mob spawner", StealFocus = 1, Timeout = 0, settings=settings)

	if (isnull(returned_prefs))
		return FALSE

	if (returned_prefs["button"] == 1)
		var/list/prefs = settings["mainsettings"]
		spawn_it(prefs)
		return TRUE

/datum/admins/proc/spawn_it(list/settings)
	. = settings
	var/mob_to_spawn = settings["mob_to_spawn"]["value"]
	if (!ispath(settings["mob_to_spawn"]["value"]))
		mob_to_spawn = text2path(settings["mob_to_spawn"]["value"])

	var/obj/structure/mob_spawner/spawned_spawner = new /obj/structure/mob_spawner(get_turf(usr))

	spawned_spawner.monster_types = list(mob_to_spawn)
	spawned_spawner.max_mobs = settings["max_mobs"]["value"]
	spawned_spawner.spawn_cooldown = settings["spawn_cooldown"]["value"]
	spawned_spawner.regenerate_time = settings["regenerate_time"]["value"]
	spawned_spawner.retaliate_cooldown = settings["retaliate_cooldown"]["value"]
	spawned_spawner.icon_state = settings["nest_icon"]["value"]
