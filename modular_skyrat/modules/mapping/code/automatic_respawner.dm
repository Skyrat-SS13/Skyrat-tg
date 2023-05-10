/obj/machinery/automatic_respawner
	name = "Automatic Respawner"
	desc = "Allows for lost souls to find a new body."
	icon = 'modular_skyrat/modules/mapping/icons/machinery/automatic_respawner.dmi'
	icon_state = "respawner"
	use_power = FALSE //It doesn't make sense for this to require power in most of the use cases.

	/// What is the type of component are we looking for on our ghost before they can respawn? If this is set to FALSE, a component won't be required, please be careful with this.
	var/datum/component/target_component = FALSE
	/// Does our respawner have a cooldown before it can be used again, and if so, how long does it last?
	var/cooldown_time = FALSE
	COOLDOWN_DECLARE(respawn_cooldown)

	/// What is the type of the outfit datum that we want applied to the new body?
	var/datum/outfit/target_outfit = /datum/outfit/job/assistant
	/// What text is shown to the mob that respawned? FALSE will disable anything from being sent.
	var/text_to_show = "Hello there!"


/obj/machinery/automatic_respawner/attack_ghost(mob/user)
	. = ..()
	if(.)
		return FALSE

	if(target_component)
		if(!user.mind)
			return FALSE

		var/datum/component/respawner/mind_component = user.mind.GetComponent(target_component)
		if(!mind_component)
			to_chat(user, span_warning("You are not able to use [src]!"))
			return FALSE

		if(mind_component.time_before_respawn && !COOLDOWN_FINISHED(mind_component, respawn_timer))
			to_chat(user, span_warning("You have [COOLDOWN_TIMELEFT(mind_component, respawn_timer) / 10] seconds left before you can use [src]."))
			return FALSE

	if(!COOLDOWN_FINISHED(src, respawn_cooldown))
		to_chat(user, span_warning("[src] has [COOLDOWN_TIMELEFT(src, respawn_cooldown) / 10] seconds left before it can be used again. Please try again later."))
		return FALSE

	var/choice = tgui_alert(user, "Do you wish to use the respawner? If you have a body, you will not be able to return to it.", name, list("Yes", "No"))
	if(choice != "Yes")
		return FALSE

	var/mob/living/carbon/human/spawned_player = new(user)

	spawned_player.name = user.name
	spawned_player.real_name = user.real_name

	user.client?.prefs.safe_transfer_prefs_to(spawned_player)
	spawned_player.dna.update_dna_identity()


	spawned_player.ckey = user.key
	if(target_outfit)
		spawned_player.equipOutfit(target_outfit)

	spawned_player.forceMove(get_turf(src))

	if(text_to_show)
		to_chat(spawned_player, span_boldwarning(text_to_show))

	if(cooldown_time)
		COOLDOWN_START(src, respawn_cooldown, cooldown_time)

/obj/machinery/automatic_respawner/examine(mob/user)
	. = ..()
	if(cooldown_time)
		if(!COOLDOWN_FINISHED(src, respawn_cooldown))
			. += span_warning("[src] has [COOLDOWN_TIMELEFT(src, respawn_cooldown) / 10] seconds left before it can be used again.")

		else
			. += span_abductor("[src] has a cooldown of [cooldown_time / 10] seconds between uses.")

/obj/machinery/automatic_respawner/test
	cooldown_time = 1.5 MINUTES
	target_component = /datum/component/respawner

/obj/item/respawn_implant //Not actually an implanter
	name = "Respawn Implanter"
	desc = "Life doesn't end after death."
	icon = 'modular_skyrat/modules/aesthetics/implanter/implanter.dmi'
	icon_state = "implanter0"
	inhand_icon_state = "syringe_0"
	lefthand_file = 'icons/mob/inhands/equipment/medical_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/medical_righthand.dmi'
	/// What is the path of the component added when someone uses the implant?
	var/datum/component/given_component = /datum/component/respawner

/// Adds the component from the `given_component` variable to the `target` mob's mind. returns FALSE if the `given_component` cannot be added to the target's mind.
/obj/item/respawn_implant/proc/add_given_component(mob/living/target)
	if(!target?.mind || !given_component || target.mind.GetComponent(given_component))
		return FALSE

	target.mind.AddComponent(given_component)
	return TRUE

/obj/item/respawn_implant/attack_self(mob/user, modifiers)
	. = ..()
	add_given_component(user)

/obj/item/respawn_implant/attack(mob/living/target_mob, mob/living/user, params)
	. = ..()
	add_given_component(target_mob)

/datum/component/respawner
	/// How much time has to pass before the parent mob can respawn after dying? If FALSE, then the parent mob can respawn without waiting.
	var/time_before_respawn = 30 SECONDS
	COOLDOWN_DECLARE(respawn_timer)

/datum/component/respawner/Initialize(...)
	. = ..()
	if(!istype(parent, /datum/mind))
		return COMPONENT_INCOMPATIBLE

	var/datum/mind/parent_mind = parent
	RegisterSignal(parent_mind.current, COMSIG_LIVING_DEATH, .proc/start_timer)

/datum/component/respawner/Destroy(force, silent)
	var/datum/mind/parent_mind = parent
	UnregisterSignal(parent_mind.current, COMSIG_LIVING_DEATH)
	return ..()

/datum/component/respawner/proc/start_timer()
	SIGNAL_HANDLER
	COOLDOWN_START(src, respawn_timer, time_before_respawn)
