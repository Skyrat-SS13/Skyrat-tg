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
	)
	inherent_biotypes = MOB_UNDEAD | MOB_HUMANOID
	mutant_bodyparts = list("wings" = "None")
	exotic_bloodtype = "U"
	use_skintones = TRUE
	mutantheart = /obj/item/organ/heart/vampire
	mutanttongue = /obj/item/organ/tongue/vampire
	changesource_flags = MIRROR_BADMIN | WABBAJACK | MIRROR_MAGIC | MIRROR_PRIDE | ERT_SPAWN | RACE_SWAP | SLIME_EXTRACT
	examine_limb_id = SPECIES_HUMAN
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
		vampire.heal_overall_damage(1.5 * delta_time, 1.5 * delta_time, 0, BODYTYPE_ORGANIC) // Fast, but not as fast due to them being able to use normal lockers.
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
	if(istype(A, /area/station/service/chapel) && halloween_version) // If hemophages have bat form, they cannot enter the church
		to_chat(vampire, span_warning("You don't belong here!"))
		vampire.adjustFireLoss(10 * delta_time)
		vampire.adjust_fire_stacks(3 * delta_time)
		vampire.ignite_mob()

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

/obj/effect/proc_holder/spell/targeted/shapeshift/bat
	name = "Bat Form"
	desc = "Take on the shape a space bat."
	invocation = "*snap"
	charge_max = 5 SECONDS
	cooldown_min = 5 SECONDS
	shapeshift_type = /mob/living/simple_animal/hostile/retaliate/bat
