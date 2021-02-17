/obj/item/organ/lungs/cold
	name = "Cold Adapted Lungs"
	icon_state = "lungs"
	desc = "A set of lungs adapted to low temperatures, though they are more susceptible to high temperatures"
	icon_state = "lungs_cold"
	cold_message = "Your face is freezing and a warm sensation of coldness is forming"
	cold_level_1_threshold = 208
	cold_level_2_threshold = 200
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_1 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_1
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_damage_type = BURN

	hot_message = "You can't stand the searing heat with every breath you take!"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN


/obj/item/organ/lungs/hot
	name = "Heat Adapted Lungs"
	desc = "A set of lungs adapted to high temperatures, though they are more susceptible to low temperatures"
	icon_state = "lungs_heat"
	cold_message = "You can't stand the freezing cold with every breath you take!"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BURN

	hot_message = "The warmth on your face is comfortable but still hurts!"
	heat_level_1_threshold = 373
	heat_level_2_threshold = 473
	heat_level_3_threshold = 523
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_1
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_1
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_damage_type = BURN

/obj/item/organ/lungs/toxin
	name = "Toxic Adapted Lungs"
	desc = "These lungs seem to be adapted to Toxic environments. These lungs seem fairly less resistant to low temperatures and high ones."
	icon_state = "lungs_toxin"
	safe_toxins_max = 27
	safe_co2_max = 27

	cold_message = "Your face is melting due to the freezing temperature!"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BURN


	hot_message = "You cant stand the searing heat on your face!"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

/obj/item/organ/lungs/oxy
	name = "Low-Oxygen Adapted Lungs"
	desc = "These lungs seem to be adapted to Low Oxygen environments. These lungs seem fairly less resistant to low temperatures and high ones."
	icon_state = "lungs_toxin"
	safe_oxygen_min = 5

	hot_message = "You cant stand the searing heat on your face!"
	heat_level_1_threshold = 318
	heat_level_2_threshold = 348
	heat_level_3_threshold = 1000
	heat_level_1_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_2_damage = HEAT_GAS_DAMAGE_LEVEL_2
	heat_level_3_damage = HEAT_GAS_DAMAGE_LEVEL_3
	heat_damage_type = BURN

	cold_message = "Your face is melting due to the freezing temperature!"
	cold_level_1_threshold = 248
	cold_level_2_threshold = 220
	cold_level_3_threshold = 170
	cold_level_1_damage = COLD_GAS_DAMAGE_LEVEL_2 //Keep in mind with gas damage levels, you can set these to be negative, if you want someone to heal, instead.
	cold_level_2_damage = COLD_GAS_DAMAGE_LEVEL_2
	cold_level_3_damage = COLD_GAS_DAMAGE_LEVEL_3
	cold_damage_type = BURN
