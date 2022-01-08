/datum/antagonist/marker
	name = "Marker"
	roundend_category = "markers"
	antagpanel_category = "Biohazards"
	show_to_ghosts = TRUE
//	job_rank = ROLE_NECROMPROH

	var/datum/action/innate/markerpop/pop_action
	var/starting_points_human_marker = OVERMIND_STARTING_POINTS

/datum/antagonist/marker/roundend_report()
	var/basic_report = ..()
	//Display max markerpoints for blebs that lost
	if(isovermind(owner.current)) //embarrasing if not
		var/mob/camera/marker/overmind = owner.current
		if(!overmind.victory_in_progress) //if it won this doesn't really matter
			var/point_report = "<br><b>[owner.name]</b> took over [overmind.max_count] tiles at the height of its growth."
			return basic_report+point_report
	return basic_report

/datum/antagonist/marker/greet()
	if(!isovermind(owner.current))
		to_chat(owner,span_userdanger("You feel bloated."))

/datum/antagonist/marker/on_gain()
	create_objectives()
	. = ..()

/datum/antagonist/marker/proc/create_objectives()
	var/datum/objective/marker_takeover/main = new
	main.owner = owner
	objectives += main

/datum/antagonist/marker/apply_innate_effects(mob/living/mob_override)
	if(!isovermind(owner.current))
		if(!pop_action)
			pop_action = new
		pop_action.Grant(owner.current)

/datum/objective/marker_takeover
	explanation_text = "Reach critical mass!"

//Non-overminds get this on marker antag assignment
/datum/action/innate/markerpop
	name = "Pop"
	desc = "Unleash the marker"
	icon_icon = 'modular_skyrat/modules/necromorphs/icons/obj/marker_normal.dmi' // TEMPORARY
	button_icon_state = "marker_normal_active"

/datum/action/innate/markerpop/Activate()
	var/mob/living/old_body = owner
	var/datum/antagonist/marker/markertag = owner.mind.has_antag_datum(/datum/antagonist/marker)
	if(!markertag)
		Remove()
		return
	var/mob/camera/marker/B = new /mob/camera/marker(get_turf(old_body), markertag.starting_points_human_marker)
	owner.mind.transfer_to(B)
	old_body.gib()
	B.place_marker_core(placement_override = TRUE, pop_override = TRUE)


/datum/antagonist/marker/antag_listing_status()
	. = ..()
	if(owner?.current)
		var/mob/camera/marker/B = owner.current
		if(istype(B))
			. += "(Progress: [B.markers_legit.len]/[B.markerwincount])"

/datum/antagonist/marker/antag_listing_status()
	. = ..()
	if(owner?.current)
		var/mob/camera/marker/B = owner.current
		if(istype(B))
			. += "(Progress: N/A"
