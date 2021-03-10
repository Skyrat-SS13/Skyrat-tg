/obj/effect/proc_holder/spell/targeted/telepathy/weak
	name = "Weak Telepathy"
	desc = "Telepathically transmits a message to the target."
	charge_max = 0
	clothes_req = 0
	range = 3
	include_user = 0
	action_icon = 'icons/mob/actions/actions_revenant.dmi'
	action_icon_state = "r_transmit"
	action_background_icon_state = "bg_spell"
	var/notice = "notice"
	var/boldnotice = "boldnotice"
	var/magic_check = FALSE
	var/holy_check = FALSE
	var/tinfoil_check = TRUE

/obj/effect/proc_holder/spell/targeted/telepathy/cast(list/targets, mob/living/simple_animal/revenant/user = usr)
	for(var/mob/living/M in targets)
		var/msg = stripped_input(usr, "What do you wish to tell [M]?", null, "")
		if(!msg)
			charge_counter = charge_max
			return
		log_directed_talk(user, M, msg, LOG_SAY, "[name]")
		to_chat(user, "<span class='[boldnotice]'>You weakily transmit to [M]:</span> <span class='[notice]'>[msg]</span>")
		if(!M.anti_magic_check(magic_check, holy_check, tinfoil_check, 0)
			to_chat(M, "<span class='[boldnotice]'>You hear something very soft behind you talking...</span> <span class='[notice]'>[msg]</span>")
		for(var/ded in GLOB.dead_mob_list)
			if(!isobserver(ded))
				continue
			var/follow_rev = FOLLOW_LINK(ded, user)
			var/follow_whispee = FOLLOW_LINK(ded, M)
			to_chat(ded, "[follow_rev] <span class='[boldnotice]'>[user] [name]:</span> <span class='[notice]'>\"[msg]\" to</span> [follow_whispee] <span class='name'>[M]</span>")


/datum/mutation/human/telepathy/weak
	name = "Weak Telepathy"
	desc = "A rare mutation that allows the user to telepathically communicate to others."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>You can hear your own voice echoing in your mind!</span>"
	text_lose_indication = "<span class='notice'>You don't hear your mind echo anymore.</span>"
	power = /obj/effect/proc_holder/spell/targeted/telepathy/weak
	instability = 0
	conflicts = list(/obj/effect/proc_holder/spell/targeted/telepathy)

/datum/mutation/human/olfaction/canine
	name = "Animal Olfaction"
	desc = "Your sense of smell is comparable to any kind of animal."
	quality = POSITIVE
	text_gain_indication = "<span class='notice'>Smells begin to make more sense...</span>"
	text_lose_indication = "<span class='notice'>Your sense of smell goes back to normal.</span>"
	instability = 0
	conflicts = list(/datum/mutation/human/olfaction)
