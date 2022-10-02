/**
 * Damage calculation for getting hit by the tram. 120 to 240 damage to the player at a lethality of 4. A chance of death, but it's going to hurt.
var/damage = rand(5, 10) * collision_lethality
				collided.apply_damage(2 * damage, BRUTE, BODY_ZONE_HEAD)
				collided.apply_damage(2 * damage, BRUTE, BODY_ZONE_CHEST)
				collided.apply_damage(0.5 * damage, BRUTE, BODY_ZONE_L_LEG)
				collided.apply_damage(0.5 * damage, BRUTE, BODY_ZONE_R_LEG)
				collided.apply_damage(0.5 * damage, BRUTE, BODY_ZONE_L_ARM)
				collided.apply_damage(0.5 * damage, BRUTE, BODY_ZONE_R_ARM)
 */
/datum/lift_master/tram
	collision_lethality = 4
