#define MATH_REWARD_EASY  1
#define MATH_REWARD_MEDIUM  2.5
#define MATH_REWARD_HARD  5
#define MATH_MULTIPLIER_SCIENCE  750 // If science points and cargo points need to be balanced seperately
#define MATH_MULTIPLIER_CARGO  500 // Difficulty reward gets multiplied by these

/obj/item/computermath
	icon = 'modular_skyrat/modules/computermath/icons/computermath.dmi'
	verb_say = "beeps"
	var/charge_count

/obj/item/computermath/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/computermath/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/computermath/proc/check_charges()
	return FALSE

/obj/item/computermath/proc/consume_charges()
	return FALSE

/obj/item/computermath/proc/give_question(mob/user, var/reward_type)
	if(!reward_type)
		say("Critical error. Program terminating.")
		return

	if(!check_charges()) // Out of charges!
		say("No current problems available. Try again later.")
		playsound(src, 'sound/machines/buzz-sigh.ogg', 30, 1)
		return

	var/operator
	var/difficulties = list("Easy", "Medium", "Hard")
	var/query = "Please select the difficulty level. Reward scales with difficulty."
	var/difficulty = input(user, query, "Select Difficulty") as null|anything in difficulties
	if(!difficulty)
		return
	switch(difficulty)
		if("Easy")
			operator = pick("add","subtract","multiply")
		if("Medium")
			operator = pick("division", "exponent", "easy algebra")
		if("Hard")
			operator = pick("2nd polynomial", "algebra", "line intersection")
	var/correct = FALSE
	switch(operator)
		// Easy problems. The numbers need to be so it's doable without a calculator, yet not easy.
		if("add")
			var/addnum_1 = rand(1, 500)
			var/addnum_2 = rand(1, 500)
			var/question = "What is [addnum_1] + [addnum_2]?"
			var/solution = addnum_1 + addnum_2
			var/answer = input(user, question, "Math Problem") as null|num
			if(isnull(answer)) // User hit the cancel button
				return
			if(answer == solution)
				correct = TRUE
		if("subtract")
			var/subnum_1 = rand(-100, 100)
			var/subnum_2 = rand(-100, 200)
			var/question = "What is [subnum_1] - [subnum_2]?"
			var/solution = subnum_1 - subnum_2
			var/answer = input(user, question, "Math Problem") as null|num
			if(isnull(answer)) // User hit the cancel button
				return
			if(answer == solution)
				correct = TRUE
		if("multiply")
			var/multnum_1 = rand(-50, 50)
			var/multnum_2 = rand(-250, 500)
			var/question = "What is [multnum_1] * [multnum_2]?"
			var/solution = multnum_1 * multnum_2
			var/answer = input(user, question, "Math Problem") as null|num
			if(isnull(answer)) // User hit the cancel button
				return
			if(answer == solution)
				correct = TRUE

		// Medium problems
		if("division")
			var/divnum_2 = rand(3, 12)
			var/divnum_1 = rand(-50, 50) * divnum_2 // Nice numbers only.
			var/question = "What is [divnum_1] / [divnum_2]? Rounded the answer down if applicable."
			var/solution = round(divnum_1 / divnum_2)
			var/answer = input(user, question, "Math Problem") as null|num
			if(isnull(answer)) // User hit the cancel button
				return
			if(answer == solution)
				correct = TRUE
		if("exponent")
			var/expnum_1 = rand(-50, 50)
			var/expnum_2 = pick(list(2, 3, 1/2)) // Also square root!
			var/question = "What is ([expnum_1]) ^ [expnum_2]? Answer is rounded down if applicable."
			var/solution
			if(expnum_2 == 1/2) // For some reason, a ** 1/2 throws a runtime error, so just use sqrt()
				solution = round(sqrt(abs(expnum_1)))
			else
				solution = round(expnum_1 ** expnum_2)
			var/answer = input(user, question, "Math Problem") as null|num
			if(isnull(answer)) // User hit the cancel button
				return
			if(answer == solution)
				correct = TRUE

		if("easy algebra")
			// ax + b = c ----> x = (c-b)/a
			var/num_a = rand(1,5)
			var/num_b = rand(-5,10)
			var/num_c = rand(-10, 10)
			var/question = "[num_a]x + [num_b] = [num_c]. Solve for x."
			var/solution = (num_c - num_b)/num_a
			var/answer = input(user, question, "Math Problem") as null|num
			if(isnull(answer)) // User hit the cancel button
				return
			if(answer == solution)
				correct = TRUE
		// Hard problems, where 'hard' is high school maths
		if("algebra") // everyone's favorite :)
			var/answer
			var/solution
			if(prob(50)) // 2 variants of the question
				// a/bx = c  --->  x = a/bc. b and c may not be 0.
				var/num_a = rand(-100, 100)
				var/num_b = rand(-5, 5)
				if(num_b == 0)
					num_b = 12
				var/num_c = rand(1, 10)
				var/question = "[num_a]/([num_b]x) = [num_c]. Solve for x. Round down if applicable."
				solution = round(num_a / (num_b * num_c))
				answer = input(user, question, "Math Problem") as null|num
			else
				// (a-x)/b = x/c ----> x=ac/(b+c), b+c and b*c may not be 0
				var/num_a = rand(-50, 50)
				var/num_b = rand(1, 5)
				var/num_c = rand(1, 10)
				var/question = "([num_a]-x)/[num_b] = x/[num_c]. Solve for x. Round down if applicable."
				solution = round((num_a * num_c)/(num_b + num_c))
				answer = input(user, question, "Math Problem") as null|num
			if(isnull(answer)) // User hit the cancel button
				return
			if(answer == solution)
				correct = TRUE

		if("2nd polynomial")
			// Math part
			var/num_a = rand(1, 2)
			var/num_b = rand(-5, 5)
			var/num_c = rand(-25, 25)
			var/discriminant = num_b**2 - 4 * num_a * num_c
			var/solution1
			var/solution2
			if(discriminant >= 0) // positive gives 2 solutions, if D=0 then sol1=sol2 anyway
				// Quadratic formula
				solution1 = round((-num_b+sqrt(discriminant))/(2*num_a))
				solution2 = round((-num_b-sqrt(discriminant))/(2*num_a))
			else
				solution1 = 0
				solution2 = 0
			// Answering part
			var/question = "[num_a]x^2 + [num_b]x + [num_c] = 0. Solve for x, give any real solution. Fill in 0 for no real solutions. Answers are rounded down. (-0.25 becomes -1)"
			var/answer = input(user, question, "Math Problem") as null|num
			if(isnull(answer)) // User hit the cancel button
				return
			if(answer == solution1 || answer == solution2)
				correct = TRUE
		if("line intersection")
			// y1=ax+b
			// y2=cx+d
			// intersect: x=(d-c)/(a-b), y=a(d-c)/(a-b)+c. So a-b or c-d may never be 0.
			var/num_a = rand(1,5)
			var/num_b = rand(-10,-1)
			var/num_c = rand(1, 10)
			var/num_d = rand(-10, -1)
			var/x_intersect = round((num_d-num_c)/(num_a-num_b))
			var/y_intersect = round(num_a * (num_d - num_c)/(num_a - num_b) + num_c)
			var/question
			var/answer
			if(prob(50)) // 50% chance to ask for x, or y
				question = "Given the lines y=[num_a]x+[num_b] and y=[num_c]x+[num_d], what is the x-value of their intersection point? Rounded down if applicable."
				answer = input(user, question, "Math Problem") as null|num
				if(answer == x_intersect)
					correct = TRUE
			else
				question = "Given the lines y=[num_a]x+[num_b] and y=[num_c]x+[num_d], what is the y-value of their intersection point? Rounded down if applicable."
				answer = input(user, question, "Math Problem") as null|num
				if(answer == y_intersect)
					correct = TRUE
			if(isnull(answer)) // User hit the cancel button
				return

	// An answer has been submitted, remove a charge and check if it's correct!
	if(consume_charges())
		handle_reward(user, reward_type, correct, difficulty)
	else // Ran out of charges while answering due to multiple characters using the computers
		say("Error. All available problems have been resolved in the time it took to answer. Please wait for more to become available.")
		playsound(src, 'sound/machines/buzz-sigh.ogg', 30, 1)
		return

/obj/item/computermath/proc/handle_reward(mob/user, var/reward_type, var/correct, var/difficulty)
	var/mob/living/LM = user
	// Calculate points
	var/points_awarded
	switch(difficulty)
		if("Easy")
			points_awarded = MATH_REWARD_EASY
		if("Medium")
			points_awarded = MATH_REWARD_MEDIUM
		if("Hard")
			points_awarded = MATH_REWARD_HARD
	switch(reward_type)
		if("Cargo")
			points_awarded *= MATH_MULTIPLIER_CARGO
		if("Science")
			points_awarded *= MATH_MULTIPLIER_SCIENCE
	// Incorrect answer is a point penalty.
	if(!correct)
		var/points_lost = points_awarded / 4  // Penalty for failure is 1/4th success points
		say("Warning! Incorrect answer.")
		switch(reward_type)
			if("Science")
				say("Research data has been corrupted. [points_lost] science points have been lost.")
				SSresearch.science_tech.remove_point_list(list(TECHWEB_POINT_TYPE_GENERIC = points_lost))
			if("Cargo")
				say("To solve the resulting bureaucratic error, [points_lost] cargo points have been deducted from the balance.")
				SSshuttle.points -= points_lost
		playsound(src, 'sound/machines/buzz-sigh.ogg', 30, 1)
		if(difficulty == "Easy") // me fail arithmetic, me brian hurt
			to_chat(user,"<span class='warning'>You feel lightheaded after failing such an easy question...</span>")
			LM.adjustOrganLoss(ORGAN_SLOT_BRAIN, 10)
		return

	// Award points for a correct answer.
	switch(reward_type)
		if("Science")
			say("Correct data received. Applying to research algorithms...")
			say("Completed. [points_awarded] science points added.")
			SSresearch.science_tech.add_point_list(list(TECHWEB_POINT_TYPE_GENERIC = points_awarded))
		if("Cargo")
			say("Correct data received. Updating cargo manifests...")
			say("Completed. [points_awarded] cargo credits have been added to station balance.")
			SSshuttle.points += points_awarded
	playsound(src, 'sound/machines/chime.ogg', 30, 1)
/obj/item/computermath/default
	name = "Unassigned Problem Computer"
	desc = "This Problem Computer has not been assigned yet. Earn points by solving math problems."
	icon_state = "defaulttab"
	var/static/radial_cargo = image(icon = 'modular_skyrat/modules/computermath/icons/computermath.dmi', icon_state = "cargotab")
	var/static/radial_science = image(icon = 'modular_skyrat/modules/computermath/icons/computermath.dmi', icon_state = "sciencetab")
	var/static/list/radial_options = list("cargo" = radial_cargo, "science" = radial_science)
/obj/item/computermath/default/attack_self(mob/user)
	var/choice = show_radial_menu(user, src, radial_options)
	switch(choice)
		if("cargo")
			var/obj/item/computermath/cargo/CT = new /obj/item/computermath/cargo(drop_location())
			qdel(src)
			user.put_in_active_hand(CT)
		if("science")
			var/obj/item/computermath/science/ST = new /obj/item/computermath/science(drop_location())
			qdel(src)
			user.put_in_active_hand(ST)

/obj/item/computermath/cargo
	name = "Cargo Problem Computer"
	desc = "Earn points by solving math problems."
	icon_state = "cargotab"
/obj/item/computermath/cargo/attack_self(mob/user)
	give_question(user, "Cargo")

/obj/item/computermath/cargo/process()
	var/old_charge_count = charge_count
	charge_count = SSshuttle.problem_computer_charges
	if(charge_count > old_charge_count)
		say("A new problem solving opportunity has become available! There are now [charge_count] problems to be solved.")

/obj/item/computermath/cargo/check_charges()
	if(SSshuttle.problem_computer_charges > 0)
		return TRUE
	..()

/obj/item/computermath/cargo/consume_charges()
	if(SSresearch.problem_computer_charges > 0)
		SSshuttle.problem_computer_charges -= 1
		return TRUE
	..()

/obj/item/computermath/science
	name = "Science Problem Computer"
	desc = "Earn points by solving math problems."
	icon_state = "sciencetab"

/obj/item/computermath/science/process()
	var/old_charge_count = charge_count
	charge_count = SSresearch.problem_computer_charges
	if(charge_count > old_charge_count)
		say("A new problem solving opportunity has become available! There are now [charge_count] problems to be solved.")

/obj/item/computermath/science/check_charges()
	if(SSresearch.problem_computer_charges > 0)
		return TRUE
	..()

/obj/item/computermath/science/consume_charges()
	if(SSresearch.problem_computer_charges > 0)
		SSresearch.problem_computer_charges -= 1
		return TRUE
	..()

/obj/item/computermath/science/attack_self(mob/user)
	give_question(user, "Science")