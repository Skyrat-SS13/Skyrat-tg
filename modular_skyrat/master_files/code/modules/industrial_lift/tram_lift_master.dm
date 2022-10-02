/**
 * Damage calculation for getting hit by the tram. 120 to 240 damage to the player at a lethality of 4. A chance of death, but it's going to hurt.
var/damage = rand(5, 10) * collision_lethality
				collided.apply_damage(2 * damage, BRUTE, BODY_ZONE_HEAD)
				collided.apply_damage(2 * damage, BRUTE, BODY_ZONE_CHEST)
				collided.apply_damage(0.5 * damage, BRUTE, BODY_ZONE_L_LEG)
				collided.apply_damage(0.5 * damage, BRUTE, BODY_ZONE_R_LEG)
				collided.apply_damage(0.5 * damage, BRUTE, BODY_ZONE_L_ARM)
				collided.apply_damage(0.5 * damage, BRUTE, BODY_ZONE_R_ARM)

We change the horizontal speed because with the increased lethality, we also have characters who are slower than normal, and nobody should get hit by the tram unless it's their own hubris.
Also because of tram code, lower horizontal_speed is actually faster, which... yeah. Keep that in mind if you want to change it in the future.
 */
/datum/lift_master/tram
	collision_lethality = 4
	base_horizontal_speed = 0.6
	horizontal_speed = 0.6
