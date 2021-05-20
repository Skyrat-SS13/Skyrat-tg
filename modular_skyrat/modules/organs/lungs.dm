/obj/item/organ/lungs/cold
	name = "Cold Adapted Lungs"
	icon = 'modular_skyrat/modules/organs/lungs.dmi'
	desc = "A set of lungs adapted to low temperatures, though they are more susceptible to high temperatures, breathing cold gases heals you very lightly depending how cold they are."
	icon_state = "lungs_cold"
	cold_message = "There is a slightly painful, though bearable, smoothing and good cold sensation with every breath you take"
	cold_level_1_threshold = 213
	cold_level_2_threshold = 153
	cold_level_3_threshold = 93
	cold_level_1_damage = -0.2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = -0.7
	cold_level_3_damage = 1 //why this? To people don't heal on extreme temperature.
	cold_damage_type = BRUTE|BURN|OXY

	hot_message = "You can't stand the searing heat with every breath you take"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = 2.2 //Yes people with lungs will be uttery fucked up if they don't use internals on hot areas.
	heat_level_2_damage = 4.4
	heat_level_3_damage = 6.6
	heat_damage_type = BURN|BRUTE|OXY


/obj/item/organ/lungs/hot
	name = "Heat Adapted Lungs"
	icon = 'modular_skyrat/modules/organs/lungs.dmi'
	desc = "A set of lungs adapted to high temperatures, though they are more susceptible to low temperatures, breathing hot gases heals you very lightly depending how hot they are"
	icon_state = "lungs_heat"
	cold_message = "You can't stand the freezing cold with every breath you take"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = 2.2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = 4.4
	cold_level_3_damage = 6.6
	cold_damage_type = BURN|BRUTE|OXY

	hot_message = "There is a slightly painful, though bearable, warmth with every breath you take"
	heat_level_1_threshold = 373
	heat_level_2_threshold = 473
	heat_level_3_threshold = 523
	heat_level_1_damage = -0.2
	heat_level_2_damage = -0.7
	heat_level_3_damage = 1
	heat_damage_type = BURN|BRUTE|OXY

/obj/item/organ/lungs/toxin
	name = "Toxic Adapted Lungs"
	icon = 'modular_skyrat/modules/organs/lungs.dmi'
	desc = "A set of lungs adapted to toxic environments, though more susceptible to extreme temperatures."
	icon_state = "lungs_toxin"
	safe_toxins_max = 27
	safe_co2_max = 27

	cold_message = "You can't stand the freezing cold with every breath you take"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BURN


	hot_message = "You can't stand the searing heat with every breath you take"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

/obj/item/organ/lungs/oxy
	name = "Low-Oxygen Adapted Lungs"
	icon = 'modular_skyrat/modules/organs/lungs.dmi'
	desc = "A set of lungs adapted to lower-pressure environments, though more susceptible to extreme temperatures."
	icon_state = "lungs_toxin"
	safe_oxygen_min = 2

	hot_message = "You can't stand the searing heat with every breath you take"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

	cold_message = "You can't stand the freezing cold with every breath you take"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BURN
