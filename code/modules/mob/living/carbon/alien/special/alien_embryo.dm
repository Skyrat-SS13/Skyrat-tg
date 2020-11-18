// This is to replace the previous datum/disease/alien_embryo for slightly improved handling and maintainability
// It functions almost identically (see code/datums/diseases/alien_embryo.dm)
/obj/item/organ/body_egg/alien_embryo
	name = "alien embryo"
	icon = 'icons/mob/alien.dmi'
	icon_state = "larva0_dead"
	food_reagents = list(/datum/reagent/consumable/nutriment = 5, /datum/reagent/toxin/acid = 10)
	var/stage = 0
	var/bursting = FALSE

/obj/item/organ/body_egg/alien_embryo/on_find(mob/living/finder)
	..()
	if(stage < 4)
		to_chat(finder, "<span class='notice'>It's small and weak, barely the size of a foetus.</span>")
	else
		to_chat(finder, "<span class='notice'>It's grown quite large, and writhes slightly as you look at it.</span>")
		if(prob(10))
			AttemptGrow(0)

/obj/item/organ/body_egg/alien_embryo/on_life()
	. = ..()
	switch(stage)
		if(2, 3)
			if(prob(2))
				owner.emote("sneeze")
			if(prob(2))
				owner.emote("cough")
			if(prob(2))
				to_chat(owner, "<span class='danger'>Your throat feels sore.</span>")
			if(prob(2))
				to_chat(owner, "<span class='danger'>Mucous runs down the back of your throat.</span>")
		if(4)
			if(prob(2))
				owner.emote("sneeze")
			if(prob(2))
				owner.emote("cough")
			if(prob(4))
				to_chat(owner, "<span class='danger'>Your muscles ache.</span>")
				if(prob(20))
					owner.take_bodypart_damage(1)
			if(prob(4))
				to_chat(owner, "<span class='danger'>Your stomach hurts.</span>")
				if(prob(20))
					owner.adjustToxLoss(1)
		if(5)
			to_chat(owner, "<span class='danger'>You feel something tearing its way out of your stomach...</span>")
			owner.adjustToxLoss(10)

/obj/item/organ/body_egg/alien_embryo/egg_process()
	if(stage < 5 && prob(3))
		stage++
		INVOKE_ASYNC(src, .proc/RefreshInfectionImage)

	if(stage == 5 && prob(50))
		for(var/datum/surgery/S in owner.surgeries)
			if(S.location == BODY_ZONE_CHEST && istype(S.get_surgery_step(), /datum/surgery_step/manipulate_organs))
				AttemptGrow(0)
				return
		AttemptGrow()



/obj/item/organ/body_egg/alien_embryo/proc/AttemptGrow(gib_on_success=TRUE)
	if(!owner || bursting)
		return

	bursting = TRUE

	var/list/candidates = pollGhostCandidates("Do you want to play as an alien larva that will burst out of [owner.real_name]?", ROLE_ALIEN, null, ROLE_ALIEN, 100, POLL_IGNORE_ALIEN_LARVA)

	if(QDELETED(src) || QDELETED(owner))
		return

	if(!candidates.len || !owner)
		bursting = FALSE
		stage = 4
		return

	var/mob/dead/observer/ghost = pick(candidates)

	var/mutable_appearance/overlay = mutable_appearance('icons/mob/alien.dmi', "burst_lie")
	owner.add_overlay(overlay)

	var/atom/xeno_loc = get_turf(owner)
	var/mob/living/carbon/alien/larva/new_xeno = new(xeno_loc)
	new_xeno.key = ghost.key
	SEND_SOUND(new_xeno, sound('sound/voice/hiss5.ogg',0,0,0,100))	//To get the player's attention
	ADD_TRAIT(new_xeno, TRAIT_IMMOBILIZED, type) //so we don't move during the bursting animation
	ADD_TRAIT(new_xeno, TRAIT_HANDS_BLOCKED, type)
	new_xeno.notransform = 1
	new_xeno.invisibility = INVISIBILITY_MAXIMUM

	sleep(6)

	if(QDELETED(src) || QDELETED(owner))
		qdel(new_xeno)
		CRASH("AttemptGrow failed due to the early qdeletion of source or owner.")

	if(new_xeno)
		REMOVE_TRAIT(new_xeno, TRAIT_IMMOBILIZED, type)
		REMOVE_TRAIT(new_xeno, TRAIT_HANDS_BLOCKED, type)
		new_xeno.notransform = 0
		new_xeno.invisibility = 0

	if(gib_on_success)
		new_xeno.visible_message("<span class='danger'>[new_xeno] bursts out of [owner] in a shower of gore!</span>", "<span class='userdanger'>You exit [owner], your previous host.</span>", "<span class='hear'>You hear organic matter ripping and tearing!</span>")
		//owner.gib(TRUE) - ORIGINAL
		//SKYRAT EDIT CHANGE - ALIEN QOL
		for(var/obj/item/bodypart/BP in owner.bodyparts) //We want to check if there is a chest to dismember.
			if(BP.name == "chest")
				BP.dismember()
				break
		//SKYRAT EDIT END
	else
		new_xeno.visible_message("<span class='danger'>[new_xeno] wriggles out of [owner]!</span>", "<span class='userdanger'>You exit [owner], your previous host.</span>")
		owner.adjustBruteLoss(40)
		owner.cut_overlay(overlay)
	qdel(src)


/*----------------------------------------
Proc: AddInfectionImages(C)
Des: Adds the infection image to all aliens for this embryo
----------------------------------------*/
/obj/item/organ/body_egg/alien_embryo/AddInfectionImages()
	for(var/mob/living/carbon/alien/alien in GLOB.player_list)
		var/I = image('icons/mob/alien.dmi', loc = owner, icon_state = "infected[stage]")
		alien.client.images += I

/*----------------------------------------
Proc: RemoveInfectionImage(C)
Des: Removes all images from the mob infected by this embryo
----------------------------------------*/
/obj/item/organ/body_egg/alien_embryo/RemoveInfectionImages()
	for(var/mob/living/carbon/alien/alien in GLOB.player_list)
		for(var/image/I in alien.client.images)
			var/searchfor = "infected"
			if(I.loc == owner && findtext(I.icon_state, searchfor, 1, length(searchfor) + 1))
				qdel(I)
