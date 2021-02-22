/*
	Head Component mob

	The head does not autofill from queue normally, the mob controlling the divider will take over it

	The head has a special execution move covered lower down. It wraps itself around the victims throat, strangling them until their head is cut off
	Then it slithers its tentacles down the hole and takes over the body, replacing the head
*/
/mob/living/simple_animal/necromorph/divider_component/head
	name = "head"
	icon_state = "head"
	icon_living = "head"
	icon_dead = list("head_dead_1", "head_dead_2")
	melee_damage_lower = 4
	melee_damage_upper = 6
	attacktext = "whipped"
	attack_sound = 'sound/weapons/bite.ogg'
	speed = 1.75
	leap_range = 4
	max_health = 50

	pain_sounds = list('sound/effects/creatures/necromorph/divider/component/head_pain_1.ogg',
	'sound/effects/creatures/necromorph/divider/component/head_pain_2.ogg')

	attack_sounds = list('sound/effects/creatures/necromorph/divider/component/head_attack_1.ogg',
	'sound/effects/creatures/necromorph/divider/component/head_attack_2.ogg')

	leap_state = "head_leap"
	attack_state = "head_attack"


/mob/living/simple_animal/necromorph/divider_component/head/Initialize()
	.=..()
	add_modclick_verb(KEY_CTRLALT, /mob/living/simple_animal/necromorph/divider_component/head/proc/takeover_verb)

/mob/living/simple_animal/necromorph/divider_component/head/get_controlling_player(var/fetch = FALSE)
	if (!fetch)
		return
	.=..()



//Inhabits the corpse of a headless human
//This normal version is used on an already dead corpse on the ground
/mob/living/simple_animal/necromorph/divider_component/head/proc/takeover_verb(var/mob/living/carbon/human/H)
	if (QDELETED(src) || !isturf(loc) || incapacitated(INCAPACITATION_FORCELYING))
		return //Prevent some edge cases

	if (H.is_necromorph())
		return

	if (H.get_organ(BP_HEAD))
		var/obj/item/organ/external/E = H.get_organ(BP_HEAD)
		if (!E.is_stump())
			to_chat(src, SPAN_DANGER("You can only take over a headless corpse."))
			return FALSE

	if (get_extension(H, /datum/extension/used_vessel))
		to_chat(src, SPAN_DANGER("This vessel has been posessed and used up already, find another!"))
		return FALSE

	if (get_dist(src, H) > 1)
		to_chat(src, SPAN_DANGER("You must be within one tile"))
		return FALSE
	playsound(src, 'sound/effects/creatures/necromorph/divider/divider_posession.ogg', VOLUME_LOUD, TRUE)

	if (!do_after(src, 5 SECONDS))
		return
	takeover(H)







/*
	Core Takeover Code
*/
/mob/living/simple_animal/necromorph/divider_component/head/proc/takeover(var/mob/living/carbon/human/H)
	//Safety checks done, we are past the point of no return


	//Remove any leftover head stump
	var/obj/item/organ/external/E = H.get_organ(BP_HEAD)
	if (E)
		E.removed()
		qdel(E)

	//TODO: Slithering sound

	//Create the head and pass in our dna
	var/list/new_organs = list()
	var/obj/item/organ/head = new /obj/item/organ/external/head/simple/divider/human(H, dna)
	head.owner = H
	head.replaced(H)
	new_organs += head

	//We must also create brain and eyes, and put them into the head
	var/obj/item/organ/brain = new /obj/item/organ/internal/brain/undead(H, dna)
	brain.owner = H
	brain.replaced(H, head)
	new_organs += brain

	var/obj/item/organ/eyes = new /obj/item/organ/internal/eyes(H, dna)
	eyes.owner = H
	eyes.replaced(H, head)
	new_organs += eyes

	var/datum/species/necromorph/divider/D = all_species[SPECIES_NECROMORPH_DIVIDER]

	for(var/obj/item/organ/O in new_organs)
		D.post_organ_rejuvenate(O)

	H.update_body()

	//Transfer our player
	mind.transfer_to(H)
	H.verbs +=/mob/living/carbon/human/proc/abandon_vessel

	//Fix up comms
	H.remove_all_languages()
	H.add_language(LANGUAGE_NECROCHAT)

	//Apply debuffs
	set_extension(H, /datum/extension/divider_puppet)
	set_extension(H, /datum/extension/used_vessel)

	//Wake me up inside
	H.resurrect(200)

	//Delete this mob
	qdel(src)












/obj/item/organ/external/head/simple/divider
	base_miss_chance = 45
	can_regrow = FALSE

/*
	Special head subtype, used only on puppets
*/
/obj/item/organ/external/head/simple/divider/human
	icon_name = "head_human"
	can_regrow = FALSE


/obj/item/organ/external/head/simple/divider/New(var/mob/living/carbon/holder, var/datum/dna/given_dna)
	.=..()
	GLOB.death_event.register(holder, src, /obj/item/organ/external/head/simple/divider/proc/holder_death)



//It becomes a head mob again if severed
/obj/item/organ/external/head/simple/divider/droplimb(var/clean, var/disintegrate = DROPLIMB_EDGE, var/ignore_children, var/silent, var/atom/cutter)
	if (!QDELETED(src) && owner)
		create_divider_component(owner, 0)
		qdel(src)
		return
	.=..()

//Called when the holder dies. This is intended for death by methods other than decapitation
//It will be called in a decapitation case too, but one or more of the three vars below will prevent an infinite loop
/obj/item/organ/external/head/simple/divider/proc/holder_death()
	if (!QDELETED(src) && owner && divider_component_type)
		create_divider_component(owner, 0)
		qdel(src)
		return


/*
	Base Organ Code
*/
//If the divider player is still connected, they transfer control to the head
/obj/item/organ/external/head/create_divider_component(var/mob/living/carbon/human/H, var/deletion_delay)
	.=..()
	if (.)
		var/mob/living/simple_animal/necromorph/divider_component/L = .
		if (H && H.mind && H.client)
			H.mind.transfer_to(L)

		else
			//If the player can't take control, then we'll fetch someone from necroqueue
			L.get_controlling_player(TRUE)

		//Removing the head kills the divider's main body
		//We do a spawn then some checks here to prevent infinite loops
		spawn(1 SECOND)
			if (!QDELETED(H) && H.stat != DEAD)
				H.death()





/*
	Puppet extension, permanant effect on the controlled mob
	Applies various penalties
		-20 ranged accuracy
		clumsy mutation (includes a farther -15 accuracy)
		-30% movespeed
		Chance to lurch when moving
		higher chance to lurch when bumping into things
*/
/datum/extension/divider_puppet
	var/mob/living/carbon/human/H
	flags = EXTENSION_FLAG_IMMEDIATE
	var/screen_rotated = FALSE
	statmods = list(STATMOD_RANGED_ACCURACY = -20,
	STATMOD_MOVESPEED_MULTIPLICATIVE = 0.70)

/datum/extension/divider_puppet/New(var/mob/newholder)
	.=..()
	H = newholder
	if (H.client)
		screen_rotation()

	H.mutations.Add(CLUMSY)
	GLOB.moved_event.register(H, src, /datum/extension/divider_puppet/proc/holder_moved)
	GLOB.bump_event.register(H, src, /datum/extension/divider_puppet/proc/holder_bump)

/datum/extension/divider_puppet/proc/holder_moved()
	if (prob(3))
		H.visible_message("[H] lurches around awkwardly")
		H.lurch()

/datum/extension/divider_puppet/proc/holder_bump(var/mover, var/obstacle)
	if (prob(10))
		H.visible_message("[H] bumps into [obstacle] and staggers off")
		H.lurch(get_dir(obstacle, H))

/datum/extension/divider_puppet/proc/screen_rotation()
	if (!H.client || screen_rotated)
		return

	screen_rotated = TRUE

	//Lets do some cool camera tricks

	H.client.dir = SOUTH
	spawn(70)
		if (H && H.client)
			H.visible_message("[H] adjusts its head upon the new body")
			H.client.dir = pick(list(EAST, WEST))
			sleep(15)
			H.client.dir = NORTH




/*
	Mounting
*/
/mob/living/simple_animal/necromorph/divider_component/head/charge_impact(var/datum/extension/charge/leap/charge)
	shake_camera(charge.user,5,3)
	.=TRUE
	if (isliving(charge.last_obstacle))
		var/mob/living/L = charge.last_obstacle

		//We cannot attach to lying down targets, but we can stay attached if they fall over afterwards
		if (L.lying)
			return
		//Lets make mount parameters for posterity. We're just using the default settings at time of writing, but maybe they'll change in future
		var/datum/mount_parameters/WP = new()
		WP.attach_walls	=	FALSE	//Can this be attached to wall turfs?
		WP.attach_anchored	=	FALSE	//Can this be attached to anchored objects, eg heaving machinery
		WP.attach_unanchored	=	FALSE	//Can this be attached to unanchored objects, like janicarts?
		WP.dense_only = FALSE	//If true, only sticks to dense atoms
		WP.attach_mob_standing		=	TRUE		//Can this be attached to mobs, like brutes?
		WP.attach_mob_downed		=	TRUE	//Can this be/remain attached to mobs that are lying down?
		WP.attach_mob_dead	=	FALSE	//Can this be/remain attached to mobs that are dead?
		charge.do_winddown_animation = FALSE
		mount_to_atom(src, charge.last_obstacle, /datum/extension/mount/divider_head, WP)



//Mount extension
/datum/extension/mount/divider_head/on_mount()
	.=..()
	var/mob/living/simple_animal/necromorph/divider_component/head/head = mountee
	var/mob/living/carbon/human/H = mountpoint
	var/result = divider_head_start(head, H)
	if (result == EXECUTION_CANCEL)
		dismount()
		return

	if (!head.perform_execution(/datum/extension/execution/divider_head, H))
		return

	spawn(0.5 SECONDS)
		if (!QDELETED(head) && !QDELETED(src) && mountpoint && mountee)
			//Lets put the parasite somewhere nice looking on the mob
			var/new_rotation = rand(-45, 45)
			var/new_x = 0
			var/new_y = 6
			var/matrix/M = matrix()
			M = M.Scale(0.75)
			M = M.Turn(new_rotation)

			animate(head, transform = M, pixel_x = new_x, pixel_y = new_y, time = 5, flags = ANIMATION_END_NOW)



/*
	Execution: Hostile Takeover
*/
/datum/extension/execution/divider_head
	name = "Hostile Takeover"
	base_type = /datum/extension/execution/divider_head
	cooldown = 60	//Cooldown isnt handled here
	require_grab = FALSE
	reward_biomass = 10
	reward_energy = 100
	reward_heal = 0
	range = 0
	all_stages = list(/datum/execution_stage/headwrap,
	/datum/execution_stage/strangle/first,
	/datum/execution_stage/strangle/second,
	/datum/execution_stage/strangle/third,
	/datum/execution_stage/finisher/decapitate,
	/datum/execution_stage/divider_possess)



	vision_mod = -4


/datum/extension/execution/divider_head/safety_check()


	var/safety_result = divider_head_continue(user, victim)

	if (safety_result == EXECUTION_SUCCESS)
		success = TRUE
		return EXECUTION_SUCCESS
	else if (safety_result == EXECUTION_CONTINUE)
		.=..()
	else
		return EXECUTION_CANCEL


/datum/execution_stage/headwrap/enter()

	//The user cannot move or take any action
	host.user.Stun(2)

	host.victim.losebreath += 4
	host.user.visible_message(SPAN_EXECUTION("[host.user] wraps their tentacles around [host.victim]'s throat, constricting their airways and holding them in place!"))
	var/mob/living/simple_animal/necromorph/divider_component/head/head = host.user
	if (LAZYLEN(head.attack_sounds))
		playsound(host.victim, pick(head.attack_sounds), VOLUME_MAX, TRUE)

/datum/execution_stage/divider_possess_start
	duration = 5 SECONDS

/datum/execution_stage/divider_possess/enter()
	playsound(host.user, 'sound/effects/creatures/necromorph/divider/divider_posession.ogg', VOLUME_LOUD, TRUE)
	host.user.visible_message(SPAN_EXECUTION("[host.user] slips their tentacles down the gaping neck hole on [host.victim]'s twitching, headless corpse."))



/datum/execution_stage/divider_possess/exit()
	host.user.visible_message(SPAN_EXECUTION("[host.user] entwines its tentacles with [host.victim]'s nervous system, as the corpse jerks back into life!"))
	var/mob/living/simple_animal/necromorph/divider_component/head/head = host.user
	head.takeover(host.victim)





/*
	Safety Checks

	Core checks. It is called as part of other check procs on initial tongue contact, and periodically while performing the execution.
	If it returns false, the execution is denied or cancelled.
*/
/proc/divider_head_safety(var/mob/living/simple_animal/necromorph/divider_component/head/user, var/mob/living/carbon/human/target)

	//We only target humans
	if (!istype(user) || !istype(target))
		return EXECUTION_CANCEL

	//Abort if either mob is deleted
	if (QDELETED(user) || QDELETED(target))
		return EXECUTION_CANCEL

	//Don't target our allies
	if (target.is_necromorph())
		return EXECUTION_CANCEL

	//The execution continues until one party is dead
	if (user.stat == DEAD)
		return EXECUTION_CANCEL

	return EXECUTION_CONTINUE


/*
	Start check, called to see if we can grab the mob
*/
/proc/divider_head_start(var/mob/living/simple_animal/necromorph/divider_component/head/user, var/mob/living/carbon/human/target)
	//Core first
	.=divider_head_safety(user, target)
	if (. == EXECUTION_CANCEL)
		return

	//Now in addition

	//The target must be alive when we start.
	if (target.stat == DEAD)
		return EXECUTION_CANCEL

	//The target must have a head for us to rip off
	if (!target.get_organ(BP_HEAD))
		return EXECUTION_CANCEL

	//The target must be standing
	if (target.lying)
		return EXECUTION_CANCEL

	return EXECUTION_CONTINUE


/*
	Continue check, called during the execution, this has three return values
	0 = FAIL, the execution is cancelled
	1 = continue, keep going
	2 = win, the execution ends successfully, the victim is killed and we skip to the final stage
*/
/proc/divider_head_continue(var/mob/living/simple_animal/necromorph/divider_component/head/user, var/mob/living/carbon/human/target)
	//Core first
	.=divider_head_safety(user, target)
	if (. == EXECUTION_CANCEL)
		return

	//Now in addition

	//If the target's head has been removed since we started, then we win! Decapitating them is our goal
	if (!target.get_organ(BP_HEAD))
		return EXECUTION_SUCCESS

	//If the target died from anything other than losing their head, we have failed
	if (target.stat == DEAD)
		return EXECUTION_CANCEL


	return EXECUTION_CONTINUE




/mob/living/carbon/human/proc/abandon_vessel()
	set category = "Abilities"
	set name = "Abandon Vessel"
	set desc = "Detaches your head from this body so you can find another. This is irreversible, the current body cannot be used again."

	var/obj/item/organ/external/E = get_organ(BP_HEAD)
	if (E)
		E.droplimb()

	update_body()


//This extension just marks a corpse so that a head can't repeatedly reuse it
/datum/extension/used_vessel
	expected_type = /mob/living/carbon/human