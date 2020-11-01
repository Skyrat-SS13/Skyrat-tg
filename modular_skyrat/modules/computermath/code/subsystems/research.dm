
/datum/controller/subsystem/research
	var/problem_computer_max_charges = 5
	var/problem_computer_charges = 5
	var/problem_computer_charge_time = 90 SECONDS
	var/problem_computer_next_charge_time = 0

/datum/controller/subsystem/research/fire()
	. = ..()
	if(problem_computer_charges < problem_computer_max_charges && world.time >= problem_computer_next_charge_time)
		problem_computer_next_charge_time = world.time + problem_computer_charge_time
		problem_computer_charges += 1
