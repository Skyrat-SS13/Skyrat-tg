/datum/species/hemophage
	name = "Hemophage"
	id = SPECIES_HEMOPHAGE
	default_color = "FFFFFF"
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
	)
	inherent_biotypes = MOB_UNDEAD|MOB_HUMANOID
	mutant_bodyparts = list("wings" = "None")
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_PRIDE | MIRROR_MAGIC | ERT_SPAWN
	exotic_bloodtype = "U"
	use_skintones = TRUE
	mutantheart = /obj/item/organ/heart/vampire
	mutanttongue = /obj/item/organ/tongue/vampire
	limbs_id = SPECIES_HUMAN
	skinned_type = /obj/item/stack/sheet/animalhide/human
	var/info_text = "You are a <span class='danger'>Hemophage</span>. You will slowly but constantly lose blood if outside of a coffin. If inside a coffin, you will slowly heal. You may gain more blood by grabbing a live victim and using your drain ability."
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/batform //attached to the datum itself to avoid cloning memes, and other duplicates
	///SKYRAT EDIT: Allow a neutered version of hemophages without batform
	var/halloween_version = FALSE
	veteran_only = TRUE // SKYRAT EDIT - Hemophages roundstart

/datum/species/hemophage/check_roundstart_eligible()
	if(SSevents.holidays && SSevents.holidays[HALLOWEEN]) // SKYRAT EDIT - sleepy time roundstart check
		return TRUE
	return ..()

/datum/species/hemophage/on_species_gain(mob/living/carbon/human/C, datum/species/old_species)
	. = ..()
	to_chat(C, "[info_text]")
	// C.skin_tone = "albino" SKYRAT EDIT: Allow hemophages to be different skin tones beside one
	C.update_body(0)
	//SKYRAT EDIT: Allow a neutered version of hemophages without batform
	if(SSevents.holidays && SSevents.holidays[HALLOWEEN])
		halloween_version = TRUE
	if(isnull(batform) && halloween_version)
	//SKYRAT EDIT: Allow a neutered version of hemophages without batform
		batform = new
		C.AddSpell(batform)
	C.set_safe_hunger_level()

/datum/species/hemophage/on_species_loss(mob/living/carbon/C)
	. = ..()
	if(!isnull(batform))
		C.RemoveSpell(batform)
		QDEL_NULL(batform)

/datum/species/hemophage/spec_life(mob/living/carbon/human/C, delta_time, times_fired)
	. = ..()
	if(istype(C.loc, /obj/structure/closet) && !istype(C.loc, /obj/structure/closet/body_bag)) // SKYRAT EDIT - NORMAL CLOSETS INSTEAD OF COFFINS.
		C.heal_overall_damage(1.5 * delta_time, 1.5 * delta_time, 0, BODYPART_ORGANIC) // SKYRAT EDIT - ORIGINAL 2 - Fast, but not as fast due ot them being able to use normal lockers.
		C.adjustToxLoss(-1 * delta_time) // SKYRAT EDIT - ORIGINAL 2 - 50% base speed to keep it fair
		C.adjustOxyLoss(-2 * delta_time)
		C.adjustCloneLoss(-0.5 * delta_time) // SKYRAT EDIT - ORIGINAL 2 - HARDMODE DAMAGE
		return
	C.blood_volume -= 0.125 * delta_time
	if(C.blood_volume <= BLOOD_VOLUME_SURVIVE)
		to_chat(C, span_danger("You ran out of blood!"))
		var/obj/shapeshift_holder/H = locate() in C
		if(H)
			H.shape.death() //make sure we're killing the bat if you are out of blood, if you don't it creates weird situations where the bat is alive but the caster is dusted.
		C.death() // Skyrat Edit - Owch! Ran out of blood.
	var/area/A = get_area(C)
	if(istype(A, /area/service/chapel) && halloween_version) // SKYRAT EDIT: If hemophages have bat form, they cannot enter the church
		to_chat(C, span_warning("You don't belong here!"))
		C.adjustFireLoss(10 * delta_time)
		C.adjust_fire_stacks(3 * delta_time)
		C.IgniteMob()


/obj/effect/proc_holder/spell/targeted/shapeshift/bat
	name = "Bat Form"
	desc = "Take on the shape a space bat."
	invocation = "Squeak!"
	charge_max = 50
	cooldown_min = 50
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/bat
