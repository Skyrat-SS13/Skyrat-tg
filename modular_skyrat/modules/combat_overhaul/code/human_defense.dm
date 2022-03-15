/mob/living/carbon/human/bullet_act(obj/projectile/hitting_projectile, def_zone, piercing_hit = FALSE)
	SEND_SIGNAL(src, COMSIG_ATOM_BULLET_ACT, hitting_projectile, def_zone)
	// This armor check only matters for the visuals and messages in on_hit(), it's not actually used to reduce damage since
	// only living mobs use armor to reduce damage, but on_hit() is going to need the value no matter what is shot.
	var/visual_armor_check = check_projectile_armor(def_zone, hitting_projectile)
	. = hitting_projectile.on_hit(src, visual_armor_check, def_zone, piercing_hit)
	if(!hitting_projectile.nodamage && (. != BULLET_ACT_BLOCK))
		var/attack_direction = get_dir(hitting_projectile.starting, src)
		// First, let's get the bullets base damage.
		var/projectile_damage = hitting_projectile.damage
		// Let's get the armor rating, it takes into account the integrity for us.
		var/armor_rating = get_and_process_armor(def_zone, hitting_projectile.flag, projectile_damage)
		// We take the bullets armor penetration and remove it from our armor rating. Make sure to clamp it so it can't go below 0.
		armor_rating = clamp(armor_rating - hitting_projectile.armour_penetration, 0, INFINITY)
		// We calculate the raw damage that the bullet will inflict, it will be the bullets damage type.
		var/calculated_damage = clamp(projectile_damage - armor_rating, 0, INFINITY)
		// Any left over bullet damage is converted into stamina damage.
		var/calculated_stamina_damage = clamp(projectile_damage - calculated_damage, 0, INFINITY)
		// Wound bonus is only dealt if the armor is "penetrated".
		var/wound_bonus = (calculated_damage > armor_rating) ? hitting_projectile.wound_bonus : 0

		// Now we apply the damage, if any.
		if(calculated_damage > 0)
			apply_damage(
				calculated_damage,
				hitting_projectile.damage_type,
				def_zone,
				FALSE,
				wound_bonus = wound_bonus,
				bare_wound_bonus = hitting_projectile.bare_wound_bonus,
				sharpness = hitting_projectile.sharpness,
				attack_direction = attack_direction
				)
		if(calculated_stamina_damage > 0)
			apply_damage(
				calculated_stamina_damage,
				STAMINA,
				def_zone,
				FALSE,
				attack_direction = attack_direction
			)
		// We need effects to occur so things like an e-crossbow can't be nulled permanently by armor.
		apply_effects(
			hitting_projectile.stun,
			hitting_projectile.knockdown,
			hitting_projectile.unconscious,
			hitting_projectile.slur,
			hitting_projectile.stutter,
			hitting_projectile.eyeblur,
			hitting_projectile.drowsy,
			armor,
			hitting_projectile.stamina,
			hitting_projectile.jitter,
			hitting_projectile.paralyze,
			hitting_projectile.immobilize
			)
		if(hitting_projectile.dismemberment)
			check_projectile_dismemberment(hitting_projectile, def_zone)

		// Now we deal with displaying the damage feedback. I have to admit, this is really bad code.
		var/obj/item/bodypart/bodypart
		if(isbodypart(def_zone))
			bodypart = def_zone
		else
			bodypart = get_bodypart(check_zone(def_zone))
		// We have confirmed that our bodypart does indeed exist...
		if(bodypart)
			var/list/clothing_zones = list(head, wear_mask, wear_suit, w_uniform, back, gloves, shoes, belt, s_store, glasses, ears, wear_id, wear_neck) // Hate.
			for(var/clothing_zone in clothing_zones)
				if(!clothing_zone)
					continue
				if(clothing_zone && istype(clothing_zone, /obj/item/clothing))
					var/obj/item/clothing/clothing = clothing_zone
					if(clothing.body_parts_covered & bodypart.body_part && clothing.armor.getRating(hitting_projectile.damage_type, TRUE)) // We have a piece of armor that is protecting this bodypart.
						if(wound_bonus)
							to_chat(src, span_userdanger("[clothing] that was covering your [bodypart.name] was penetrated!"))
						else
							to_chat(src, span_danger("[clothing] that was covering your [bodypart.name] fully absorbed the hit!"))

		to_chat(src, "DEBUG: bullet_damage:[projectile_damage] | calculated_damage:[calculated_damage] | calculated_stamina_damage:[calculated_stamina_damage] | wound_bonus:[wound_bonus] | armor_rating:[armor_rating] | attack_direction:[attack_direction]")

	return . ? BULLET_ACT_HIT : BULLET_ACT_BLOCK

/mob/living/carbon/human/proc/get_and_process_armor(def_zone, damage_type, damage)
	if(def_zone)
		if(isbodypart(def_zone))
			var/obj/item/bodypart/bodypart = def_zone
			if(bodypart)
				return process_armor(def_zone, damage_type, damage)
		var/obj/item/bodypart/affecting = get_bodypart(check_zone(def_zone))
		if(affecting)
			return process_armor(affecting, damage_type, damage)
		//If a specific bodypart is targetted, check how that bodypart is protected and return the value.

	//If you don't specify a bodypart, it checks ALL your bodyparts for protection, and averages out the values
	var/armor_value = 0
	var/organ_number = 0
	for(var/X in bodyparts)
		var/obj/item/bodypart/bodypart = X
		armor_value += checkarmor(bodypart, damage_type)
		organ_number++
	return (armor_value / max(organ_number, 1))

/**
 * This proc is used to actually process the armor and degrade it's integrity.
 */
/mob/living/carbon/human/proc/process_armor(obj/item/bodypart/def_zone, damage_type, damage)
	if(!damage_type)
		return FALSE
	var/protection = 0
	var/list/body_parts = list(head, wear_mask, wear_suit, w_uniform, back, gloves, shoes, belt, s_store, glasses, ears, wear_id, wear_neck) //Everything but pockets. Pockets are l_store and r_store. (if pockets were allowed, putting something armored, gloves or hats for example, would double up on the armor)
	for(var/bodypart in body_parts)
		if(!bodypart)
			continue
		if(bodypart && istype(bodypart, /obj/item/clothing))
			var/obj/item/clothing/clothing = bodypart
			if(clothing.body_parts_covered & def_zone.body_part)
				protection += clothing.armor.getRating(damage_type)
				// Here is where we degrade the armor.
				clothing.armor.degrade(damage, damage_type)
	protection += physiology.armor.getRating(damage_type)
	return protection

