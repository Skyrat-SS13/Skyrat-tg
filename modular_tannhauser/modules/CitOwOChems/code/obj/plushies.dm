/obj/item/toy/plush
	var/can_random_spawn = TRUE			//if this is FALSE, don't spawn this for random plushies.

/obj/item/toy/plush/carpplushie/dehy_carp
	can_random_spawn = FALSE

GLOBAL_LIST_INIT(valid_plushie_paths, valid_plushie_paths())
/proc/valid_plushie_paths()
	. = list()
	for(var/i in subtypesof(/obj/item/toy/plush))
		var/obj/item/toy/plush/abstract = i
		if(!initial(abstract.can_random_spawn))
			continue
		. += i

/obj/item/toy/plush/plushling
	icon = 'modular_skyrat/master_files/icons/obj/plushes.dmi'
	icon_state = "blue_fox"
	name = "peculiar plushie"
	desc = "An adorable stuffed toy- wait, did it just move?"
	can_random_spawn = FALSE
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
	. = ..()
	user.changeNext_move(CLICK_CD_MELEE) // To avoid spam, in some cases (sadly not all of them)
	var/mob/living/living_user = user
	if(istype(living_user))
		living_user.add_mood_event("plush_bite", /datum/mood_event/plush_bite)
	to_chat(user, "<span class='warning'>You try to pet the plushie, but recoil as it bites your hand instead! OW!</span>")
	var/mob/living/carbon/human/H = user
	if(!H)
		return //Type safety.
	H.apply_damage(5, BRUTE, pick(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM))
	addtimer(CALLBACK(H, /mob/living/carbon/human.proc/dropItemToGround, src, TRUE), 1)

/obj/item/toy/plush/plushling/New()
	var/source_plush_type = pick(GLOB.valid_plushie_paths)
	var/source_plush = new source_plush_type(loc)
	set_appearance(source_plush)
	qdel(source_plush)
	START_PROCESSING(SSobj, src)
	. = ..()

/obj/item/toy/plush/plushling/proc/set_appearance(obj/item/toy/plush/Source_Plush)
	name = "peculiar " + Source_Plush.name
	desc = Source_Plush.desc + " Wait, did it just move?"
	icon = Source_Plush.icon
	icon_state = Source_Plush.icon_state
	inhand_icon_state = Source_Plush.inhand_icon_state
	attack_verb_continuous = Source_Plush.attack_verb_continuous
	attack_verb_simple = Source_Plush.attack_verb_simple
	squeak_override = Source_Plush.squeak_override

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
	visible_message("<span class='warning'>[src] gruesomely mutilliates [victim], leaving nothing more than shredded fluff!</span>")
	new /obj/effect/decal/cleanable/shreds(get_turf(victim), victim.name)
	qdel(victim)

/obj/item/toy/plush/plushling/plop(obj/item/toy/plush/Daddy)
	return FALSE

/obj/item/toy/plush/plushling/love(obj/item/toy/plush/Kisser, mob/living/user) //You shouldn't have come here, poor plush.
	if(!Kisser)
		return
	plushie_absorb(Kisser)
