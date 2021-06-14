/obj/item/toy/plush
	var/can_random_spawn = TRUE			//if this is FALSE, don't spawn this for random plushies.
//	var/snowflake_idvar/snowflake_id


GLOBAL_LIST_INIT(valid_plushie_paths, valid_plushie_paths())
/proc/valid_plushie_paths()
	. = list()
	for(var/i in subtypesof(/obj/item/toy/plush))
		var/obj/item/toy/plush/abstract = i
		if(!initial(abstract.can_random_spawn))
			continue
		. += i

/obj/item/toy/plush/random
	name = "Illegal plushie"
	desc = "Something fucked up"

/obj/item/toy/plush/random/Initialize()
	SHOULD_CALL_PARENT(FALSE)
	var/newtype = pick(GLOB.valid_plushie_paths)
//	var/list/snowflake_list = CONFIG_GET(keyed_list/snowflake_plushies)

	/// If there are no snowflake plushies we'll default to base plush, so we grab from the valid list
//	if (snowflake_list.len)
//		newtype = prob(CONFIG_GET(number/snowflake_plushie_prob)) ? /obj/item/toy/plush/random_snowflake : pick(GLOB.valid_plushie_paths)
//	else
//		newtype = pick(GLOB.valid_plushie_paths)

	new newtype(loc)
	return INITIALIZE_HINT_QDEL

/obj/item/toy/plush/plushling
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "blue_fox"
	name = "peculiar plushie"
	desc = "An adorable stuffed toy- wait, did it just move?"
	var/absorb_cooldown = 100 //ticks cooldown between absorbs
	var/next_absorb = 0 //When can it absorb another plushie
	var/check_interval = 20
	var/next_check = 0

/datum/mood_event/plush_bite
	description = "<span class='warning'>IT BIT ME!! OW!</span>\n"
	mood_change = -3
	timeout = 2 MINUTES

//Overrides parent proc
/obj/item/toy/plush/plushling/attack_self(mob/user)
	if(!user) //hmmmmm
		return
	to_chat(user, "<span class='warning'>You try to pet the plushie, but recoil as it bites your hand instead! OW!</span>")
	SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT,"plush_bite", /datum/mood_event/plush_bite)
	var/mob/living/carbon/human/H = user
	if(!H)
		return //Type safety.
	H.apply_damage(5, BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
	addtimer(CALLBACK(H, /mob/living/carbon/human.proc/dropItemToGround, src, TRUE), 1)

/obj/item/toy/plush/plushling/New()
	var/initial_state = pick("plushie_lizard", "plushie_snake", "plushie_slime", "plushie_fox")
	icon_state = initial_state
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/item/toy/plush/plushling/Destroy()
	STOP_PROCESSING(SSobj, src)
	. = ..()

/obj/item/toy/plush/plushling/process()
	if(world.time < next_absorb || world.time < next_check)
		return
	next_check = world.time + check_interval
	var/obj/item/toy/plush/target
	for(var/obj/item/toy/plush/possible_target in loc) //First, it tries to get anything in its same location, be it a tile or a backpack
		if(possible_target == src || istype(possible_target, /obj/item/toy/plush/plushling))
			continue
		target = possible_target
		break
	if(!target)
		if(!isturf(loc))
			return
		for(var/obj/item/toy/plush/P in oview(1, src)) //If that doesn't work, it hunts for plushies adjacent to its own tile
			if(istype(P, /obj/item/toy/plush/plushling)) //These do not hunt their own kind
				continue
			src.throw_at(P, 1, 2)
			visible_message("<span class='danger'>[src] leaps at [P]!</span>")
			break
		return
	if(istype(target, /obj/item/toy/plush/plushling)) //These do not consume their own.
		return
	next_absorb = world.time + absorb_cooldown
	plushie_absorb(target)

/obj/item/toy/plush/plushling/proc/plushie_absorb(obj/item/toy/plush/victim)
//	if(!victim)
//		return
	visible_message("<span class='warning'>[src] gruesomely mutilliates [victim], leaving nothing more than dust!</span>")
/*	if(victim.snowflake_id) //Snowflake code for snowflake plushies.
		set_snowflake_from_config(victim.snowflake_id)
		desc += " Wait, did it just move..?"
	else
		name = victim.name
		desc = victim.desc + " Wait, did it just move..?"
		icon_state = victim.icon_state
		squeak_override = victim.squeak_override
		attack_verb_simple = victim.attack_verb_simple
*/
	new /obj/effect/decal/cleanable/ash(get_turf(victim))
	qdel(victim)

/obj/item/toy/plush/plushling/love(obj/item/toy/plush/Kisser, mob/living/user) //You shouldn't have come here, poor plush.
	if(!Kisser)
		return
	plushie_absorb(Kisser)
