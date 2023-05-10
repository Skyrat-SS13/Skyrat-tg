/// Maximum an Hemophage will drain, they will drain less if they hit their cap.
#define HEMOPHAGE_DRAIN_AMOUNT 50
/// How much blood do Hemophages normally lose per second (visible effect is every two seconds, so twice this value).
#define NORMAL_BLOOD_DRAIN 0.125
/// Minimum amount of blood that you can reach via blood regeneration, regeneration will stop below this.
#define MINIMUM_VOLUME_FOR_REGEN (BLOOD_VOLUME_BAD + 1) // We do this to avoid any jankiness, and because we want to ensure that they don't fall into a state where they're constantly passing out in a locker.
/// Minimum amount of light for Hemophages to be considered in pure darkness, and therefore be allowed to heal just like in a closet.
#define MINIMUM_LIGHT_THRESHOLD_FOR_REGEN 0
/// How much organ damage do all hemophage organs take per second when the tumor is removed?
#define TUMORLESS_ORGAN_DAMAGE 5
/// How much damage can their organs take at maximum when the tumor isn't present anymore?
#define TUMORLESS_ORGAN_DAMAGE_MAX 100

/// Some starter text sent to the Hemophage initially, because Hemophages have shit to do to stay alive.
#define HEMOPHAGE_SPAWN_TEXT "You are an [span_danger("Hemophage")]. You will slowly but constantly lose blood if outside of a closet-like object. If inside a closet-like object, or in pure darkness, you will slowly heal, at the cost of blood. You may gain more blood by grabbing a live victim and using your drain ability."

/// How much brute damage their body regenerates per second (calculated every two seconds) while under the proper conditions.
#define BLOOD_REGEN_BRUTE_AMOUNT 0.75
/// How much burn damage their body regenerates per second (calculated every two seconds) while under the proper conditions.
#define BLOOD_REGEN_BURN_AMOUNT 0.75
/// How much toxin damage their body regenerates per second (calculated every two seconds) while under the proper conditions.
#define BLOOD_REGEN_TOXIN_AMOUNT 0.5
/// How much cellular damage their body regenerates per second (calculated every two seconds) while under the proper conditions.
#define BLOOD_REGEN_CELLULAR_AMOUNT 0.25

/// The message displayed in the hemophage's chat when they enter their dormant state.
#define DORMANT_STATE_START_MESSAGE "You feel your tumor's pulse slowing down, as it enters a dormant state. You suddenly feel incredibly weak and vulnerable to everything, and exercise has become even more difficult, as only your most vital bodily functions remain."
/// The message displayed in the hemophage's chat when they leave their dormant state.
#define DORMANT_STATE_END_MESSAGE "You feel a rush through your veins, as you can tell your tumor is pulsating at a regular pace once again. You no longer feel incredibly vulnerable, and exercise isn't as difficult anymore."
/// How high should the damage multiplier to the Hemophage be when they're in a dormant state?
#define DORMANT_DAMAGE_MULTIPLIER 3
/// By how much the blood drain will be divided when the tumor is in a dormant state.
#define DORMANT_BLOODLOSS_MULTIPLIER 10

/// Generic description for the corrupted organs that don't have one.
#define GENERIC_CORRUPTED_ORGAN_DESC "This shares the shape of a normal organ, but it's been covered and filled with some sort of midnight-black pulsing tissue, engorged with some sort of infectious mass."

/// We have a tumor, it's active.
#define PULSATING_TUMOR_ACTIVE 0
/// We have a tumor, it's dormant.
#define PULSATING_TUMOR_DORMANT 1
/// We don't have a tumor.
#define PULSATING_TUMOR_MISSING 2

/// Organ flag for organs of hemophage origin, or organs that have since been infected by an hemophage's tumor.
#define ORGAN_TUMOR_CORRUPTED (1<<12) // Not taking chances, hopefully this number remains good for a little while.

/// Just a conversion factor that ensures there's no weird floating point errors when blood is draining.
#define FLOATING_POINT_ERROR_AVOIDING_FACTOR 1000

/// The minimum ratio of reagents that need to have the `REAGENT_BLOOD_REGENERATING` chemical_flags for the Hemophage not to violently vomit upon consumption.
#define MINIMUM_BLOOD_REGENING_REAGENT_RATIO 0.75
/// How much disgust we're at after eating/drinking something the tumor doesn't like.
#define TUMOR_DISLIKED_FOOD_DISGUST DISGUST_LEVEL_GROSS + 15
/// The ratio of reagents that get purged while a Hemophage vomits from trying to eat/drink something that their tumor doesn't like.
#define HEMOPHAGE_VOMIT_PURGE_RATIO 0.95
/// The multiplier for blood received by Hemophages out of humans with ckeys.
#define BLOOD_DRAIN_MULTIPLIER_CKEY 1.5
/// The rate at which blood metabolizes in a Hemophage's stomach subtype.
#define BLOOD_METABOLIZATION_RATE (0.1 * REAGENTS_METABOLISM)

/datum/species/hemophage
	name = "Hemophage"
	id = SPECIES_HEMOPHAGE
	species_traits = list(
		EYECOLOR,
		HAIR,
		FACEHAIR,
		LIPS,
		DRINKSBLOOD,
	)
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_VIRUSIMMUNE,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
	)
	inherent_biotypes = MOB_HUMANOID | MOB_ORGANIC
	default_mutant_bodyparts = list(
		"legs" = "Normal Legs"
	)
	exotic_bloodtype = "U"
	use_skintones = TRUE
	mutantheart = /obj/item/organ/internal/heart/hemophage
	mutantliver = /obj/item/organ/internal/liver/hemophage
	mutantstomach = /obj/item/organ/internal/stomach/hemophage
	mutanttongue = /obj/item/organ/internal/tongue/hemophage
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_HUMAN
	skinned_type = /obj/item/stack/sheet/animalhide/human
	liked_food = BLOODY
	/// Current multiplier for how fast their blood drains on spec_life(). Higher values mean it goes down faster.
	var/bloodloss_speed_multiplier = 1
	/// Current multiplier for how much blood they spend healing themselves for every point of damage healed.
	var/blood_to_health_multiplier = 1
	/// The current status of our tumor. If PULSATING_TUMOR_MISSING, all tumor-corrupted organs will start to decay rapidly. If PULSATING_TUMOR_INACTIVE, no enhanced regeneration.
	var/tumor_status = PULSATING_TUMOR_MISSING

	veteran_only = TRUE


/datum/species/hemophage/check_roundstart_eligible()
	if(check_holidays(HALLOWEEN))
		return TRUE

	return ..()


/datum/species/hemophage/on_species_gain(mob/living/carbon/human/new_hemophage, datum/species/old_species)
	. = ..()
	to_chat(new_hemophage, HEMOPHAGE_SPAWN_TEXT)
	new_hemophage.update_body()
	new_hemophage.set_safe_hunger_level()


/datum/species/hemophage/spec_life(mob/living/carbon/human/hemophage, seconds_per_tick, times_fired)
	. = ..()
	if(hemophage.stat >= DEAD)
		return

	// If the tumor isn't in their body, and they've got tumor-corrupted organs, they're going to decay at a relatively swift rate.
	if(tumor_status == PULSATING_TUMOR_MISSING)
		var/static/list/tumor_reliant_organ_slots = list(ORGAN_SLOT_LIVER, ORGAN_SLOT_STOMACH)
		for(var/organ_slot in tumor_reliant_organ_slots)
			var/obj/item/organ/affected_organ = hemophage.get_organ_slot(organ_slot)
			if(!affected_organ || !(affected_organ.organ_flags & ORGAN_TUMOR_CORRUPTED))
				continue

			hemophage.adjustOrganLoss(organ_slot, TUMORLESS_ORGAN_DAMAGE * seconds_per_tick, TUMORLESS_ORGAN_DAMAGE_MAX)

		return // We don't actually want to do any healing or blood loss without a tumor, y'know.

	var/remove_status_effect = TRUE

	if(hemophage.health < hemophage.maxHealth && tumor_status == PULSATING_TUMOR_ACTIVE && hemophage.blood_volume > MINIMUM_VOLUME_FOR_REGEN && (in_closet(hemophage) || in_total_darkness(hemophage)))
		var/max_blood_for_regen = hemophage.blood_volume - MINIMUM_VOLUME_FOR_REGEN
		var/blood_used = NONE

		var/brutes_to_heal = NONE
		var/brute_damage = hemophage.getBruteLoss()

		// We have to check for the damaged bodyparts like this as well, to account for robotic bodyparts, as we don't want to heal those. Stupid, I know, but that's the best proc we got to check that currently.
		if(brute_damage && length(hemophage.get_damaged_bodyparts(brute = TRUE, burn = FALSE, required_bodytype = BODYTYPE_ORGANIC)))
			brutes_to_heal = min(max_blood_for_regen, min(BLOOD_REGEN_BRUTE_AMOUNT, brute_damage) * seconds_per_tick)
			blood_used += brutes_to_heal * blood_to_health_multiplier
			max_blood_for_regen -= brutes_to_heal * blood_to_health_multiplier

		var/burns_to_heal = NONE
		var/burn_damage = hemophage.getFireLoss()

		if(burn_damage && max_blood_for_regen > NONE && length(hemophage.get_damaged_bodyparts(brute = FALSE, burn = TRUE, required_bodytype = BODYTYPE_ORGANIC)))
			burns_to_heal = min(max_blood_for_regen, min(BLOOD_REGEN_BURN_AMOUNT, burn_damage) * seconds_per_tick)
			blood_used += burns_to_heal * blood_to_health_multiplier
			max_blood_for_regen -= burns_to_heal * blood_to_health_multiplier

		if(brutes_to_heal || burns_to_heal)
			hemophage.heal_overall_damage(brutes_to_heal, burns_to_heal, NONE, BODYTYPE_ORGANIC)

		var/toxin_damage = hemophage.getToxLoss()

		if(toxin_damage && max_blood_for_regen > NONE)
			var/toxins_to_heal = min(max_blood_for_regen, min(BLOOD_REGEN_TOXIN_AMOUNT, toxin_damage) * seconds_per_tick)
			blood_used += toxins_to_heal * blood_to_health_multiplier
			max_blood_for_regen -= toxins_to_heal * blood_to_health_multiplier
			hemophage.adjustToxLoss(-toxins_to_heal)

		var/cellular_damage = hemophage.getCloneLoss()

		if(cellular_damage && max_blood_for_regen > NONE)
			var/cells_to_heal = min(max_blood_for_regen, min(BLOOD_REGEN_TOXIN_AMOUNT, cellular_damage) * seconds_per_tick)
			blood_used += cells_to_heal * blood_to_health_multiplier
			max_blood_for_regen -= cells_to_heal * blood_to_health_multiplier
			hemophage.adjustCloneLoss(-cells_to_heal)

		if(blood_used)
			hemophage.blood_volume = max(hemophage.blood_volume - blood_used, MINIMUM_VOLUME_FOR_REGEN) // Just to clamp the value, to ensure we don't get anything weird.
			hemophage.apply_status_effect(/datum/status_effect/blood_regen_active)
			remove_status_effect = FALSE

	if(remove_status_effect)
		hemophage.remove_status_effect(/datum/status_effect/blood_regen_active)

	if(in_closet(hemophage)) // No regular bloodloss if you're in a closet
		return

	hemophage.blood_volume = (hemophage.blood_volume * FLOATING_POINT_ERROR_AVOIDING_FACTOR - NORMAL_BLOOD_DRAIN * seconds_per_tick * bloodloss_speed_multiplier * FLOATING_POINT_ERROR_AVOIDING_FACTOR) / FLOATING_POINT_ERROR_AVOIDING_FACTOR

	if(hemophage.blood_volume <= BLOOD_VOLUME_SURVIVE)
		to_chat(hemophage, span_danger("You ran out of blood!"))
		hemophage.investigate_log("starved to death from lack of blood as a hemophage.", INVESTIGATE_DEATHS)
		hemophage.death() // Owch! Ran out of blood.


/// Simple helper proc that returns whether or not the given hemophage is in a closet subtype (but not in any bodybag subtype).
/datum/species/hemophage/proc/in_closet(mob/living/carbon/human/hemophage)
	return istype(hemophage.loc, /obj/structure/closet) && !istype(hemophage.loc, /obj/structure/closet/body_bag)


/// Simple helper proc that returns whether or not the given hemophage is in total darkness.
/datum/species/hemophage/proc/in_total_darkness(mob/living/carbon/human/hemophage)
	var/turf/current_turf = get_turf(hemophage)
	if(!istype(current_turf))
		return FALSE

	return current_turf.get_lumcount() <= MINIMUM_LIGHT_THRESHOLD_FOR_REGEN


/// Simple helper to toggle the hemophage's vulnerability (or lack thereof) based on the status of their tumor. Ideally, eventually, this should all be moved into the tumor, and shouldn't be handled by the species' code at all.
/// This proc contains no check whatsoever, to avoid redundancy of null checks and such. That being said, it shouldn't be used by anything but the tumor, if you have to call it outside of that, you probably have gone wrong somewhere.
/datum/species/hemophage/proc/toggle_dormant_tumor_vulnerabilities(mob/living/carbon/human/hemophage)
	var/datum/physiology/hemophage_physiology = hemophage.physiology
	var/damage_multiplier = tumor_status == PULSATING_TUMOR_DORMANT ? DORMANT_DAMAGE_MULTIPLIER : 1 / DORMANT_DAMAGE_MULTIPLIER

	hemophage_physiology.brute_mod *= damage_multiplier
	hemophage_physiology.burn_mod *= damage_multiplier
	hemophage_physiology.tox_mod *= damage_multiplier
	hemophage_physiology.clone_mod *= damage_multiplier
	hemophage_physiology.stamina_mod *= damage_multiplier / 2 // Doing half here so that they don't instantly hit stam-crit when hit like only once.

	bloodloss_speed_multiplier *= tumor_status == PULSATING_TUMOR_DORMANT ? 1 / DORMANT_BLOODLOSS_MULTIPLIER : DORMANT_BLOODLOSS_MULTIPLIER


/datum/species/hemophage/get_species_description()
	return "Oftentimes feared or pushed out of society for the predatory nature of their condition, \
		Hemophages are typically mixed around various Frontier populations, keeping their true nature hidden while \
		reaping both the benefits and easy access to prey, enjoying unpursued existences on the Frontier."


/datum/species/hemophage/get_species_lore()
	return list(
		"Though known by many other names, 'Hemophages' are those that have found themselves the host of a bloodthirsty infection. 'Natural' hemophages have their infection first overtake their body through the bloodstream, though methods vary; \
		Hemophages thought to be a dense cluster of tightly related but distinct strains and variants. It will first take root in the chest, making alterations to the cells making up the host's organs to rapidly expand and take them over. \
		Lungs will deflate into nothingness, the liver becomes wrapped up and filled with corrupted tissue and the digestive organs will gear themselves towards the intake of the only meal they can have; blood. The host's heart will almost triple in size from this 'cancerous' tissue, forming an overgrown coal-black tumor that now keeps their body standing.",

		"The initial infection process in someone becoming a Hemophage can have varied effects and impacts, though there is a sort of timeline that crops up in the vast majority of cases. The process often begins with the steady decline of the host's heartrate into severe bradycardial agony as it begins to become choked with tumor tissue, chest pains and lightheadedness signaling the first stretch. \
		Fatigue, exercise intolerance, and near-fainting persist and worsen as the host's lungs slowly begin to atrophy; the second organ to normally be 'attacked' by the process. Coughing and hemoptysis will worsen and worsen until it suddenly stops, alongside the Hemophage's ability and need to continue breathing altogether.",

		"The ability to eat normal food becomes psychologically intolerable quickly after the infection fully takes root in their central nervous system, the tumor no longer holding interest in anything it cannot derive nutrients from. Foods once enjoyed by the host begin to taste completely revolting, many quickly developing an aversion to even try chewing it. \
		However, new desires quickly begin to form, the host's whole suite of senses rapidly adapting to a keen interest in blood. Hyperosmia in specific kicks in, the iron-tinged scent of a bleeder provoking and agitating hunger like the smell of any fresh cooking would for a human. \
		Not all blood aids the host the same. It's currently thought that a Hemophage is capable at a subconscious level of recognizing and differentiating different sources of blood, and the tumor within hijacking their psychology to prioritize blood from creatures it is able to reproduce inside of. \
		Blood from animals is reported to 'be like trying to subsist on milk or whipped cream or heavily fluffed up bread,' harder to digest, taste, or enjoy, necessitating the Hemophage to drink far more of it just to get the same value from a relatively small amount of human blood. \
		'Storebought' blood, like from refrigerated medical blood bags, is reported to 'taste thin,' like a heavily watered down drink. Only the physical, predatory act of drinking blood fresh from another humanoid is enough to properly 'sate' the tumor, ticking the right psychological and physiological boxes to be fully digested and enjoyed. \
		The sensation is like nothing else, being extremely pleasurable for the host; even if they don't want it to be.",

		"Photosensitivity of the skin develops. While light artificial or not won't harm them, it's noted that Hemophages seem to be far more comfortable in any level of darkness, their skin and eyes far more sensitive than before to UV. \
		When taken away from it, and ideally isolated from higher-than-average levels of radiation such as found in orbital habitats, it's noted that the host's body will begin to reconstruct with aid from the tumor inside. Flesh will knit back together, burns will rapidly cast off, and even scar tissue will properly regenerate into normal tissue. \
		It's thought that this process is even delicate enough to work at the host's DNA, prolonging epigenetic maintenance and ensuring biological systems remain healthy and youthful for far longer than normal. \
		Given that Hemophages are converted and kept alive by their infection, it will ruthlessly fight off foreign bacteria, viruses, and tissues, repurposing or annihilating them to ensure there's no 'competition' over its host. \
		Notably, the host's blood will turn almost black like ink due to their blood becoming more 'dense', yet no longer carrying nearly as much oxygen. Due to this hemophages are known to look more 'ashen', their lips often turning to a dark gray, and their skin going more pale than it normally would be. \
		Their tongues, not an organ the tumor spares, additionally turn a pure black; in some cases, the sclera in their eyes might even turn significantly dark especially when bloodshot.",

		"The psychology of Hemophages is well-studied in the psychiatric field. Over time, hemophages have developed a plethora of conditioned responses and quirks just as humans, their prey, have. \
		The first few years after a Hemophage is 'changed' is often enough to drive them over the edge. In some cases, the first few days. The process of being turned is a series of traumas in quick succession as the host is often made to murder. \
		The lucky have a 'moral' source of blood at hand and whoever 'converted' them to guide them through it; the unlucky have to scramble to maintain their sense of self as they become something else. \
		The physical sensation of first infection is often painful, often terrifying, and often grotesque to experience as the host feels their body shocked with vicious tumor tissue and their mind warped by near-death stretching over potentially days. \
		Some snap, some grow stone-hard, but it's rare to actually meet a Hemophage that remembers the process. Some hemophages are born into their condition; the infection staying dormant until the child is a few months to a year old, ensuring their stability in being able to handle the tumor. \
		These hosts tend to live extremely tumultuous childhoods, simply not being strong enough to feed on anything but the weakest of creatures, and trending towards immense loneliness from the high visibility of their condition's treatment during youth.",

		"The hunger is the main driver for these sordid creatures. From the very moment they wake back up from the process of being 'changed,' a powerful hunger is awakened. It twists and throbs in their heart, drowning out coherent thought. \
		During the 'semi-starvation' phase in humans, the changes are dramatic. Significant decreases in strength and stamina, body temperature, heart rate, and obsession with food. Dreaming and fantasizing about it, reading and talking about it, and savoring what little meals they can get access to; hoarding it for themselves and eating to the last crumb. \
		In Hemophages, this response is heavily similar, but turned outwards. The hunger of a Hemophage is psychologically pressing in nearly every way, detracting from all other concerns in an urge to be dealt with as soon as it can be. \
		Panic easily sets in during these times of famine, the host instinctually knowing that it must be sated or the tumor within them will soon run out of blood to feed on, which would result in their mutual death. \
		Even the very sight and smell of fresh blood can push a Hemophage into this kind of state if they haven't fed in awhile, only drinking from a living creature or intense meditation and concentration being able to push it down.",

		"Socially, Hemophages are mostly solitary hunters. It is extremely easy for them to recognize each other; the unique smell of their blackened ichor, the subtle details of their body and the way it moves, the shallow or nonexistant breathing, or even the likely smell of multiple victims' blood on their breath. \
		Even normal humans report talking to known Hemophages being psychologically unsettling, linked to being armed with the knowledge that they've likely taken several lives and might take theirs. \
		This predatory aura surrounding them tends to leave them operating primarily solitarily; always passively running threat analysis on others of their kind, especially given the higher 'value' of their more nutrient-rich blood. \
		When they do choose to work together, Hemophages gather in groups of no more than ten. Any more, and their activities would surely be impossible to disguise.",

		"'Conversion' tends to be uncommon for Hemophages. The typical line of thought is that one 'wouldn't want to raise a kid every time they go out for dinner,' as the 'creation' of a new Hemophage involves, essentially, becoming an on-site therapist and mentor for an unspecified amount of time. \
		It's often not worth the risk to potentially allow a fresh 'convert' to gain access to a Hemophage's identity if they're attempting to 'blend', and to potentially turn on them and expose their illegal activities. \
		However the infection which creates them, like any living creature, has a drive to procreate regardless; often the urge to spread it overtakes a hemophage's sensibilities anyway, and some are known to serially infect others simply to 'stir the pot.",

		"In terms of human society, it's known for Hemophages to be passively strangled by the law itself. In 'civilized' places like Sol, Hemophages that attack or kill humans for their blood are prosecuted heavily; almost disproportionately compared to if the same crimes were committed by a normal person. \
		Artificial sources of blood are intentionally kept rare by pharmaceutical companies, and those that do end up getting an easier access to such sources seem to almost always be working in the Medical field. \
		Even adopting pets is made nigh-on-impossible for them. Those that don't leave to places like frontier systems typically end up part of oft-ephemeral networks of others of their kind, offering time-sensitive advice on where certain 'low-risk' or 'less-than-legal' meals may be found and forcing themselves to work past their base instincts to cooperate to an extent; anything else would mean death."
	)


/datum/species/hemophage/prepare_human_for_preview(mob/living/carbon/human/human)
	human.skin_tone = "albino"
	human.hair_color = "#1d1d1d"
	human.hairstyle = "Pompadour (Big)"
	regenerate_organs(human, src, visual_only = TRUE)
	human.update_body(TRUE)


/datum/species/hemophage/create_pref_unique_perks()
	var/list/to_add = list()

	to_add += list(
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "moon",
			SPECIES_PERK_NAME = "Darkness Affinity",
			SPECIES_PERK_DESC = "A Hemophage is only at home in the darkness, the infection \
								within a Hemophage seeking to return them to a healthy state \
								whenever it can be in the shadow. However, light artificial or \
								otherwise irritates their bodies and the cancer keeping them alive, \
								not harming them but keeping them from regenerating. Modern \
								Hemophages have been known to use lockers as a convenient \
								source of darkness, while the extra protection they provide \
								against background radiations allows their tumor to avoid \
								having to expend any blood to maintain minimal bodily functions \
								so long as their host remains stationary in said locker.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_POSITIVE_PERK,
			SPECIES_PERK_ICON = "biohazard",
			SPECIES_PERK_NAME = "Viral Symbiosis",
			SPECIES_PERK_DESC = "Hemophages, due to their condition, cannot get infected by \
								other viruses and don't actually require an external source of oxygen \
								to stay alive.",
		),
		list(
			SPECIES_PERK_TYPE = SPECIES_NEGATIVE_PERK,
			SPECIES_PERK_ICON = "tint",
			SPECIES_PERK_NAME = "The Thirst",
			SPECIES_PERK_DESC = "In place of eating, Hemophages suffer from the Thirst, caused by their tumor. \
								Thirst of what? Blood! Their tongue allows them to grab people and drink \
								their blood, and they will suffer severe consequences if they run out. As a note, \
								it doesn't matter whose blood you drink, it will all be converted into your blood \
								type when consumed. That being said, the blood of other sentient humanoids seems \
								to quench their Thirst for longer than otherwise-acquired blood would.",
		),
	)

	return to_add


/datum/species/hemophage/create_pref_blood_perks()
	var/list/to_add = list()

	to_add += list(list(
		SPECIES_PERK_TYPE = SPECIES_NEUTRAL_PERK,
		SPECIES_PERK_ICON = "tint",
		SPECIES_PERK_NAME = "Universal Blood",
		SPECIES_PERK_DESC = "[plural_form] have blood that appears to be an amalgamation of all other \
							blood types, made possible thanks to some special antigens produced by \
							their tumor, making them able to receive blood of any other type, so \
							long as it is still human-like blood.",
		),
	)

	return to_add


// We don't need to mention that they're undead, as the perks that come from it are otherwise already explicited, and they might no longer be actually undead from a gameplay perspective, eventually.
/datum/species/hemophage/create_pref_biotypes_perks()
	return


/obj/item/organ/internal/heart/hemophage
	name = "pulsating tumor"
	icon = 'modular_skyrat/modules/organs/icons/hemophage_organs.dmi'
	icon_state = "tumor-on"
	base_icon_state = "tumor"
	desc = "This pulsating organ nearly resembles a normal heart, but it's been twisted beyond any human appearance, having turned to the color of coal. The way it barely fits where the original organ was sends shivers down your spine... <i>The fact that it's what keeps them alive makes it all the more terrifying.</i>"
	actions_types = list(/datum/action/cooldown/hemophage/toggle_dormant_state)
	/// Are we currently dormant? Defaults to PULSATING_TUMOR_ACTIVE (so FALSE).
	var/is_dormant = PULSATING_TUMOR_ACTIVE


/obj/item/organ/internal/heart/hemophage/Insert(mob/living/carbon/reciever, special, drop_if_replaced)
	. = ..()
	if(!ishemophage(reciever))
		return

	var/mob/living/carbon/human/tumorful_hemophage = reciever
	var/datum/species/hemophage/tumorful_species = tumorful_hemophage.dna.species

	tumorful_species.tumor_status = is_dormant

	// We make sure to account for dormant tumor vulnerabilities, so that we don't achieve states that shouldn't be possible.
	if(is_dormant)
		tumorful_species.toggle_dormant_tumor_vulnerabilities(tumorful_hemophage)
		tumorful_hemophage.add_movespeed_modifier(/datum/movespeed_modifier/hemophage_dormant_state)


/obj/item/organ/internal/heart/hemophage/Remove(mob/living/carbon/tumorless, special = FALSE)
	. = ..()
	if(!ishemophage(tumorless))
		return

	var/mob/living/carbon/human/tumorless_hemophage = tumorless
	var/datum/species/hemophage/tumorless_species = tumorless_hemophage.dna.species

	tumorless_species.tumor_status = PULSATING_TUMOR_MISSING

	// We make sure to account for dormant tumor vulnerabilities, so that we don't achieve states that shouldn't be possible.
	if(is_dormant)
		tumorless_species.toggle_dormant_tumor_vulnerabilities(tumorless_hemophage)
		tumorless_hemophage.remove_movespeed_modifier(/datum/movespeed_modifier/hemophage_dormant_state)


/// Simple helper proc that toggles the dormant state of the tumor, which also switches its appearance to reflect said change.
/obj/item/organ/internal/heart/hemophage/proc/toggle_dormant_state()
	is_dormant = !is_dormant
	base_icon_state = is_dormant ? "[base_icon_state]-dormant" : initial(base_icon_state)
	update_appearance()


/obj/item/organ/internal/liver/hemophage
	name = "corrupted liver"
	desc = GENERIC_CORRUPTED_ORGAN_DESC
	icon = 'modular_skyrat/modules/organs/icons/hemophage_organs.dmi'
	organ_flags = ORGAN_EDIBLE | ORGAN_TUMOR_CORRUPTED


/obj/item/organ/internal/liver/hemophage/Insert(mob/living/carbon/reciever, special, drop_if_replaced)
	. = ..()

	RegisterSignal(reciever, COMSIG_GLASS_DRANK, PROC_REF(handle_drink))


/obj/item/organ/internal/liver/hemophage/Remove(mob/living/carbon/organ_owner, special)
	. = ..()

	UnregisterSignal(organ_owner, COMSIG_GLASS_DRANK)


/**
 * Handles reacting to drinks based on their content, to see if the tumor likes what's in it or not.
 */
/obj/item/organ/internal/liver/hemophage/proc/handle_drink(mob/living/target_mob, obj/item/reagent_containers/cup/container, mob/living/user)
	SIGNAL_HANDLER

	if(HAS_TRAIT(owner, TRAIT_AGEUSIA)) // They don't taste anything, their body shouldn't react strongly to the taste of that stuff.
		return

	if(container.reagents.has_chemical_flag_skyrat(REAGENT_BLOOD_REGENERATING, container.reagents.total_volume * MINIMUM_BLOOD_REGENING_REAGENT_RATIO)) // At least 75% of the content of the cup needs to be something that's counting as blood-regenerating for the tumor not to freak out.
		return

	var/mob/living/carbon/body = owner
	ASSERT(istype(body))

	owner.set_disgust(max(owner.disgust, TUMOR_DISLIKED_FOOD_DISGUST))

	to_chat(owner, span_warning("That tasted awful..."))

	// We don't lose nutrition because we don't even use nutrition as Hemopahges. It WILL however purge nearly all of what's in their stomach.
	body.vomit(lost_nutrition = 0, stun = FALSE, distance = 1, force = TRUE, purge_ratio = HEMOPHAGE_VOMIT_PURGE_RATIO)


/obj/item/organ/internal/stomach/hemophage
	name = "corrupted stomach"
	desc = GENERIC_CORRUPTED_ORGAN_DESC
	icon = 'modular_skyrat/modules/organs/icons/hemophage_organs.dmi'
	organ_flags = ORGAN_EDIBLE | ORGAN_TUMOR_CORRUPTED


/obj/item/organ/internal/stomach/hemophage/after_eat(atom/edible)
	if(!istype(edible, /obj/item/food))
		return

	var/obj/item/food/eaten = edible

	if(BLOODY & eaten.foodtypes) // They're good if it's BLOODY food, they're less good if it isn't.
		return

	if(HAS_TRAIT(owner, TRAIT_AGEUSIA)) // They don't taste anything, their body shouldn't react strongly to the taste of that stuff.
		return

	var/mob/living/carbon/body = owner
	ASSERT(istype(body))

	owner.set_disgust(max(owner.disgust, TUMOR_DISLIKED_FOOD_DISGUST))

	to_chat(owner, span_warning("That tasted awful..."))

	// We don't lose nutrition because we don't even use nutrition as hemopahges. It WILL however purge nearly all of what's in their stomach.
	body.vomit(lost_nutrition = 0, stun = FALSE, distance = 1, force = TRUE, purge_ratio = HEMOPHAGE_VOMIT_PURGE_RATIO)
	return ..()

/obj/item/organ/internal/stomach/hemophage/on_life(seconds_per_tick, times_fired)
	var/datum/reagent/blood/blood = reagents.get_reagent(/datum/reagent/blood)
	if(blood)
		blood.metabolization_rate = BLOOD_METABOLIZATION_RATE
	..()

/obj/item/organ/internal/tongue/hemophage
	name = "corrupted tongue"
	desc = GENERIC_CORRUPTED_ORGAN_DESC
	icon = 'modular_skyrat/modules/organs/icons/hemophage_organs.dmi'
	organ_flags = ORGAN_EDIBLE | ORGAN_TUMOR_CORRUPTED
	actions_types = list(/datum/action/cooldown/hemophage/drain_victim)


/datum/action/cooldown/hemophage
	cooldown_time = 3 SECONDS
	button_icon_state = null


/datum/action/cooldown/hemophage/New(Target)
	. = ..()

	if(target && isnull(button_icon_state))
		AddComponent(/datum/component/action_item_overlay, target)


/datum/action/cooldown/hemophage/drain_victim
	name = "Drain Victim"
	desc = "Leech blood from any carbon victim you are passively grabbing."


/datum/action/cooldown/hemophage/drain_victim/Activate(atom/target)
	if(!iscarbon(owner))
		return

	var/mob/living/carbon/hemophage = owner

	if(!hemophage.pulling || !iscarbon(hemophage.pulling) || isalien(hemophage.pulling))
		hemophage.balloon_alert(hemophage, "not pulling any valid target!")
		return

	var/mob/living/carbon/victim = hemophage.pulling
	if(hemophage.blood_volume >= BLOOD_VOLUME_MAXIMUM)
		hemophage.balloon_alert(hemophage, "already full!")
		return

	if(victim.stat == DEAD)
		hemophage.balloon_alert(hemophage, "needs a living victim!")
		return

	if(!victim.blood_volume || (victim.dna && ((HAS_TRAIT(victim, TRAIT_NOBLOOD)) || victim.dna.species.exotic_blood)))
		hemophage.balloon_alert(hemophage, "[victim] doesn't have blood!")
		return


	var/blood_volume_difference = BLOOD_VOLUME_MAXIMUM - hemophage.blood_volume //How much capacity we have left to absorb blood
	// We start by checking that the victim is a human and they have a client, so we can give them the
	// beneficial status effect for drinking higher-quality blood.
	var/is_target_human_with_client = istype(victim, /mob/living/carbon/human) && victim.client

	if(ismonkey(victim))
		if(hemophage.blood_volume >= BLOOD_VOLUME_NORMAL)
			hemophage.balloon_alert(hemophage, "their inferior blood cannot sate you any further!")
			return

		is_target_human_with_client = FALSE // Sorry, not going to get the status effect from monkeys, even if they have a client in them.

		blood_volume_difference = BLOOD_VOLUME_NORMAL - hemophage.blood_volume

	StartCooldown()

	if(victim.can_block_magic(MAGIC_RESISTANCE_HOLY, charge_cost = 0))
		victim.show_message(span_warning("[hemophage] tries to bite you, but stops before touching you!"))
		to_chat(hemophage, span_warning("[victim] is blessed! You stop just in time to avoid catching fire."))
		return

	if(victim.has_reagent(/datum/reagent/consumable/garlic))
		victim.show_message(span_warning("[hemophage] tries to bite you, but recoils in disgust!"))
		to_chat(hemophage, span_warning("[victim] reeks of garlic! You can't bring yourself to drain such tainted blood."))
		return

	if(!do_after(hemophage, 3 SECONDS, target = victim))
		hemophage.balloon_alert(hemophage, "stopped feeding")
		return

	var/drained_blood = min(victim.blood_volume, HEMOPHAGE_DRAIN_AMOUNT, blood_volume_difference)
	// if you drained from a human w/ a client, congrats
	var/drained_multiplier = (is_target_human_with_client ? BLOOD_DRAIN_MULTIPLIER_CKEY : 1)

	victim.blood_volume = clamp(victim.blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
	hemophage.blood_volume = clamp(hemophage.blood_volume + (drained_blood * drained_multiplier), 0, BLOOD_VOLUME_MAXIMUM)

	log_combat(hemophage, victim, "drained [drained_blood]u of blood from", addition = " (NEW BLOOD VOLUME: [victim.blood_volume] cL)")
	victim.show_message(span_danger("[hemophage] drains some of your blood!"))
	to_chat(hemophage, span_notice("You drink some blood from [victim]![is_target_human_with_client ? " That tasted particularly good!" : ""]"))

	playsound(hemophage, 'sound/items/drink.ogg', 30, TRUE, -2)

	if(victim.blood_volume <= BLOOD_VOLUME_OKAY)
		to_chat(hemophage, span_warning("That definitely left them looking pale..."))

	if(is_target_human_with_client)
		hemophage.apply_status_effect(/datum/status_effect/blood_thirst_satiated)

	if(!victim.blood_volume || victim.blood_volume < BLOOD_VOLUME_SURVIVE)
		to_chat(hemophage, span_warning("You finish off [victim]'s blood supply."))


/datum/action/cooldown/hemophage/toggle_dormant_state
	name = "Enter Dormant State"
	desc = "Causes the tumor inside of you to enter a dormant state, causing it to need just a minimum amount of blood to survive. However, as the tumor living in your body is the only thing keeping you still alive, rendering it latent cuts both it and you to just the essential functions to keep standing. It will no longer mend your body even in the darkness, and the lack of blood pumping through you will have you the weakest you've ever felt; and leave you hardly able to run. It is not on a switch, and it will take some time for it to awaken."
	cooldown_time = 3 MINUTES


/datum/action/cooldown/hemophage/toggle_dormant_state/Activate(atom/action_target)
	if(!owner || !ishemophage(owner) || !target) // Sorry, but blood drain and the likes are only usable by Hemophages.
		return

	var/obj/item/organ/internal/heart/hemophage/tumor = target
	if(!tumor || !istype(tumor)) // This shouldn't happen, but you can never be too careful.
		return

	owner.balloon_alert(owner, "[tumor.is_dormant ? "leaving" : "entering"] dormant state")

	if(!do_after(owner, 3 SECONDS))
		owner.balloon_alert(owner, "cancelled state change")
		return

	to_chat(owner, span_notice("[tumor.is_dormant ? DORMANT_STATE_END_MESSAGE : DORMANT_STATE_START_MESSAGE]"))

	var/mob/living/carbon/human/hemophage = owner
	var/datum/species/hemophage/hemophage_species = hemophage.dna.species

	tumor.toggle_dormant_state()

	StartCooldown()

	hemophage_species.tumor_status = tumor.is_dormant
	hemophage_species.toggle_dormant_tumor_vulnerabilities(hemophage)

	if(tumor.is_dormant)
		name = "Exit Dormant State"
		desc =  "Causes the pitch-black mass living inside of you to awaken, allowing your circulation to return and blood to pump freely once again. It fills your legs to let you run again, and longs for the darkness as it did before. You start to feel strength rather than the weakness you felt before. However, the tumor giving you life is not on a switch, and it will take some time to subdue it again."
		hemophage.add_movespeed_modifier(/datum/movespeed_modifier/hemophage_dormant_state)
	else
		name = initial(name)
		desc = initial(desc)
		hemophage.remove_movespeed_modifier(/datum/movespeed_modifier/hemophage_dormant_state)


// We need to override it here because we changed their vampire heart with an Hemophage heart
/mob/living/carbon/get_status_tab_items()
	. = ..()
	var/obj/item/organ/internal/heart/hemophage/tumor_heart = get_organ_by_type(/obj/item/organ/internal/heart/hemophage)
	if(tumor_heart)
		. += "Current blood level: [blood_volume]/[BLOOD_VOLUME_MAXIMUM]"

	return .


/datum/status_effect/blood_thirst_satiated
	id = "blood_thirst_satiated"
	duration = 30 MINUTES
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/blood_thirst_satiated
	/// What will the bloodloss_speed_multiplier of the Hemophage be changed by upon receiving this status effect?
	var/bloodloss_speed_multiplier = 0.5


/datum/status_effect/blood_thirst_satiated/on_apply()
	// This status effect should not exist on its own, or on a non-human.
	if(!owner || !ishuman(owner))
		return FALSE

	var/mob/living/carbon/human/human_owner = owner

	// This only ever applies to Hemophages, shoo if you're not an Hemophage!
	if(!ishemophage(human_owner))
		return FALSE

	var/datum/species/hemophage/owner_species = human_owner.dna.species
	owner_species.bloodloss_speed_multiplier *= bloodloss_speed_multiplier

	return TRUE


/datum/status_effect/blood_thirst_satiated/on_remove()
	// This status effect should not exist on its own, or on a non-human.
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/human_owner = owner

	// This only ever applies to Hemophages, shoo if you're not an Hemophage!
	if(!ishemophage(human_owner))
		return

	var/datum/species/hemophage/owner_species = human_owner.dna.species
	owner_species.bloodloss_speed_multiplier /= bloodloss_speed_multiplier


/datum/status_effect/blood_regen_active
	id = "blood_regen_active"
	status_type = STATUS_EFFECT_UNIQUE
	alert_type = /atom/movable/screen/alert/status_effect/blood_regen_active


/datum/status_effect/blood_regen_active/on_apply()
	// This status effect should not exist on its own, or on a non-human.
	if(!owner || !ishuman(owner))
		return FALSE

	to_chat(owner, span_notice("You feel the tumor inside you pulse faster as the absence of light eases its work, allowing it to knit your flesh and reconstruct your body."))

	return TRUE


// This code also had to be copied over from /datum/action/item_action to ensure that we could display the heart in the alert.
/datum/status_effect/blood_regen_active/on_creation(mob/living/new_owner, ...)
	. = ..()
	if(!.)
		return

	if(!linked_alert)
		return

	var/obj/item/organ/internal/heart/hemophage/tumor_heart = owner.get_organ_by_type(/obj/item/organ/internal/heart/hemophage)
	if(tumor_heart)
		var/old_layer = tumor_heart.layer
		var/old_plane = tumor_heart.plane
		// reset the x & y offset so that item is aligned center
		tumor_heart.pixel_x = 0
		tumor_heart.pixel_y = 0
		tumor_heart.layer = FLOAT_LAYER // They need to be displayed on the proper layer and plane to show up on the button. We elevate them temporarily just to steal their appearance, and then revert it.
		tumor_heart.plane = FLOAT_PLANE
		linked_alert.cut_overlays()
		linked_alert.add_overlay(tumor_heart)
		tumor_heart.layer = old_layer
		tumor_heart.plane = old_plane

	return .


/datum/status_effect/blood_regen_active/on_remove()
	// This status effect should not exist on its own.
	if(!owner)
		return

	to_chat(owner, span_notice("You feel the pulse of the tumor in your chest returning back to normal."))


/datum/movespeed_modifier/hemophage_dormant_state
	id = "hemophage_dormant_state"
	multiplicative_slowdown = 3 // Yeah, they'll be quite significantly slower when in their dormant state.
	blacklisted_movetypes = FLOATING


/atom/movable/screen/alert/status_effect/blood_thirst_satiated
	name = "Thirst Satiated"
	desc = "Substitutes and taste-thin imitations keep your pale body standing, but nothing abates eternal thirst and slakes the infection quite like the real thing: Hot blood from a real sentient being."
	icon = 'icons/effects/bleed.dmi'
	icon_state = "bleed10"


/atom/movable/screen/alert/status_effect/blood_regen_active
	name = "Enhanced Regeneration"
	desc = "Being in a sufficiently dark location allows your tumor to allocate more energy to enhancing your body's natural regeneration, at the cost of blood volume proportional to the damage healed."
	icon = 'icons/hud/screen_alert.dmi'
	icon_state = "template"


#undef HEMOPHAGE_DRAIN_AMOUNT
#undef NORMAL_BLOOD_DRAIN
#undef MINIMUM_VOLUME_FOR_REGEN
#undef MINIMUM_LIGHT_THRESHOLD_FOR_REGEN
#undef TUMORLESS_ORGAN_DAMAGE
#undef TUMORLESS_ORGAN_DAMAGE_MAX

#undef HEMOPHAGE_SPAWN_TEXT

#undef BLOOD_REGEN_BRUTE_AMOUNT
#undef BLOOD_REGEN_BURN_AMOUNT
#undef BLOOD_REGEN_TOXIN_AMOUNT
#undef BLOOD_REGEN_CELLULAR_AMOUNT

#undef DORMANT_STATE_START_MESSAGE
#undef DORMANT_STATE_END_MESSAGE
#undef DORMANT_DAMAGE_MULTIPLIER
#undef DORMANT_BLOODLOSS_MULTIPLIER

#undef GENERIC_CORRUPTED_ORGAN_DESC

#undef PULSATING_TUMOR_ACTIVE
#undef PULSATING_TUMOR_DORMANT
#undef PULSATING_TUMOR_MISSING

#undef ORGAN_TUMOR_CORRUPTED

#undef FLOATING_POINT_ERROR_AVOIDING_FACTOR

#undef HEMOPHAGE_VOMIT_PURGE_RATIO
#undef TUMOR_DISLIKED_FOOD_DISGUST
#undef MINIMUM_BLOOD_REGENING_REAGENT_RATIO

#undef BLOOD_DRAIN_MULTIPLIER_CKEY
#undef BLOOD_METABOLIZATION_RATE
