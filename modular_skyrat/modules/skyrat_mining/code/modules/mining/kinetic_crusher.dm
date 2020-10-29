//kinetic destroyer (premium crusher)
/obj/item/kinetic_crusher/premiumcrusher
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/mining.dmi'
	lefthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/hammer_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/hammer_righthand.dmi'
	name = "Kinetic Destroyer"
	desc = "Revised and refined by veteran miners, this crusher design has been improved in nearly everyway. Featuring a lightweight composite body and a hardened plastitanium head, this weapon is exceptional at removing life from most things."
	hitsound = 'sound/weapons/bladeslice.ogg'
	armour_penetration = 15
	detonation_damage = 60
	backstab_bonus = 40

//legion (the big one!)
/obj/item/crusher_trophy/golden_skull
	name = "golden legion skull"
	desc = "Nope, it's not the crystal one, but still valuable. Suitable as a trophy for a kinetic crusher."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/artifacts.dmi'
	icon_state = "goldenskull"
	denied_type = /obj/item/crusher_trophy/golden_skull

/obj/item/crusher_trophy/golden_skull/effect_desc()
	return "a kinetic crusher to make dead animals into friendly fauna, as well as turning corpses into legions, if the user is on grab intent"

/obj/item/crusher_trophy/golden_skull/on_mark_detonation(mob/living/target, mob/living/user)
	if(target.stat == DEAD)
		if(istype(target, /mob/living/simple_animal/hostile/asteroid) && user.a_intent == INTENT_GRAB)
			var/mob/living/simple_animal/hostile/asteroid/L = target
			L.revive(full_heal = 1, admin_revive = 1)
			L.attack_same = 0
			L.loot = null
			L.crusher_loot = null
			L.faction = user.faction.Copy()
			user.visible_message("<span class='notice'>[user] revives [target] with [src], as a friendly fauna</span>")
			playsound(src,'sound/effects/supermatter.ogg',50,1)

/obj/item/crusher_trophy/golden_skull/on_melee_hit(mob/living/target, mob/living/user)
	var/obj/item/kinetic_crusher/K = loc
	var/is_wielded = TRUE
	if(istype(loc))
		var/datum/component/two_handed/TH = K.GetComponent(/datum/component/two_handed)
		is_wielded = TH.wielded
	if(ishuman(target) && (target.stat == DEAD) && (is_wielded) && user.a_intent == INTENT_GRAB)
		var/confirm = input("Are you sure you want to turn [target] into a friendly legion?", "Legionification") in list("Yes", "No")
		if(confirm == "Yes")
			var/mob/living/carbon/human/H = target
			var/mob/living/simple_animal/hostile/asteroid/hivelord/legion/L = new /mob/living/simple_animal/hostile/asteroid/hivelord/legion(H.loc)
			L.stored_mob = H
			H.forceMove(L)
			L.faction = user.faction.Copy()
			L.revive(full_heal = 1, admin_revive = 1)
			L.attack_same = 0
			L.loot = null
			L.crusher_loot = null
			user.visible_message("<span class='notice'>[user] revives [target] with [src], as a friendly legion.</span>")
			playsound(src,'sound/effects/supermatter.ogg',50,1)
		else
			(to_chat(user, "<span class='notice'>You cancel turning [target] into a legion.</span>"))

//rogue process
/obj/item/crusher_trophy/brokentech
	name = "broken AI"
	desc = "It used to control a mecha, now it's just trash. Suitable as a trophy for a kinetic crusher."
	denied_type = /obj/item/crusher_trophy/brokentech
	icon = 'icons/obj/aicards.dmi'
	icon_state = "pai"
	var/range = 4
	var/cooldowntime = 50
	var/cooldown = 0

/obj/item/crusher_trophy/brokentech/effect_desc()
	return "your kinetic crusher to create shockwaves when fired."

/obj/item/crusher_trophy/brokentech/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	. = ..()
	if(cooldowntime < world.time)
		INVOKE_ASYNC(src, .proc/invokesmoke, user)

/obj/item/crusher_trophy/brokentech/proc/invokesmoke(mob/living/user)
	cooldown = world.time + cooldowntime
	var/list/hit_things = list()
	var/turf/T = get_turf(get_step(user, user.dir))
	var/ogdir = user.dir
	for(var/i = 0, i < src.range, i++)
		new /obj/effect/temp_visual/small_smoke/halfsecond(T)
		for(var/mob/living/L in T.contents)
			if(L != user && !(L in hit_things) && !ishuman(L))
				if(!faction_check(user.faction, L.faction))
					if(prob(25))
						L.Stun(10)
					L.apply_damage_type(20, BRUTE)
		if(ismineralturf(T))
			var/turf/closed/mineral/M = T
			M.gets_drilled(user)
		T = get_step(T, ogdir)
		sleep(2)

//shambling miner
/obj/item/crusher_trophy/blaster_tubes/mask
	name = "mask of a shambling miner"
	desc = "It really doesn't seem like it could be worn. Suitable as a crusher trophy."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/artifacts.dmi'
	icon_state = "miner_mask"
	bonus_value = 10
	denied_type = /obj/item/crusher_trophy/blaster_tubes/mask

/obj/item/crusher_trophy/blaster_tubes/mask/effect_desc()
	return "the crusher to deal <b>[bonus_value]</b> extra melee damage"

/obj/item/crusher_trophy/blaster_tubes/mask/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	if(deadly_shot)
		marker.name = "kinetic [marker.name]"
		marker.icon_state = "ka_tracer"
		marker.damage = bonus_value
		marker.nodamage = FALSE
		deadly_shot = FALSE

/obj/item/crusher_trophy/blaster_tubes/mask/on_mark_application(mob/living/target, datum/status_effect/crusher_mark/mark, had_mark)
	new /obj/effect/temp_visual/kinetic_blast(target)
	playsound(target.loc, 'sound/weapons/kenetic_accel.ogg', 60, 0)

/obj/item/crusher_trophy/blaster_tubes/mask/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	H.force += bonus_value

/obj/item/crusher_trophy/blaster_tubes/mask/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	H.force -= bonus_value

//lava imp
/obj/item/crusher_trophy/blaster_tubes/impskull
	name = "imp skull"
	desc = "Somebody got glory killed. Suitable as a trophy."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/artifacts.dmi'
	icon_state = "impskull"
	bonus_value = 5
	denied_type = /obj/item/crusher_trophy/blaster_tubes/impskull

/obj/item/crusher_trophy/blaster_tubes/impskull/effect_desc()
	return "causes every marker to deal <b>[bonus_value]</b> damage."

/obj/item/crusher_trophy/blaster_tubes/impskull/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	marker.name = "fiery [marker.name]"
	marker.icon_state = "fireball"
	marker.damage = bonus_value
	marker.nodamage = FALSE
	playsound(user.loc, 'modular_skyrat/modules/skyrat_mining/sound/impranged.wav', 50, 0)

//traitor crusher
/obj/projectile/destabilizer/harm
	name = "harmful destabilzing force"
	range = 10

/obj/projectile/destabilizer/harm/on_hit(atom/target, blocked = FALSE)
	if(isliving(target))
		var/mob/living/L = target
		var/had_effect = (L.has_status_effect(STATUS_EFFECT_CRUSHERMARK_HARM)) //used as a boolean
		var/datum/status_effect/crusher_mark/CM = L.apply_status_effect(STATUS_EFFECT_CRUSHERMARK_HARM, hammer_synced)
		if(hammer_synced)
			for(var/t in hammer_synced.trophies)
				var/obj/item/crusher_trophy/T = t
				T.on_mark_application(target, CM, had_effect)
	var/target_turf = get_turf(target)
	if(ismineralturf(target_turf))
		var/turf/closed/mineral/M = target_turf
		new /obj/effect/temp_visual/kinetic_blast(M)
		M.gets_drilled(firer)
	..()

//Harm crusher
/datum/status_effect/crusher_mark/harm
	id = "crusher_mark_harm"
	duration = 100

/datum/status_effect/crusher_mark/harm/on_apply()
	. = ..()
	marked_underlay = mutable_appearance('icons/effects/effects.dmi', "shield2")
	marked_underlay.pixel_x = -owner.pixel_x
	marked_underlay.pixel_y = -owner.pixel_y
	owner.underlays += marked_underlay
	return TRUE

/obj/item/kinetic_crusher/harm
	desc = "An early design of the proto-kinetic accelerator, it is little more than an combination of various mining tools cobbled together, forming a high-tech club. \
	While it is an effective mining tool, it did little to aid any but the most skilled and/or suicidal miners against local fauna. Something's very odd about this one, however..."

/obj/item/kinetic_crusher/harm/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	if(istype(target, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = target
		T.add_to(src, user)
	if(!wielded)
		return
	if(!proximity_flag && charged)//Mark a target, or mine a tile.
		var/turf/proj_turf = user.loc
		if(!isturf(proj_turf))
			return
		var/obj/projectile/destabilizer/harm/D = new /obj/projectile/destabilizer/harm(proj_turf)
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_projectile_fire(D, user)
		D.preparePixelProjectile(target, user, clickparams)
		D.firer = user
		D.hammer_synced = src
		playsound(user, 'sound/weapons/plasma_cutter.ogg', 100, 1)
		D.fire()
		charged = FALSE
		update_icon()
		addtimer(CALLBACK(src, .proc/Recharge), charge_time)
		return
	if(proximity_flag && isliving(target))
		var/mob/living/L = target
		var/datum/status_effect/crusher_mark/CM = L.has_status_effect(STATUS_EFFECT_CRUSHERMARK_HARM)
		if(!CM || CM.hammer_synced != src || !L.remove_status_effect(STATUS_EFFECT_CRUSHERMARK_HARM))
			return
		var/datum/status_effect/crusher_damage/C = L.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		var/target_health = L.health
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_mark_detonation(target, user)
		if(!QDELETED(L))
			if(!QDELETED(C))
				C.total_damage += target_health - L.health //we did some damage, but let's not assume how much we did
			new /obj/effect/temp_visual/kinetic_blast(get_turf(L))
			var/backstab_dir = get_dir(user, L)
			var/def_check = L.getarmor(type = "bomb")
			if((user.dir & backstab_dir) && (L.dir & backstab_dir))
				if(!QDELETED(C))
					C.total_damage += detonation_damage + backstab_bonus //cheat a little and add the total before killing it, so certain mobs don't have much lower chances of giving an item
				L.apply_damage(detonation_damage + backstab_bonus, BRUTE, blocked = def_check)
				playsound(user, 'sound/weapons/kenetic_accel.ogg', 100, 1) //Seriously who spelled it wrong
			else
				if(!QDELETED(C))
					C.total_damage += detonation_damage
				L.apply_damage(detonation_damage, BRUTE, blocked = def_check)

			if(user && lavaland_equipment_pressure_check(get_turf(user))) //CIT CHANGE - makes sure below only happens in low pressure environments
				user.adjustStaminaLoss(-30)//CIT CHANGE - makes crushers heal stamina
	SEND_SIGNAL(src, COMSIG_ITEM_AFTERATTACK, target, user, proximity_flag, clickparams)
	SEND_SIGNAL(user, COMSIG_MOB_ITEM_AFTERATTACK, target, user, proximity_flag, clickparams)

//king goat
/obj/item/crusher_trophy/king_goat
	name = "king goat hoof"
	desc = "A hoof from the king of all goats, it still glows with a fraction of its original power... Suitable as a trophy for a kinetic crusher."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/artifacts.dmi'
	icon_state = "goat_hoof" //needs a better sprite but I cant sprite .
	denied_type = /obj/item/crusher_trophy/king_goat

/obj/item/crusher_trophy/king_goat/effect_desc()
	return "you also passively recharge markers 5x as fast while equipped and do a decent amount of damage at the cost of dulling the blade"

/obj/item/crusher_trophy/king_goat/on_projectile_fire(obj/projectile/destabilizer/marker, mob/living/user)
	marker.damage = 10 //in my testing only does damage to simple mobs so should be fine to have it high

/obj/item/crusher_trophy/king_goat/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		var/datum/component/two_handed/TH = H.GetComponent(/datum/component/two_handed)
		H.charge_time -= 12
		TH.force_wielded -= 15

/obj/item/crusher_trophy/king_goat/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		var/datum/component/two_handed/TH = H.GetComponent(/datum/component/two_handed)
		H.charge_time += 15
		TH.force_wielded += 12

//hierophant crusher small changes
/obj/item/crusher_trophy/vortex_talisman
	var/cdmultiplier = 1.25
	var/vortex_cd

/obj/item/crusher_trophy/vortex_talisman/on_mark_detonation(mob/living/target, mob/living/user)
	if(vortex_cd >= world.time)
		return
	var/turf/T = get_turf(user)
	var/obj/effect/temp_visual/hierophant/wall/crusher/wall = new /obj/effect/temp_visual/hierophant/wall/crusher(T, user) //a wall only you can pass!
	var/turf/otherT = get_step(T, turn(user.dir, 90))
	if(otherT)
		new /obj/effect/temp_visual/hierophant/wall/crusher(otherT, user)
	otherT = get_step(T, turn(user.dir, -90))
	if(otherT)
		new /obj/effect/temp_visual/hierophant/wall/crusher(otherT, user)
	vortex_cd = world.time + (wall.duration * cdmultiplier)

//gladiator
/obj/item/crusher_trophy/gladiator
	name = "gladiator's horn"
	desc = "The remaining horn of the Gladiator. Suitable as a crusher trophy."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/artifacts.dmi'
	icon_state = "horn"
	bonus_value = 15
	denied_type = /obj/item/crusher_trophy/gladiator

/obj/item/crusher_trophy/gladiator/effect_desc()
	return "the crusher to have a <b>[bonus_value]%</b> chance to block any incoming attack."

/obj/item/crusher_trophy/gladiator/add_to(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.block_chance += bonus_value

/obj/item/crusher_trophy/gladiator/remove_from(obj/item/kinetic_crusher/H, mob/living/user)
	. = ..()
	if(.)
		H.block_chance -= bonus_value

//hierophant crusher nerf "but muh i deserve it after killing hierocunt" yes but its op fuck you you piece of shit
/obj/effect/temp_visual/hierophant/wall/crusher
	duration = 40 //this is more than enough time bro

//watcher wing slight nerf
/obj/item/crusher_trophy/watcher_wing
	bonus_value = 5

//gladiator zweihander - it's just a one handed crusher
/obj/item/melee/zweihander
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/artifacts.dmi'
	icon_state = "zweihander"
	resistance_flags = FIRE_PROOF | UNACIDABLE | INDESTRUCTIBLE
	lefthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/swords_lefthand.dmi'
	righthand_file = 'modular_skyrat/modules/skyrat_mining/icons/mob/inhands/swords_righthand.dmi'
	name = "Zweihander"
	desc = "A surprisingly tough sword, made out of drake hide and bone. Somehow, despite it's large size, it's easy to carry one handed."
	force = 15
	w_class = WEIGHT_CLASS_BULKY
	throwforce = 15
	throw_speed = 4
	armour_penetration = 20
	custom_materials = list(/datum/material/titanium=3150, /datum/material/glass=2075, /datum/material/gold=3000, /datum/material/diamond=5000)
	hitsound = 'modular_skyrat/modules/skyrat_mining/sound/zweihanderslice.ogg'
	attack_verb_continuous = list("smashes", "crushes", "cleaves", "chops", "pulps")
	attack_verb_simple = list("smash", "crush", "cleave", "chop", "pulp")
	sharpness = SHARP_EDGED
	var/list/trophies = list()
	var/charged = TRUE
	var/charge_time = 12
	var/detonation_damage = 65
	var/backstab_bonus = 40
	var/brightness = 7

/obj/item/melee/zweihander/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 80, 110)
	set_light(brightness)

/obj/item/melee/zweihander/Destroy()
	QDEL_LIST(trophies)
	return ..()

/obj/item/melee/zweihander/examine(mob/living/user)
	. = ..()
	. += "<span class='notice'>Mark a large creature with the destabilizing force, then hit them in melee to do <b>[force + detonation_damage]</b> damage.</span>"
	. += "<span class='notice'>Does <b>[force + detonation_damage + backstab_bonus]</b> damage if the target is backstabbed, instead of <b>[force + detonation_damage]</b>.</span>"
	for(var/t in trophies)
		var/obj/item/crusher_trophy/T = t
		. += "<span class='notice'>It has \a [T] attached, which causes [T.effect_desc()].</span>"

/obj/item/melee/zweihander/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/crowbar))
		if(LAZYLEN(trophies))
			to_chat(user, "<span class='notice'>You remove [src]'s trophies.</span>")
			I.play_tool_sound(src)
			for(var/t in trophies)
				var/obj/item/crusher_trophy/T = t
				T.remove_from(src, user)
		else
			to_chat(user, "<span class='warning'>There are no trophies on [src].</span>")
	else if(istype(I, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = I
		T.add_to(src, user)
	else
		return ..()

/obj/item/melee/zweihander/attack(mob/living/target, mob/living/carbon/user)
	var/datum/status_effect/crusher_damage/C = target.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
	var/target_health = target.health
	..()
	for(var/t in trophies)
		if(!QDELETED(target))
			var/obj/item/crusher_trophy/T = t
			T.on_melee_hit(target, user)
	if(!QDELETED(C) && !QDELETED(target))
		C.total_damage += target_health - target.health //we did some damage, but let's not assume how much we did

/obj/item/melee/zweihander/afterattack(atom/target, mob/living/user, proximity_flag, clickparams)
	. = ..()
	if(istype(target, /obj/item/crusher_trophy))
		var/obj/item/crusher_trophy/T = target
		T.add_to(src, user)
	if(!proximity_flag && charged)//Mark a target, or mine a tile.
		var/turf/proj_turf = user.loc
		if(!isturf(proj_turf))
			return
		var/obj/projectile/destabilizer/D = new /obj/projectile/destabilizer(proj_turf)
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_projectile_fire(D, user)
		D.preparePixelProjectile(target, user, clickparams)
		D.firer = user
		D.hammer_synced = src
		playsound(user, 'sound/weapons/plasma_cutter.ogg', 100, 1)
		D.fire()
		charged = FALSE
		update_icon()
		addtimer(CALLBACK(src, .proc/Recharge), charge_time)
		return
	if(proximity_flag && isliving(target))
		var/mob/living/L = target
		var/datum/status_effect/crusher_mark/CM = L.has_status_effect(STATUS_EFFECT_CRUSHERMARK)
		if(!CM || CM.hammer_synced != src || !L.remove_status_effect(STATUS_EFFECT_CRUSHERMARK))
			return
		var/datum/status_effect/crusher_damage/C = L.has_status_effect(STATUS_EFFECT_CRUSHERDAMAGETRACKING)
		var/target_health = L.health
		for(var/t in trophies)
			var/obj/item/crusher_trophy/T = t
			T.on_mark_detonation(target, user)
		if(!QDELETED(L))
			if(!QDELETED(C))
				C.total_damage += target_health - L.health //we did some damage, but let's not assume how much we did
			new /obj/effect/temp_visual/kinetic_blast(get_turf(L))
			var/backstab_dir = get_dir(user, L)
			var/def_check = L.getarmor(type = "bomb")
			if((user.dir & backstab_dir) && (L.dir & backstab_dir))
				if(!QDELETED(C))
					C.total_damage += detonation_damage + backstab_bonus //cheat a little and add the total before killing it, so certain mobs don't have much lower chances of giving an item
				L.apply_damage(detonation_damage + backstab_bonus, BRUTE, blocked = def_check)
				playsound(user, 'sound/weapons/kenetic_accel.ogg', 100, 1) //Seriously who spelled it wrong
			else
				if(!QDELETED(C))
					C.total_damage += detonation_damage
				L.apply_damage(detonation_damage, BRUTE, blocked = def_check)

			if(user && lavaland_equipment_pressure_check(get_turf(user))) //CIT CHANGE - makes sure below only happens in low pressure environments
				user.adjustStaminaLoss(-30)//CIT CHANGE - makes crushers heal stamina

/obj/item/melee/zweihander/proc/Recharge()
	if(!charged)
		charged = TRUE
		update_icon()
		playsound(src.loc, 'sound/weapons/kenetic_reload.ogg', 60, 1)

//great brown wolf sif
/obj/item/crusher_trophy/dark_energy
	name = "dark energy"
	desc = "A black ball of energy that was formed when Sif miraculously imploded. Suitable as a trophy for a kinetic crusher."
	icon = 'modular_skyrat/modules/skyrat_mining/icons/obj/sif.dmi'
	icon_state = "sif_energy"
	denied_type = /obj/item/crusher_trophy/dark_energy
	bonus_value = 30
	var/range = 3

/obj/item/crusher_trophy/dark_energy/effect_desc()
	return "mark detonation to perform a bash dealing <b>[bonus_value]</b> - dashing through the target if possible"

/obj/item/crusher_trophy/dark_energy/on_mark_detonation(mob/living/target, mob/living/user)
	if(!target || !user)
		return
	var/chargeturf = get_turf(target) //get target turf
	if(!chargeturf)
		return
	var/dir = get_dir(user, chargeturf)//get direction
	var/turf/T = get_ranged_target_turf(chargeturf,dir,range)//get final dash turf
	if(!T) //the final dash turf was out of range - we settle for the target turf instead
		T = chargeturf
	playsound(user, pick('modular_skyrat/modules/skyrat_mining/sound/sif/whoosh1.ogg', 'modular_skyrat/modules/skyrat_mining/sound/sif/whoosh2.ogg', 'modular_skyrat/modules/skyrat_mining/sound/sif/whoosh3.ogg'), 300, 1)
	new /obj/effect/temp_visual/decoy/fading(user.loc, user)
	//Stop movement
	walk(user,0)
	setDir(dir)
	var/movespeed = 0.7
	//Apply damage
	target.apply_damage(bonus_value, BRUTE)
	playsound(user, 'sound/effects/meteorimpact.ogg', 200, 1, 2, 1)
	//Dash through the target if possible (it was a furious bash after all)
	if(target.CanPass(user, T))
		walk_to(user, T, 0, 1, movespeed)
		playsound(user, pick('modular_skyrat/modules/skyrat_mining/sound/sif/whoosh1.ogg', 'modular_skyrat/modules/skyrat_mining/sound/sif/whoosh2.ogg', 'modular_skyrat/modules/skyrat_mining/sound/sif/whoosh3.ogg'), 300, 1)
		new /obj/effect/temp_visual/decoy/fading(user.loc, user)
	//Stop movement
	walk(user, 0)
