/// Volume 'light' mode extracts per action
#define VOLUME_LIGHT 1
/// Volume 'strong' mode extracts per action
#define VOLUME_STRONG 5
/// 'light' mode
#define HANDLE_LIGHT 1
/// 'strong' mode
#define HANDLE_STRONG 2
/// The lowest numbered setting currently available (so we dont need yet another list)
#define HANDLE_MODE_LOWEST 1
/// The highest numbered setting currently available
#define HANDLE_MODE_HIGHEST 2
/// How much pleasure is gained through 'light' mode
#define PLEASURE_LIGHT 1
/// How much pleasure is gained through 'strong' mode
#define PLEASURE_STRONG 3
/// How much arousal is gained through 'light' mode
#define AROUSAL_LIGHT 1
/// How much arousal is gained through 'strong' mode
#define AROUSAL_STRONG 3
/// How much pain is gained through 'light' mode
#define PAIN_LIGHT 3
/// How much pain is gained through 'strong' mode
#define PAIN_STRONG 10

// Self-(and otherwise) Expression (of mammary organs)

/// The expression device
/obj/item/milker
	name = "milker"
	desc = "You and me, baby, ain't nothin' but mammals."
	icon_state = "latexballon"
	inhand_icon_state = "nothing"
	force = 0
	throwforce = 0
	item_flags = DROPDEL | ABSTRACT | HAND_ITEM
	attack_verb_continuous = list("slaps")
	attack_verb_simple = list("slap")
	hitsound = 'sound/effects/snap.ogg'
	/// Amount of pleasure inflicted from an action
	var/pleasure_amount = PLEASURE_LIGHT
	/// Amount of arousal inflicted from an action
	var/arousal_amount = AROUSAL_LIGHT
	/// Amount of pain inflicted from an action
	var/pain_amount = PAIN_LIGHT // *chomp*
	/// How aggressively we're going to milk someone
	var/handle_mode = HANDLE_LIGHT
	/// How much we're trying to express per squeeze / suck / CHOMP
	var/squirt_volume = VOLUME_LIGHT

/obj/item/milker/Initialize(mapload)
	. = ..()
	toggle_mode(null)

/obj/item/milker/attack(mob/living/target, mob/living/carbon/human/user)
	if(!in_range(target, user))
		to_chat(user, span_warning("[target] is too far away!"))
		return FALSE
	var/mob/living/carbon/being_milked = target

	var/obj/item/organ/genital/breasts/breasts = being_milked.getorganslot(ORGAN_SLOT_BREASTS)
	if(!breast_check(being_milked, user, breasts))
		return FALSE

	// What's in our other hand? If it's a reagent container, we could try bottling it!
	// Holding a reagent container implies wanting to *use* the container, so if the container doesn't work, don't proceed!
	var/obj/item/reagent_containers/milk_bottle = user.get_inactive_held_item()
	if(istype(milk_bottle))
		bottle_milk(being_milked, user, breasts, milk_bottle)
	else // Or just drink it
		drink_milk(being_milked, user, breasts)

/obj/item/milker/attack_self(mob/user)
	toggle_mode(user)

/**
 * Cycles through how intense the milking will be
 *
 * Arguments:
 * * user - The mob using the milker
 */
/obj/item/milker/proc/toggle_mode(mob/user)
	if(user)
		if(handle_mode++ > HANDLE_MODE_HIGHEST)
			handle_mode = HANDLE_MODE_LOWEST
	switch(handle_mode)
		if(HANDLE_LIGHT)
			user?.visible_message(
			message = span_purple("[user] relaxes [user.p_their()] jaw and softens [user.p_their()] milking hand, appearing to opt for a gentler approach."),
			self_message = span_purple("You relax your jaw and soften your milking hand, opting for a gentler approach."),
			blind_message = span_purple("You hear a relaxed rustle."),
			vision_distance = 1)
			desc = "[initial(desc)]" + "\n[span_purple("It looks somewhat gentle.")]"
			pleasure_amount = PLEASURE_LIGHT
			arousal_amount = AROUSAL_LIGHT
			pain_amount = PAIN_LIGHT
			squirt_volume = VOLUME_LIGHT
		if(HANDLE_STRONG)
			user?.visible_message(
			message = span_purple("[user] tightens [user.p_their()] jaw and clenches [user.p_their()] milking hand, appearing to opt for a more aggressive approach."),
			self_message = span_purple("You tighten your jaw and clench your milking hand, opting for a more aggressive approach."),
			blind_message = span_purple("You hear a vigorous rustle."),
			vision_distance = 1)
			desc = "[initial(desc)]" + "\n[span_purple("It looks rather aggressive!")]"
			pleasure_amount = PLEASURE_STRONG
			arousal_amount = AROUSAL_STRONG
			pain_amount = PAIN_STRONG
			squirt_volume = VOLUME_STRONG

/// Checks if the breasts are present, exposed, lactating, in range, and containing some kind of fluid. Returns a message if not!
/obj/item/milker/proc/breast_check(mob/living/carbon/being_milked, mob/living/carbon/human/milker, obj/item/organ/genital/breasts/breasts)
	var/self_suckle = (being_milked == milker) // Grammarize
	if(!being_milked.client)
		to_chat(milker, span_warning("[being_milked] is too busy staring off into space to be milked!"))
		return FALSE
	if(!being_milked.client || !being_milked.client.prefs.read_preference(/datum/preference/toggle/master_erp_preferences)) // clients are weird
		to_chat(milker, span_warning("[self_suckle ? "You would prefer to leave those alone!" : "[being_milked] would prefer you leave those alone!"]"))
		return FALSE
	if(!being_milked.client || !being_milked.client.prefs.read_preference(/datum/preference/toggle/erp/sex_toy)) // I guess its a sextoy!
		to_chat(milker, span_warning("[self_suckle ? "You would prefer to put your hands somewhere else!" : "[being_milked] would prefer you to keep your hands to yourself!"]"))
		return FALSE
	if(!ishuman(being_milked)) // Trying to milk a robot? A megarachnid? *IAN*?
		to_chat(milker, span_warning("You can't milk that!"))
		return FALSE
	if(being_milked.stat != CONSCIOUS)
		to_chat(milker, span_warning("[self_suckle ? "You are in no condition to be milked!" : "[being_milked] is in no condition to be milked!"]"))
		return FALSE
	if(!istype(breasts))
		to_chat(milker, span_warning("[self_suckle ? "You don't have any breasts!" : "[being_milked] doesn't seem to have any breasts!"]"))
		return FALSE
	if(!breasts.is_exposed())
		to_chat(milker, span_warning("[self_suckle ? "You can't get to your breasts!" : "[being_milked]'s breasts aren't accessible!"]"))
		return FALSE
	if(!breasts.lactates)
		to_chat(milker, span_warning("[self_suckle ? "You aren't lactating!" : "[being_milked] doesn't seem to be lactating!"]"))
		return FALSE
	if(breasts.internal_fluids.total_volume <= NONE)
		to_chat(milker, span_warning("[self_suckle ? "You're out of milk!" : "[being_milked] is fresh out of milk!"]"))
		return FALSE
	if(!in_range(being_milked, milker))
		to_chat(milker, span_warning("[self_suckle ? "Your breasts are too far away! ...somehow!" : "[being_milked]'s breasts are too far away!"]"))
		return FALSE
	return TRUE

/// Checks if the drinker can, in fact, get their mouth onto the thing they're drinking
/obj/item/milker/proc/mouth_check(mob/living/carbon/human/milker)
	if(!ishuman(milker))
		return FALSE
	var/covered
	if(milker.is_mouth_covered(head_only = 1))
		covered = "headgear"
	else if(milker.is_mouth_covered(mask_only = 1))
		covered = "mask"
	if(covered)
		to_chat(milker, span_warning("You have to remove your [covered] first!"))
		return FALSE
	return TRUE

/// Checks if the container is a container, unsealed, and has room. Retyrns a message if not!
/obj/item/milker/proc/bottle_check(mob/living/carbon/being_milked, mob/living/carbon/human/milker, obj/item/reagent_containers/milk_bottle)
	if(!istype(milk_bottle)) // Not a container?
		return FALSE
	if(!milk_bottle.is_open_container()) // Sealed container?
		to_chat(milker, span_warning("[milk_bottle] is sealed!"))
		return FALSE
	if(milk_bottle.reagents?.holder_full()) // Is full?
		to_chat(milker, span_warning("[milk_bottle] is full!"))
		return FALSE
	return TRUE

/// Attempt to consume the contents of someone's breasts.
/obj/item/milker/proc/drink_milk(mob/living/carbon/human/being_milked, mob/living/carbon/human/milker, obj/item/organ/genital/breasts/breasts)
	if(!breast_check(being_milked, milker, breasts) || !mouth_check(milker))
		return FALSE

	var/self_suckle = (being_milked == milker) // Feeding off your own supply?

	switch(handle_mode)
		if(HANDLE_LIGHT) // Gentle paws...
			if(milker.combat_mode)
				milker.visible_message(
				message = span_purple("[milker] yanks one of [self_suckle ? "[milker.p_their()] own" : "[being_milked]'s"] nipples up to [milker.p_their()] mouth and starts nibbling..."),
				self_message = span_purple("You yank one of [self_suckle ? "your own" : "[being_milked]'s"] nipples up to your mouth and start nibbling..."),
				blind_message = span_purple("You hear an awkward nibbling noise."),
				vision_distance = 1) // Subtle distance
			else
				milker.visible_message(
				message = span_purple("[milker] pulls one of [self_suckle ? "[milker.p_their()] own" : "[being_milked]'s"] nipples up to [milker.p_their()] lips..."),
				self_message = span_purple("You pull one of [self_suckle ? "your own" : "[being_milked]'s"] nipples up to your lips and start suckling..."),
				blind_message = span_purple("You hear an awkward kissing noise."),
				vision_distance = 1)
		if(HANDLE_STRONG) // SQUISH
			if(milker.combat_mode) // CHOMP
				milker.visible_message(
				message = span_purple("[milker] grips hard into one of [self_suckle ? "[milker.p_their()] own" : "[being_milked]'s"] breasts and wrenches it up to [milker.p_their()] mouth, chomping down hard!"),
				self_message = span_purple("You wrench one of [self_suckle ? "your own" : "[being_milked]'s"] breasts up to your mouth and start to bite down!"),
				blind_message = span_purple("You hear an awkward chomping noise."),
				vision_distance = 1) // Subtle distance
			else // SUCK
				milker.visible_message(
				message = span_purple("[milker] clasps a hand into one of [self_suckle ? "[milker.p_their()] own" : "[being_milked]'s"] breasts, then plunges [milker.p_their()] mouth around [milker.p_their()][self_suckle ? " own" : ""] nipple!"),
				self_message = span_purple("You grab onto one of [self_suckle ? "your own" : "[being_milked]'s"] breasts and ram that nipple right into your mouth!"),
				blind_message = span_purple("You hear an awkward plapping noise."),
				vision_distance = 1)

	if(!do_mob(milker, being_milked, 1 SECONDS))
		milker.visible_message(
		message = span_purple("[milker] was interrupted!"),
		self_message = span_purple("You were interrupted!"),
		blind_message = span_purple("You hear someone's lips slip."),
		vision_distance = 1)
		return FALSE
	if(!breast_check(being_milked, milker, breasts)) // Their breasts may have changed state (gutted, clothes, drained...)
		return FALSE

	milker.adjustArousal(arousal_amount)

	switch(handle_mode)
		if(HANDLE_LIGHT) // Gentle paws...
			if(milker.combat_mode) // Nibble...
				milker.visible_message(
				message = span_purple("[milker] nibbles on [self_suckle ? "[milker.p_their()] own" : "[being_milked]'s"] nipple, teasing out a stream of milk!"),
				self_message = span_purple("You nibble into [self_suckle ? "your own" : "[being_milked]'s"] nipple and feel a stream of milk spray into your mouth!"),
				blind_message = span_purple("You hear a nibble, and a squirt."),
				vision_distance = 1)
				being_milked.adjustPain(pain_amount)
				playsound(milker.loc, 'sound/weapons/bite.ogg', rand(10, 50), TRUE)
			else
				milker.visible_message(
				message = span_purple("[milker] suckles out a gentle stream of [self_suckle ? "[milker.p_their()] own" : "[being_milked]'s"] milk!"),
				self_message = span_purple("You suckle down a gentle stream of [self_suckle ? "your own" : "[being_milked]'s"] milk!"),
				blind_message = span_purple("You hear a slurp."),
				vision_distance = 1)
				being_milked.adjustArousal(arousal_amount)
				being_milked.adjustPleasure(pleasure_amount)
				playsound(milker.loc, 'sound/items/drink.ogg', rand(10, 50), TRUE)
		if(HANDLE_STRONG) // SQUISH
			if(milker.combat_mode) // CHOMP
				milker.visible_message(
				message = span_purple("[milker] bites down into [self_suckle ? "[milker.p_their()] own" : "[being_milked]'s"] nipple, slurping down a mouthful of milk!"),
				self_message = span_purple("You chomp down into [self_suckle ? "your own" : "[being_milked]'s"] breast and feast upon the milk within!"),
				blind_message = span_purple("You hear a hungry nibble."),
				vision_distance = 1)
				being_milked.adjustPain(pain_amount)
				playsound(milker.loc, 'sound/weapons/bite.ogg', rand(10, 50), TRUE)
			else
				milker.visible_message(
				message = span_purple("[milker] suckles down a mouthful of [self_suckle ? "[milker.p_their()] own" : "[being_milked]'s"] milk!"),
				self_message = span_purple("You suckle down a mouthful of [self_suckle ? "your own" : "[being_milked]'s"] milk!"),
				blind_message = span_purple("You hear a faint slurp."),
				vision_distance = 1)
				being_milked.adjustArousal(arousal_amount)
				being_milked.adjustPleasure(pleasure_amount)
				playsound(milker.loc, 'sound/items/drink.ogg', rand(10, 50), TRUE)

	var/gulp_size = squirt_volume
	SEND_SIGNAL(breasts, COMSIG_DRINK_DRANK, being_milked, milker)
	breasts.internal_fluids.trans_to(milker, gulp_size, transfered_by = being_milked, methods = INGEST)
	return TRUE

/// Attempt to bottle the contents of someone's breasts.
/obj/item/milker/proc/bottle_milk(mob/living/carbon/human/being_milked, mob/living/carbon/human/milker, obj/item/organ/genital/breasts/target_breasts, obj/item/reagent_containers/milk_bottle)
	if(!bottle_check(being_milked, milker, milk_bottle))
		return FALSE
	if(!breast_check(being_milked, milker, target_breasts))
		return FALSE

	var/self_bottle = (being_milked == milker) // Feeding off your own supply?

	milker.visible_message(
	message = span_purple("[milker] places \a [milk_bottle] under one of [self_bottle ? "[milker.p_their()]" : "[being_milked]'s"] nipples and starts to squeeze..."),
	self_message = span_purple("You place \the [milk_bottle] under one of [self_bottle ? "your" : "[being_milked]'s"] nipples and start to squeeze..."),
	blind_message = span_purple("You hear a faint plap."),
	vision_distance = 1) // Subtle distance

	if(!do_mob(milker, being_milked, 3 SECONDS))
		milker.visible_message(
		message = span_purple("[milker] was interrupted!"),
		self_message = span_purple("You were interrupted!"),
		blind_message = span_purple("You hear someone's fingers slip."),
		vision_distance = 1)
		return FALSE
	if(!breast_check(being_milked, milker, target_breasts)) // Their breasts may have changed state (gutted, clothes, drained...)
		return FALSE
	if(!bottle_check(being_milked, milker, milk_bottle)) // Their container may have changed state (filled, sealed, dropped...)
		return FALSE

	being_milked.adjustArousal(arousal_amount)
	being_milked.adjustPleasure(pleasure_amount)
	milker.adjustArousal(arousal_amount)

	target_breasts.internal_fluids.trans_to(milk_bottle, squirt_volume, transfered_by = milker)
	milker.visible_message(
	message = span_purple("[milker] takes aim and squirts some of [self_bottle ? "[milker.p_their()]" : "[being_milked]'s"] milk into \a [milk_bottle]!"),
	self_message = span_purple("You take aim and squirt some of [self_bottle ? "your" : "[being_milked]'s"] milk into \the [milk_bottle]!"),
	blind_message = span_purple("You hear a faint trickle."),
	vision_distance = 1)
	return TRUE
