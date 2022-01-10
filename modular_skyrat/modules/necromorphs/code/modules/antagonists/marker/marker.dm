/*
	The marker needs to be able to be placed as a structure or item, and triggered.
	They dont activate instantly. Ideally, there should be a "Trigger Verb" for admins
	And a trigger requirement for the structure by default.

	The marker can also be spawned through a marker shard, which will innately spread
	corruption if sitting still for too long. Not to the level of a active master,
	but minor corruption levels. The shard will also resist all attempts at destroying
	it actively including being placed in disposals.

	**
	All of this code needs to be refactor and overhauled, it is very piecemeal. And does not require the same
	amount of variation support that the blob inherently had. Ideally I want to split the "Corruption" into its own
	file for updating and tracking.

	At the moment it utilizes simple mobs for spawning, this will need to be removed and replaced with various defensive
	structures that they posses.
	**


	**
	MARKER POINTS:
	Need to be renamed to BIOMASS as that is the resource that the marker utilizes.
	**
*/


/datum/antagonist/marker
	name = "\improper Marker"
	roundend_category = "markers"
	antagpanel_category = "Biohazards"
	show_to_ghosts = TRUE
//	job_rank = ROLE_NECROMPROH

	var/datum/action/innate/markerpop/pop_action
	var/starting_points_human_marker = MASTER_STARTING_POINTS

/datum/antagonist/marker/roundend_report()
	var/basic_report = ..()
	//Display max markerpoints for blebs that lost
	if(ismaster(owner.current)) //embarrasing if not
		var/mob/camera/marker/master = owner.current
		if(!master.victory_in_progress) //if it won this doesn't really matter
			var/point_report = "<br><b>[owner.name]</b> took over [master.max_count] tiles at the height of its growth."
			return basic_report+point_report
	return basic_report

/datum/antagonist/marker/greet()
	if(!ismaster(owner.current))
		to_chat(owner,span_userdanger("You feel bloated."))

/datum/antagonist/marker/on_gain()
	create_objectives()
	. = ..()

/datum/antagonist/marker/remove_innate_effects()
	QDEL_NULL(pop_action)
	return ..()


/*

TODO: NEEDS TO BE UPDATED WITH PROPER ICONS

*/
/datum/antagonist/marker/get_preview_icon()
	var/icon/icon = icon('icons/mob/blob.dmi', "blob_core")
	icon.Blend(icon('icons/mob/blob.dmi', "blob_core_overlay"), ICON_OVERLAY)
	icon.Scale(ANTAGONIST_PREVIEW_ICON_SIZE, ANTAGONIST_PREVIEW_ICON_SIZE)

	return icon

/datum/antagonist/marker/proc/create_objectives()
	var/datum/objective/marker_takeover/main = new
	main.owner = owner
	objectives += main


/datum/antagonist/marker/apply_innate_effects(mob/living/mob_override)
	if(!ismaster(owner.current))
		if(!pop_action)
			pop_action = new
		pop_action.Grant(owner.current)

/datum/objective/marker_takeover
	explanation_text = "Reach critical mass!"


/*
	TODO: FIX ICON
	TODO: ENSURE QDEL
	TODO: FIX AUTOMATIC PLACEMENT TRIGGERING
	Infection ability to start marker.
	Non-masters get this on blob antag assignment
*/
/datum/action/innate/markerpop
	name = "Pop"
	desc = "Unleash the marker"
	icon_icon = 'icons/mob/blob.dmi'
	button_icon_state = "blob_core"

	/// The time taken before this ability is automatically activated.
	var/autoplace_time = MASTER_STARTING_AUTO_PLACE_TIME


/datum/action/innate/markerpop/Grant(Target)
	. = ..()
	if(owner)
		addtimer(CALLBACK(src, .proc/Activate, TRUE), autoplace_time, TIMER_UNIQUE|TIMER_OVERRIDE)
		to_chat(owner, "<span class='big'><font color=\"#EE4000\">You will automatically pop and place your blob core in [DisplayTimeText(autoplace_time)].</font></span>")

/datum/action/innate/markerpop/Activate(timer_activated = FALSE)
	var/mob/living/old_body = owner
	if(!owner)
		return

	var/datum/antagonist/marker/markertag = owner.mind.has_antag_datum(/datum/antagonist/marker)
	if(!markertag)
		Remove(owner)
		return

	. = TRUE
	var/turf/target_turf = get_turf(owner)
	if(target_turf.density)
		to_chat(owner, "<span class='warning'>This spot is too dense to place a marker core on!</span>")
		. = FALSE
	var/area/target_area = get_area(target_turf)
	if(isspaceturf(target_turf) || !(target_area?.area_flags & BLOBS_ALLOWED) || !is_station_level(target_turf.z))
		to_chat(owner, "<span class='warning'>You cannot place your core here!</span>")
		. = FALSE

	var/placement_override = BLOB_FORCE_PLACEMENT
	if(!.)
		if(!timer_activated)
			return
		placement_override = BLOB_RANDOM_PLACEMENT
		to_chat(owner, "<span class='boldwarning'>Because your current location is an invalid starting spot and you need to pop, you've been moved to a random location!</span>")

	var/mob/camera/marker/marker_cam = new /mob/camera/marker(get_turf(old_body), markertag.starting_points_human_marker)
	owner.mind.transfer_to(marker_cam)
	old_body.gib()
	marker_cam.place_marker_core(placement_override, pop_override = TRUE)
	playsound(get_turf(marker_cam), 'sound/ambience/antag/blobalert.ogg', 50, FALSE)


/datum/antagonist/marker/antag_listing_status()
	. = ..()
	if(owner?.current)
		var/mob/camera/marker/B = owner.current
		if(istype(B))
			. += "(Progress: [B.markers_legit.len]/[B.markerwincount])"


/*

	TODO: ADD UNITOLOGY
	TODO: ADD MARKER SHARD

*/

///datum/antagonist/marker/infection
	//job_rank = ROLE_BLOB_INFECTION

