/obj/item/organ/internal/empowered_borer_egg
	name = "strange egg"
	desc = "All slimy and yuck."
	icon_state = "innards" // not like you'll be seeing this anyway
	visual = TRUE
	zone = BODY_ZONE_CHEST
	slot = ORGAN_SLOT_PARASITE_EGG
	/// How long it takes to burst from a corpse
	var/burst_time = 3 MINUTES
	/// What generation the egg will be
	var/generation = 1

/obj/item/organ/internal/empowered_borer_egg/on_find(mob/living/finder)
	..()
	to_chat(finder, span_warning("You found an unknown egg in [owner]'s [zone]!"))

/obj/item/organ/internal/empowered_borer_egg/Initialize(mapload)
	. = ..()
	if(iscarbon(loc))
		Insert(loc)

/obj/item/organ/internal/empowered_borer_egg/Insert(mob/living/carbon/M, special = FALSE, drop_if_replaced = TRUE)
	..()
	addtimer(CALLBACK(src, .proc/try_burst), burst_time)

/obj/item/organ/internal/empowered_borer_egg/Remove(mob/living/carbon/M, special = FALSE)
	. = ..()
	visible_message(span_warning(span_italics("As [src] is cut out of [M], it quickly vibrates and shatters, leaving nothing but some goop!")))
	new/obj/effect/decal/cleanable/food/egg_smudge(get_turf(src))
	qdel(src)

/obj/item/organ/internal/empowered_borer_egg/proc/try_burst()
	if(!owner)
		qdel(src)
		return
	if(owner.stat != DEAD)
		qdel(src)
		return
	var/list/candidates = poll_ghost_candidates("Do you want to spawn as an empowered Cortical Borer bursting from [owner]?", ROLE_PAI, FALSE, 10 SECONDS, POLL_IGNORE_CORTICAL_BORER)
	if(!length(candidates))
		var/obj/effect/mob_spawn/ghost_role/borer_egg/empowered/borer_egg = new(get_turf(owner))
		borer_egg.generation = generation
		var/obj/item/bodypart/chest/chest = owner.get_bodypart(BODY_ZONE_CHEST)
		chest.dismember()
		return
	var/mob/dead/observer/new_borer = pick(candidates)
	var/mob/living/basic/cortical_borer/empowered/spawned_cb = new(get_turf(owner))
	var/obj/item/bodypart/chest/chest = owner.get_bodypart(BODY_ZONE_CHEST)
	chest.dismember()
	spawned_cb.generation = generation
	spawned_cb.ckey = new_borer.ckey
	spawned_cb.mind.add_antag_datum(/datum/antagonist/cortical_borer)
