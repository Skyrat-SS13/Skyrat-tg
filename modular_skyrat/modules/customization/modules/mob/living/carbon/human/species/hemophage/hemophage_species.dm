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

/// Just a conversion factor that ensures there's no weird floating point errors when blood is draining.
#define FLOATING_POINT_ERROR_AVOIDING_FACTOR 1000

/// How high should the damage multiplier to the Hemophage be when they're in a dormant state?
#define DORMANT_DAMAGE_MULTIPLIER 3
/// By how much the blood drain will be divided when the tumor is in a dormant state.
#define DORMANT_BLOODLOSS_MULTIPLIER 10
/// How much blood do Hemophages normally lose per second (visible effect is every two seconds, so twice this value).
#define NORMAL_BLOOD_DRAIN 0.125


/datum/species/hemophage
	name = "Hemophage"
	id = SPECIES_HEMOPHAGE
	inherent_traits = list(
		TRAIT_ADVANCEDTOOLUSER,
		TRAIT_CAN_STRIP,
		TRAIT_NOHUNGER,
		TRAIT_NOBREATH,
		TRAIT_OXYIMMUNE,
		TRAIT_VIRUSIMMUNE,
		TRAIT_CAN_USE_FLIGHT_POTION,
		TRAIT_LITERATE,
		TRAIT_DRINKS_BLOOD,
		TRAIT_USES_SKINTONES,
	)
	inherent_biotypes = MOB_HUMANOID | MOB_ORGANIC
	default_mutant_bodyparts = list(
		"legs" = "Normal Legs"
	)
	exotic_bloodtype = "U"
	mutantheart = /obj/item/organ/internal/heart/hemophage
	mutantliver = /obj/item/organ/internal/liver/hemophage
	mutantstomach = /obj/item/organ/internal/stomach/hemophage
	mutanttongue = /obj/item/organ/internal/tongue/hemophage
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_HUMAN
	skinned_type = /obj/item/stack/sheet/animalhide/human
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


/datum/species/hemophage/on_species_gain(mob/living/carbon/human/new_hemophage, datum/species/old_species, pref_load)
	. = ..()
	to_chat(new_hemophage, HEMOPHAGE_SPAWN_TEXT)
	new_hemophage.update_body()
	new_hemophage.set_safe_hunger_level()

	if(istype(old_species, /datum/species/hemophage) && tumor_status == PULSATING_TUMOR_MISSING)
		var/datum/species/hemophage/old_hemo_species = old_species
		tumor_status = old_hemo_species.tumor_status


/datum/species/hemophage/on_species_loss(mob/living/carbon/human/former_hemophage, datum/species/new_species, pref_load)
	. = ..()

	// if we are still a hemophage for whatever reason then we don't want to do any of this (this can happen with the Pride Mirror)
	if(ishemophage(former_hemophage))
		return

	var/obj/item/organ/internal/heart/hemophage/tumor = former_hemophage.get_organ_by_type(/obj/item/organ/internal/heart/hemophage)

	// make sure we clear dormant status when changing species
	if(tumor?.is_dormant)
		tumor.toggle_dormant_state()
		tumor_status = tumor.is_dormant
		toggle_dormant_tumor_vulnerabilities(former_hemophage)
		former_hemophage.remove_movespeed_modifier(/datum/movespeed_modifier/hemophage_dormant_state)


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

#undef FLOATING_POINT_ERROR_AVOIDING_FACTOR

#undef DORMANT_DAMAGE_MULTIPLIER
#undef DORMANT_BLOODLOSS_MULTIPLIER
