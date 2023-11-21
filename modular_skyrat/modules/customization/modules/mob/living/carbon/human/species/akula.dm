/// How long the akula will stay wet for, AKA how long until they get a mood debuff
#define DRY_UP_TIME 10 MINUTES
/// How many wetstacks an Akula will get upon creation
#define WETSTACK_INITIAL 5
/// How many wetstacks an Akula needs to activate the TRAIT_SLIPPERY trait
#define WETSTACK_THRESHOLD 3

/datum/species/akula
	name = "Akula"
	id = SPECIES_AKULA
	lore_protected = TRUE
	offset_features = list(
		OFFSET_GLASSES = list(0, 1),
		OFFSET_EARS = list(0, 2),
		OFFSET_FACEMASK = list(0, 2),
		OFFSET_HEAD = list(0, 2),
		OFFSET_HAIR = list(0, 1),
	)
	eyes_icon = 'modular_skyrat/modules/organs/icons/akula_eyes.dmi'
	mutanteyes = /obj/item/organ/internal/eyes/akula
	mutanttongue = /obj/item/organ/internal/tongue/akula
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_LITERATE,
		TRAIT_WATER_BREATHING,
		TRAIT_SLICK_SKIN,
		TRAIT_MUTANT_COLORS,
	)
	inherent_biotypes = MOB_ORGANIC|MOB_HUMANOID
	mutant_bodyparts = list()
	default_mutant_bodyparts = list(
		"tail" = ACC_RANDOM,
		"legs" = "Normal Legs"
	)
	outfit_important_for_life = /datum/outfit/akula
	payday_modifier = 1.0
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	bodypart_overrides = list(
		BODY_ZONE_HEAD = /obj/item/bodypart/head/mutant/akula,
		BODY_ZONE_CHEST = /obj/item/bodypart/chest/mutant/akula,
		BODY_ZONE_L_ARM = /obj/item/bodypart/arm/left/mutant/akula,
		BODY_ZONE_R_ARM = /obj/item/bodypart/arm/right/mutant/akula,
		BODY_ZONE_L_LEG = /obj/item/bodypart/leg/left/mutant/akula,
		BODY_ZONE_R_LEG = /obj/item/bodypart/leg/right/mutant/akula,
	)
	/// This variable stores the timer datum which appears if the mob becomes wet
	var/dry_up_timer = TIMER_ID_NULL

/datum/species/akula/get_default_mutant_bodyparts()
	return list(
		"tail" = list("Akula", TRUE),
		"legs" = list("Normal Legs", FALSE),
	)

/datum/species/akula/get_species_description()
	return placeholder_description

/datum/species/akula/get_species_lore()
	return list("The Azuleans, known as 'Akulas' or 'Akulans' to humans, are a strong-willed and monarchist culture. A vast nation, the Kingdom of Agurkrral has achieved its status largely by sheer tenacity; Azuleans forcing themselves upwards from the depths of their home seas all the way to a monarchy that even dwarfs the Sol Federation. They are known to be an expansionist culture, collectivist opportunists that are driven by history and culture to push further, and to push onward. To keep moving, or to suffocate and stagnate.",
	"Beginning their prehistory with total defeat of another intelligent species set to keep them in their waters forever, the Azuleans have forged themselves into a pioneering people willing to exploit even the most hostile lands; and turn foreign places, flora and fauna, and even people to their advantage. New colonies are being terraformed into 'Agurkrral-A-Likes' every day, strange bioengineered creatures released into the wilds and massive treatment machines being ran in the waters to accomodate the new biosphere. Even some foreign citizens have been forcibly turned into Azuleans through genemodding, before having their genes locked and unable to be altered by anyone else.",
	"Their drive for constant expansion and 'the next great thing' has made the Kingdom a divided one; a culture split in two. Generations of Azuleans are separated not by age-based cohorts, but by distance; the 'Near' generations growing up in the Old Principalities, and the 'Far' generations growing up in the New Principalities.",
	"The Old Principalities, coreward around their Homeworld, are a burgeoning place slowly falling victim to stagnation. The core worlds still cling to ancient traditions, ceremonies and expectation; old aristocratic houses, tracing their power from ancient ancestors placed to protect and shepherd their assigned lands, still thrive; and the King still rules over many systems of old. Constant reforms and false shake-ups of the status quo demand more and more. Longer bouts of service to achieve citizenship, reformation camps to 'iron out' those with physical and mental defects, and high reliance on exams, education, and pomp to create a hierarchy within its society.",
	"The New Principalities, created and commandeered by edgerunning 'border princes' dwelling around the furthest reaches of the Kingdom, embody the Azulean spirit of opportunism and adventurism. Warlord-style nobles reign free, able to outswim any checks meant to control their power and influence. A laissez-faire approach is taken here, where anyone can do anything to become somebody; ambition and self-evolution valued far more than any birthright. Sprawling casino cities, pirate ports, and even luxurious resorts are known to be built up overnight, anyone being able to make money and become wealthy and even command naval ships on charisma and strength alone; fear being the second state currency right behind credits. Even some SolFed citizens are known to come here and profit as mercenaries, investors, gamblers, or even 'border princes.'",
	"These generations split apart by distance are known for their animosity towards the other. To those in the New Principalities, their coreward cousins have lost the 'Azulean spirit;' rotting apart in their palaces, sitting in waters choked with ennui. Their forever expansion into the frontier colonies, their use of every useful material and lifeform is what they believe their Kingdom is fueled by. But to those in the Old Principalities, their edgeward descendants have lost their minds. They believe the spiritual and societal importance of their Homeworld has fallen on deaf ears, and the lackadaisical attitude about the core mechanisms and noble structures holding the Kingdom together has become nothing short of infuriating. It is the belief of many high-ranking members of the Monarchy that the ongoing terraforming processes in the frontiers are proof of the arrogance of the 'border princes' controlling them; each and every world made in the image of a planet the King himself is meant to protect.",
	"Yet, despite their differences, all Agurkrral citizens swim freely in their kingdom's waters. Even the most controlling border princes, even those in the Old Principalities working the slave trade, know better than to openly erode a citizen's right to life, property, and speech. Any alien species can become an Agurkrral citizen, and even non-citizens enjoy the right to life, with executions outright banned. The aristocracy remains well-educated, even the edgerunner warlords of the New Principalities, and the Kingdom as a whole enjoys its status as a nation that's now a true rival to Sol. Larger, more populated, and better developed; though, having to 'integrate' Solarian technologies, goods, and peoples to fully succeed. The Azuleans are even known as an environmentally-focused people; although they hold no care for lands they cannot make use of, modern nobles are still in charge of maintaining the biosphere of lands they control, to allow their strangely engineered flora and fauna to thrive, and for the people to have healthy and clean waters to live in.",
	)

/datum/species/akula/randomize_features(mob/living/carbon/human/human_mob)
	var/main_color
	var/secondary_color
	var/tertiary_color
	var/random = rand(1, 4)
	switch(random)
		if(1)
			main_color = "#1CD3E5"
			secondary_color = "#6AF1D6"
			tertiary_color = "#CCF6E2"
		if(2)
			main_color = "#CF3565"
			secondary_color = "#d93554"
			tertiary_color = "#fbc2dd"
		if(3)
			main_color = "#FFC44D"
			secondary_color = "#FFE85F"
			tertiary_color = "#FFF9D6"
		if(4)
			main_color = "#DB35DE"
			secondary_color = "#BE3AFE"
			tertiary_color = "#F5E2EE"
	human_mob.dna.features["mcolor"] = main_color
	human_mob.dna.features["mcolor2"] = secondary_color
	human_mob.dna.features["mcolor3"] = tertiary_color

/datum/species/akula/prepare_human_for_preview(mob/living/carbon/human/akula)
	var/main_color = "#1CD3E5"
	var/secondary_color = "#6AF1D6"
	var/tertiary_color = "#CCF6E2"
	akula.dna.features["mcolor"] = main_color
	akula.dna.features["mcolor2"] = secondary_color
	akula.dna.features["mcolor3"] = tertiary_color
	akula.dna.mutant_bodyparts["tail"] = list(MUTANT_INDEX_NAME = "Akula", MUTANT_INDEX_COLOR_LIST = list(main_color, secondary_color, tertiary_color))
	akula.dna.features["legs"] = "Normal Legs"
	regenerate_organs(akula, src, visual_only = TRUE)
	akula.update_body(TRUE)

/obj/item/organ/internal/eyes/akula
	// Eyes over hair as bandaid for the low amounts of head matching hair
	eyes_layer = HAIR_LAYER-0.1


/obj/item/organ/internal/tongue/akula
	liked_foodtypes = SEAFOOD | RAW
	disliked_foodtypes = CLOTH | DAIRY
	toxic_foodtypes = TOXIC


/datum/species/akula/get_random_body_markings(list/passed_features)
	var/datum/body_marking_set/body_marking_set = GLOB.body_marking_sets["Akula"]
	var/list/markings = list()
	if(body_marking_set)
		markings = assemble_body_markings_from_set(body_marking_set, passed_features, src)
	return markings

/datum/species/akula/pre_equip_species_outfit(datum/job/job, mob/living/carbon/human/equipping, visuals_only = FALSE)
	if(job?.akula_outfit)
		equipping.equipOutfit(job.akula_outfit, visuals_only)
	else
		give_important_for_life(equipping)

// Wet_stacks handling
// more about grab_resists in `code\modules\mob\living\living.dm` at li 1119
// more about slide_distance in `code\game\turfs\open\_open.dm` at li 233
/// Lets register the signal which calls when we are above 10 wet_stacks
/datum/species/akula/on_species_gain(mob/living/carbon/akula, datum/species/old_species, pref_load)
	. = ..()
	RegisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN, PROC_REF(wetted), akula)
	// lets give 15 wet_stacks on initial
	akula.set_wet_stacks(WETSTACK_INITIAL, remove_fire_stacks = FALSE)

/// Remove the signal on species loss
/datum/species/akula/on_species_loss(mob/living/carbon/akula, datum/species/new_species, pref_load)
	. = ..()
	UnregisterSignal(akula, COMSIG_MOB_TRIGGER_WET_SKIN)

/// This proc is called when a mob with TRAIT_SLICK_SKIN gains over 10 wet_stacks
/datum/species/akula/proc/wetted(mob/living/carbon/akula)
	SIGNAL_HANDLER
	// Apply the slippery trait if its not there yet
	if(!HAS_TRAIT(akula, TRAIT_SLIPPERY))
		ADD_TRAIT(akula, TRAIT_SLIPPERY, SPECIES_TRAIT)

	// Relieve the negative moodlet
	akula.clear_mood_event("dry_skin")
	// The timer which will initiate above 10 wet_stacks, and call dried() once the timer runs out
	dry_up_timer = addtimer(CALLBACK(src, PROC_REF(dried), akula), DRY_UP_TIME, TIMER_UNIQUE | TIMER_STOPPABLE)

/// This proc is called after a mob with the TRAIT_SLIPPERY has its related timer run out
/datum/species/akula/proc/dried(mob/living/carbon/akula)
	// A moodlet which will not go away until the user gets wet
	akula.add_mood_event("dry_skin", /datum/mood_event/dry_skin)

/// A simple overwrite which calls parent to listen to wet_stacks
/datum/status_effect/fire_handler/wet_stacks/tick(delta_time)
	. = ..()
	if(!owner)
		return
	if(HAS_TRAIT(owner, TRAIT_SLICK_SKIN) && stacks >= WETSTACK_THRESHOLD)
		SEND_SIGNAL(owner, COMSIG_MOB_TRIGGER_WET_SKIN)

	if(HAS_TRAIT(owner, TRAIT_SLIPPERY) && stacks <= 0.5) // Removed just before we hit 0 and delete the /status_effect/
		REMOVE_TRAIT(owner, TRAIT_SLIPPERY, SPECIES_TRAIT)

#undef DRY_UP_TIME
#undef WETSTACK_INITIAL
#undef WETSTACK_THRESHOLD
