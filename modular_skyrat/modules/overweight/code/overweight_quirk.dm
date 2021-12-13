/// The slowdown being overweight causes. Less than a duffelbag.
#define OVERWEIGHT_SPEED_SLOWDOWN 0.3
/// How much stamina damage to we take per step, by default.
#define OVERWEIGHT_STAMINA_LOSS 1
/// How much stamina damage to we take per step, while fat.
#define OVERWEIGHT_AND_FAT_STAMINA_LOSS 2
/// How low fatigued should this make us get while not double-fat.
#define OVERWEIGHT_STAMINA_DAMAGE_CAP 50
/// If we are double-fat, how often should chairs complain at out weight.
#define OVERWEIGHT_AND_FAT_CHAIR_COMPLAIN_CHANCE 40
/// If we are double-fat, what percentage of the chair's health does our butt do to it.
#define OVERWEIGHT_AND_FAT_CHAIR_DAMAGE_MULTIPLIER 0.05
// Also: Double-fat means someone with the overweight quirk who got fat too.

/datum/quirk/overweight
	name = "Overweight"
	desc = "You, for reasons all your own, are quite a bit heavier than the average crewman."
	gain_text = span_notice("You feel a bit more ounce in your bounce.")
	lose_text = span_notice("Your wardrobe sighs in relief.")
	medical_record_text = "Patient has an excessive BMI."
	value = 0
	mob_trait = TRAIT_OVERWEIGHT
	icon = "expand-arrows-alt"
	var/base_stamina_drain = OVERWEIGHT_STAMINA_LOSS
	var/fat_stamina_drain = OVERWEIGHT_AND_FAT_STAMINA_LOSS
	var/base_stamloss_cap = OVERWEIGHT_STAMINA_DAMAGE_CAP

/datum/quirk/overweight/add()
	var/mob/living/carbon/human/human_holder = quirk_holder
	RegisterSignal(human_holder, COMSIG_MOVABLE_MOVED, .proc/move_fatigue) //emphasis on fat
	var/speedmod = human_holder.dna.species.speedmod + OVERWEIGHT_SPEED_SLOWDOWN
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)

/datum/quirk/overweight/remove()
	var/mob/living/carbon/human/human_holder = quirk_holder
	UnregisterSignal(human_holder, COMSIG_MOVABLE_MOVED)
	var/speedmod = human_holder.dna.species.speedmod
	human_holder.add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/species, multiplicative_slowdown=speedmod)

/// Applies stamina damage every step the mob takes, cus they're heavy
/datum/quirk/overweight/proc/move_fatigue(mob/living/carbon/human/hefty)
	if(!ishuman(hefty)) //Fat robots dont get tired (just tires)
		return
	if(hefty.stat > UNCONSCIOUS) //Too asleep to use their legs
		return
	if(!isturf(hefty.loc)) //Mechs and such walk for them
		return
	if(isspaceturf(hefty.loc)) //Space is a fatty's favorite place
		return
	if((hefty.movement_type & FLOATING) || hefty.buckled) //Sitting down or weightless
		return
	if(hefty.pulledby && hefty.body_position == LYING_DOWN) //Dragging means not using their legs
		return
	if(hefty.throwing) //Aint walking through the air
		return
	if(hefty.m_intent == MOVE_INTENT_WALK)
		return
	if(HAS_TRAIT(hefty, TRAIT_FAT))
		hefty.apply_damage(fat_stamina_drain, STAMINA, BODY_ZONE_CHEST) //Huff puff
	else if(hefty.get_damage_amount(STAMINA) >= base_stamloss_cap)
		return
	else
		hefty.apply_damage(base_stamina_drain, STAMINA, BODY_ZONE_CHEST)

/// They were fat to begin with, more fat isnt *that* much of an issue... for now
/datum/movespeed_modifier/obesity/lesser
	multiplicative_slowdown = 1.2

/**
 * Chairs crumble before their might. Progressively damages the chair just by having someone sit on it.
 *
 * Arguments:
 * * sitter - Who is sitting in this chair?
 * * just_sat_down - Did they just sit down, and thus get a different message?
*/
/obj/structure/chair/proc/overweight_chair_damage(mob/living/carbon/human/sitter, just_sat_down = TRUE)
	if(!ishuman(sitter))
		return
	if(!HAS_TRAIT(sitter, TRAIT_OVERWEIGHT))
		return
	if(sitter.buckled != src)
		return
	if(!uses_integrity)
		return
	if(resistance_flags & INDESTRUCTIBLE) //Seat can support their weight
		return
	if(!has_gravity(get_turf(sitter))) //If the sitter is weightless, then they aren't all that heavy
		return
	if((sitter.movement_type & FLOATING)) //Floating also makes a person less heavy
		return
	/// Only show this stuff to people who also have the quirk
	if(HAS_TRAIT(sitter, TRAIT_FAT)) //Double fat? start crushing that chair
		var/make_noise = prob(OVERWEIGHT_AND_FAT_CHAIR_COMPLAIN_CHANCE)
		var/sit_damage = max_integrity * OVERWEIGHT_AND_FAT_CHAIR_DAMAGE_MULTIPLIER * (sitter.nutrition / NUTRITION_LEVEL_FAT)
		if((atom_integrity - sit_damage) <= (max_integrity * integrity_failure)) // If the seat can't survive this ass attack, do some special behavior
			overweight_chair_destruction(sitter)
			return
		else if(just_sat_down)
			sitter.visible_message(span_notice("[src] bends visibly, starting to buckle under [sitter]'s tremendous weight..."),
			blind_message = span_notice("[src] creaks ominously under [sitter]'s tremendous weight..."),
			self_message = span_warning("[src] lets out an ominous creak as it struggles to support your tremendous weight!"),
			ignored_mobs = get_overweight_in_range(sitter, DEFAULT_MESSAGE_RANGE))
		else if(make_noise)
			sitter.visible_message(span_notice("[src] bends as it struggles in vain to support [sitter]..."),
			blind_message = span_notice("You hear a loud creak."),
			self_message = span_warning("You feel something in \the [src] snap as it tries in vain to support your mass..."),
			ignored_mobs = get_overweight_in_range(sitter, DEFAULT_MESSAGE_RANGE))
		if(take_damage(sit_damage, damage_type = BRUTE, damage_flag = MELEE, sound_effect = FALSE)) //If it still didnt do any damage, don't try again
			addtimer(CALLBACK(src, .proc/overweight_chair_damage, sitter, FALSE), 5 SECONDS)
	else
		to_chat(sitter, span_notice("You subject \the [src] to your weight. It creaks, but holds firm."))

/**
 * This chair just got destroyed by someone's butt. Throw them on the ground
 *
 * Arguments:
 * * seated - Who is sitting in this chair?
*/
/obj/structure/chair/proc/overweight_chair_destruction(mob/living/carbon/human/seated)
	if(!ishuman(seated))
		return
	if(seated.buckled != src)
		return
	if(!uses_integrity)
		return
	if(resistance_flags & INDESTRUCTIBLE)
		return
	if(!HAS_TRAIT(seated, TRAIT_OVERWEIGHT))
		return
	unbuckle_mob(seated)
	seated.AdjustKnockdown(5 SECONDS)
	seated.visible_message(span_warning("[src] falls apart!"),
	blind_message = span_warning("You hear a loud crash, followed by a soft whump."),
	self_message = span_warning("You feel something in \the [src] snap as the last of its strength gives out! It crumbles under your weight, throwing you down onto its flattened remains!"))
	playsound(src, 'modular_skyrat/modules/oversized/sound/chair_break.ogg', 70, TRUE)
	deconstruct(FALSE)

/obj/structure/chair/proc/get_overweight_in_range(mob/living/carbon/human/origin, range = 2)
	if(!origin)
		return
	for(var/mob/living/prefcheck in view(range, origin))
		if(prefcheck == origin)
			continue
		if(!HAS_TRAIT(prefcheck, TRAIT_OVERWEIGHT))
			LAZYADD(., prefcheck)
	return

#undef OVERWEIGHT_SPEED_SLOWDOWN
#undef OVERWEIGHT_STAMINA_LOSS
#undef OVERWEIGHT_AND_FAT_STAMINA_LOSS
#undef OVERWEIGHT_STAMINA_DAMAGE_CAP
#undef OVERWEIGHT_AND_FAT_CHAIR_COMPLAIN_CHANCE
#undef OVERWEIGHT_AND_FAT_CHAIR_DAMAGE_MULTIPLIER
