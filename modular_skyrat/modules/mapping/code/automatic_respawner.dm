/obj/machinery/automatic_respawner
	name = "Automatic Respawner"
	desc = "Allows for lost souls to find a new body."
	icon = 'modular_skyrat/modules/mapping/icons/machinery/automatic_respawner.dmi'
	icon_state = "respawner"
	use_power = FALSE //It doesn't make sense for this to require power in most of the use cases.

	/// What is the type of component are we looking for on our ghost before they can respawn? If this is set to FALSE, a component won't be required, please be careful with this.
	var/datum/component/target_component = FALSE
	/// Does our respawner have a cooldown before it can be used again, and if so, how long does it last?
	var/respawn_timer = FALSE
	/// Is our respawner currently on cooldown?
	var/on_cooldown = FALSE

	/// What is the type of the outfit datum that we want applied to the new body?
	var/datum/outfit/target_outfit = /datum/outfit/job/assistant
	/// What text is shown to the mob that respawned? FALSE will disable anything from being sent.
	var/text_to_show = "Hello there!"


/obj/machinery/automatic_respawner/attack_ghost(mob/user)
	. = ..()
	if(.)
		return FALSE

	if(target_component && !user.GetComponent(target_component))
		return FALSE

	if(on_cooldown)
		//Put things here
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
