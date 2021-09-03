//Chameleon causes the owner to slowly become transparent when not moving.
/datum/mutation/human/chameleon
	name = "Chameleon"
	desc = "A genome that causes the holder's skin to become transparent over time."
	quality = POSITIVE
	difficulty = 16
	text_gain_indication = "<span class='notice'>You feel one with your surroundings.</span>"
	text_lose_indication = "<span class='notice'>You feel oddly exposed.</span>"
	time_coeff = 5
	instability = 35
	power = /obj/effect/proc_holder/spell/self/chameleon_skin_activate

/obj/effect/proc_holder/spell/self/chameleon_skin_activate
	name = "Activate Chameleon Skin"
	desc = "The chromatophores in your skin adjust to your surroundings, as long as you stay still."
	clothes_req = FALSE
	action_icon = 'icons/mob/actions/actions_minor_antag.dmi'
	action_icon_state = "ninja_cloak"

/datum/mutation/human/chameleon/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	if(HAS_TRAIT(owner,TRAIT_CHAMELEON_SKIN))
		return
	owner.alpha = CHAMELEON_MUTATION_DEFAULT_TRANSPARENCY
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, .proc/on_move)
	RegisterSignal(owner, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, .proc/on_attack_hand)

/obj/effect/proc_holder/spell/self/chameleon_skin_activate/cast(list/targets, mob/user = usr)
	. = ..()

	if(HAS_TRAIT(user,TRAIT_CHAMELEON_SKIN))
		chameleon_skin_deactivate(user)
		return

	ADD_TRAIT(user, TRAIT_CHAMELEON_SKIN, GENETIC_MUTATION)
	to_chat(user, "The pigmentation of your skin shifts and starts to take on the colors of your surroundings.")

/obj/effect/proc_holder/spell/self/chameleon_skin_activate/proc/chameleon_skin_deactivate(mob/user = usr)
	if(!HAS_TRAIT_FROM(user,TRAIT_CHAMELEON_SKIN, GENETIC_MUTATION))
		return

	REMOVE_TRAIT(user, TRAIT_CHAMELEON_SKIN, GENETIC_MUTATION)
	user.alpha = 255
	to_chat(user, text("Your skin shifts as it shimmers back into its original colors."))

/datum/mutation/human/chameleon/on_life(delta_time, times_fired)
	if(HAS_TRAIT(owner, TRAIT_CHAMELEON_SKIN))
		owner.alpha = max(owner.alpha - (12.5 * delta_time), 0)

/datum/mutation/human/chameleon/proc/on_move()
	SIGNAL_HANDLER

	if(HAS_TRAIT(owner, TRAIT_CHAMELEON_SKIN))
		owner.alpha = CHAMELEON_MUTATION_DEFAULT_TRANSPARENCY
	else
		owner.alpha = 255

/datum/mutation/human/chameleon/proc/on_attack_hand(atom/target, proximity)
	SIGNAL_HANDLER

	if(!proximity) //stops tk from breaking chameleon
		return
	owner.alpha = CHAMELEON_MUTATION_DEFAULT_TRANSPARENCY

/datum/mutation/human/chameleon/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.alpha = 255
	UnregisterSignal(owner, COMSIG_MOVABLE_MOVED)
