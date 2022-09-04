/datum/brain_trauma/special/laser_pointer
	name = "Laser"
	desc = "Patient seems to be a feline."
	scan_desc = "feline mind"
	gain_text = "<span class='warning'>LIGHT.</span>"
	lose_text = "<span class='notice'>Where'd that light go?</span>"
	random_gain = FALSE
	/// The laser hallucination we're chasing
	var/obj/effect/hallucination/simple/laser_pointer/laser
	/// How likely we are to hallucinate on_life(). Runs twice.
	var/hallucination_chance = 15
	/// How far away from the owner the laser can spawn
	var/spawn_range = 1
	/// How likely the owner is to pounce at the light
	var/pounce_chance = 50
	/// How long the owner's pounce knocks them down
	var/knockdown_time = 1 SECONDS
	/// How much stamina the owner's pounce uses
	var/stamina_usage = 25

/datum/brain_trauma/special/laser_pointer/on_lose()
	QDEL_NULL(laser)
	..()

/*
*	create_light handles the main "gimmick" of the trauma, if they're cat-like
*	It creates a hallucination of a light around the owner which they have a chance to pounce at
*/
/datum/brain_trauma/special/laser_pointer/proc/create_light()
	if(owner.incapacitated() || owner.is_blind())
		return
	// Creating the light
	var/turf/target_turf = locate(owner.x + pick(spawn_range, -spawn_range), owner.y + pick(spawn_range, -spawn_range), owner.z)
	laser = new(target_turf, owner)
	QDEL_IN(laser, 1 SECONDS)
	owner.setDir(get_dir(owner, target_turf)) // Always look

	// Pouncing
	if(!owner.body_position == STANDING_UP)
		return
	if(prob(pounce_chance)) // Do we pounce at the hallucination?
		owner.visible_message(span_warning("[owner] pounces at nothing!"), span_userdanger("LIGHT!"))
		owner.Knockdown(knockdown_time, ignore_canstun = TRUE)
		owner.adjustStaminaLoss(stamina_usage)
		owner.throw_at(target_turf, range = 1, speed = 1, thrower = owner, spin = FALSE)
	else
		owner.visible_message(span_notice("[owner] suddenly becomes fixated on the floor."), span_warning("You're briefly tempted by the shiny light..."))

/datum/brain_trauma/special/laser_pointer/on_life()
	if(QDELETED(laser) || !laser.loc || laser.z != owner.z)
		QDEL_NULL(laser)
		if(prob(hallucination_chance))
			create_light()
		else if(prob(hallucination_chance))
			var/turf/squeaking_turf = locate(owner.x + rand(-10, 10), owner.y + rand(-10, 10), owner.z)
			owner.playsound_local(squeaking_turf, 'sound/effects/mousesqueek.ogg', 20)
	..()

/obj/effect/hallucination/simple/laser_pointer
	name = "laser"
	desc = "LIGHT."
	image_icon = 'icons/obj/weapons/guns/projectiles.dmi'
	image_state = "red_laser"

/obj/effect/hallucination/simple/laser_pointer/Initialize(mapload)
	. = ..()
	image_state = pick("red_laser", "blue_laser", "green_laser", "purple_laser")
	pixel_x = rand(-5,5)
	pixel_y = rand(-5,5)
