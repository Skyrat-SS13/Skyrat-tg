/obj/item/organ/corticalstack
	name = "cortical stack"
	desc = "A strange, crystalline storage device containing 'DHF', digitised conciousness."
	icon = 'modular_skyrat/modules/neural-lacing/icons/Neuralstack.dmi'
	icon_state = "cortical-stack"
	base_icon_state = "cortical-stack"
	zone = BODY_ZONE_HEAD
	slot = ORGAN_SLOT_STACK
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC

	var/active = FALSE
	var/invasive = 1 //WILL THIS KILL THE HOST IF REMOVED?
	var/ownerckey
	var/datum/mind/backup
	var/prompting = FALSE // Are we waiting for a user prompt before backing them up to DHF?

/obj/item/organ/corticalstack/examine()
	. = ..()
	if(!backup && !ownerckey && active) //SHOULD NOT HAPPEN
		. += span_info("The integrity light upon the lace is dull, and black. The DHF is corrupted beyond repair.")
		return
	if((ownerckey && (backup || backup.get_ghost()))) //Incase something incredibly bad happens
		if(organ_flags & ORGAN_FAILING)
			. += span_info("The integrity light upon the neural lace is flashing a dull red, damaged. You may be able to restore it with some <b>cable coils</b>.")
		else
			. += span_info("The integrity light is showing a pale blue.")
	else
		. += span_info("This one is dark and dull, empty.")


/obj/item/organ/corticalstack/Insert(mob/living/carbon/MSTACK)
	. = ..()
	MSTACK.visible_message(span_notice("[MSTACK] jerks violently as the cortical stack is inserted..."))
	if(!active)
		ownerckey = MSTACK.ckey
		backup = MSTACK.mind
		active = TRUE
		to_chat(MSTACK, span_danger("You feel a sharp sting, and then a cool, almost numbing sensation spread over your form; your cortical stack coming online..."))
		MSTACK.visible_message(span_notice("..Before ceasing, the stack letting out a ping; it has succeeded in integrating with their neural systems."))
	else
		if(MSTACK.mind && (backup || ownerckey) && !(MSTACK.mind == backup || MSTACK.ckey != ownerckey))
			MSTACK.visible_message(span_warning("..Before ceasing, the stack letting out an alarm; unable to override the conciousness within."))
		else
			MSTACK.visible_message(span_notice("..Before ceasing, the stack letting out a ping; it has succeeded in integrating with their neural systems."))
			to_chat(owner, span_notice("You feel a strange, ephermeal sensation come over you, as you re-awaken from your slumber..."))
			REMOVE_TRAIT(MSTACK, TRAIT_DNR, src) //PREVENTS PEOPLE FROM GETTING DNR'D AFTER HAVING THEIR STACK REMOVED AND RELACED
			MSTACK.ckey = ownerckey
			MSTACK.mind = backup
			MSTACK.SetSleeping(100)

/obj/item/organ/corticalstack/Remove(mob/living/carbon/MSTACK)
	. = ..()
	if(invasive)
		MSTACK.death()
		MSTACK.visible_message(span_danger("[MSTACK] violently siezes as their stack is removed!"))
		ADD_TRAIT(MSTACK, TRAIT_DNR, src)

	else
		MSTACK.visible_message(span_danger("[MSTACK] twinges in discomfort; although remains concious."))

/obj/item/organ/corticalstack/Destroy()
	. = ..()
	ownerckey = null
	backup = null
