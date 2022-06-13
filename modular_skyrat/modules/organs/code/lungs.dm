/obj/item/organ/internal/lungs/cold
	name = "cold-adapted lungs"
	icon = 'modular_skyrat/modules/organs/icons/lungs.dmi'
	desc = "A set of lungs adapted to low temperatures, though they are more susceptible to high temperatures"
	icon_state = "lungs_cold"
	cold_message = "a slightly painful, though bearable, cold sensation"
	cold_level_1_threshold = 208
	cold_level_2_threshold = 200
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_1
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_damage_type = BURN

	hot_message = "the searing heat with every breath you take"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN


/obj/item/organ/internal/lungs/hot
	name = "heat-adapted lungs"
	icon = 'modular_skyrat/modules/organs/icons/lungs.dmi'
	desc = "A set of lungs adapted to high temperatures, though they are more susceptible to low temperatures"
	icon_state = "lungs_heat"
	cold_message = "the freezing cold with every breath you take"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BURN

	hot_message = "a slightly painful, though bearable, warmth"
	heat_level_1_threshold = 373
	heat_level_2_threshold = 473
	heat_level_3_threshold = 523
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_1
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_1
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_damage_type = BURN

/obj/item/organ/internal/lungs/toxin
	name = "toxin-adapted lungs"
	icon = 'modular_skyrat/modules/organs/icons/lungs.dmi'
	desc = "A set of lungs adapted to toxic environments, though more susceptible to extreme temperatures."
	icon_state = "lungs_toxin"
	safe_plasma_max = 27
	safe_co2_max = 27

	cold_message = "the freezing cold with every breath you take"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BRUTE


	hot_message = "the searing heat with every breath you take"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

/obj/item/organ/internal/lungs/oxy
	name = "low-oxygen-adapted lungs"
	icon = 'modular_skyrat/modules/organs/icons/lungs.dmi'
	desc = "A set of lungs adapted to lower-pressure environments, though more susceptible to extreme temperatures."
	icon_state = "lungs_toxin"
	safe_oxygen_min = 5

	hot_message = "the searing heat with every breath you take"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

	cold_message = "the freezing cold with every breath you take"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BURN
