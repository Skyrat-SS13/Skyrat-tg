
GLOBAL_DATUM(suit_up_controller, /datum/suit_up_controller)

/**
 * The highlander controller handles the admin highlander mode, if enabled.
 * It is first created when "there can only be one" triggers it, and it can be referenced from GLOB.highlander_controller
 */
/datum/suit_up_controller

/datum/suit_up_controller/New()
	. = ..()
	RegisterSignal(SSdcs, COMSIG_GLOB_CREWMEMBER_JOINED, .proc/new_colonist)

	for(var/mob/living/carbon/human/human in GLOB.player_list)
		if(human.stat == DEAD)
			continue
		suit_up_mf(human)

/datum/suit_up_controller/Destroy(force, ...)
	. = ..()
	UnregisterSignal(SSdcs, COMSIG_GLOB_CREWMEMBER_JOINED)

/**
 * Triggers at beginning of the game when there is a confirmed list of valid, ready players.
 * Creates a 100% ready game that has NOT started (no players in bodies)
 * Followed by start game
 *
 * Does the following:
 * * Picks map, and loads it
 * * Grabs landmarks if it is the first time it's loading
 * * Sets up the role list
 * * Puts players in each role randomly
 * Arguments:
 * * setup_list: list of all the datum setups (fancy list of roles) that would work for the game
 * * ready_players: list of filtered, sane players (so not playing or disconnected) for the game to put into roles
 */
/datum/suit_up_controller/proc/new_colonist(datum/source, mob/living/new_crewmember, rank)
	SIGNAL_HANDLER

	to_chat(new_crewmember, span_userdanger("<i>Welcome to the red planet, watch out for the storms!</i>"))
	suit_up_mf(new_crewmember)

/datum/suit_up_controller/proc/suit_up_mf(mob/living/carbon/human/target_player)
	for(var/obj/item/item in target_player.get_equipped_items())
		qdel(item)

	var/obj/item/organ/internal/brain/human_brain = target_player.getorganslot(BRAIN)
	human_brain.destroy_all_skillchips()

	target_player.equipOutfit(/datum/outfit/event_colonizer)
	target_player.regenerate_icons()

/client/proc/suit_up_all()
	if(!SSticker.HasRoundStarted())
		tgui_alert(usr,"The game hasn't started yet!")
		return
	GLOB.suit_up_controller = new /datum/suit_up_controller
	message_admins(span_adminnotice("[key_name_admin(usr)] used an admin secret to give everyone suits and tools"))
	log_admin("[key_name(usr)] used give everyone suits.")
