#define EXAMINE_RANGE 3

/obj/effect/fake_rune //runes without all that cult bullshit
	name = "rune"
	desc = "An odd collection of symbols drawn in what seems to be blood."
	anchored = TRUE
	icon = 'icons/obj/rune.dmi'
	icon_state = "1"
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	layer = SIGIL_LAYER
	color = RUNE_COLOR_RED

/obj/effect/fake_rune/narsie
	icon = 'icons/effects/96x96.dmi'
	color = RUNE_COLOR_DARKRED
	icon_state = "rune_large"
	pixel_x = -32 //So the big ol' 96x96 sprite shows up right
	pixel_y = -32

/obj/effect/fake_rune/narsie/puzzle
	/// Has it been solved yet
	var/solved = FALSE

/obj/effect/fake_rune/narsie/puzzle/examine(mob/user)
	. = ..()
	if(solved)
		return
	if(get_dist(src, user) > EXAMINE_RANGE)
		return
	. += span_cult("On close inspection of [src], an overwhelming force fills your mind!")
	. += span_cultbold("The path shall be clear when the blood of a heretic is spilled.")
	if(ishuman(user))
		var/mob/living/carbon/human/human_user = user
		human_user.adjustOrganLoss(ORGAN_SLOT_BRAIN, 5, BRAIN_DAMAGE_DEATH / 2) // don't fuck with cult runes, y'all.

/obj/effect/fake_rune/narsie/puzzle/Initialize(mapload)
	. = ..()
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
		COMSIG_ATOM_EXITED = .proc/on_exited,
	)
	AddElement(/datum/element/connect_loc, loc_connections) // test if this applies anywhere on the 3x3 or just one tile

/obj/effect/fake_rune/narsie/puzzle/proc/on_entered(datum/source, atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	SIGNAL_HANDLER

	if(isliving(arrived))
		RegisterSignal(arrived, COMSIG_LIVING_BLEED_DECAL, .proc/on_bleed)

/obj/effect/fake_rune/narsie/puzzle/proc/on_exited(datum/source, atom/movable/gone, direction)
	SIGNAL_HANDLER

	if(isliving(gone))
		UnregisterSignal(gone, COMSIG_LIVING_BLEED_DECAL)

/obj/effect/fake_rune/narsie/puzzle/proc/on_bleed(mob/living/source)
	SIGNAL_HANDLER

	if(!istype(source) || solved)
		return
	if("clock" in source.faction)
		for(var/mob/nearby_mob in viewers(7, src))
			to_chat(nearby_mob, span_cult("As the blood of a heretic is spilled on [src], the forcefields nearby fade out of existence..."))
		for(var/obj/effect/forcefield/cult/cult_field in GLOB.areas_by_type[/area/awaymission/outbound_expedition/ruin/blood])
			qdel(cult_field) //might make it more interesting later
		solved = TRUE

#undef EXAMINE_RANGE
