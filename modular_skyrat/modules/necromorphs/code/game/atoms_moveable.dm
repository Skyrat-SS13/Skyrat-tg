/atom/movable
	//Mass is measured in kilograms. It should never be zero
	var/mass = 1

	//Biomass is also measured in kilograms, its the organic mass in the atom. Is often zero
	var/biomass = 0

/atom/movable/proc/reset_move_animation()
	animate_movement = SLIDE_STEPS

/atom/movable/proc/get_mass()
	return mass
