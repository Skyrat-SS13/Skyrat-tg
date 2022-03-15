/mob/living/carbon/human/bullet_act(obj/projectile/bullet, def_zone, piercing_hit = FALSE)
	. = call(src, /atom/proc/bullet_act)(bullet, def_zone, piercing_hit)
	if(!bullet.nodamage && (. != BULLET_ACT_BLOCK))
		var/attack_direction = get_dir(bullet.starting, src)
		// First, let's get the bullets base damage.
		var/bullet_damage = bullet.damage
		// Let's get the armor rating, it takes into account the integrity for us.
		var/armor_rating = get_and_process_armor(def_zone, bullet.flag, bullet_damage)
		// We take the bullets armor penetration and remove it from our armor rating. Make sure to clamp it so it can't go below 0.
		armor_rating = clamp(armor_rating - bullet.armour_penetration, 0, INFINITY)
		// We calculate the raw damage that the bullet will inflict, it will be the bullets damage type.
		var/calculated_damage = clamp(bullet_damage - armor_rating, 0, INFINITY)
		// Any left over bullet damage is converted into stamina damage.
		var/calculated_stamina_damage = clamp(calculated_damage - bullet_damage, 0, INFINITY)
		// Wound bonus is only dealt if the armor is "penetrated".
		var/wound_bonus = (calculated_damage > armor_rating) ? bullet.wound_bonus : 0
		// Now we apply the damage, if any.
		if(calculated_damage > 0)
			apply_damage(
				calculated_damage,
				bullet.damage_type,
				def_zone,
				FALSE,
				wound_bonus = wound_bonus,
				bare_wound_bonus = bullet.bare_wound_bonus,
				sharpness = bullet.sharpness,
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
			bullet.stun,
			bullet.knockdown,
			bullet.unconscious,
			bullet.slur,
			bullet.stutter,
			bullet.eyeblur,
			bullet.drowsy,
			armor,
			bullet.stamina,
			bullet.jitter,
			bullet.paralyze,
			bullet.immobilize
			)
		if(bullet.dismemberment)
			check_projectile_dismemberment(bullet, def_zone)

		to_chat(src, "DEBUG: calculated_damage:[calculated_damage] | calculated_stamina_damage:[calculated_stamina_damage] | wound_bonus:[wound_bonus] | armor_rating:[armor_rating] | attack_direction:[attack_direction]")

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

