///A list containing all open soulcatcher NIFSofts
GLOBAL_LIST_EMPTY(open_soulcatchers)


/obj/item/disk/nifsoft_uploader/soulcatcher
	loaded_nifsoft = /datum/nifsoft/soulcatcher

/datum/nifsoft/soulcatcher
	name = "Soulcatcher"
	program_desc = "Allows the user to become a vessel for drifting souls." //placeholder description

	///What souls are currently connected to the Soulcatcher
	var/list/hosted_souls = list()
	///What does the room look like to those inside?
	var/room_description = "An orange platform suspended in space orbited by reflective cubes of various sizes. There really isn't much here." //placeholder text
	///Are ghosts able to join in without asking?
	var/free_join_enabled = TRUE //True for debug purposes. :)
	///This is the warning message that it sends to the soul when they join the soulcatcher.
	var/warning_message = "Don't be a dick and share information about things going on in the round. I'll know." //Placeholder - Policy team or whoever, write something scary to discourage bad actors please.

/datum/nifsoft/soulcatcher/New()
	. = ..()
	linked_mob.verbs += /mob/living/carbon/human/verb/nif_say
	linked_mob.verbs += /mob/living/carbon/human/verb/nif_me

	linked_mob.active_soulcatcher = src
	name = "[linked_mob.name]'s Soulcatcher"

	GLOB.open_soulcatchers += src //This is only this way for testing, this will most likely be disabled by default.

/datum/nifsoft/soulcatcher/Destroy()
	linked_mob.verbs -= /mob/living/carbon/human/verb/nif_say
	linked_mob.verbs -= /mob/living/carbon/human/verb/nif_me

	linked_mob.active_soulcatcher = FALSE

	for(var/mob/living/brain/soulcatcher/soul as anything in hosted_souls)
		remove_soul(soul)

	if(src in GLOB.open_soulcatchers)
		GLOB.open_soulcatchers -= src

	. = ..()

///Adds a soul to the soulcatcher.
/datum/nifsoft/soulcatcher/proc/add_soul(soul_to_add, warning = FALSE)
	var/mob/sourcemob = soul_to_add

	if(!sourcemob || !sourcemob.key)
		return FALSE

	var/mob/living/brain/soulcatcher/soul = new(parent_nif)

	soul.name = sourcemob.name
	soul.real_name = sourcemob.real_name

	soul.key = sourcemob.key

	soul.active_soulcatcher = src
	soul.soulcatcher_owner = src.linked_mob

	soul.set_stat(CONSCIOUS)
	soul.reset_perspective()

	hosted_souls += soul

	soul.verbs += /mob/living/brain/soulcatcher/verb/nif_say
	soul.verbs += /mob/living/brain/soulcatcher/verb/nif_me

	if(warning)
		to_chat(src, span_warning("[warning_message]"))

	return TRUE

///Removes a soul from the soulcatcher
/datum/nifsoft/soulcatcher/proc/remove_soul(soul_to_remove)
	var/mob/living/brain/soulcatcher/removed_soul = soul_to_remove
	if(!(removed_soul in hosted_souls))
		return FALSE

	hosted_souls -= removed_soul

	removed_soul.verbs -= /mob/living/brain/soulcatcher/verb/nif_say
	removed_soul.verbs -= /mob/living/brain/soulcatcher/verb/nif_me

	removed_soul.active_soulcatcher = FALSE
	qdel(removed_soul)

///Sends a message to everyone connected to the soulcatcher
/datum/nifsoft/soulcatcher/proc/send_message(message, emote = FALSE)

	if(!message)
		return FALSE

	for(var/mob/living/brain/soulcatcher/soul as anything in hosted_souls)
		if((!emote && !soul.soulcatcher_hearing) || (emote && !soul.soulcatcher_seeing))
			continue

		to_chat(soul, span_cyan(message))

	to_chat(linked_mob, span_cyan(message))

///Makes the soulcatcher visible to ghosts
/datum/nifsoft/soulcatcher/proc/toggle_visibility
	if(src in GLOB.open_soulcatchers)
		GLOB.open_soulcatchers -= src

		to_chat(linked_mob, span_cyan("Ghosts can no longer join your soulcatcher"))
		return TRUE

	GLOB.open_soulcatchers += src

	to_chat(linked_mob, span_cyan("Ghosts can now join your soulcatcher"))
	return TRUE


/mob/living
	///What soulcatcher, if any, does the user belong to or own?
	var/datum/nifsoft/soulcatcher/active_soulcatcher = FALSE

///The mob that a ghost becomes when it joins a soulcatcher
/mob/living/brain/soulcatcher
	name = "Lost Soul"
	desc = "a soul that is hosted inside of a soulcatcher"
	//Hearing / Sight Variables.
	///Can the soul hear the outside world?
	var/world_hearing = TRUE
	///Can the soul see the outside world?
	var/world_seeing = TRUE
	///Is the soul able to "see" emotes inside of the soulcatcher?
	var/soulcatcher_seeing = TRUE
	///Is the soul able to hear inside of the soulcatcher?
	var/soulcatcher_hearing = TRUE
	///Is the soul able to speak inside of the soulcatcher?
	var/soulcatcher_speaking = TRUE
	///Is the soul able to emote inside of the soulcatcher?
	var/soulcatcher_emoting = TRUE

	///Who owns the soulcatcher?
	var/mob/living/carbon/human/soulcatcher_owner

///Sends a message to the soulcatcher nifsoft
/mob/proc/send_soulcatcher_message(emote = FALSE)
	var/mob/living/user = src

	var/message_type = "[emote ? "emote" : "communicate"]"
	if(!user)
		return FALSE

	if(!user.active_soulcatcher)
		return FALSE

	if(src.incapacitated())
		to_chat(src, span_warning("You are currently unable to [message_type]"))

	if(istype(src, /mob/living/brain/soulcatcher))
		var/mob/living/brain/soulcatcher/soul = src

		if((!emote && !soul.soulcatcher_speaking) || (emote && soul.soulcatcher_emoting))
			to_chat(src, span_warning("Your host has disabled your ability to [message_type]"))
			return FALSE

	var/message = sanitize(tgui_input_text(src, "Type in an [message_type]", "Soulcatcher"))

	if(!message)
		to_chat(src, span_warning("You did not enter an [message_type]!"))
		return FALSE

	var/completed_message = "<b>Soulcatcher</b> [user.name][!emote ? ":" : ""] [message]" /// Get the fancy little icon that virgo has!
	user.active_soulcatcher.send_message(completed_message, emote)

///Sends a say though to a Soulcatcher for a human
/mob/living/carbon/human/verb/nif_say()
	set name = "NIF Say"
	set desc = "Speak to the residents of your soulcatcher"
	set category = "NIF"

	src.send_soulcatcher_message()

///Sends a me though to a Soulcatcher for a human
/mob/living/carbon/human/verb/nif_me()
	set name = "NIF Me"
	set desc = "Emote to the residents of your soulcatcher"
	set category = "NIF"

	src.send_soulcatcher_message(TRUE)

///Sends a say though to a Soulcatcher for a soul.
/mob/living/brain/soulcatcher/verb/nif_say()
	set name = "NIF Say"
	set desc = "Speak through your soulcatcher"
	set category = "NIF"

	src.send_soulcatcher_message()

///Sends a emote though to a Soulcatcher for a soul.
/mob/living/brain/soulcatcher/verb/nif_me()
	set name = "NIF Me"
	set desc = "Emote through your soulcatcher"
	set category = "NIF"

	src.send_soulcatcher_message(TRUE)


/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	remove_verb(src, /mob/living/carbon/human/verb/nif_me)
	remove_verb(src, /mob/living/carbon/human/verb/nif_say)

///Allows a ghost to enter a visible soulcatcher.
/mob/dead/observer/verb/enter_soulcatcher()
	set name = "Enter Soulcatcher"
	set desc = "Enter a soulcatcher"
	set category = "IC"

	if(!isobserver(src))
		to_chat(usr, span_warning("You can't join a soulcatcher if you are still alive!"))

	var/list/avalible_soulcatchers = list()
	avalible_soulcatchers += GLOB.open_soulcatchers

	var/datum/nifsoft/soulcatcher/chosen_soulcatcher = tgui_input_list(src, "Chose a soulcatcher to enter.", "Enter Soulcatcher", avalible_soulcatchers)

	if(!chosen_soulcatcher)
		to_chat(src, span_warning("You did not chose a soulcatcher"))
		return FALSE

	if(!chosen_soulcatcher.free_join_enabled)

		var/mob/living/soulcatcher_owner = chosen_soulcatcher.linked_mob
		if(!soulcatcher_owner)
			return FALSE

		if(tgui_alert(soulcatcher_owner, "[src] wishes to enter your soulcatcher", "Soulcatcher", list("Accept", "Reject")) != "Accept")
			to_chat(src, span_warning("[soulcatcher_owner] denied you access to their soulcatcher"))
			return FALSE

	if(!chosen_soulcatcher.add_soul(src), TRUE)
		return FALSE
