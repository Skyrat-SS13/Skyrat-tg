// Sidepaths for knowledge between Void and Blade.

/// The max health given to Shattered Risen
#define RISEN_MAX_HEALTH 125

/datum/heretic_knowledge/limited_amount/risen_corpse
	name = "Shattered Ritual"
	desc = "Allows you to transmute a corpse with a soul, a pair of latex or nitrile gloves, and \
		and any exosuit clothing (such as armor) to create a Shattered Risen. \
		Shattered Risen are strong ghouls that have 125 health, but cannot hold items, \
		instead having two brutal weapons for hands. You can only create one at a time."
	gain_text = "I witnessed a cold, rending force drag this corpse back to near-life. \
		When it moves, it crunches like broken glass. Its hands are no longer recognizable as human - \
		each clenched fist contains a brutal nest of sharp bone-shards instead."
	next_knowledge = list(
		/datum/heretic_knowledge/cold_snap,
		/datum/heretic_knowledge/blade_dance,
	)
	required_atoms = list(
		/obj/item/clothing/suit = 1,
		/obj/item/clothing/gloves/latex = 1,
	)
	limit = 1
	cost = 1
	route = PATH_SIDE

/datum/heretic_knowledge/limited_amount/risen_corpse/recipe_snowflake_check(mob/living/user, list/atoms, list/selected_atoms, turf/loc)
	. = ..()
	if(!.)
		return FALSE

	for(var/mob/living/carbon/human/body in atoms)
		if(body.stat != DEAD)
			continue
		if(!IS_VALID_GHOUL_MOB(body) || HAS_TRAIT(body, TRAIT_HUSK))
			to_chat(user, span_hierophant_warning("[body] is not in a valid state to be made into a ghoul."))
			continue
		if(!body.mind)
			to_chat(user, span_hierophant_warning("[body] is mindless and cannot be made into a ghoul."))
			continue
		if(!body.client && !body.mind.get_ghost(ghosts_with_clients = TRUE))
			to_chat(user, span_hierophant_warning("[body] is soulless and cannot be made into a ghoul."))
			continue

		// We will only accept valid bodies with a mind, or with a ghost connected that used to control the body
		selected_atoms += body
		return TRUE

	loc.balloon_alert(user, "ritual failed, no valid body!")
	return FALSE

/datum/heretic_knowledge/limited_amount/risen_corpse/on_finished_recipe(mob/living/user, list/selected_atoms, turf/loc)
	var/mob/living/carbon/human/soon_to_be_ghoul = locate() in selected_atoms
	if(QDELETED(soon_to_be_ghoul)) // No body? No ritual
		stack_trace("[type] reached on_finished_recipe without a human in selected_atoms to make a ghoul out of.")
		loc.balloon_alert(user, "ritual failed, no valid body!")
		return FALSE

	soon_to_be_ghoul.grab_ghost()
	if(!soon_to_be_ghoul.mind || !soon_to_be_ghoul.client)
		stack_trace("[type] reached on_finished_recipe without a minded / cliented human in selected_atoms to make a ghoul out of.")
		loc.balloon_alert(user, "ritual failed, no valid body!")
		return FALSE

	selected_atoms -= soon_to_be_ghoul
	make_risen(user, soon_to_be_ghoul)
	return TRUE

/// Make [victim] into a shattered risen ghoul.
/datum/heretic_knowledge/limited_amount/risen_corpse/proc/make_risen(mob/living/user, mob/living/carbon/human/victim)
	user.log_message("created a shattered risen out of [key_name(victim)].", LOG_GAME)
	victim.log_message("became a shattered risen of [key_name(user)]'s.", LOG_VICTIM, log_globally = FALSE)
	message_admins("[ADMIN_LOOKUPFLW(user)] created a shattered risen, [ADMIN_LOOKUPFLW(victim)].")

	victim.apply_status_effect(
		/datum/status_effect/ghoul,
		RISEN_MAX_HEALTH,
		user.mind,
		CALLBACK(src, PROC_REF(apply_to_risen)),
		CALLBACK(src, PROC_REF(remove_from_risen)),
	)

/// Callback for the ghoul status effect - what effects are applied to the ghoul.
/datum/heretic_knowledge/limited_amount/risen_corpse/proc/apply_to_risen(mob/living/risen)
	LAZYADD(created_items, WEAKREF(risen))
	risen.AddComponent(/datum/component/mutant_hands, mutant_hand_path = /obj/item/mutant_hand/shattered_risen)

/// Callback for the ghoul status effect - cleaning up effects after the ghoul status is removed.
/datum/heretic_knowledge/limited_amount/risen_corpse/proc/remove_from_risen(mob/living/risen)
	LAZYREMOVE(created_items, WEAKREF(risen))
	qdel(risen.GetComponent(/datum/component/mutant_hands))

#undef RISEN_MAX_HEALTH

/// The "hand" "weapon" used by shattered risen
/obj/item/mutant_hand/shattered_risen
	name = "bone-shards"
	desc = "What once appeared to be a normal human fist, now holds a maulled nest of sharp bone-shards."
	color = "#001aff"
	hitsound = SFX_SHATTER
	force = 16
	wound_bonus = -30
	bare_wound_bonus = 15
	demolition_mod = 1.5
	sharpness = SHARP_EDGED

/obj/item/mutant_hand/shattered_risen/Initialize(mapload)
	. = ..()
	ADD_TRAIT(src, TRAIT_NODROP, HAND_REPLACEMENT_TRAIT)

/obj/item/mutant_hand/shattered_risen/visual_equipped(mob/user, slot)
	. = ..()

	// Even hand indexes are right hands,
	// Odd hand indexes are left hand
	// ...But also, we swap it intentionally here,
	// so right icon is shown on the left (Because hands)
	if(user.get_held_index_of_item(src) % 2 == 1)
		icon_state = "[base_icon_state]_right"
	else
		icon_state = "[base_icon_state]_left"

/datum/heretic_knowledge/rune_carver
	name = "Carving Knife"
	desc = "Allows you to transmute a knife, a shard of glass, and a piece of paper to create a Carving Knife. \
		The Carving Knife allows you to etch difficult to see traps that trigger on heathens who walk overhead. \
		Also makes for a handy throwing weapon."
	gain_text = "Etched, carved... eternal. There is power hidden in everything. I can unveil it! \
		I can carve the monolith to reveal the chains!"
	next_knowledge = list(
		/datum/heretic_knowledge/spell/void_phase,
		/datum/heretic_knowledge/duel_stance,
	)
	required_atoms = list(
		/obj/item/knife = 1,
		/obj/item/shard = 1,
		/obj/item/paper = 1,
	)
	result_atoms = list(/obj/item/melee/rune_carver)
	cost = 1
	route = PATH_SIDE

/datum/heretic_knowledge/summon/maid_in_mirror
	name = "Maid in the Mirror"
	desc = "Allows you to transmute five sheets of titanium, a flash, a suit of armor, and a pair of lungs \
		to create a Maid in the Mirror. Maid in the Mirrors are decent combatants that can become incorporeal by \
		phasing in and out of the mirror realm, serving as powerful scouts and ambushers. \
		However, they are weak to mortal gaze and take damage by being examined."
	gain_text = "Within each reflection, lies a gateway into an unimaginable world of colors never seen and \
		people never met. The ascent is glass, and the walls are knives. Each step is blood, if you do not have a guide."
	next_knowledge = list(
		/datum/heretic_knowledge/spell/void_pull,
		/datum/heretic_knowledge/spell/furious_steel,
	)
	required_atoms = list(
		/obj/item/stack/sheet/mineral/titanium = 5,
		/obj/item/clothing/suit/armor = 1,
		/obj/item/assembly/flash = 1,
		/obj/item/organ/internal/lungs = 1,
	)
	cost = 1
	route = PATH_SIDE
	mob_to_summon = /mob/living/basic/heretic_summon/maid_in_the_mirror
	poll_ignore_define = POLL_IGNORE_MAID_IN_MIRROR
