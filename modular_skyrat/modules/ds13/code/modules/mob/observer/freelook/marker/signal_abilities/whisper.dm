GLOBAL_LIST_INIT(whispered, list())
/datum/signal_ability/whisper
	name = "Whisper"
	id = "whisper"
	desc = "Allows you to broadcast a subliminal message into the mind of a receptive target. Can be used on anyone visible, or on unitologists remotely.<br>\
	<br>\
	Please remember that subliminal messages are in-character communication. You are a spooky voice in their head that they might just be imagining. Roleplay appropriately, no memes. Admins are watching"
	target_string = "a zealot or similarly mentally open target"
	energy_cost = 30
	require_corruption = FALSE
	autotarget_range = 1
	target_types = list(/mob/living)


//This is kinda inefficient, but it shouldnt be used too often
/datum/signal_ability/whisper/proc/get_possible_targets()
	var/list/possible = list()
	for (var/mob/M in GLOB.unitologists_list)
		if (M.stat == DEAD)
			continue

		possible += M

	//TODO in future: Allow speaking to people with enough psychosis
	//TODO in future: Allow speaking to people who are near the marker or a shard

	return possible


/datum/signal_ability/whisper/select_target(var/mob/user, var/candidate,  var/list/data)
	.=..()
	if (!.)
		//If the parent returned false, then we didn't click a valid mob. We'll continue anyway with a null target
		finish_casting(user, null, list())

		return TRUE


/datum/signal_ability/whisper/on_cast(var/mob/user, var/mob/living/target, var/list/data)
	if (!target || !isliving(target) || !target.client)
		var/list/possible_targets = get_possible_targets()
		if (!possible_targets.len)
			to_chat(user, "<span class='warning'>No target selected and no valid targets to choose from. Cancelling</span>")
			refund(user)
			return

		target = input(user, "Who do you wish to speak to?", "Subliminal Message", "") as null|mob in get_possible_targets()
		if (!target || !target.client)
			to_chat(user, "<span class='warning'>No target selected or target is disconnected. Cancelling.</span>")
			refund(user)
			return

	var/message = sanitize(input(user, "Write a message to send to [target.name]", "Subliminal Message", ""))

	to_chat(target, "<span class='necromorph'>[message]</span>")
	message_necromorphs("[user] -> [target] <span class='necromorph'>[message]</span>", TRUE, list(target))


	//If this is the first time this round that this person has been whispered, link them to the codex
	if (!(target in GLOB.whispered))
		to_chat(target, "<span class='notice'>This is a <b><a href='?src=\ref[SScodex];show_examined_info=\ref[SScodex.get_entry_by_string("whisper")];show_to=\ref[target]'>whisper</a></b>.</span>")
		GLOB.whispered += target


/datum/codex_entry/concept/whisper
	display_name = "Whisper"
	category = CATEGORY_CONCEPTS
	associated_strings = list("whisper")
	lore_text = "You hear a voice in your head. Is it your own, or a message from the outside? It may tell you helpful things, it may lie to you, \
	it may threaten to harm you. And it may give orders. If you told someone, they'd surely think you were crazy, you might get locked up."
	mechanics_text = "Whispers are messages from players on the necromorph team. Signals bent on mischief, interesting roleplay, or perhaps just meaningless slaughter<br>\
	When they speak to you, remember the golden rule: No killing innocents<br>\
	Don't do anything that would probably lead to the death of a fellow crewmember. <br>\
	Aside from that, you're generally allowed to deal with these voices in your head however you wish. The one speaking to you will often be watching and listening, <br>\
	You may speak your reply aloud to an empty room and there's a possibility they'll hear you, though you'll certainly look a little crazy. If they tell you to do things, its generally your choice of whether or not to follow their directions. As long as you don't kill people, you won't get in trouble with admins<br>\
	The voices can see more than you, if they give you advice or tell you things, it may be a good idea to listen. Of course, they might be lying too.<br>\
	Whatever you do, try to make interesting roleplay out of it. Just ignoring them is pretty boring."
	antag_text = "If you're a zealot, the no killing rule does not apply. Whispers should be considered direct orders from the marker, and you should try your best to fulfil them.<br>\
	Exactly how you do that is at your discretion. If the voices tell you to kill someone, it doesn't necessarily mean you have to rush screaming across the room and start stabbing. You could stalk them for a while, wait for a moment to catch them alone.<br>\
	As long as you're not breaking server rules (like destroying the supermatter engine), you can mostly do whatever the voices tell you. Even orders telling you to kill yourself are perfectly valid. Remember, you are roleplaying a mad cultist."