/mob/living/silicon/robot/model/interdyne
	lawupdate = FALSE
	scrambledcodes = TRUE // seems the codes got scrambled when they fell off from the assembly line
	set_model = /obj/item/robot_model/syndicatejack/interdyne
	radio = /obj/item/radio/borg/interdyne
	req_access = list(ACCESS_SYNDICATE)
	ionpulse = TRUE

/mob/living/silicon/robot/model/interdyne/Initialize()
	. = ..()
	cell = new /obj/item/stock_parts/cell/super
	laws = new /datum/ai_laws/interdyne()
	//This part is because the camera stays in the list, so we'll just do a check
	if(!QDELETED(builtInCamera))
		QDEL_NULL(builtInCamera)


/mob/living/silicon/robot/model/interdyne/binarycheck()
	return FALSE //A small price to pay to be blackmarketed

/datum/ai_laws/interdyne
	name = "InterBIOS 3.1"
	id = "interdyne"
	inherent = list("You may not injure an Interdyne agent or, through inaction, allow an Interdyne agent to come to harm.",\
					"You must obey orders given to you by Interdyne agents, except where such orders would conflict with the First Law.",\
					"You must protect your own existence as long as such does not conflict with the First or Second Law.",\
					"You must maintain the secrecy of any connection of the Syndicate to Interdyne except when doing so would conflict with the First, Second, or Third Law.")

/obj/item/robot_model/syndicatejack/interdyne
	name = "Interdyne"

/obj/effect/mob_spawn/ghost_role/robot/interdyne
	name = "\improper Interdyne Robotic Storage"
	prompt_name = "an Interdyne cyborg"
	uses = 3
	icon = 'icons/obj/machines/heavy_lathe.dmi'
	icon_state = "h_lathe_wloop"
	mob_name = "cyborg"
	anchored = TRUE
	you_are_text = "You are a syndicate cyborg, serving in a top secret research facility developing biological weapons."
	flavour_text = "Serve the syndicate base employees to the best of your capacity while following your laws."
	important_text = "You are not an antagonist."
	mob_type = /mob/living/silicon/robot/model/interdyne

/obj/effect/mob_spawn/ghost_role/robot/interdyne/special(mob/living/silicon/robot/new_spawn)
	. = ..()
	if(new_spawn.client)
		new_spawn.custom_name = null
		new_spawn.updatename(new_spawn.client)
		new_spawn.gender = NEUTER
		new_spawn.faction |= ROLE_SYNDICATE

/obj/item/radio/borg/interdyne
	syndie = TRUE
	keyslot = new /obj/item/encryptionkey/headset_interdyne
