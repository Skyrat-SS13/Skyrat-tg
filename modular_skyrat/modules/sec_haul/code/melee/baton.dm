// VERY IMPORTANT TO NOTE: Armor with batons is averaged across all limbs, meaning
// A helmet of melee 2 won't be as effective as a jumpsuit with melee 1.

/obj/item/melee/baton
	/// The armor flag used when we use our stun function, AKA our left click.
	var/stun_armor_flag = MELEE
	/// The armor penetration used for our stun function. Flat.
	var/stun_armor_flat_penetration = 0
	/// The armor penetration used for our stun function. Percentage, 0 to 1 scale. but can go higher.
	var/stun_armor_percent_penetration = 0.9

// Override to make batons respect armor
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
		target.apply_damage(stamina_damage, STAMINA, blocked = (target.run_armor_check(attack_flag = stun_armor_flag, armour_penetration = stun_armor_flat_penetration, weak_against_armour = src.weak_against_armour))*(1-stun_armor_percent_penetration))
		if(!trait_check)
			target.Knockdown((isnull(stun_override) ? knockdown_time : stun_override))
		additional_effects_non_cyborg(target, user)
	return TRUE
