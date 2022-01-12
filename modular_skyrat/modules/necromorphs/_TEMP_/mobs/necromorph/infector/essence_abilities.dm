#define ESSENCE_COST_REANIMATE	3
/datum/species/necromorph/infector
	var/list/essence_abilities = list("Reanimate"	= /datum/extension/ability/domob/reanimate,
	"Engorge"	= /datum/extension/ability/domob/engorge,
	"Mend"	=	/datum/extension/ability/domob/mend,
	"Forming: Maw" = /datum/extension/ability/construction/corruption/maw,
	"Forming: Eye" = /datum/extension/ability/construction/corruption/eye,
	"Forming: Snare" = /datum/extension/ability/construction/corruption/snare,
	"Forming: Propagator" = /datum/extension/ability/construction/corruption/growth,
	"Forming: New Growth" = /datum/extension/ability/construction/corruption/newgrowth,
	"Forming: Harvester" = /datum/extension/ability/construction/corruption/harvester,
	"Forming: Bioluminescence" = /datum/extension/ability/construction/corruption/light)


//Once, on species creation, lets do some runtime processing on the essence abilities list
//This is here because I could not find a way to do this at compiletime
/datum/species/necromorph/infector/New()
	.=..()
	var/list/essence_abilities_altered = list()
	for (var/string_name in essence_abilities)
		var/data = essence_abilities[string_name]

		//Possible future todo: Data could be a list containing more than just a typepath
		var/datum/extension/ability/A = data

		var/cost = initial(A.resource_cost_quantity)
		string_name += "	([cost])"
		essence_abilities_altered[string_name] = data

	//Replace the old list with our new one
	essence_abilities = essence_abilities_altered


/datum/species/necromorph/infector/setup_interaction(var/mob/living/carbon/human/H)
	.=..()
	set_extension(H, /datum/extension/resource/essence)



/datum/extension/resource/essence
	name = "Essence"
	current_value = 5 //5 points free to start with
	max_value = 15
	regen = (1 SECOND) / (1 MINUTE)	//One point regenerated per minute
	meter_type = /atom/movable/screen/meter/resource/essence
	var/list/selected_essence_ability	//Used by infector, this is a list containing the type and parameters of the essence ability we have selected


//Regenerates faster when over half, to encourage cautious allocation
/datum/extension/resource/essence/get_regen_amount()
	.=..()
	if (current_value >= max_value * 0.5)
		.*=1.5

/*
	Entrypoints
*/
/mob/living/carbon/human/proc/select_essence_ability()
	set name = "Select Essence Ability"
	set desc = "Select your active ability to use with essence"
	set category = "Abilities"

	var/datum/species/necromorph/infector/I = species
	var/list/abilities = I.essence_abilities	//We won't modify this so copying it is unnecessary
	var/selection = input(src, "Current Essence:	[get_resource_curmax(RESOURCE_ESSENCE)]\n\
	Select which ability you wish to make active, and then trigger it with Ctrl+Alt+Click after selection.", "Ability Selection") as null|anything in abilities


	var/datum/extension/resource/essence/E = get_extension(src, /datum/extension/resource/essence)
	var/datum/extension/ability/selected_ability_type = abilities[selection]
	if (selected_ability_type)
		E.selected_essence_ability = list(selected_ability_type)
		to_chat(src, "Now selected: [initial(selected_ability_type.name)]\n\
		[initial(selected_ability_type.blurb)]")



/mob/living/carbon/human/proc/use_selected_essence_ability(var/atom/target)
	set name = "Trigger Essence Ability"
	set desc = "Use an active ability"
	set category = "Abilities"
	var/datum/extension/resource/essence/E = get_extension(src, /datum/extension/resource/essence)

	if (E.selected_essence_ability)
		var/ability_type = E.selected_essence_ability[1]	//The type of ability is always the first thing
		var/list/parameters = E.selected_essence_ability.Copy(2)	//Copy everything but the first to make our params
		parameters["target"]	=	target	//Add in the target we were passed
		do_ability(ability_type, parameters)
	else
		to_chat(src, "No ability is selected. Use Select Essence Ability from the abilities tab!")



/*
	Reanimate
*/
/datum/extension/ability/domob/reanimate
	name = "Reanimate"
	blurb = "Resurrects a target corpse as a new necromorph."
	duration = 13 SECONDS
	reach = 2
	resource_cost_type	=	RESOURCE_ESSENCE
	resource_cost_quantity = 3

/datum/extension/ability/domob/reanimate/apply_start_effect()
	var/mob/living/L = target
	spawn()
		L.start_necromorph_conversion()

/datum/extension/ability/domob/reanimate/stop()
	var/mob/living/L = target
	DEL_TRANSFORMATION_MOVEMENT_HANDLER(L)	//This handler is checked for during the loop, so it will stop it
	.=..()

/datum/extension/ability/domob/reanimate/is_valid_target(var/datum/potential_target, var/mob/potential_user)
	.=..()
	if (.)
		//Gotta be living, dead, not necro
		var/mob/living/L = potential_target

		//Already changing
		if (HAS_TRANSFORMATION_MOVEMENT_HANDLER(L))
			return

		if (!L.is_necromorph_conversion_valid())
			to_chat(potential_user, "Invalid Target: The target must be a dead or unconscious,  non-necromorph lifeform which is not headless")
			return FALSE
/*
	Engorge
*/
/datum/extension/ability/domob/engorge
	name = "Engorge"
	blurb = "Makes the targeted necromorph larger, increasing its health, movespeed and view range."
	resource_cost_type	=	RESOURCE_ESSENCE
	resource_cost_quantity = 2

/datum/extension/ability/domob/engorge/apply_effect()
	if (!has_extension(target, /datum/extension/engorge))
		set_extension(target, /datum/extension/engorge)

/datum/extension/ability/domob/engorge/is_valid_target(var/datum/potential_target, var/mob/potential_user)
	.=..()
	if (.)
		//Gotta be an alive necromorph
		var/mob/living/L = potential_target

		if (L.stat == DEAD)
			to_chat(potential_user, "Target must be alive")
			return FALSE

		if (!L.is_necromorph())
			to_chat(potential_user, "Target must be Necromorph")
			return FALSE

		if (has_extension(L, /datum/extension/engorge))
			to_chat(potential_user, "Target is already engorged")
			return FALSE

		if (L == potential_user)
			to_chat(potential_user, "You can't target yourself!")
			return FALSE



/datum/extension/engorge
	flags = EXTENSION_FLAG_IMMEDIATE
	statmods = list(STATMOD_SCALE	=	0.15,
	STATMOD_MOVESPEED_MULTIPLICATIVE = 1.08,
	STATMOD_HEALTH = 50,
	STATMOD_VIEW_RANGE = 1)






#define MEND_HEAL_PER_TICK	5
#define MEND_COST_PER_TICK	0.1
/*
	Mend
	A heal-over-time. Ticks each second, consuming some essence and healing the target
*/
/datum/extension/ability/domob/mend
	name = "Mend"
	blurb = "Heals the targeted necromorph, restoring its health and consuming essence over time"
	reach = 2
	resource_cost_type	=	RESOURCE_ESSENCE
	resource_cost_quantity = 0

/datum/extension/ability/domob/mend/pre_calculate()
	.=..()
	var/mob/living/L = target
	var/damage = L.getBruteLoss() + L.getFireLoss() + L.getLastingDamage()


	//Lets figure out the duration
	duration = (ceil(damage / MEND_HEAL_PER_TICK) + 1) SECONDS


/datum/extension/ability/domob/mend/is_valid_target(var/datum/potential_target, var/mob/potential_user)
	.=..()

	if (.)
		//Gotta be an alive mob
		var/mob/living/L = potential_target

		if (!istype(L) || L.stat == DEAD)
			to_chat(potential_user, "Target must be alive")
			return FALSE

		var/damage = L.getBruteLoss() + L.getFireLoss() + L.getLastingDamage()
		if (!(damage > 0))
			to_chat(potential_user, "Target is in perfect health")
			return FALSE

		if (L == potential_user)
			to_chat(potential_user, "You can't target yourself!")
			return FALSE


/datum/extension/ability/domob/mend/assemble_callback()
	C = CALLBACK(src, /datum/extension/ability/domob/mend/proc/heal)

/datum/extension/ability/domob/mend/proc/heal()
	//Safety checks first
	var/mob/living/L = target
	if (!continue_safety())
		interrupt()
		return

	//Costs 0.1 essence per tick
	if (user.consume_resource(resource_cost_type, MEND_COST_PER_TICK))
		//To heal 10 damage
		L.heal_quantified_damage(MEND_HEAL_PER_TICK, brute = TRUE, fire = TRUE, lasting = TRUE)
		//TODO: Some kind of sound here?
		user.do_attack_animation(L)
		L.shake_animation()
	else
		//We ran out of essence? Abort
		interrupt()
		return

/datum/extension/ability/domob/mend/continue_safety()
	.=..()
	if (.)
		if (!is_valid_target(target, user))
			return FALSE



/*
	Construction Abilities
*/
/datum/extension/ability/construction/corruption/maw
	name = "Forming: Maw"
	blurb = "Constructs a Maw, used as a floor trap and for recovering biomass from corpses."
	result_path = /obj/structure/corruption_node/maw
	construction_time = 20	//Seconds
	resource_cost_quantity = 3


/datum/extension/ability/construction/corruption/eye
	name = "Forming: Eye"
	blurb = "Constructs an Eye, used to detect humans and reveal an area."
	result_path = /obj/structure/corruption_node/eye
	construction_time = 10	//Seconds
	resource_cost_quantity = 1


/datum/extension/ability/construction/corruption/snare
	name = "Forming: Snare"
	blurb = "Constructs a Snare, used as a floor trap."
	result_path = /obj/structure/corruption_node/snare
	construction_time = 5	//Seconds
	resource_cost_quantity = 1


/datum/extension/ability/construction/corruption/growth
	name = "Forming: Propagator"
	blurb = "Constructs a Propagator, used to spread corruption."
	result_path = /obj/structure/corruption_node/growth
	construction_time = 30	//Seconds
	resource_cost_quantity = 4


/datum/extension/ability/construction/corruption/newgrowth
	name = "Forming: New Growth"
	blurb = "Constructs a Propagator without requiring existing corruption, allowing an entirely new place to be corrupted. \n\
	This is very slow and expensive, multiple Infectors should work together."
	result_path = /obj/structure/corruption_node/growth
	construction_time = 300	//Seconds
	resource_cost_quantity = 30
	deposit = 0.05	//1.5 base deposit
	require_corruption = FALSE


/datum/extension/ability/construction/corruption/harvester
	name = "Forming: Harvester"
	blurb = "Constructs a Harvester, used to secure areas, and draw biomass from certain machinery."
	result_path = /obj/structure/corruption_node/harvester
	construction_time = 180	//Seconds
	resource_cost_quantity = 12
	deposit = 0.1


/datum/extension/ability/construction/corruption/light
	name = "Forming: Bioluminescence"
	blurb = "Constructs a Bioluminescent node, used to illuminate an area."
	result_path = /obj/structure/corruption_node/bioluminescence
	construction_time = 10	//Seconds
	resource_cost_quantity = 0.5