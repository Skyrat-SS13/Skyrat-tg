/// The base clockwork structure. Can have an alternate desc and will show up in the list of clockwork objects.
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
	debris = list(
		/obj/structure/fluff/clockwork/alloy_shards/large = 1,
		/obj/structure/fluff/clockwork/alloy_shards/medium = 2,
		/obj/structure/fluff/clockwork/alloy_shards/small = 3,
	)
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


/obj/structure/destructible/clockwork/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/clockwork_description, clockwork_desc)


/obj/structure/destructible/clockwork/Destroy()
	owner = null

	return ..()


/obj/structure/destructible/clockwork/attacked_by(obj/item/I, mob/living/user)
	if(immune_to_servant_attacks && (IS_CLOCK(user)))
		return

	return ..()


/obj/structure/destructible/clockwork/crowbar_act(mob/living/user, obj/item/tool)
	if(IS_CLOCK(user))
		setDir(turn(dir, 90))
		balloon_alert(user, "rotated [dir2text(dir)]")

	return TRUE


/// The base clockwork machinery, which isn't actually a machine subtype, but happens to use power
/obj/structure/destructible/clockwork/powered
	/// Ref to the targetted APC that we draw power from
	var/obj/machinery/power/apc/target_apc
	/// If this is trying to take power or not
	var/active = FALSE
	/// If this currently requires power to actually work
	var/needs_power = TRUE
	/// icon_state while process() is being called
	var/active_icon = null
	///icon_state while process() isn't being called
	var/inactive_icon = null


/obj/structure/destructible/clockwork/powered/Destroy()
	target_apc = null
	return ..()
