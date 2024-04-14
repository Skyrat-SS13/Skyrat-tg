#define BAC_STAGE_1_ACTIVE 0.01
#define BAC_STAGE_2_WARN 0.05
#define BAC_STAGE_2_ACTIVE 0.07
#define BAC_STAGE_3_WARN 0.11
#define BAC_STAGE_3_ACTIVE 0.13
#define BAC_STAGE_4_WARN 0.17
#define BAC_STAGE_4_ACTIVE 0.19
#define BAC_STAGE_5_WARN 0.23

/datum/reagent/consumable/ethanol
	metabolization_rate = 0.3 * REAGENTS_METABOLISM

/atom/movable/screen/alert/status_effect/drunk
	desc = "All that alcohol you've been drinking is impairing your speech, \
		motor skills, and mental cognition. Make sure to act like it. \
		Check your current drunkenness level using your mood status."

/// Adds a moodlet entry based on if the mob currently has alcohol processing in their system.
/datum/mood/proc/get_alcohol_processing(mob/user)
    if(user.reagents.reagent_list.len)
        for(var/datum/reagent/consumable/ethanol/booze in user.reagents.reagent_list)
            return span_notice("I'm still processing that alcohol I drank...\n")

/// Adds a moodlet entry based on the current blood alcohol content of the mob.
/datum/mood/proc/get_drunk_mood(mob/user)
    var/mob/living/target = user
    var/blood_alcohol_content = target.get_blood_alcohol_content()
    switch(blood_alcohol_content)
        if(BAC_STAGE_1_ACTIVE to BAC_STAGE_2_WARN)
            return span_notice("Had a drink, time to relax!\n")
        if(BAC_STAGE_2_WARN to BAC_STAGE_2_ACTIVE)
            return span_nicegreen("Now I'm starting to feel that drink.\n")
        if(BAC_STAGE_2_ACTIVE to BAC_STAGE_3_WARN)
            return span_nicegreen("A bit tipsy, this feels good!\n")
        if(BAC_STAGE_3_WARN to BAC_STAGE_3_ACTIVE)
            return span_nicegreen("Those drinks are really starting to hit!\n")
        if(BAC_STAGE_3_ACTIVE to BAC_STAGE_4_WARN)
            return span_nicegreen("I can't remember how many I've had, but I feel great!\n")
        if(BAC_STAGE_4_WARN to BAC_STAGE_4_ACTIVE)
            return span_warning("I think I've had too much to drink... I should probably stop... drink some water...\n")
        if(BAC_STAGE_4_ACTIVE to BAC_STAGE_5_WARN)
            return span_bolddanger("I'm not feeling so hot...\n")
        if(BAC_STAGE_5_WARN to INFINITY)
            return span_bolddanger("Is there a doctor around? I really don't feel good...\n")

#undef BAC_STAGE_1_ACTIVE
#undef BAC_STAGE_2_WARN
#undef BAC_STAGE_2_ACTIVE
#undef BAC_STAGE_3_WARN
#undef BAC_STAGE_3_ACTIVE
#undef BAC_STAGE_4_WARN
#undef BAC_STAGE_4_ACTIVE
#undef BAC_STAGE_5_WARN
