/// Checks that all rituals work fully as intended
/datum/unit_test/ash_rituals

/datum/unit_test/ash_rituals/Run()
	var/obj/effect/ash_rune/our_rune = allocate(/obj/effect/ash_rune, FALSE)
	var/mob/living/carbon/human/our_human = allocate(/mob/living/carbon/human)
	our_human.set_species(/datum/species/lizard/ashwalker)
	our_human.mind_initialize()
	our_human.mind.add_antag_datum(/datum/antagonist/ashwalker)

	our_rune.forceMove(locate((run_loc_floor_bottom_left.x + 1), (run_loc_floor_bottom_left.y + 1), run_loc_floor_bottom_left.z))
	our_rune.spawn_side_runes()

	for(var/type in subtypesof(/datum/ash_ritual))
		var/datum/ash_ritual/spawned_ritual = new type
		if(spawned_ritual.ritual_bitflags & ASH_RITUAL_AGING)
			qdel(spawned_ritual)
			continue
		spawned_ritual.ritual_time = 0
		our_rune.current_ritual = spawned_ritual
		for(var/requirement_dir in spawned_ritual.required_components)
			var/atom/required_atom = spawned_ritual.required_components[requirement_dir]
			new required_atom(get_step(our_rune, requirement_dir))
		spawned_ritual.ritual_start(our_rune)

		var/list/result_amount = list(0, length(spawned_ritual.ritual_success_items))
		for(var/atom/movable/atoms_near in range(1, our_rune))
			if(istype(atoms_near, /obj/effect/ash_rune) || istype(atoms_near, /obj/effect/side_rune) || istype(atoms_near, /mob/living/carbon/human))
				continue
			for(var/type in spawned_ritual.consumed_components)
				if(istype(atoms_near, type))
					TEST_FAIL("Ash Rituals: [type] was found unconsumed in [spawned_ritual.type] by the ritual circle, even though it was specified that it should.")
					continue
			for(var/type in spawned_ritual.ritual_success_items)
				if(istype(atoms_near, type))
					result_amount[1]++
					continue
			if(result_amount[1] != result_amount[2])
				TEST_FAIL("Ash Rituals: [spawned_ritual.type] did not produce the expected amount of result items.")
			if(result_amount[1] == 0 && !(spawned_ritual.ritual_bitflags & ASH_RITUAL_NO_RESULT))
				TEST_FAIL("Ash Rituals: [spawned_ritual.type] did not produce any result items while lacking the ASH_RITUAL_NO_RESULT bitflag.")
		qdel(spawned_ritual)

	var/datum/ash_ritual/ash_ceremony/aging_ritual = new
	our_human.forceMove(our_rune.loc)
	for(var/requirement_dir in aging_ritual.required_components)
		var/atom/required_atom = aging_ritual.required_components[requirement_dir]
		new required_atom(get_step(our_rune, requirement_dir))
	aging_ritual.ritual_time = 0
	var/datum/component/ash_age/ashie_aging = our_human.GetComponent(/datum/component/ash_age)
	if(!ashie_aging)
		TEST_FAIL("Ash Rituals: Ashwalker did not get ash_age component!")
	ashie_aging.evo_time = 0
	var/current_age = ashie_aging.current_stage
	aging_ritual.ritual_start(our_rune)
	if(ashie_aging.current_stage != (current_age + 1))
		TEST_FAIL("Ash Rituals: [aging_ritual.type] did not age the ashwalker correctly (expected [current_age + 1], recieved [ashie_aging.current_stage]!")
	qdel(aging_ritual)

	qdel(our_human)
	qdel(our_rune)
