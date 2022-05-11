/datum/species/robotic
	say_mod = "beeps"
	inherent_biotypes = MOB_ROBOTIC|MOB_HUMANOID
	inherent_traits = list(
		TRAIT_CAN_STRIP,
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_RADIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_NOBREATH,
		TRAIT_TOXIMMUNE,
		TRAIT_NOCLONELOSS,
		TRAIT_GENELESS,
		TRAIT_STABLEHEART,
		TRAIT_LIMBATTACHMENT,
		TRAIT_NO_HUSK,
		TRAIT_OXYIMMUNE
	)
	mutant_bodyparts = list()
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	reagent_flags = PROCESS_SYNTHETIC
	burnmod = 1.3 // Every 0.1% is 10% above the base.
	brutemod = 1.3
	coldmod = 1.2
	heatmod = 2
	siemens_coeff = 1.4 //Not more because some shocks will outright crit you, which is very unfun
	payday_modifier = 0.75 // Matches the rest of the pay penalties the non-human crew have
	species_language_holder = /datum/language_holder/machine
	mutant_organs = list(/obj/item/organ/cyberimp/arm/power_cord)
	mutantbrain = /obj/item/organ/brain/ipc_positron
	mutantstomach = /obj/item/organ/stomach/robot_ipc
	mutantears = /obj/item/organ/ears/robot_ipc
	mutanttongue = /obj/item/organ/tongue/robot_ipc
	mutanteyes = /obj/item/organ/eyes/robot_ipc
	mutantlungs = /obj/item/organ/lungs/robot_ipc
	mutantheart = /obj/item/organ/heart/robot_ipc
	mutantliver = /obj/item/organ/liver/robot_ipc
	exotic_blood = /datum/reagent/fuel/oil
	learnable_languages = list(/datum/language/common, /datum/language/machine)

/datum/species/robotic/spec_life(mob/living/carbon/human/H)
	if(H.stat == SOFT_CRIT || H.stat == HARD_CRIT)
		H.adjustFireLoss(1) //Still deal some damage in case a cold environment would be preventing us from the sweet release to robot heaven
		H.adjust_bodytemperature(13) //We're overheating!!
		if(prob(10))
			to_chat(H, span_warning("Alert: Critical damage taken! Cooling systems failing!"))
			do_sparks(3, TRUE, H)

/datum/species/robotic/spec_revival(mob/living/carbon/human/H)
	playsound(H.loc, 'sound/machines/chime.ogg', 50, 1, -1)
	H.visible_message(span_notice("[H]'s monitor lights up."), span_notice("All systems nominal. You're back online!"))

/datum/species/robotic/on_species_gain(mob/living/carbon/human/C)
	. = ..()
	var/obj/item/organ/appendix/appendix = C.getorganslot(ORGAN_SLOT_APPENDIX)
	if(appendix)
		appendix.Remove(C)
		qdel(appendix)

/datum/species/robotic/random_name(gender,unique,lastname)
	var/randname = pick(GLOB.posibrain_names)
	randname = "[randname]-[rand(100, 999)]"
	return randname

/datum/species/robotic/get_types_to_preload()
	return ..() - typesof(/obj/item/organ/cyberimp/arm/power_cord) // Don't cache things that lead to hard deletions.

/datum/species/robotic/get_species_description()
	return placeholder_description

/datum/species/robotic/get_species_lore()
	return list(placeholder_lore)
