#define TRANSLATE_EXTRA_SWING_ARMOR(armor) (1 - armor)

// VERY IMPORTANT TO NOTE: Armor with batons is averaged across all limbs, meaning
// A helmet of melee 2 won't be as effective as a jumpsuit with melee 1.

// god i love subtypes so much i love subtypes police batons are the base type ahAAAA
/obj/item/melee/baton
	/// The amount of swings we will ideally cause a knockdown with. Affected by armor_for_extra_swing_needed_for_knockdown.
	var/swings_to_knockdown = 1
	/// If the target has melee armor equal or above this, it will take an extra swing to knock them down.
	/// The threshold for knockdown is multiplied by (1 - this), so be careful of the values you enter.
	// (35*2)*(1-0.2) = 56, the same as the final damage dealt with 0.2 melee armor = 56
	// By default, the police baton is less effective against armor
	var/armor_for_extra_swing_needed_for_knockdown = 0.10 // Even a firesuit is enough to prevent instant knockdown

	/// The armor flag used when we use our stun function, AKA our left click.
	var/stun_armor_flag = MELEE

// Fast, low-damage attacks, but with the same overall effectiveness as the police baton
/obj/item/melee/baton/telescopic // change made for no particular reason other than "this seems cool", feel free to revert
	swings_to_knockdown = 6
	stamina_damage = 8.75
	cooldown = 1 SECONDS
	knockdown_time = 0.25 SECONDS
	armor_for_extra_swing_needed_for_knockdown = 0.20

/// Slow decently-damaging attacks that knockdown for a long period of time after a delay.
// No armor: Resist first knockdown, then knockdown, until 4th hit, which is crit.
// Security officer: Surprisingly, the only change is that it takes 5 hits to crit.
// Riot armor: Resist first two hits, knockdowno n third and later, crit on 9th.
// Contractor MODsuit: Resist first two, knockdown on third, crit on 7th.
// Fully kitted-out miner with full ash drake armor, talisman, gas mask, etc: Resist first six, crit on 13th.
/obj/item/melee/baton/security
	swings_to_knockdown = 2
	armor_for_extra_swing_needed_for_knockdown = 0.20

	//stun_armor_flag = ENERGY // These variables are commented out because I'm unsure of what the implications of using energy would be.

/**
 * Very slow high-damage attacks that instantly knock down anyone without an armor value of .15, which is surprisingly difficult to get as, say, an assistant.
 * Compared to the stun baton, the contractor baton crits faster, knocks down faster, but is less flexible given it's cooldown. Still objectively better, but
 * not egregiously. You could absolutely win a baton duel against this, you just have to be good.
 */
// No armor: Knockdown, then crit. Security officer: Resist first knockdown, weakly crawl up on second hit, crit on third.
// Riot armor: Resist first knockdown, knockdown on second, weakly crawl up on third hit, crit on fourth.
/obj/item/melee/baton/telescopic/contractor_baton
	swings_to_knockdown = 1
	stamina_damage = 85
	cooldown = 4 SECONDS
	knockdown_time = 2.5 SECONDS
	armor_for_extra_swing_needed_for_knockdown = 0.15

	//stun_armor_flag = ENERGY

/obj/item/melee/baton/abductor

	//stun_armor_flag = ENERGY

// Override to make batons respect armor and delay knockdown
/obj/item/melee/baton/baton_effect(mob/living/target, mob/living/user, modifiers, stun_override)
	var/trait_check = HAS_TRAIT(target, TRAIT_BATON_RESISTANCE)
	if(iscyborg(target))
		if(!affect_cyborg)
			return FALSE
		target.flash_act(affect_silicon = TRUE)
		target.Paralyze((isnull(stun_override) ? stun_time_cyborg : stun_override) * (trait_check ? 0.1 : 1))
		additional_effects_cyborg(target, user)
	else
		if(ishuman(target))
			var/mob/living/carbon/human/human_target = target
			if(prob(force_say_chance))
				human_target.force_say()
		target.apply_damage(stamina_damage, STAMINA, blocked = target.run_armor_check(attack_flag = stun_armor_flag, armour_penetration = src.armour_penetration, weak_against_armour = src.weak_against_armour))
		if(!trait_check)
			var/stamina_damage_threshold_for_knockdown = ((stamina_damage * swings_to_knockdown) * TRANSLATE_EXTRA_SWING_ARMOR(armor_for_extra_swing_needed_for_knockdown))
			if (target.staminaloss > stamina_damage_threshold_for_knockdown)
				target.Knockdown((isnull(stun_override) ? knockdown_time : stun_override))
		additional_effects_non_cyborg(target, user)
	return TRUE

/obj/item/melee/baton/security/apply_stun_effect_end(mob/living/target)
	var/stamina_damage_threshold_for_knockdown = ((stamina_damage * swings_to_knockdown) * TRANSLATE_EXTRA_SWING_ARMOR(armor_for_extra_swing_needed_for_knockdown))
	if(target.staminaloss > stamina_damage_threshold_for_knockdown)
		var/trait_check = HAS_TRAIT(target, TRAIT_BATON_RESISTANCE) //var since we check it in out to_chat as well as determine stun duration
		if(!target.IsKnockdown())
			to_chat(target, span_warning("Your muscles seize, making you collapse[trait_check ? ", but your body quickly recovers..." : "!"]"))

		if(!trait_check)
			target.Knockdown(knockdown_time)

#undef TRANSLATE_EXTRA_SWING_ARMOR
