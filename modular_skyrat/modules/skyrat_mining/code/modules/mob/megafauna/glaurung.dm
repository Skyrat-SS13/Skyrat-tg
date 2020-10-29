/*

GLAURUNG

Glaurung is a special Ash Drake for admemery roleplay. It's distinguishing features are the name, description, and the glowing blue eyes.

When not controlled by a player, it acts as a normal ashdrake, but with various changes.

Whenever possible, the drake will breathe fire in the direction it faces, igniting and heavily damaging anything caught in the blast.
It also often causes fire to rain from the sky - many nearby turfs will flash red as a fireball crashes into them, dealing damage to anything on the turfs.
Glaurung is unable to fly due to excess years of damage to its wings, but it is much faster on its legs.

When an ash drake dies, it leaves behind a chest that can contain four things:
 1. A spectral blade that allows its wielder to call ghosts to it, enhancing its power
 2. A lava staff that allows its wielder to create lava
 3. A spellbook and wand of fireballs
 4. A bottle of dragon's blood with several effects, including turning its imbiber into a drake themselves.

When butchered, they leave behind diamonds, sinew, bone, and ash drake hide. Ash drake hide can be used to create a hooded cloak that protects its wearer from ash storms.

Difficulty: Medium

*/

/mob/living/simple_animal/hostile/megafauna/dragon/glaurung
	name = "Glaurung"
	desc = "An ancient Ash Drake untouched except for age. It's eyes glow a soft blue color as opposed to a regular yellow. It carries itself with more strength than the standard drake, eyeing those who come near with caution. Perhaps it is smarter and capable of speech?"
	health = 2000
	maxHealth = 2000
	lighting_alpha = LIGHTING_PLANE_ALPHA_MOSTLY_INVISIBLE
	sight = SEE_TURFS|SEE_MOBS|SEE_OBJS
	attack_verb_continuous = "chomps"
	attack_verb_simple = "chomp"
	attack_sound = 'sound/magic/demon_attack1.ogg'
	icon = 'modular_skyrat/modules/skyrat_mining/icons/mob/lavaland/glaurung.dmi'
	icon_state = "glaurung"
	icon_living = "glaurung"
	icon_dead = "glaurung_dead"
	friendly_verb_continuous = "stares down"
	friendly_verb_simple = "stare down"
	speak_emote = list("roars")
	armour_penetration = 45
	melee_damage_lower = 20
	melee_damage_upper = 40
	gps_name = "Wise Signal"
	speed = 1
	move_to_delay = 4
	ranged = 1
	pixel_x = -16
	crusher_loot = list(/obj/structure/closet/crate/necropolis/glaurung/crusher)
	loot = list(/obj/structure/closet/crate/necropolis/glaurung)
	butcher_results = list(/obj/item/stack/ore/diamond = 5, /obj/item/stack/sheet/sinew = 5, /obj/item/stack/sheet/bone = 30)
	guaranteed_butcher_results = list(/obj/item/stack/sheet/animalhide/ashdrake = 10)
	deathmessage = "collapses into a pile of bones, its flesh sloughing away."
	songs = null
	move_force = MOVE_FORCE_NORMAL
	move_resist = MOVE_FORCE_NORMAL
	pull_force = MOVE_FORCE_NORMAL


/mob/living/simple_animal/hostile/megafauna/dragon/glaurung/line_target(offset, range, atom/at = target)
	if(!at)
		return
	var/angle = ATAN2(at.x - src.x, at.y - src.y) + offset
	var/turf/T = get_turf(src)
	for(var/i in 1 to range)
		var/turf/check = locate(src.x + cos(angle) * i, src.y + sin(angle) * i, src.z)
		if(!check)
			break
		T = check
	return (getline(src, T) - get_turf(src))

/mob/living/simple_animal/hostile/megafauna/dragon/glaurung/fire_line(var/list/turfs)
	sleep(0)
	dragon_fire_line(src, turfs)

/mob/living/simple_animal/hostile/megafauna/dragon/glaurung/proc/fire_stream(var/atom/at = target)
	playsound(get_turf(src),'sound/magic/fireball.ogg', 200, TRUE)
	sleep(0)
	var/range = 20
	var/list/turfs = list()
	turfs = line_target(0, range, at)
	INVOKE_ASYNC(src, .proc/fire_line, turfs)

/mob/living/simple_animal/hostile/megafauna/dragon/glaurung/OpenFire()
	if(swooping)
		return
	ranged_cooldown = world.time + ranged_cooldown_time
	fire_stream()

/mob/living/simple_animal/hostile/megafauna/dragon/glaurung/swoop_attack(fire_rain, atom/movable/manual_target, swoop_duration = 40)
	return null

/mob/living/simple_animal/hostile/megafauna/dragon/glaurung/AltClickOn(atom/movable/A)
	if(!istype(A))
		to_chat(src, "<span class='warning'>Your wings are too damaged for old swoop maneuvers.</span>")
		return
