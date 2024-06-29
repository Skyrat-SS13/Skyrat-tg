/*
	The holodeck activates these shortly after the program loads,
	and deactivates them immediately before changing or disabling the holodeck.

	These remove snowflake code for special holodeck functions.
*/
/obj/effect/holodeck_effect
	icon = 'icons/hud/screen_gen.dmi'
	icon_state = "x2"
	invisibility = INVISIBILITY_ABSTRACT

/obj/effect/holodeck_effect/proc/activate(obj/machinery/computer/holodeck/HC)
	return

/obj/effect/holodeck_effect/proc/deactivate(obj/machinery/computer/holodeck/HC)
	qdel(src)
	return

// Called by the holodeck computer as long as the program is running
/obj/effect/holodeck_effect/proc/tick(obj/machinery/computer/holodeck/HC)
	return

/obj/effect/holodeck_effect/proc/safety(active)
	return

// Generates a holodeck-tracked card deck
/obj/effect/holodeck_effect/cards
	icon = 'icons/obj/toys/playing_cards.dmi'
	icon_state = "deck_syndicate_full"

/obj/effect/holodeck_effect/cards/activate(obj/machinery/computer/holodeck/holodeck)
	var/obj/item/toy/cards/deck/syndicate/holographic/deck = new(loc, holodeck)
	deck.flags_1 |= HOLOGRAM_1
	return deck

/obj/effect/holodeck_effect/sparks/activate(obj/machinery/computer/holodeck/HC)
	var/turf/T = get_turf(src)
	if(T)
		var/datum/effect_system/spark_spread/s = new
		s.set_up(3, 1, T)
		s.start()
		T.temperature = 5000 //Why? not quite sure to be honest with you
		T.hotspot_expose(50000,50000,1)

/obj/effect/holodeck_effect/random_book


/obj/effect/holodeck_effect/random_book/activate(obj/machinery/computer/holodeck/father_holodeck)
	var/static/banned_books = list(/obj/item/book/manual/random, /obj/item/book/manual/nuclear, /obj/item/book/manual/wiki)
	var/newtype = pick(subtypesof(/obj/item/book/manual) - banned_books)
	var/obj/item/book/manual/to_spawn = new newtype(loc)
	to_spawn.flags_1 |= HOLOGRAM_1
	to_spawn.obj_flags |= NO_DEBRIS_AFTER_DECONSTRUCTION
	return to_spawn

/obj/effect/holodeck_effect/mobspawner
	var/mobtype = /mob/living/basic/carp/holographic
	var/mob/our_mob = null

/obj/effect/holodeck_effect/mobspawner/activate(obj/machinery/computer/holodeck/HC)
	if(islist(mobtype))
		mobtype = pick(mobtype)
	our_mob = new mobtype(loc)
	our_mob.flags_1 |= HOLOGRAM_1

	// these vars are not really standardized but all would theoretically create stuff on death
	our_mob.add_traits(list(TRAIT_PERMANENTLY_MORTAL, TRAIT_NO_BLOOD_OVERLAY, TRAIT_NOBLOOD, TRAIT_NOHUNGER), INNATE_TRAIT)
	RegisterSignal(our_mob, COMSIG_QDELETING, PROC_REF(handle_mob_delete))
	return our_mob

/obj/effect/holodeck_effect/mobspawner/deactivate(obj/machinery/computer/holodeck/HC)
	if(our_mob)
		HC.derez(our_mob)
	qdel(src)

/obj/effect/holodeck_effect/mobspawner/proc/handle_mob_delete(datum/source)
	SIGNAL_HANDLER
	our_mob = null

/obj/effect/holodeck_effect/mobspawner/pet

/obj/effect/holodeck_effect/mobspawner/pet/Initialize(mapload)
	. = ..()
	mobtype = list(
		/mob/living/basic/butterfly,
		/mob/living/basic/chick/permanent,
		/mob/living/basic/pet/fox/docile,
		/mob/living/basic/rabbit,
	)
	mobtype += pick(
		/mob/living/basic/pet/dog/corgi,
		/mob/living/basic/pet/dog/corgi/puppy,
		/mob/living/basic/pet/dog/pug,
	)
	mobtype += pick(
		/mob/living/basic/pet/cat,
		/mob/living/basic/pet/cat/kitten,
	)

/obj/effect/holodeck_effect/mobspawner/bee
	mobtype = /mob/living/basic/bee/toxin

/obj/effect/holodeck_effect/mobspawner/monkey
	mobtype = /mob/living/carbon/human/species/monkey

/obj/effect/holodeck_effect/mobspawner/monkey/activate(obj/machinery/computer/holodeck/computer)
	var/mob/living/carbon/human/monkey = ..()
	. = list() + monkey

	for(var/atom/atom as anything in monkey.contents + monkey.organs)
		. += atom

/obj/effect/holodeck_effect/mobspawner/penguin
	mobtype = /mob/living/basic/pet/penguin/emperor/neuter

/obj/effect/holodeck_effect/mobspawner/penguin/Initialize(mapload)
	if(prob(1))
		mobtype = /mob/living/basic/pet/penguin/emperor/shamebrero/neuter
	return ..()

/obj/effect/holodeck_effect/mobspawner/penguin_baby
	mobtype = /mob/living/basic/pet/penguin/baby/permanent

/obj/effect/holodeck_effect/mobspawner/crab/jon
	mobtype = /mob/living/basic/crab/jon
