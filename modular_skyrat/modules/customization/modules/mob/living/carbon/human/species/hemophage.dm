/datum/species/hemophage
	name = "Hemophage"
	id = SPECIES_HEMOPHAGE
	species_traits = list(
		EYECOLOR,
		HAIR,
		FACEHAIR,
		LIPS,
		DRINKSBLOOD,
		HAS_FLESH,
		HAS_BONE,
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
	inherent_biotypes = MOB_UNDEAD | MOB_HUMANOID
	mutant_bodyparts = list("wings" = "None")
	exotic_bloodtype = "U"
	use_skintones = TRUE
	mutantheart = /obj/item/organ/internal/heart/hemophage
	mutanttongue = /obj/item/organ/internal/tongue/hemophage
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_HUMAN
	skinned_type = /obj/item/stack/sheet/animalhide/human
	/// Some starter text sent to the hemophage initially, because hemophages have shit to do to stay alive.
	var/info_text = "You are a <span class='danger'>Hemophage</span>. You will slowly but constantly lose blood if outside of a closet-like object. If inside a closet-like object, you will slowly heal. You may gain more blood by grabbing a live victim and using your drain ability."
	/// The shapeshifting action, attached to the datum itself to avoid cloning memes, and other duplicates.
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/batform
	/// Is it currently Halloween and are we the Halloween version? If not, we do not get a batform nor do we burn in the chapel.
	var/halloween_version = FALSE
	/// Current multiplier for how fast their blood drains on spec_life(). Higher values mean it goes down faster.
	var/bloodloss_speed_multiplier = 1
	veteran_only = TRUE


/datum/species/hemophage/check_roundstart_eligible()
	if(SSevents.holidays && SSevents.holidays[HALLOWEEN])
		return TRUE

	return ..()


/datum/species/hemophage/on_species_gain(mob/living/carbon/human/new_hemophage, datum/species/old_species)
	. = ..()
	to_chat(new_hemophage, "[info_text]")
	new_hemophage.update_body(0)
	new_hemophage.set_safe_hunger_level()
	if(SSevents.holidays && SSevents.holidays[HALLOWEEN])
		halloween_version = TRUE


/datum/species/hemophage/spec_life(mob/living/carbon/human/hemophage, delta_time, times_fired)
	. = ..()
	if(hemophage.stat == DEAD)
		return

	if(istype(hemophage.loc, /obj/structure/closet) && !istype(hemophage.loc, /obj/structure/closet/body_bag))
		hemophage.heal_overall_damage(1.5 * delta_time, 1.5 * delta_time, 0, BODYTYPE_ORGANIC) // Fast, but not as fast due to them being able to use normal lockers.
		hemophage.adjustToxLoss(-1 * delta_time) // 50% base speed to keep it fair.
		hemophage.adjustOxyLoss(-2 * delta_time)
		hemophage.adjustCloneLoss(-0.5 * delta_time) // HARDMODE DAMAGE
		return

	hemophage.blood_volume -= 0.125 * delta_time * bloodloss_speed_multiplier

	if(hemophage.blood_volume <= BLOOD_VOLUME_SURVIVE)
		to_chat(hemophage, span_danger("You ran out of blood!"))
		hemophage.death() // Owch! Ran out of blood.

	if(halloween_version)// If hemophages have bat form, they cannot enter the church
		var/area/current_area = get_area(hemophage)
		if(istype(current_area, /area/station/service/chapel))
			to_chat(hemophage, span_warning("You don't belong here!"))
			hemophage.adjustFireLoss(10 * delta_time)
			hemophage.adjust_fire_stacks(3 * delta_time)
			hemophage.ignite_mob()


/datum/species/hemophage/get_species_description()
	return "Oftentimes feared for the different bits of folklore surrounding their condition, \
		Hemophages are typically mixed amongst the crew, hiding away their blood-deficiency and \
		the benefits that come from it from most, to enjoy a nearly-normal existence on the Frontier."


/datum/species/hemophage/get_species_lore()
	return list("Though known by many other names, 'Hemophages' are those that have found themselves the host of a bloodthirsty infection. Initially entering their hosts through the bloodstream, or activating after a period of dormancy in infants, this infection initially travels to the chest first. Afterwards, it infects several cells, making countless alterations to their genetic sequence, until it starts rapidly expanding and taking over every nearby organ, notably the heart, lungs, and stomach, forming a massive tumor vaguely reminiscent of an overgrown, coal-black heart, that hijacks them for its own benefit, and in exchange, allows the host to 'sense' the quality, and amount of blood currently occupying their body.",
    "While this kills the host initially, the tumor will jumpstart the body and begin functioning as a surrogate to keep their host going. This does confer certain advantages to the host, in the interest of keeping them alive; working anaerobically, requiring no food to function, and extending their lifespan dramatically. However, this comes at a cost, as the tumor changes their host into an obligate hemophage; only the enzymes, and iron in blood being able to fuel them. If they are to run out of blood, the tumor will begin consuming its own host.",
    "Historically, Hemophages have caused great societal strife through their very existence. Many have reported dread on having someone reveal they require blood to survive, worse on learning they have been undead, espiecally in 'superstitious' communities. In many places they occupy a sort of second class, unable to live normal lives due to their condition being a sort of skeleton in their closet. Some can actually be found in slaughterhouses or the agricultural industry, gaining easy access to a large supply of animal blood to feed their eternal thirst.",
    "Others find their way into mostly-vampiric communities, turning others into their own kind; though, the virus can only transmit to hosts that are incredibly low on blood, taking advantage of their reduced immune system efficiency and higher rate of blood creation to be able to survive the initial few days within their host.",
    "\"What the fuck does any of this mean?\" - Doctor Micheals, reading their CentCom report about the new 'hires'.")


/datum/species/hemophage/prepare_human_for_preview(mob/living/carbon/human/human)
	human.skin_tone = "albino"
	human.hair_color = "#1d1d1d"
	human.hairstyle = "Pompadour (Big)"
	human.update_mutant_bodyparts(TRUE)
	human.update_body(TRUE)


/obj/item/organ/internal/tongue/hemophage
	name = "hemophage tongue"
	color = "#333333"
	actions_types = list(/datum/action/item_action/organ_action/hemophage)
	COOLDOWN_DECLARE(drain_cooldown)


/datum/action/item_action/organ_action/hemophage
	name = "Drain Victim"
	desc = "Leech blood from any carbon victim you are passively grabbing."

/// Maximum an Hemophage will drain, they will drain less if they hit their cap.
#define HEMOPHAGE_DRAIN_AMOUNT 50


/datum/action/item_action/organ_action/hemophage/Trigger(trigger_flags)
	. = ..()
	if(iscarbon(owner))
		var/mob/living/carbon/hemophage = owner
		var/obj/item/organ/internal/tongue/hemophage/tongue = target

		if(!COOLDOWN_FINISHED(tongue, drain_cooldown))
			to_chat(hemophage, span_warning("You just drained blood, wait a few seconds!"))
			return

		if(hemophage.pulling && iscarbon(hemophage.pulling))
			var/mob/living/carbon/victim = hemophage.pulling
			if(hemophage.blood_volume >= BLOOD_VOLUME_MAXIMUM)
				to_chat(hemophage, span_warning("You're already full!"))
				return

			if(victim.stat == DEAD)
				to_chat(hemophage, span_warning("You need a living victim!"))
				return

			if(!victim.blood_volume || (victim.dna && ((NOBLOOD in victim.dna.species.species_traits) || victim.dna.species.exotic_blood)))
				to_chat(hemophage, span_warning("[victim] doesn't have blood!"))
				return


			var/blood_volume_difference = BLOOD_VOLUME_MAXIMUM - hemophage.blood_volume //How much capacity we have left to absorb blood
			// We start by checking that the victim is a human and they have a client, so we can give them the
			// beneficial status effect for drinking higher-quality blood.
			var/is_target_human_with_client = istype(victim, /mob/living/carbon/human) && victim.client

			if(ismonkey(victim))
				if(hemophage.blood_volume >= BLOOD_VOLUME_NORMAL)
					to_chat(hemophage, span_warning("Their inferior blood cannot sate you any further!"))
					return

				is_target_human_with_client = FALSE // Sorry, not going to get the status effect from monkeys, even if they have a client in them.

				blood_volume_difference = BLOOD_VOLUME_NORMAL - hemophage.blood_volume


			COOLDOWN_START(tongue, drain_cooldown, 3 SECONDS)
			if(victim.can_block_magic(MAGIC_RESISTANCE_HOLY, charge_cost = 0))
				victim.show_message(span_warning("[hemophage] tries to bite you, but stops before touching you!"))
				to_chat(hemophage, span_warning("[victim] is blessed! You stop just in time to avoid catching fire."))
				return

			if(victim.has_reagent(/datum/reagent/consumable/garlic))
				victim.show_message(span_warning("[hemophage] tries to bite you, but recoils in disgust!"))
				to_chat(hemophage, span_warning("[victim] reeks of garlic! you can't bring yourself to drain such tainted blood."))
				return

			if(!do_after(hemophage, 3 SECONDS, target = victim))
				return

			var/drained_blood = min(victim.blood_volume, HEMOPHAGE_DRAIN_AMOUNT, blood_volume_difference)

			victim.show_message(span_danger("[hemophage] drains some of your blood!"))
			to_chat(hemophage, span_notice("You drink some blood from [victim]![is_target_human_with_client ? " That tasted particularly good!" : ""]"))
			playsound(hemophage, 'sound/items/drink.ogg', 30, TRUE, -2)

			victim.blood_volume = clamp(victim.blood_volume - drained_blood, 0, BLOOD_VOLUME_MAXIMUM)
			hemophage.blood_volume = clamp(hemophage.blood_volume + drained_blood, 0, BLOOD_VOLUME_MAXIMUM)

			log_combat(hemophage, victim, "drained [drained_blood]u of blood from", addition = " (NEW BLOOD VOLUME: [victim.blood_volume] cL)")

			if(is_target_human_with_client)
				hemophage.apply_status_effect(/datum/status_effect/quality_blood_satiety)

			if(!victim.blood_volume)
				to_chat(hemophage, span_notice("You finish off [victim]'s blood supply."))


#undef HEMOPHAGE_DRAIN_AMOUNT


/obj/item/organ/internal/heart/hemophage
	name = "pulsating tumor"
	desc = "Just looking at how it pulsates at the beat of the heart it's wrapped around sends shivers down your spine... <i>The fact it's what keeps them alive makes it all the more terrifying.</i>"
	color = "#1C1C1C"


// We need to override it here because we changed their vampire heart with an Hemophage heart
/mob/living/carbon/get_status_tab_items()
	. = ..()
	var/obj/item/organ/internal/heart/hemophage/tumor_heart = getorgan(/obj/item/organ/internal/heart/hemophage)
	if(tumor_heart)
		. += "Current blood level: [blood_volume]/[BLOOD_VOLUME_MAXIMUM]."


/datum/status_effect/quality_blood_satiety
	id = "quality_blood_satiety"
	duration = 20 MINUTES
	status_type = STATUS_EFFECT_REFRESH
	alert_type = /atom/movable/screen/alert/status_effect/quality_blood_satiety
	/// What will the bloodloss_speed_multiplier of the Hemophage be changed by upon receiving this status effect?
	var/bloodloss_speed_multiplier = 0.5


/datum/status_effect/quality_blood_satiety/on_apply()
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


/datum/status_effect/quality_blood_satiety/on_remove()
	// This status effect should not exist on its own, or on a non-human.
	if(!owner || !ishuman(owner))
		return

	var/mob/living/carbon/human/human_owner = owner

	// This only ever applies to Hemophages, shoo if you're not an Hemophage!
	if(!ishemophage(human_owner))
		return

	var/datum/species/hemophage/owner_species = human_owner.dna.species
	owner_species.bloodloss_speed_multiplier /= bloodloss_speed_multiplier


/atom/movable/screen/alert/status_effect/quality_blood_satiety
	name = "Quality Blood Satiety"
	desc = "There's something about feeding off of other sentient beings that just can't quite be replicated artificially... It's somehow making it last a lot longer inside of your body than normal, most likely from satieting your tumor more than usual."
	icon_state = "highbloodpressure"
