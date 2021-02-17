#define VORE_SOUND_FALLOFF 0.1
#define VORE_SOUND_RANGE 3

//
//  Belly system 2.0, now using objects instead of datums because EH at datums.
//	How many times have I rewritten bellies and vore now? -Aro
//

// If you change what variables are on this, then you need to update the copy() proc.

//
// Parent type of all the various "belly" varieties.
//
/obj/belly
	name = "belly"							// Name of this location
	desc = "It's a belly! You're in it!"	// Flavor text description of inside sight/sound/smells/feels.
	var/vore_sound = "Gulp"					// Sound when ingesting someone
	var/vore_verb = "ingest"				// Verb for eating with this in messages
	var/release_sound = "Splatter"			// Sound for letting someone out.
	var/human_prey_swallow_time = 100		// Time in deciseconds to swallow /mob/living/carbon/human
	var/nonhuman_prey_swallow_time = 30		// Time in deciseconds to swallow anything else
	var/emote_time = 60 SECONDS				// How long between stomach emotes at prey
	var/digest_brute = 2					// Brute damage per tick in digestion mode
	var/digest_burn = 2						// Burn damage per tick in digestion mode
	var/immutable = FALSE					// Prevents this belly from being deleted
	var/escapable = TRUE					// Belly can be resisted out of at any time
	var/escapetime = 20 SECONDS				// Deciseconds, how long to escape this belly
	var/digestchance = 0					// % Chance of stomach beginning to digest if prey struggles
	var/absorbchance = 0					// % Chance of stomach beginning to absorb if prey struggles
	var/escapechance = 0 					// % Chance of prey beginning to escape if prey struggles.
	var/can_taste = FALSE					// If this belly prints the flavor of prey when it eats someone.
	var/bulge_size = 0.25					// The minimum size the prey has to be in order to show up on examine.
//	var/shrink_grow_size = 1				// This horribly named variable determines the minimum/maximum size it will shrink/grow prey to.

	var/transferlocation					// Location that the prey is released if they struggle and get dropped off.
	var/transferchance = 0 					// % Chance of prey being transferred to transfer location when resisting
	var/autotransferchance = 0 				// % Chance of prey being autotransferred to transfer location
	var/autotransferwait = 10 				// Time between trying to transfer.
	var/swallow_time = 10 SECONDS			// for mob transfering automation
	var/vore_capacity = 1					// simple animal nom capacity
	var/is_wet = TRUE						// Is this belly inside slimy parts?
	var/wet_loop = TRUE						// Does this belly have a slimy internal loop?

	//I don't think we've ever altered these lists. making them static until someone actually overrides them somewhere.
	var/tmp/static/list/digest_modes = list(DM_HOLD,DM_DIGEST,DM_HEAL,DM_NOISY,DM_ABSORB,DM_UNABSORB)	// Possible digest modes

	var/tmp/mob/living/owner					// The mob whose belly this is.
	var/tmp/digest_mode = DM_HOLD				// Current mode the belly is set to from digest_modes (+transform_modes if human)
	var/tmp/next_process = 0					// Waiting for this SSbellies times_fired to process again.
	var/tmp/list/items_preserved = list()		// Stuff that wont digest so we shouldn't process it again.
	var/tmp/next_emote = 0						// When we're supposed to print our next emote, as a belly controller tick #
	var/tmp/recent_sound						// Prevent audio spam
	var/tmp/last_hearcheck = 0
	var/tmp/list/hearing_mobs

	// Don't forget to watch your commas at the end of each line if you change these.
	var/list/struggle_messages_outside = list(
		"%pred's %belly wobbles with a squirming meal.",
		"%pred's %belly jostles with movement.",
		"%pred's %belly briefly swells outward as someone pushes from inside.",
		"%pred's %belly fidgets with a trapped victim.",
		"%pred's %belly jiggles with motion from inside.",
		"%pred's %belly sloshes around.",
		"%pred's %belly gushes softly.",
		"%pred's %belly lets out a wet squelch.")

	var/list/struggle_messages_inside = list(
		"Your useless squirming only causes %pred's slimy %belly to squelch over your body.",
		"Your struggles only cause %pred's %belly to gush softly around you.",
		"Your movement only causes %pred's %belly to slosh around you.",
		"Your motion causes %pred's %belly to jiggle.",
		"You fidget around inside of %pred's %belly.",
		"You shove against the walls of %pred's %belly, making it briefly swell outward.",
		"You jostle %pred's %belly with movement.",
		"You squirm inside of %pred's %belly, making it wobble around.")

	var/list/digest_messages_owner = list(
		"You feel %prey's body succumb to your digestive system, which breaks it apart into soft slurry.",
		"You hear a lewd glorp as your %belly muscles grind %prey into a warm pulp.",
		"Your %belly lets out a rumble as it melts %prey into sludge.",
		"You feel a soft gurgle as %prey's body loses form in your %belly. They're nothing but a soft mass of churning slop now.",
		"Your %belly begins gushing %prey's remains through your system, adding some extra weight to your thighs.",
		"Your %belly begins gushing %prey's remains through your system, adding some extra weight to your rump.",
		"Your %belly begins gushing %prey's remains through your system, adding some extra weight to your belly.",
		"Your %belly groans as %prey falls apart into a thick soup. You can feel their remains soon flowing deeper into your body to be absorbed.",
		"Your %belly kneads on every fiber of %prey, softening them down into mush to fuel your next hunt.",
		"Your %belly churns %prey down into a hot slush. You can feel the nutrients coursing through your digestive track with a series of long, wet glorps.")

	var/list/digest_messages_prey = list(
		"Your body succumbs to %pred's digestive system, which breaks you apart into soft slurry.",
		"%pred's %belly lets out a lewd glorp as their muscles grind you into a warm pulp.",
		"%pred's %belly lets out a rumble as it melts you into sludge.",
		"%pred feels a soft gurgle as your body loses form in their %belly. You're nothing but a soft mass of churning slop now.",
		"%pred's %belly begins gushing your remains through their system, adding some extra weight to %pred's thighs.",
		"%pred's %belly begins gushing your remains through their system, adding some extra weight to %pred's rump.",
		"%pred's %belly begins gushing your remains through their system, adding some extra weight to %pred's belly.",
		"%pred's %belly groans as you fall apart into a thick soup. Your remains soon flow deeper into %pred's body to be absorbed.",
		"%pred's %belly kneads on every fiber of your body, softening you down into mush to fuel their next hunt.",
		"%pred's %belly churns you down into a hot slush. Your nutrient-rich remains course through their digestive track with a series of long, wet glorps.")

	var/list/examine_messages = list(
		"They have something solid in their %belly!",
		"It looks like they have something in their %belly!")

	//Mostly for being overridden on precreated bellies on mobs. Could be VV'd into
	//a carbon's belly if someone really wanted. No UI for carbons to adjust this.
	//List has indexes that are the digestion mode strings, and keys that are lists of strings.
	var/tmp/list/emote_lists = list()

//For serialization, keep this updated AND IN ORDER OF VARS LISTED ABOVE AND IN DUPE AT THE BOTTOM!!, required for bellies to save correctly.
/obj/belly/vars_to_save()
	return ..() + list(
		"name",
		"desc",
		"vore_sound",
		"vore_verb",
		"release_sound",
		"human_prey_swallow_time",
		"nonhuman_prey_swallow_time",
		"emote_time",
		"digest_brute",
		"digest_burn",
		"immutable",
		"escapable",
		"escapetime",
		"digestchance",
		"absorbchance",
		"escapechance",
		"can_taste",
		"bulge_size",
		"transferlocation",
		"transferchance",
		"autotransferchance",
		"autotransferwait",
		"swallow_time",
		"vore_capacity",
		"struggle_messages_outside",
		"struggle_messages_inside",
		"digest_messages_owner",
		"digest_messages_prey",
		"examine_messages",
		"emote_lists",
		"is_wet",
		"wet_loop"
		)

		//ommitted list
		// "shrink_grow_size",
/obj/belly/Initialize()
	. = ..()
	take_ownership(src.loc)

/obj/belly/proc/take_ownership(var/newloc)
	//If not, we're probably just in a prefs list or something.
	if(isliving(newloc))
		owner = loc
		owner.vore_organs |= src
		SSbellies.belly_list += src

/obj/belly/Destroy()
	SSbellies.belly_list -= src
	if(owner?.vore_organs)
		owner.vore_organs -= src
		if(owner.vore_selected == src)
			owner.vore_selected = null
		owner = null
	. = ..()

// Called whenever an atom enters this belly
/obj/belly/Entered(atom/movable/thing, atom/OldLoc)
	. = ..()
	var/mob/living/L //for chat messages and blindness
	if(isliving(thing))
		L = thing
		L.become_blind("belly_[REF(src)]")
	if(OldLoc in contents)
		return //Someone dropping something (or being stripdigested)

	//Generic entered message
	to_chat(owner,"<span class='notice'>[thing] slides into your [lowertext(name)].</span>")

	//Sound w/ antispam flag setting
	if(vore_sound && !recent_sound)
		if((world.time + NORMIE_HEARCHECK) > last_hearcheck)
			LAZYCLEARLIST(hearing_mobs)
			for(var/mob/living/H in get_hearers_in_view(VORE_SOUND_RANGE, owner))
				if(!H.client || !(H.client.prefs.cit_toggles & EATING_NOISES))
					continue
				LAZYADD(hearing_mobs, H)
			last_hearcheck = world.time
		for(var/mob/living/H in hearing_mobs)
			if(H && H.client && (isturf(H.loc) || (H.loc != src.contents)))
				var/sound/eating = GLOB.pred_vore_sounds[vore_sound]
				SEND_SOUND(H,eating)
			else if(H?.client && (H in contents))
				var/sound/eating = GLOB.prey_vore_sounds[vore_sound]
				SEND_SOUND(H,eating)
			recent_sound = TRUE

	if(L && desc)
		to_chat(L, "<span class='notice'><B>[desc]</B></span>")

/obj/belly/Exited(atom/movable/AM, atom/newloc)
	. = ..()
	if(isliving(AM))
		var/mob/living/L = AM
		L.cure_blind("belly_[REF(src)]")

// Release all contents of this belly into the owning mob's location.
// If that location is another mob, contents are transferred into whichever of its bellies the owning mob is in.
// Returns the number of mobs so released.
/obj/belly/proc/release_all_contents(var/include_absorbed = FALSE, var/silent = FALSE)
//	var/atom/destination = drop_location()
	//Don't bother if we don't have contents
	if(!contents.len)
		return FALSE

	var/count = 0
	for(var/thing in contents)
		var/atom/movable/AM = thing
		if(isliving(AM))
			var/mob/living/L = AM
			var/mob/living/OW = owner
			if(L.vore_flags & ABSORBED && !include_absorbed)
				continue
			L.vore_flags &= ~ABSORBED
			L.stop_sound_channel(CHANNEL_PREYLOOP)
			SEND_SIGNAL(OW, COMSIG_CLEAR_MOOD_EVENT, "fedpred", /datum/mood_event/fedpred)
			SEND_SIGNAL(L, COMSIG_CLEAR_MOOD_EVENT, "fedprey", /datum/mood_event/fedprey)
			SEND_SIGNAL(OW, COMSIG_ADD_MOOD_EVENT, "emptypred", /datum/mood_event/emptypred)
			SEND_SIGNAL(L, COMSIG_ADD_MOOD_EVENT, "emptyprey", /datum/mood_event/emptyprey)
		count += release_specific_contents(AM, silent = TRUE)

	//Clean up our own business
	items_preserved.Cut()
	owner.update_icons()

	if(!silent)
		if(release_sound && !recent_sound)
			if((world.time + NORMIE_HEARCHECK) > last_hearcheck)
				LAZYCLEARLIST(hearing_mobs)
				for(var/mob/living/H in get_hearers_in_view(VORE_SOUND_RANGE, owner))
					if(!H.client || !(H.client.prefs.cit_toggles & EATING_NOISES))
						continue
					LAZYADD(hearing_mobs, H)
				last_hearcheck = world.time
			for(var/mob/living/H in hearing_mobs)
				if(H && H.client && (isturf(H.loc) || (H.loc != src.contents)))
					var/sound/releasement = GLOB.pred_release_sounds[release_sound]
					H.playsound_local(owner.loc, releasement, vol = 75, vary = 1, falloff = VORE_SOUND_FALLOFF)
				else if(H?.client && (H in contents))
					var/sound/releasement = GLOB.prey_release_sounds[release_sound]
					SEND_SOUND(H,releasement)
				recent_sound = TRUE
		owner.visible_message("<font color='green'><b>[owner] expels everything from their [lowertext(name)]!</b></font>")

	return count

// Release a specific atom from the contents of this belly into the owning mob's location.
// If that location is another mob, the atom is transferred into whichever of its bellies the owning mob is in.
// Returns the number of atoms so released.
/obj/belly/proc/release_specific_contents(var/atom/movable/M, var/silent = FALSE)
	if (!(M in contents))
		return FALSE // They weren't in this belly anyway

	M.forceMove(drop_location())  // Move the belly contents into the same location as belly's owner.
	items_preserved -= M


	if(istype(M,/mob/living))
		var/mob/living/ML = M
		var/mob/living/OW = owner
		if(ML.client)
			ML.stop_sound_channel(CHANNEL_PREYLOOP) //Stop the internal loop, it'll restart if the isbelly check on next tick anyway
		SEND_SIGNAL(OW, COMSIG_CLEAR_MOOD_EVENT, "fedpred", /datum/mood_event/fedpred)
		SEND_SIGNAL(ML, COMSIG_CLEAR_MOOD_EVENT, "fedprey", /datum/mood_event/fedprey)
		SEND_SIGNAL(OW, COMSIG_ADD_MOOD_EVENT, "emptypred", /datum/mood_event/emptypred)
		SEND_SIGNAL(ML, COMSIG_ADD_MOOD_EVENT, "emptyprey", /datum/mood_event/emptyprey)

		if(CHECK_BITFIELD(ML.vore_flags,ABSORBED))
			DISABLE_BITFIELD(ML.vore_flags,ABSORBED)
			if(ishuman(M) && ishuman(OW))
				var/mob/living/carbon/human/Prey = M
				var/mob/living/carbon/human/Pred = OW
				var/absorbed_count = 2 //Prey that we were, plus the pred gets a portion
				for(var/mob/living/P in contents)
					if(CHECK_BITFIELD(P.vore_flags,ABSORBED))
						absorbed_count++
				Pred.reagents.trans_to(Prey, Pred.reagents.total_volume / absorbed_count)

	//Clean up our own business
	owner.update_icons()

	if(!silent)
		if(release_sound && !recent_sound)
			if((world.time + NORMIE_HEARCHECK) > last_hearcheck)
				LAZYCLEARLIST(hearing_mobs)
				for(var/mob/living/H in get_hearers_in_view(3, owner))
					if(!H.client || !(H.client.prefs.cit_toggles & EATING_NOISES))
						continue
					LAZYADD(hearing_mobs, H)
					last_hearcheck = world.time
			for(var/mob/living/H in hearing_mobs)
				if(H && H.client && (isturf(H.loc) || (H.loc != src.contents)))
					var/sound/releasement = GLOB.pred_release_sounds[release_sound]
					H.playsound_local(owner.loc, releasement, vol = 75, vary = 1, falloff = VORE_SOUND_FALLOFF)
				else if(H?.client && (H in contents))
					var/sound/releasement = GLOB.prey_release_sounds[release_sound]
					SEND_SOUND(H,releasement)
				recent_sound = TRUE
		owner.visible_message("<font color='green'><b>[owner] expels [M] from their [lowertext(name)]!</b></font>")

	return TRUE

// Actually perform the mechanics of devouring the tasty prey.
// The purpose of this method is to avoid duplicate code, and ensure that all necessary
// steps are taken.
/obj/belly/proc/nom_mob(var/mob/prey, var/mob/user)
	if(owner.stat == DEAD)
		return
	if (prey.buckled)
		prey.buckled.unbuckle_mob(prey,TRUE)

	if(!isbelly(prey.loc))
		SEND_SIGNAL(owner, COMSIG_ADD_MOOD_EVENT, "fedpred", /datum/mood_event/fedpred)
		SEND_SIGNAL(prey, COMSIG_ADD_MOOD_EVENT, "fedprey", /datum/mood_event/fedprey)
	else
		SEND_SIGNAL(owner, COMSIG_CLEAR_MOOD_EVENT, "emptypred", /datum/mood_event/emptypred)
		SEND_SIGNAL(prey, COMSIG_CLEAR_MOOD_EVENT, "emptyprey", /datum/mood_event/emptyprey)

	prey.forceMove(src)

	owner.updateVRPanel()

	for(var/mob/living/M in contents)
		M.updateVRPanel()

	// Setup the autotransfer checks if needed
	if(transferlocation != null && autotransferchance > 0)
		addtimer(CALLBACK(src, /obj/belly/.proc/check_autotransfer, prey), autotransferwait)

/obj/belly/proc/check_autotransfer(var/mob/prey, var/obj/belly/target)
	// Some sanity checks
	if(transferlocation && (autotransferchance > 0) && (prey in contents))
		if(prob(autotransferchance))
			transfer_contents(prey, transferlocation)
		else
			// Didn't transfer, so wait before retrying
			addtimer(CALLBACK(src, /obj/belly/.proc/check_autotransfer, prey), autotransferwait)

//Transfers contents from one belly to another
/obj/belly/proc/transfer_contents(var/atom/movable/content, var/obj/belly/target, silent = FALSE)
	if(!(content in src) || !istype(target))
		return
	content.forceMove(target)

	if(vore_sound && !recent_sound && !silent)
		if((world.time + NORMIE_HEARCHECK) > last_hearcheck)
			LAZYCLEARLIST(hearing_mobs)
			for(var/mob/living/H in get_hearers_in_view(VORE_SOUND_RANGE, owner))
				if(!H.client || !(H.client.prefs.cit_toggles & EATING_NOISES))
					continue
				LAZYADD(hearing_mobs, H)
				last_hearcheck = world.time
		for(var/mob/living/H in hearing_mobs)
			if(H && H.client && (isturf(H.loc) || (H.loc != src.contents)))
				var/sound/eating = GLOB.pred_vore_sounds[vore_sound]
				H.playsound_local(owner.loc, eating, vol = 75, vary = 1, falloff = VORE_SOUND_FALLOFF)
			else if(H?.client && (H in contents))
				var/sound/eating = GLOB.prey_vore_sounds[vore_sound]
				SEND_SOUND(H,eating)
			recent_sound = TRUE

	owner.updateVRPanel()
	for(var/mob/living/M in contents)
		M.updateVRPanel()

// Get the line that should show up in Examine message if the owner of this belly
// is examined.   By making this a proc, we not only take advantage of polymorphism,
// but can easily make the message vary based on how many people are inside, etc.
// Returns a string which shoul be appended to the Examine output.
/obj/belly/proc/get_examine_msg()
	if(contents.len && examine_messages.len)
		var/formatted_message
		var/raw_message = pick(examine_messages)
		var/total_bulge = 0

		formatted_message = replacetext(raw_message,"%belly",lowertext(name))
		formatted_message = replacetext(formatted_message,"%pred",owner)
		formatted_message = replacetext(formatted_message,"%prey",english_list(contents))
		for(var/mob/living/P in contents)
			if(!CHECK_BITFIELD(P.vore_flags, ABSORBED)) //This is required first, in case there's a person absorbed and not absorbed in a stomach.
				total_bulge += P.mob_size
		if(total_bulge >= bulge_size && bulge_size != 0)
			return("<span class='warning'>[formatted_message]</span><BR>")
		else
			return ""

// The next function gets the messages set on the belly, in human-readable format.
// This is useful in customization boxes and such. The delimiter right now is \n\n so
// in message boxes, this looks nice and is easily delimited.
/obj/belly/proc/get_messages(var/type, var/delim = "\n\n")
	ASSERT(type == "smo" || type == "smi" || type == "dmo" || type == "dmp" || type == "em")
	var/list/raw_messages

	switch(type)
		if("smo")
			raw_messages = struggle_messages_outside
		if("smi")
			raw_messages = struggle_messages_inside
		if("dmo")
			raw_messages = digest_messages_owner
		if("dmp")
			raw_messages = digest_messages_prey
		if("em")
			raw_messages = examine_messages

	var/messages = raw_messages.Join(delim)
	return messages

// The next function sets the messages on the belly, from human-readable var
// replacement strings and linebreaks as delimiters (two \n\n by default).
// They also sanitize the messages.
/obj/belly/proc/set_messages(var/raw_text, var/type, var/delim = "\n\n")
	ASSERT(type == "smo" || type == "smi" || type == "dmo" || type == "dmp" || type == "em")

	var/list/raw_list = splittext(html_encode(raw_text),delim)
	if(raw_list.len > 10)
		raw_list.Cut(11)
		testing("[owner] tried to set [lowertext(name)] with 11+ messages")

	for(var/i = 1, i <= raw_list.len, i++)
		if(length(raw_list[i]) > 160 || length(raw_list[i]) < 10) //160 is fudged value due to htmlencoding increasing the size
			raw_list.Cut(i,i)
			testing("[owner] tried to set [lowertext(name)] with >121 or <10 char message")
		else
			raw_list[i] = readd_quotes(raw_list[i])
			//Also fix % sign for var replacement
			raw_list[i] = replacetext(raw_list[i],"&#37;","%")

	ASSERT(raw_list.len <= 10) //Sanity

	switch(type)
		if("smo")
			struggle_messages_outside = raw_list
		if("smi")
			struggle_messages_inside = raw_list
		if("dmo")
			digest_messages_owner = raw_list
		if("dmp")
			digest_messages_prey = raw_list
		if("em")
			examine_messages = raw_list

	return

// Handle the death of a mob via digestion.
// Called from the process_Life() methods of bellies that digest prey.
// Default implementation calls M.death() and removes from internal contents.
// Indigestable items are removed, and M is deleted.
/obj/belly/proc/digestion_death(var/mob/living/M)
	//M.death(1) // "Stop it he's already dead..." Basically redundant and the reason behind screaming mouse carcasses.
	if(M.ckey)
		message_admins("[key_name(owner)] has digested [key_name(M)] in their [lowertext(name)] ([owner ? "<a href='?_src_=holder;adminplayerobservecoodjump=1;X=[owner.x];Y=[owner.y];Z=[owner.z]'>JMP</a>" : "null"])")
		log_attack("[key_name(owner)] digested [key_name(M)].")

	// If digested prey is also a pred... anyone inside their bellies gets moved up.
	if(has_vore_belly(M))
		M.release_vore_contents(include_absorbed = TRUE, silent = TRUE)

	//Drop all items into the belly
	for(var/obj/item/W in M)
		if(!M.dropItemToGround(W))
			qdel(W)

	//Incase they have the loop going, let's double check to stop it.
	M.stop_sound_channel(CHANNEL_PREYLOOP)

	// Delete the digested mob
	qdel(M)

	//Update owner
	owner.updateVRPanel()

// Handle a mob being absorbed
/obj/belly/proc/absorb_living(var/mob/living/M)
	ENABLE_BITFIELD(M.vore_flags, ABSORBED)
	to_chat(M,"<span class='notice'>[owner]'s [lowertext(name)] absorbs your body, making you part of them.</span>")
	to_chat(owner,"<span class='notice'>Your [lowertext(name)] absorbs [M]'s body, making them part of you.</span>")

	if(M.loc != src)
		M.forceMove(src)

	//Seek out absorbed prey of the prey, absorb them too.
	//This in particular will recurse oddly because if there is absorbed prey of prey of prey...
	//it will just move them up one belly. This should never happen though since... when they were
	//absobred, they should have been absorbed as well!
	for(var/belly in M.vore_organs)
		var/obj/belly/B = belly
		for(var/mob/living/Mm in B)
			if(CHECK_BITFIELD(Mm.vore_flags, ABSORBED))
				absorb_living(Mm)

	//Update owner
	owner.updateVRPanel()

//Digest a single item
//Receives a return value from digest_act that's how much nutrition
//the item should be worth
/obj/belly/proc/digest_item(var/obj/item/item)
	var/digested = item.digest_act(src, owner)
	if(!digested)
		items_preserved |= item
	else
//		owner.adjust_nutrition(5 * digested) // haha no.
		if(iscyborg(owner))
			var/mob/living/silicon/robot/R = owner
			R.cell.charge += (50 * digested)

//Determine where items should fall out of us into.
//Typically just to the owner's location.
/obj/belly/drop_location()
	//Should be the case 99.99% of the time
	if(owner)
		return owner.drop_location()
	//Sketchy fallback for safety, put them somewhere safe.
	else if(ismob(src))
		testing("[src] (\ref[src]) doesn't have an owner, and dropped someone at a latespawn point!")
		SSjob.SendToLateJoin(src)
		// wew lad. let's see if this never gets used, hopefully
	else
		qdel(src) //final option, I guess.
		testing("[src] (\ref[src]) was QDEL'd for not having a drop_location!")

//Yes, it's ""safe"" to drop items here
/obj/belly/AllowDrop()
	return TRUE

//Handle a mob struggling
// Called from /mob/living/carbon/relaymove()
/obj/belly/proc/relay_resist(var/mob/living/R)
	if (!(R in contents))
		return  // User is not in this belly

	R.changeNext_move(CLICK_CD_BREAKOUT*0.5)

	if(owner.stat) //If owner is stat (dead, KO) we can actually escape
		to_chat(R,"<span class='warning'>You attempt to climb out of \the [lowertext(name)]. (This will take around [escapetime/10] seconds.)</span>")
		to_chat(owner,"<span class='warning'>Someone is attempting to climb out of your [lowertext(name)]!</span>")

		if(do_after(R, owner, escapetime))
			if((owner.stat || escapable) && (R.loc == src)) //Can still escape?
				release_specific_contents(R)
				return
			else if(R.loc != src) //Aren't even in the belly. Quietly fail.
				return
			else //Belly became inescapable or mob revived
				to_chat(R,"<span class='warning'>Your attempt to escape [lowertext(name)] has failed!</span>")
				to_chat(owner,"<span class='notice'>The attempt to escape from your [lowertext(name)] has failed!</span>")
				return

	var/struggle_outer_message = pick(struggle_messages_outside)
	var/struggle_user_message = pick(struggle_messages_inside)

	struggle_outer_message = replacetext(struggle_outer_message,"%pred",owner)
	struggle_outer_message = replacetext(struggle_outer_message,"%prey",R)
	struggle_outer_message = replacetext(struggle_outer_message,"%belly",lowertext(name))

	struggle_user_message = replacetext(struggle_user_message,"%pred",owner)
	struggle_user_message = replacetext(struggle_user_message,"%prey",R)
	struggle_user_message = replacetext(struggle_user_message,"%belly",lowertext(name))

	struggle_outer_message = "<span class='alert'>" + struggle_outer_message + "</span>"
	struggle_user_message = "<span class='alert'>" + struggle_user_message + "</span>"

	var/sound/pred_struggle_snuggle = sound(get_sfx("struggle_sound"))
	var/sound/prey_struggle_snuggle = sound(get_sfx("prey_struggle"))
	var/sound/struggle_rustle = sound(get_sfx("rustle"))

	LAZYCLEARLIST(hearing_mobs)
	for(var/mob/living/H in get_hearers_in_view(VORE_SOUND_RANGE, owner))
		if(!H.client || !(H.client.prefs.cit_toggles & EATING_NOISES))
			continue
		LAZYADD(hearing_mobs, H)

	if(is_wet)
		for(var/mob/living/H in hearing_mobs)
			if(H && H.client && (isturf(H.loc) || (H.loc != src.contents)))
				H.playsound_local(owner.loc, pred_struggle_snuggle, vol = 75, vary = 1, falloff = VORE_SOUND_FALLOFF)
			else if(H && H.client && (H in contents))
				SEND_SOUND(H,prey_struggle_snuggle)

	else
		for(var/mob/living/H in hearing_mobs)
			if(H && H.client)
				H.playsound_local(owner.loc, struggle_rustle, vol = 75, vary = 1, falloff = VORE_SOUND_FALLOFF)

	for(var/mob/living/H in hearing_mobs)
		if(H && H.client && (isturf(H.loc)))
			H.show_message(struggle_outer_message, MSG_VISUAL) // visible

	to_chat(R,struggle_user_message)

	if(escapable) //If the stomach has escapable enabled.
		if(prob(escapechance)) //Let's have it check to see if the prey escapes first.
			to_chat(R,"<span class='warning'>You start to climb out of \the [lowertext(name)].</span>")
			to_chat(owner,"<span class='warning'>Someone is attempting to climb out of your [lowertext(name)]!</span>")
			if(do_after(R, escapetime))
				if((escapable) && (R.loc == src)) //Can still escape?
					release_specific_contents(R)
					to_chat(R,"<span class='warning'>You climb out of \the [lowertext(name)].</span>")
					to_chat(owner,"<span class='warning'>[R] climbs out of your [lowertext(name)]!</span>")
					return
				else if(R.loc != src) //Aren't even in the belly. Quietly fail.
					return
				else //Belly became inescapable or mob revived
					to_chat(R,"<span class='warning'>Your attempt to escape [lowertext(name)] has failed!</span>")
					to_chat(owner,"<span class='notice'>The attempt to escape from your [lowertext(name)] has failed!</span>")
					return
		else if(prob(transferchance) && transferlocation) //Next, let's have it see if they end up getting into an even bigger mess then when they started.
			var/obj/belly/dest_belly
			for(var/belly in owner.vore_organs)
				var/obj/belly/B = belly
				if(B.name == transferlocation)
					dest_belly = B
					break

			if(!dest_belly)
				to_chat(owner, "<span class='warning'>Something went wrong with your belly transfer settings. Your <b>[lowertext(name)]</b> has had it's transfer chance and transfer location cleared as a precaution.</span>")
				transferchance = 0
				transferlocation = null
				return

			to_chat(R,"<span class='warning'>Your attempt to escape [lowertext(name)] has failed and your struggles only results in you sliding into [owner]'s [transferlocation]!</span>")
			to_chat(owner,"<span class='warning'>Someone slid into your [transferlocation] due to their struggling inside your [lowertext(name)]!</span>")
			transfer_contents(R, dest_belly)
			return

		else if(prob(absorbchance) && digest_mode != DM_ABSORB) //After that, let's have it run the absorb chance.
			to_chat(R,"<span class='warning'>In response to your struggling, \the [lowertext(name)] begins to cling more tightly...</span>")
			to_chat(owner,"<span class='warning'>You feel your [lowertext(name)] start to cling onto its contents...</span>")
			digest_mode = DM_ABSORB
			return

		else if(prob(digestchance) && digest_mode != DM_DIGEST) //Finally, let's see if it should run the digest chance.
			to_chat(R,"<span class='warning'>In response to your struggling, \the [lowertext(name)] begins to get more active...</span>")
			to_chat(owner,"<span class='warning'>You feel your [lowertext(name)] beginning to become active!</span>")
			digest_mode = DM_DIGEST
			return

		else //Nothing interesting happened.
			to_chat(R,"<span class='warning'>You make no progress in escaping [owner]'s [lowertext(name)].</span>")
			to_chat(owner,"<span class='warning'>Your prey appears to be unable to make any progress in escaping your [lowertext(name)].</span>")
			return

/obj/belly/proc/get_mobs_and_objs_in_belly()
	var/list/see = list()
	var/list/belly_mobs = list()
	see["mobs"] = belly_mobs
	var/list/belly_objs = list()
	see["objs"] = belly_objs
	for(var/mob/living/L in loc.contents)
		belly_mobs |= L
	for(var/obj/O in loc.contents)
		belly_objs |= O

	return see


// Belly copies and then returns the copy
// Needs to be updated for any var changes AND KEPT IN ORDER OF THE VARS ABOVE AS WELL!
/obj/belly/proc/copy(mob/new_owner)
	var/obj/belly/dupe = new /obj/belly(new_owner)

	//// Non-object variables
	dupe.name = name
	dupe.desc = desc
	dupe.vore_sound = vore_sound
	dupe.vore_verb = vore_verb
	dupe.release_sound = release_sound
	dupe.human_prey_swallow_time = human_prey_swallow_time
	dupe.nonhuman_prey_swallow_time = nonhuman_prey_swallow_time
	dupe.emote_time = emote_time
	dupe.digest_brute = digest_brute
	dupe.digest_burn = digest_burn
	dupe.immutable = immutable
	dupe.escapable = escapable
	dupe.escapetime = escapetime
	dupe.digestchance = digestchance
	dupe.absorbchance = absorbchance
	dupe.escapechance = escapechance
	dupe.can_taste = can_taste
	dupe.bulge_size = bulge_size
	dupe.transferlocation = transferlocation
	dupe.transferchance = transferchance
	dupe.autotransferchance = autotransferchance
	dupe.autotransferwait = autotransferwait
	dupe.swallow_time = swallow_time
	dupe.vore_capacity = vore_capacity
	dupe.is_wet = is_wet
	dupe.wet_loop = wet_loop

	//// Object-holding variables
	//struggle_messages_outside - strings
	dupe.struggle_messages_outside.Cut()
	for(var/I in struggle_messages_outside)
		dupe.struggle_messages_outside += I

	//struggle_messages_inside - strings
	dupe.struggle_messages_inside.Cut()
	for(var/I in struggle_messages_inside)
		dupe.struggle_messages_inside += I

	//digest_messages_owner - strings
	dupe.digest_messages_owner.Cut()
	for(var/I in digest_messages_owner)
		dupe.digest_messages_owner += I

	//digest_messages_prey - strings
	dupe.digest_messages_prey.Cut()
	for(var/I in digest_messages_prey)
		dupe.digest_messages_prey += I

	//examine_messages - strings
	dupe.examine_messages.Cut()
	for(var/I in examine_messages)
		dupe.examine_messages += I

	//emote_lists - index: digest mode, key: list of strings
	dupe.emote_lists.Cut()
	for(var/K in emote_lists)
		dupe.emote_lists[K] = list()
		for(var/I in emote_lists[K])
			dupe.emote_lists[K] += I
	return dupe
