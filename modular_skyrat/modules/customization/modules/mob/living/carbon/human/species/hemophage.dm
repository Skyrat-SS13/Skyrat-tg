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
	inherent_biotypes = MOB_UNDEAD | MOB_HUMANOID
	mutant_bodyparts = list("wings" = "None")
	exotic_bloodtype = "U"
	use_skintones = TRUE
	mutantheart = /obj/item/organ/heart/vampire
	mutanttongue = /obj/item/organ/tongue/vampire
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	limbs_id = SPECIES_HUMAN
	skinned_type = /obj/item/stack/sheet/animalhide/human
	/// Some starter text sent to the vampire initially, because vampires have shit to do to stay alive.
	var/info_text = "You are a <span class='danger'>Hemophage</span>. You will slowly but constantly lose blood if outside of a closet-like object. If inside a closet-like object, you will slowly heal. You may gain more blood by grabbing a live victim and using your drain ability."
	/// The shapeshifting action, attached to the datum itself to avoid cloning memes, and other duplicates.
	var/obj/effect/proc_holder/spell/targeted/shapeshift/bat/batform
	/// Is it currently Halloween and are we the Halloween version? If not, we do not get a batform nor do we burn in the chapel.
	var/halloween_version = FALSE
	veteran_only = TRUE

/datum/species/hemophage/check_roundstart_eligible()
	if(SSevents.holidays && SSevents.holidays[HALLOWEEN]) // SKYRAT EDIT - sleepy time roundstart check
		return TRUE
	return ..()

/datum/species/hemophage/on_species_gain(mob/living/carbon/human/new_vampire, datum/species/old_species)
	. = ..()
	to_chat(new_vampire, "[info_text]")
	new_vampire.update_body(0)
	new_vampire.set_safe_hunger_level()
	if(SSevents.holidays && SSevents.holidays[HALLOWEEN])
		halloween_version = TRUE
	if(isnull(batform) && halloween_version) // You can only have a batform during Halloween.
		batform = new
		new_vampire.AddSpell(batform)

/datum/species/hemophage/on_species_loss(mob/living/carbon/ex_vampire)
	. = ..()
	if(!isnull(batform))
		ex_vampire.RemoveSpell(batform)
		QDEL_NULL(batform)

/datum/species/hemophage/spec_life(mob/living/carbon/human/vampire, delta_time, times_fired)
	. = ..()
	if(vampire.stat == DEAD)
		return
	if(istype(vampire.loc, /obj/structure/closet) && !istype(vampire.loc, /obj/structure/closet/body_bag))
		vampire.heal_overall_damage(1.5 * delta_time, 1.5 * delta_time, 0, BODYPART_ORGANIC) // Fast, but not as fast due to them being able to use normal lockers.
		vampire.adjustToxLoss(-1 * delta_time) // 50% base speed to keep it fair.
		vampire.adjustOxyLoss(-2 * delta_time)
		vampire.adjustCloneLoss(-0.5 * delta_time) // HARDMODE DAMAGE
		return
	vampire.blood_volume -= 0.125 * delta_time
	if(vampire.blood_volume <= BLOOD_VOLUME_SURVIVE)
		to_chat(vampire, span_danger("You ran out of blood!"))
		var/obj/shapeshift_holder/holder = locate() in vampire
		if(holder)
			holder.shape.death() //make sure we're killing the bat if you are out of blood, if you don't it creates weird situations where the bat is alive but the caster is dead.
		vampire.death() // Owch! Ran out of blood.
	var/area/A = get_area(vampire)
	if(istype(A, /area/service/chapel) && halloween_version) // If hemophages have bat form, they cannot enter the church
		to_chat(vampire, span_warning("You don't belong here!"))
		vampire.adjustFireLoss(10 * delta_time)
		vampire.adjust_fire_stacks(3 * delta_time)
		vampire.IgniteMob()


/obj/effect/proc_holder/spell/targeted/shapeshift/bat
	name = "Bat Form"
	desc = "Take on the shape a space bat."
	invocation = "*snap"
	charge_max = 5 SECONDS
	cooldown_min = 5 SECONDS
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/bat
