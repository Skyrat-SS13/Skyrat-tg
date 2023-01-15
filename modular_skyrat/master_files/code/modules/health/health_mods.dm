#define PAIN_CAP 500
#define PAIN_MIN 0
#define SHOCK_THRESH 50
#define PAIN_WOUND_MINOR 30
#define PAIN_WOUND_MODERATE 50
#define PAIN_WOUND_MAJOR 80
#define MAGIC_PAIN_DIVISOR 10
#define PAIN "pain"
/datum/component/pain/
	var/mob/living/carbon/human/pain_haver
	var/pain_score
	var/obj/item/organ/internal/heart
	var/list/last_wounds = list()
/datum/component/pain/Initialize()
	if(!istype(parent, /mob/living/carbon/human))
		return COMPONENT_INCOMPATIBLE
/datum/component/pain/RegisterWithParent()
	pain_haver = parent
	heart = pain_haver.getorgan(/obj/item/organ/internal/heart)
	RegisterSignal(parent, COMSIG_LIVING_LIFE, .proc/pain_tick)
/datum/component/pain/UnregisterFromParent()
	pain_haver = null
	heart = null
	UnregisterSignal(parent, COMSIG_LIVING_LIFE)
/datum/component/pain/proc/pain_tick()
	SIGNAL_HANDLER
	var/pain_score_tick
	if(issynthetic(pain_haver))
		goto skip
	if(!heart)
		var/heart = pain_haver.getorgan(/obj/item/organ/internal/heart)
	if(pain_haver.stat == DEAD)
		pain_score = PAIN_CAP
		return
	for(var/datum/wound/iterwound in pain_haver.all_wounds)
//		iterwound |= last_wounds
		if(iterwound.severity == WOUND_SEVERITY_SEVERE || WOUND_SEVERITY_CRITICAL || WOUND_SEVERITY_LOSS)
			pain_score_tick += PAIN_WOUND_MAJOR / MAGIC_PAIN_DIVISOR
		if(iterwound.severity == WOUND_SEVERITY_MODERATE)
			pain_score_tick += PAIN_WOUND_MODERATE / MAGIC_PAIN_DIVISOR
		if(iterwound.severity == WOUND_SEVERITY_TRIVIAL)
			pain_score_tick += PAIN_WOUND_MINOR / MAGIC_PAIN_DIVISOR
	for(var/obj/item/organ/internal in pain_haver.internal_organs)
		if(internal.damage)
			pain_score_tick += internal.damage / MAGIC_PAIN_DIVISOR
	skip
	pain_score_tick += (pain_haver.getBruteLoss() \
		+ pain_haver.getFireLoss() \
		+ pain_haver.getToxLoss() \
		+ pain_haver.getOxyLoss() \
		+ pain_haver.getStaminaLoss() \
		/ MAGIC_PAIN_DIVISOR)
	pain_score_tick = clamp(ROUND_UP(pain_score_tick), PAIN_MIN, PAIN_CAP)
	pain_score_tick >= pain_score ? (clamp(pain_score += pain_score_tick / MAGIC_PAIN_DIVISOR, PAIN_MIN, pain_score_tick)) : (pain_score -= 1 - pain_score_tick / MAGIC_PAIN_DIVISOR)
	. = pain_score_tick
	if(pain_score >= .)
		pain_score = .
//	pain_haver.maxHealth = ((MAX_HUMAN_LIFE * 2) -= pain_score_tick)
	pain_haver.hud_used?.healths?.maptext = MAPTEXT("[pain_score] [pain_score_tick]") // This will runtime roundstart if not checked.
	if(pain_score >= SHOCK_THRESH)
		REMOVE_TRAIT(pain_haver, TRAIT_NOHARDCRIT, PAIN)
		REMOVE_TRAIT(pain_haver, TRAIT_NOSOFTCRIT, PAIN)
		if(prob(5) && pain_haver.can_heartattack())
			var/datum/disease/heart_disease = new /datum/disease/heart_failure()
			pain_haver.ForceContractDisease(heart_disease, FALSE, TRUE)
	else
		ADD_TRAIT(pain_haver, TRAIT_NOHARDCRIT, PAIN)
		ADD_TRAIT(pain_haver, TRAIT_NOSOFTCRIT, PAIN)

/mob/living/carbon/human/Initialize(mapload)
	. = ..()
	AddComponent(/datum/component/pain)
