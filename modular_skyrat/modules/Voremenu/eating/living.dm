///////////////////// Mob Living /////////////////////
/mob/living
	var/vore_flags = 0
	var/showvoreprefs = TRUE				// Determines if the mechanical vore preferences button will be displayed on the mob or not.
	var/obj/belly/vore_selected				// Default to no vore capability.
	var/list/vore_organs = list()			// List of vore containers inside a mob
	var/vore_taste = null					// What the character tastes like
	var/next_preyloop

//
// Hook for generic creation of stuff on new creatures
//
/hook/living_new/proc/vore_setup(mob/living/M)
	M.verbs += /mob/living/proc/preyloop_refresh
	M.verbs += /mob/living/proc/lick
	M.verbs += /mob/living/proc/escapeOOC

	if(M.vore_flags & NO_VORE) //If the mob isn't supposed to have a stomach, let's not give it an insidepanel so it can make one for itself, or a stomach.
		return TRUE
	M.verbs += /mob/living/proc/insidePanel

	//Tries to load prefs if a client is present otherwise gives freebie stomach
	spawn(2 SECONDS) // long delay because the server delays in its startup. just on the safe side.
		if(M)
			M.init_vore()

	//return TRUE to hook-caller
	return TRUE

/mob/living/proc/init_vore()
	ENABLE_BITFIELD(vore_flags, VORE_INIT)
	//Something else made organs, meanwhile.
	if(LAZYLEN(vore_organs))
		return TRUE

	//We'll load our client's organs if we have one
	if(client?.prefs)
		if(!copy_from_prefs_vr())
			to_chat(src,"<span class='warning'>ERROR: You seem to have saved vore prefs, but they couldn't be loaded.</span>")
			return FALSE
		if(LAZYLEN(vore_organs))
			vore_selected = vore_organs[1]
			return TRUE

/mob/living/proc/lazy_init_belly()
	if(!length(vore_organs))
		LAZYINITLIST(vore_organs)
		var/obj/belly/B = new /obj/belly(src)
		vore_selected = B
		B.immutable = TRUE
		B.name = "Stomach"
		B.desc = "It appears to be rather warm and wet. Makes sense, considering it's inside [name]."
		B.can_taste = TRUE
		return TRUE

// Handle being clicked, perhaps with something to devour
//

			// Refactored to use centralized vore code system - Leshana

			// Critical adjustments due to TG grab changes - Poojawa

/mob/living/proc/vore_attack(var/mob/living/user, var/mob/living/prey, var/mob/living/pred)
	lazy_init_belly()
	if(!user || !prey || !pred)
		return

	if(!isliving(pred)) //no badmin, you can't feed people to ghosts or objects.
		return

	if(pred == prey) //you click your target
		if(!CHECK_BITFIELD(pred.vore_flags,FEEDING))
			to_chat(user, "<span class='notice'>They aren't able to be fed.</span>")
			to_chat(pred, "<span class='notice'>[user] tried to feed you themselves, but you aren't voracious enough to be fed.</span>")
			return
		feed_self_to_grabbed(user, pred)

	else if(pred == user) //you click yourself
		feed_grabbed_to_self(user, prey)

	else // click someone other than you/prey
		if(!CHECK_BITFIELD(pred.vore_flags,FEEDING))
			to_chat(user, "<span class='notice'>They aren't voracious enough to be fed.</span>")
			to_chat(pred, "<span class='notice'>[user] tried to feed you [prey], but you aren't voracious enough to be fed.</span>")
			return
		if(!CHECK_BITFIELD(prey.vore_flags,FEEDING))
			to_chat(user, "<span class='notice'>They aren't able to be fed to someone.</span>")
			to_chat(prey, "<span class='notice'>[user] tried to feed you to [pred], but you aren't able to be fed to them.</span>")
			return
		feed_grabbed_to_other(user, prey, pred)
//
// Eating procs depending on who clicked what
//
/mob/living/proc/feed_grabbed_to_self(var/mob/living/user, var/mob/living/prey)
	user.lazy_init_belly()
	var/belly = user.vore_selected
	return perform_the_nom(user, prey, user, belly)

/mob/living/proc/feed_self_to_grabbed(var/mob/living/user, var/mob/living/pred)
	pred.lazy_init_belly()
	var/belly = input("Choose Belly") in pred.vore_organs
	return perform_the_nom(user, user, pred, belly)

/mob/living/proc/feed_grabbed_to_other(var/mob/living/user, var/mob/living/prey, var/mob/living/pred)
	pred.lazy_init_belly()
	var/belly = input("Choose Belly") in pred.vore_organs
	return perform_the_nom(user, prey, pred, belly)

//
// Master vore proc that actually does vore procedures
//

/mob/living/proc/perform_the_nom(var/mob/living/user, var/mob/living/prey, var/mob/living/pred, var/obj/belly/belly, var/delay)
	//Sanity
	if(!user || !prey || !pred || !istype(belly) || !(belly in pred.vore_organs))
		testing("[user] attempted to feed [prey] to [pred], via [lowertext(belly.name)] but it went wrong.")
		return

	if (!CHECK_BITFIELD(prey.vore_flags, DEVOURABLE))
		to_chat(user, "This can't be eaten!")
		return FALSE

	// The belly selected at the time of noms
	var/attempt_msg = "ERROR: Vore message couldn't be created. Notify a dev. (at)"
	var/success_msg = "ERROR: Vore message couldn't be created. Notify a dev. (sc)"

	// Prepare messages
	if(user == pred) //Feeding someone to yourself
		attempt_msg = text("<span class='warning'>[] is attemping to [] [] into their []!</span>",pred,lowertext(belly.vore_verb),prey,lowertext(belly.name))
		success_msg = text("<span class='warning'>[] manages to [] [] into their []!</span>",pred,lowertext(belly.vore_verb),prey,lowertext(belly.name))
	else //Feeding someone to another person
		attempt_msg = text("<span class='warning'>[] is attempting to make [] [] [] into their []!</span>",user,pred,lowertext(belly.vore_verb),prey,lowertext(belly.name))
		success_msg = text("<span class='warning'>[] manages to make [] [] [] into their []!</span>",user,pred,lowertext(belly.vore_verb),prey,lowertext(belly.name))

	if(!prey.Adjacent(user)) // let's not even bother attempting it yet if they aren't next to us.
		return FALSE

	// Announce that we start the attempt!
	user.visible_message(attempt_msg)

	// Now give the prey time to escape... return if they did
	var/swallow_time
	if(delay)
		swallow_time = delay
	else
		swallow_time = istype(prey, /mob/living/carbon/human) ? belly.human_prey_swallow_time : belly.nonhuman_prey_swallow_time

	//Timer and progress bar
	if(!do_after(user, swallow_time, TRUE, prey))
		return FALSE // Prey escaped (or user disabled) before timer expired.

	if(!prey.Adjacent(user)) //double check'd just in case they moved during the timer and the do_mob didn't fail for whatever reason
		return FALSE

	// If we got this far, nom successful! Announce it!
	user.visible_message(success_msg)

	// Actually shove prey into the belly.
	belly.nom_mob(prey, user)
	stop_pulling()

	// Flavor handling
	if(belly.can_taste && prey.get_taste_message(FALSE))
		to_chat(belly.owner, "<span class='notice'>[prey] tastes of [prey.get_taste_message(FALSE)].</span>")

	// Inform Admins
	var/prey_braindead
	var/prey_stat
	if(prey.ckey)
		prey_stat = prey.stat//only return this if they're not an unmonkey or whatever
		if(!prey.client)//if they disconnected, tell us
			prey_braindead = TRUE
	if (pred == user)
		message_admins("[ADMIN_LOOKUPFLW(pred)] ate [ADMIN_LOOKUPFLW(prey)][!prey_braindead ? "" : " (BRAINDEAD)"][prey_stat ? " (DEAD/UNCONSCIOUS)" : ""].")
		pred.log_message("[key_name(pred)] ate [key_name(prey)].", LOG_ATTACK)
		prey.log_message("[key_name(prey)] was eaten by [key_name(pred)].", LOG_ATTACK)
	else
		message_admins("[ADMIN_LOOKUPFLW(user)] forced [ADMIN_LOOKUPFLW(pred)] to eat [ADMIN_LOOKUPFLW(prey)].")
		user.log_message("[key_name(user)] forced [key_name(pred)] to eat [key_name(prey)].", LOG_ATTACK)
		pred.log_message("[key_name(user)] forced [key_name(pred)] to eat [key_name(prey)].", LOG_ATTACK)
		prey.log_message("[key_name(user)] forced [key_name(pred)] to eat [key_name(prey)].", LOG_ATTACK)
	return TRUE

//
//End vore code.


//
// Our custom resist catches for /mob/living
//
/mob/living/proc/vore_process_resist()

	//Are we resisting from inside a belly?
	if(isbelly(loc))
		var/obj/belly/B = loc
		B.relay_resist(src)
		return TRUE //resist() on living does this TRUE thing.

	//Other overridden resists go here

	return FALSE

// internal slimy button in case the loop stops playing but the player wants to hear it
/mob/living/proc/preyloop_refresh()
	set name = "Internal loop refresh"
	set category = "Vore"
	src.stop_sound_channel(CHANNEL_PREYLOOP) // sanity just in case
	if(isbelly(loc))
		var/sound/preyloop = sound('sound/vore/prey/loop.ogg')
		SEND_SOUND(src, preyloop)
	else
		to_chat(src, "<span class='alert'>You aren't inside anything, you clod.</span>")

// OOC Escape code for pref-breaking or AFK preds
//
/mob/living/proc/escapeOOC()
	set name = "OOC Escape"
	set category = "Vore"

	//You're in a belly!
	if(isbelly(loc))
		var/obj/belly/B = loc
		var/confirm = alert(src, "You're in a mob. If you're otherwise unable to escape from a pred AFK for a long time, use this.", "Confirmation", "Okay", "Cancel")
		if(!confirm == "Okay" || loc != B)
			return
		//Actual escaping
		B.release_specific_contents(src,TRUE) //we might as well take advantage of that specific belly's handling. Else we stay blinded forever.
		message_admins("[src] used OOC escape to escape from [B.owner]'s belly.")
		log_consent("[src] used OOC escape to escape from [B.owner]'s belly.")
		src.stop_sound_channel(CHANNEL_PREYLOOP)
		SEND_SIGNAL(src, COMSIG_CLEAR_MOOD_EVENT, "fedprey", /datum/mood_event/fedprey)
		for(var/mob/living/simple_animal/SA in range(10))
			SA.prey_excludes[src] = world.time

		if(isanimal(B.owner))
			var/mob/living/simple_animal/SA = B.owner
			SA.update_icons()

	//You're in a dogborg!
	else if(istype(loc, /obj/item/dogborg/sleeper))
		var/obj/item/dogborg/sleeper/belly = loc //The belly!

		var/confirm = alert(src, "You're in a dogborg sleeper. This is for escaping from preference-breaking or if your predator disconnects/AFKs. You can also resist out naturally too.", "Confirmation", "Okay", "Cancel")
		if(!confirm == "Okay" || loc != belly)
			return
		//Actual escaping
		belly.go_out(src) //Just force-ejects from the borg as if they'd clicked the eject button.
		message_admins("[src] used OOC escape from a dogborg sleeper.")
		log_consent("[src] used OOC escape from a dogborg sleeper.")
	else
		to_chat(src,"<span class='alert'>You aren't inside anyone, though, is the thing.</span>")

/mob/living/proc/copy_to_prefs_vr()
	if(!client || !client.prefs)
		to_chat(src,"<span class='warning'>You attempted to save your vore prefs but somehow you're in this character without a client.prefs variable. Tell a dev.</span>")
		return FALSE

	client.prefs.vore_flags = vore_flags // there's garbage data in here, but it doesn't matter
	client.prefs.vore_taste = vore_taste

	var/list/serialized = list()
	for(var/belly in vore_organs)
		var/obj/belly/B = belly
		serialized += list(B.serialize()) //Can't add a list as an object to another list in Byond. Thanks.

	client.prefs.belly_prefs = serialized

	return TRUE

//
//	Proc for applying vore preferences, given bellies
//
/mob/living/proc/copy_from_prefs_vr()
	if(!client || !client.prefs)
		to_chat(src,"<span class='warning'>You attempted to apply your vore prefs but somehow you're in this character without a client.prefs variable. Tell a dev.</span>")
		return FALSE
	ENABLE_BITFIELD(vore_flags,VOREPREF_INIT)

	COPY_SPECIFIC_BITFIELDS(vore_flags,client.prefs.vore_flags,DIGESTABLE | DEVOURABLE | FEEDING | LICKABLE)
	vore_taste = client.prefs.vore_taste

	release_vore_contents(silent = TRUE)
	QDEL_LIST(vore_organs)
	for(var/entry in client.prefs.belly_prefs)
		list_to_object(entry,src)

	return TRUE

//
// Release everything in every vore organ
//
/mob/living/proc/release_vore_contents(var/include_absorbed = TRUE, var/silent = FALSE)
	for(var/belly in vore_organs)
		var/obj/belly/B = belly
		B.release_all_contents(include_absorbed, silent)

//
// Returns examine messages for bellies
//
/mob/living/proc/examine_bellies()
	if(!show_pudge()) //Some clothing or equipment can hide this.
		return ""

	var/message = ""
	for (var/belly in vore_organs)
		var/obj/belly/B = belly
		message += B.get_examine_msg()

	return message

//
// Whether or not people can see our belly messages
//
/mob/living/proc/show_pudge()
	return TRUE //Can override if you want.

/mob/living/carbon/human/show_pudge()
	//A uniform could hide it.
	if(istype(w_uniform,/obj/item/clothing))
		var/obj/item/clothing/under = w_uniform
		if(under.hides_bulges)
			return FALSE

	//We return as soon as we find one, no need for 'else' really.
	if(istype(wear_suit,/obj/item/clothing))
		var/obj/item/clothing/suit = wear_suit
		if(suit.hides_bulges)
			return FALSE


	return ..()

//
// Clearly super important. Obviously.
//
/mob/living/proc/lick()
	set name = "Lick Someone"
	set category = "Vore"
	set desc = "Lick someone nearby!"

	if(incapacitated(ignore_restraints = TRUE))
		to_chat(src, "<span class='warning'>You can't do that while incapacitated.</span>")
		return
	if(next_move > world.time)
		to_chat(src, "<span class='warning'>You can't do that so fast, slow down.</span>")
		return

	var/list/choices
	for(var/mob/living/L in view(1))
		if(L != src && (!L.ckey || L.client?.prefs.vore_flags & LICKABLE) && Adjacent(L))
			LAZYADD(choices, L)

	if(!choices)
		return

	var/mob/living/tasted = input(src, "Who would you like to lick? (Excluding yourself and those with the preference disabled)", "Licking") as null|anything in choices

	if(QDELETED(tasted) || (tasted.ckey && !(tasted.client?.prefs.vore_flags & LICKABLE)) || !Adjacent(tasted) || incapacitated(ignore_restraints = TRUE))
		return

	changeNext_move(CLICK_CD_MELEE)

	visible_message("<span class='warning'>[src] licks [tasted]!</span>","<span class='notice'>You lick [tasted]. They taste rather like [tasted.get_taste_message()].</span>","<b>Slurp!</b>")


/mob/living/proc/get_taste_message(allow_generic = TRUE, datum/species/mrace)
	if(!vore_taste && !allow_generic)
		return FALSE

	var/taste_message = ""
	if(vore_taste && (vore_taste != ""))
		taste_message += "[vore_taste]"
	else
		if(ishuman(src))
			taste_message += "they haven't bothered to set their flavor text"
		else
			taste_message += "a plain old normal [src]"
	return taste_message
//	Check if an object is capable of eating things, based on vore_organs
//
/proc/has_vore_belly(var/mob/living/O)
	if(istype(O))
		if(O.vore_organs.len > 0)
			return TRUE

	return FALSE
