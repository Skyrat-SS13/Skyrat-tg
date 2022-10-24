//The base clockwork structure. Can have an alternate desc and will show up in the list of clockwork objects.
/obj/structure/destructible/clockwork
	name = "meme structure"
	desc = "Some frog or something, the fuck?"
	icon = 'modular_skyrat/modules/clock_cult/icons/clockwork_objects.dmi'
	icon_state = "rare_pepe"
	anchored = TRUE
	density = TRUE
	resistance_flags = FIRE_PROOF | ACID_PROOF
	break_message = span_warning("Sparks fly as the brass structure shatters across the ground.") //The message shown when a structure breaks
	break_sound = 'sound/magic/clockwork/anima_fragment_death.ogg' //The sound played when a structure breaks
	debris = list(/obj/structure/fluff/clockwork/alloy_shards/large = 1, \
	/obj/structure/fluff/clockwork/alloy_shards/medium = 2, \
	/obj/structure/fluff/clockwork/alloy_shards/small = 3) //Parts left behind when a structure breaks
	///if we ignore attacks from servants of ratvar instead of taking damage
	var/immune_to_servant_attacks = FALSE
	///The person who placed this structure
	var/datum/mind/owner = null
	///Shown to servants when they examine
	var/clockwork_desc = ""
	///icon for when this structure is unanchored, doubles as the var for if it can be unanchored
	var/unanchored_icon
	///if a fabricator can repair it
	var/can_be_repaired = TRUE


/obj/structure/destructible/clockwork/Destroy()
	owner = null
	return ..()

/obj/structure/destructible/clockwork/examine(mob/user)
	. = ..()
	if(clockwork_desc)
		. += span_nzcrentr(clockwork_desc)
	return .

/obj/structure/destructible/clockwork/attacked_by(obj/item/I, mob/living/user)
	if(immune_to_servant_attacks && (FACTION_CLOCK in user.faction))
		return
	return ..()

//for the ark and Ratvar
/obj/structure/destructible/clockwork/massive
	name = "massive construct"
	desc = "A very large construction."
	layer = MASSIVE_OBJ_LAYER
	density = FALSE
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF | FREEZE_PROOF

//the base clockwork machinery, which is not actually machines, but happens to use power
/obj/structure/destructible/clockwork/powered
	var/obj/machinery/power/apc/target_apc
	var/active = FALSE
	var/needs_power = TRUE
	var/active_icon = null //icon_state while process() is being called
	var/inactive_icon = null //icon_state while process() isn't being called
