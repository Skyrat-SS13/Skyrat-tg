//Chameleon causes the owner to slowly become transparent when not moving.
/datum/mutation/human/chameleon
	name = "Chameleon"
	desc = "A genome that causes the holder's skin to become transparent over time."
	quality = POSITIVE
	difficulty = 16
	text_gain_indication = "<span class='notice'>You feel one with your surroundings.</span>"
	text_lose_indication = "<span class='notice'>You feel oddly exposed.</span>"
	time_coeff = 5
	/// SKYRAT EDIT BEGIN
	instability = 35
	power = /obj/effect/proc_holder/spell/self/chameleon_skin_activate
	/// SKYRAT EDIT END

/datum/mutation/human/chameleon/on_acquiring(mob/living/carbon/human/owner)
	if(..())
		return
	/// SKYRAT EDIT BEGIN
	if(HAS_TRAIT(owner,TRAIT_CHAMELEON_SKIN))
		return
	/// SKYRAT EDIT END
	owner.alpha = CHAMELEON_MUTATION_DEFAULT_TRANSPARENCY
	RegisterSignal(owner, COMSIG_MOVABLE_MOVED, .proc/on_move)
	RegisterSignal(owner, COMSIG_HUMAN_EARLY_UNARMED_ATTACK, .proc/on_attack_hand)

/datum/mutation/human/chameleon/on_life(delta_time, times_fired)
	/// SKYRAT EDIT BEGIN
	if(HAS_TRAIT(owner, TRAIT_CHAMELEON_SKIN))
		owner.alpha = max(owner.alpha - (12.5 * delta_time), 0)
	/// SKYRAT EDIT END

/datum/mutation/human/chameleon/proc/on_move()
	SIGNAL_HANDLER

	/// SKYRAT EDIT BEGIN
	if(HAS_TRAIT(owner, TRAIT_CHAMELEON_SKIN))
		owner.alpha = CHAMELEON_MUTATION_DEFAULT_TRANSPARENCY
	else
		owner.alpha = 255
		/// SKYRAT EDIT END

/datum/mutation/human/chameleon/proc/on_attack_hand(atom/target, proximity)
	SIGNAL_HANDLER

	if(!proximity) //stops tk from breaking chameleon
		return

	/// SKYRAT EDIT BEGIN
	if(HAS_TRAIT(owner, TRAIT_CHAMELEON_SKIN))
		owner.alpha = CHAMELEON_MUTATION_DEFAULT_TRANSPARENCY
	else
		owner.alpha = 255
	/// SKYRAT EDIT END

/datum/mutation/human/chameleon/on_losing(mob/living/carbon/human/owner)
	if(..())
		return
	owner.alpha = 255
	UnregisterSignal(owner, list(COMSIG_MOVABLE_MOVED, COMSIG_HUMAN_EARLY_UNARMED_ATTACK))
