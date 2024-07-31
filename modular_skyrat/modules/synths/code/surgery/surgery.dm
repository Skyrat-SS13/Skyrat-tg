//Blacklists upstream's mechanical surgeries for augmented people in favor of our synth surgeries

/datum/surgery/advanced/bioware/cortex_folding/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/advanced/bioware/cortex_imprint/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/advanced/bioware/ligament_hook/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/advanced/bioware/muscled_veins/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/advanced/bioware/nerve_grounding/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/advanced/bioware/nerve_splicing/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/advanced/bioware/vein_threading/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/advanced/lobotomy/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/blood_filter/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/brain_surgery/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/coronary_bypass/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/gastrectomy/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/hepatectomy/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/lipoplasty/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/lobectomy/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

//Disable both normal and mechanical for synths. Makes some sense on augmented people so lacks a biotype check.
/datum/surgery/revival/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()

/datum/surgery/stomach_pump/mechanic/can_start(mob/user, mob/living/carbon/target)
	return !issynthetic(target) && ..()
