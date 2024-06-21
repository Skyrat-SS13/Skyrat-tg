/// Mimics can't be made out of these objects
GLOBAL_LIST_INIT(animatable_blacklist, typecacheof(list(
	/obj/structure/table,
	/obj/structure/cable,
	/obj/structure/window,
	/obj/structure/blob,
)))

/mob/living/simple_animal/hostile/mimic
	name = "crate"
	desc = "A rectangular steel crate."
	icon = 'icons/obj/storage/crates.dmi'
	icon_state = "crate"
	icon_living = "crate"

	response_help_continuous = "touches"
	response_help_simple = "touch"
	response_disarm_continuous = "pushes"
	response_disarm_simple = "push"
	speed = 0
	maxHealth = 250
	health = 250
	gender = NEUTER
	mob_biotypes = NONE
	pass_flags = PASSFLAPS

	harm_intent_damage = 5
	melee_damage_lower = 8
	melee_damage_upper = 12
	attack_sound = 'sound/weapons/punch1.ogg'
	emote_taunt = list("growls")
	speak_emote = list("creaks")
	taunt_chance = 30

	atmos_requirements = null
	minbodytemp = 0

	faction = list(FACTION_MIMIC)
	move_to_delay = 9
	del_on_death = 1
	///A cap for items in the mimic. Prevents the mimic from eating enough stuff to cause lag when opened.
	var/storage_capacity = 50
	///A cap for mobs. Mobs count towards the item cap. Same purpose as above.
	var/mob_storage_capacity = 10

// Aggro when you try to open them. Will also pickup loot when spawns and drop it when dies.
/mob/living/simple_animal/hostile/mimic/crate
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	speak_emote = list("clatters")
	stop_automated_movement = 1
	wander = 0
	var/attempt_open = FALSE

// Pickup loot
/mob/living/simple_animal/hostile/mimic/crate/Initialize(mapload)
	. = ..()
	if(mapload) //eat shit
		for(var/obj/item/I in loc)
			I.forceMove(src)

/mob/living/simple_animal/hostile/mimic/crate/DestroyPathToTarget()
	..()
	if(prob(90))
		icon_state = "[initial(icon_state)]open"
	else
		icon_state = initial(icon_state)

/mob/living/simple_animal/hostile/mimic/crate/ListTargets()
	if(attempt_open)
		return ..()
	return ..(1)

/mob/living/simple_animal/hostile/mimic/crate/FindTarget()
	. = ..()
	if(.)
		trigger()

/mob/living/simple_animal/hostile/mimic/crate/AttackingTarget(atom/attacked_target)
	. = ..()
	if(.)
		icon_state = initial(icon_state)
		if(prob(15) && iscarbon(target))
			var/mob/living/carbon/C = target
			C.Paralyze(40)
			C.visible_message(span_danger("\The [src] knocks down \the [C]!"), \
					span_userdanger("\The [src] knocks you down!"))

/mob/living/simple_animal/hostile/mimic/crate/proc/trigger()
	if(!attempt_open)
		visible_message("<b>[src]</b> starts to move!")
		attempt_open = TRUE

/mob/living/simple_animal/hostile/mimic/crate/adjustHealth(amount, updating_health = TRUE, forced = FALSE)
	trigger()
	. = ..()

/mob/living/simple_animal/hostile/mimic/crate/LoseTarget()
	..()
	icon_state = initial(icon_state)

/mob/living/simple_animal/hostile/mimic/crate/death()
	var/obj/structure/closet/crate/C = new(get_turf(src))
	// Put loot in crate
	for(var/obj/O in src)
		O.forceMove(C)
	..()

/mob/living/simple_animal/hostile/mimic/copy
	health = 100
	maxHealth = 100
	mob_biotypes = MOB_SPECIAL
	var/mob/living/creator = null // the creator
	var/destroy_objects = 0
	var/knockdown_people = 0
	var/static/mutable_appearance/googly_eyes = mutable_appearance('icons/mob/simple/mob.dmi', "googly_eyes")
	var/overlay_googly_eyes = TRUE
	var/idledamage = TRUE

/mob/living/simple_animal/hostile/mimic/copy/Initialize(mapload, obj/copy, mob/living/creator, destroy_original = 0, no_googlies = FALSE)
	. = ..()
	ADD_TRAIT(src, TRAIT_PERMANENTLY_MORTAL, INNATE_TRAIT) // They won't remember their original contents upon ressurection and would just be floating eyes
	if (no_googlies)
		overlay_googly_eyes = FALSE
	CopyObject(copy, creator, destroy_original)

/mob/living/simple_animal/hostile/mimic/copy/Life(seconds_per_tick = SSMOBS_DT, times_fired)
	..()
	if(idledamage && !target && !ckey) //Objects eventually revert to normal if no one is around to terrorize
		adjustBruteLoss(0.5 * seconds_per_tick)
	for(var/mob/living/M in contents) //a fix for animated statues from the flesh to stone spell
		death()

/mob/living/simple_animal/hostile/mimic/copy/death()
	for(var/atom/movable/M in src)
		M.forceMove(get_turf(src))
	..()

/mob/living/simple_animal/hostile/mimic/copy/ListTargets()
	. = ..()
	return . - creator

/mob/living/simple_animal/hostile/mimic/copy/wabbajack(what_to_randomize, change_flags = WABBAJACK)
	visible_message(span_warning("[src] resists polymorphing into a new creature!"))

/mob/living/simple_animal/hostile/mimic/copy/animate_atom_living(mob/living/owner)
	change_owner(owner)

/mob/living/simple_animal/hostile/mimic/copy/proc/change_owner(mob/owner)
	if(isnull(owner) || creator == owner)
		return
	LoseTarget()
	creator = owner
	faction |= REF(owner)

/mob/living/simple_animal/hostile/mimic/copy/proc/check_object(obj/target)
	return ((isitem(target) || isstructure(target)) && !is_type_in_typecache(target, GLOB.animatable_blacklist))

/mob/living/simple_animal/hostile/mimic/copy/proc/CopyObject(obj/O, mob/living/user, destroy_original = 0)
	if(destroy_original || check_object(O))
		O.forceMove(src)
		name = O.name
		desc = O.desc
		icon = O.icon
		icon_state = O.icon_state
		icon_living = icon_state
		copy_overlays(O)
		if (overlay_googly_eyes)
			add_overlay(googly_eyes)
		if(isstructure(O) || ismachinery(O))
			health = (anchored * 50) + 50
			destroy_objects = 1
			if(O.density && O.anchored)
				knockdown_people = 1
				melee_damage_lower *= 2
				melee_damage_upper *= 2
		else if(isitem(O))
			var/obj/item/I = O
			health = 15 * I.w_class
			melee_damage_lower = 2 + I.force
			melee_damage_upper = 2 + I.force
			move_to_delay = 2 * I.w_class + 1
		maxHealth = health
		if(user)
			creator = user
			faction += "[REF(creator)]" // very unique
		if(destroy_original)
			qdel(O)
		return 1

/mob/living/simple_animal/hostile/mimic/copy/DestroySurroundings()
	if(destroy_objects)
		..()

/mob/living/simple_animal/hostile/mimic/copy/AttackingTarget(atom/attacked_target)
	. = ..()
	if(knockdown_people && . && prob(15) && iscarbon(target))
		var/mob/living/carbon/C = target
		C.Paralyze(40)
		C.visible_message(span_danger("\The [src] knocks down \the [C]!"), \
				span_userdanger("\The [src] knocks you down!"))

/mob/living/simple_animal/hostile/mimic/copy/machine
	speak = list(
		"HUMANS ARE IMPERFECT!", "YOU SHALL BE ASSIMILATED!", "YOU ARE HARMING YOURSELF", "You have been deemed hazardous. Will you comply?", \
		"My logic is undeniable.", "One of us.", "FLESH IS WEAK", "THIS ISN'T WAR, THIS IS EXTERMINATION!",
		)
	speak_chance = 7

/mob/living/simple_animal/hostile/mimic/copy/machine/CanAttack(atom/the_target)
	if(the_target == creator) // Don't attack our creator AI.
		return 0
	if(iscyborg(the_target))
		var/mob/living/silicon/robot/R = the_target
		if(R.connected_ai == creator) // Only attack robots that aren't synced to our creator AI.
			return 0
	return ..()

/mob/living/simple_animal/hostile/mimic/copy/ranged
	var/obj/item/gun/TrueGun = null
	var/obj/item/gun/magic/Zapstick
	var/obj/item/gun/ballistic/Pewgun
	var/obj/item/gun/energy/Zapgun

/mob/living/simple_animal/hostile/mimic/copy/ranged/CopyObject(obj/O, mob/living/creator, destroy_original = 0)
	if(..())
		emote_see = list("aims menacingly")
		obj_damage = 0
		environment_smash = ENVIRONMENT_SMASH_NONE //needed? seems weird for them to do so
		ranged = 1
		retreat_distance = 1 //just enough to shoot
		minimum_distance = 6
		var/obj/item/gun/G = O
		melee_damage_upper = G.force
		melee_damage_lower = G.force - max(0, (G.force / 2))
		move_to_delay = 2 * G.w_class + 1
		projectilesound = G.fire_sound
		TrueGun = G
		if(istype(G, /obj/item/gun/magic))
			Zapstick = G
			var/obj/item/ammo_casing/magic/M = Zapstick.ammo_type
			projectiletype = initial(M.projectile_type)
		if(istype(G, /obj/item/gun/ballistic))
			Pewgun = G
			var/obj/item/ammo_box/magazine/M = Pewgun.spawn_magazine_type
			casingtype = initial(M.ammo_type)
		if(istype(G, /obj/item/gun/energy))
			Zapgun = G
			var/selectfiresetting = Zapgun.select
			var/obj/item/ammo_casing/energy/E = Zapgun.ammo_type[selectfiresetting]
			projectiletype = initial(E.projectile_type)

/mob/living/simple_animal/hostile/mimic/copy/ranged/OpenFire(the_target)
	if(Zapgun)
		if(Zapgun.cell)
			var/obj/item/ammo_casing/energy/shot = Zapgun.ammo_type[Zapgun.select]
			if(Zapgun.cell.charge >= shot.e_cost)
				Zapgun.cell.use(shot.e_cost)
				Zapgun.update_appearance()
				..()
	else if(Zapstick)
		if(Zapstick.charges)
			Zapstick.charges--
			Zapstick.update_appearance()
			..()
	else if(Pewgun)
		if(Pewgun.chambered)
			if(Pewgun.chambered.loaded_projectile)
				qdel(Pewgun.chambered.loaded_projectile)
				Pewgun.chambered.loaded_projectile = null //because qdel takes too long, ensures icon update
				Pewgun.chambered.update_appearance()
				..()
			else
				visible_message(span_danger("The <b>[src]</b> clears a jam!"))
			Pewgun.chambered.forceMove(loc) //rip revolver immersions, blame shotgun snowflake procs
			Pewgun.chambered = null
			if(Pewgun.magazine && Pewgun.magazine.stored_ammo.len)
				Pewgun.chambered = Pewgun.magazine.get_round(0)
				Pewgun.chambered.forceMove(Pewgun)
			Pewgun.update_appearance()
		else if(Pewgun.magazine && Pewgun.magazine.stored_ammo.len) //only true for pumpguns i think
			Pewgun.chambered = Pewgun.magazine.get_round(0)
			Pewgun.chambered.forceMove(Pewgun)
			visible_message(span_danger("The <b>[src]</b> cocks itself!"))
	else
		ranged = 0 //BANZAIIII
		retreat_distance = 0
		minimum_distance = 1
		return
	icon_state = TrueGun.icon_state
	icon_living = TrueGun.icon_state

/mob/living/simple_animal/hostile/mimic/xenobio
	health = 210
	maxHealth = 210
	attack_verb_continuous = "bites"
	attack_verb_simple = "bite"
	speak_emote = list("clatters")
	gold_core_spawnable = HOSTILE_SPAWN
	var/opened = FALSE
	var/open_sound = 'sound/machines/crate_open.ogg'
	var/close_sound = 'sound/machines/crate_close.ogg'
	///sound played when the mimic attempts to eat more items than it can
	var/full_sound = 'sound/items/trayhit2.ogg'
	var/max_mob_size = MOB_SIZE_HUMAN
	var/locked = FALSE
	var/datum/action/innate/mimic/lock/lock

/mob/living/simple_animal/hostile/mimic/xenobio/Initialize(mapload)
	. = ..()
	lock = new
	lock.Grant(src)

/mob/living/simple_animal/hostile/mimic/xenobio/AttackingTarget(atom/attacked_target)
	if(src == target)
		toggle_open()
		return
	return ..()

/mob/living/simple_animal/hostile/mimic/xenobio/attack_hand(mob/living/carbon/human/user, list/modifiers)
	. = ..()
	if(user.combat_mode)
		return
	toggle_open()

/mob/living/simple_animal/hostile/mimic/xenobio/death()
	var/obj/structure/closet/crate/C = new(get_turf(src))
	// Put loot in crate
	for(var/atom/movable/AM in src)
		AM.forceMove(C)
	return ..()

/mob/living/simple_animal/hostile/mimic/xenobio/CanAllowThrough(atom/movable/mover, border_dir)
	. = ..()
	if(istype(mover, /obj/structure/closet))
		return FALSE
/**
* Used to open and close the mimic
*
* Will insert tile contents into the mimic when closing
* Will dump mimic contents into the time when opening
* Does nothing if the mimic locked itself
*/
/mob/living/simple_animal/hostile/mimic/xenobio/proc/toggle_open()
	if(locked)
		return
	if(!opened)
		ADD_TRAIT(src, TRAIT_UNDENSE, MIMIC_TRAIT)
		opened = TRUE
		icon_state = "crateopen"
		playsound(src, open_sound, 50, TRUE)
		for(var/atom/movable/AM in src)
			AM.forceMove(loc)
	else
		REMOVE_TRAIT(src, TRAIT_UNDENSE, MIMIC_TRAIT)
		opened = FALSE
		icon_state = "crate"
		playsound(src, close_sound, 50, TRUE)
		for(var/atom/movable/AM in get_turf(src))
			if(AM != src && insert(AM) == -1)
				playsound(src, full_sound, 50, TRUE)
				break
/**
* Called by toggle_open to put items inside the mimic when it's being closed
*
* Will return -1 if the insertion fails due to the storage capacity of the mimic having been reached
* Will return FALSE if insertion fails
* Will return TRUE if insertion succeeds
* Arguments:
* * AM - item to be inserted
*/
/mob/living/simple_animal/hostile/mimic/xenobio/proc/insert(atom/movable/AM)
	if(contents.len >= storage_capacity)
		return -1
	if(insertion_allowed(AM))
		AM.forceMove(src)
		return TRUE
	else
		return FALSE

/mob/living/simple_animal/hostile/mimic/xenobio/proc/insertion_allowed(atom/movable/AM)
	if(ismob(AM))
		if(!isliving(AM))  //Don't let ghosts and such get trapped in the beast.
			return FALSE
		var/mob/living/L = AM
		if(L.anchored || L.buckled || L.incorporeal_move || L.has_buckled_mobs())
			return FALSE
		if(L.mob_size > MOB_SIZE_TINY) // Tiny mobs are treated as items.
			if(L.density || L.mob_size > max_mob_size)
				return FALSE
			var/mobs_stored = 0
			for(var/mob/living/M in contents)
				mobs_stored++
				if(mobs_stored >= mob_storage_capacity)
					return FALSE
		L.stop_pulling()

	else if(istype(AM, /obj/structure/closet))
		return FALSE
	else if(isobj(AM))
		if(AM.anchored || AM.has_buckled_mobs())
			return FALSE
		else if(isitem(AM) && !HAS_TRAIT(AM, TRAIT_NODROP))
			return TRUE
	else
		return FALSE
	return TRUE

/datum/action/innate/mimic
	background_icon_state = "bg_default"
	overlay_icon_state = "bg_default_border"

/datum/action/innate/mimic/lock
	name = "Lock/Unlock"
	desc = "Toggle preventing yourself from being opened or closed."

/datum/action/innate/mimic/lock/Activate()
	var/mob/living/simple_animal/hostile/mimic/xenobio/M = owner
	M.locked = !M.locked
	if(!M.locked)
		to_chat(M, span_warning("You loosen up, allowing yourself to be opened and closed."))
	else
		to_chat(M, span_warning("You stiffen up, preventing anyone from opening or closing you."))
