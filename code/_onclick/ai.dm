/*
	AI ClickOn()

	The AI can double click to move the camera (this was already true but is cleaner),
	or double click a mob to track them.

	Note that AI have no need for the adjacency proc, and so this proc is a lot cleaner.
*/
/mob/living/silicon/ai/DblClickOn(atom/A, params)
	if(control_disabled || incapacitated())
		return

	if(ismob(A))
		ai_actual_track(A)
	else
		A.move_camera_by_click()

/mob/living/silicon/ai/ClickOn(atom/A, params)
	if(world.time <= next_click)
		return
	next_click = world.time + 1

	if(!can_interact_with(A))
		return

	if(multicam_on)
		var/turf/T = get_turf(A)
		if(T)
			for(var/obj/screen/movable/pic_in_pic/ai/P in T.vis_locs)
				if(P.ai == src)
					P.Click(params)
					break

	if(check_click_intercept(params,A))
		return

	if(control_disabled || incapacitated())
		return

	var/turf/pixel_turf = get_turf_pixel(A)
	if(isnull(pixel_turf))
		return
	if(!can_see(A))
		if(isturf(A)) //On unmodified clients clicking the static overlay clicks the turf underneath
			return //So there's no point messaging admins
		message_admins("[ADMIN_LOOKUPFLW(src)] might be running a modified client! (failed can_see on AI click of [A] (Turf Loc: [ADMIN_VERBOSEJMP(pixel_turf)]))")
		var/message = "[key_name(src)] might be running a modified client! (failed can_see on AI click of [A] (Turf Loc: [AREACOORD(pixel_turf)]))"
		log_admin(message)
		if(REALTIMEOFDAY >= chnotify + 9000)
			chnotify = REALTIMEOFDAY
			send2tgs_adminless_only("NOCHEAT", message)
		return

	var/list/modifiers = params2list(params)
	if(modifiers["shift"] && modifiers["ctrl"])
		CtrlShiftClickOn(A)
		return
	if(modifiers["shift"])
		ShiftClickOn(A)
		return
	if(modifiers["alt"]) // alt and alt-gr (rightalt)
		AltClickOn(A)
		return
	if(modifiers["ctrl"])
		CtrlClickOn(A)
		return

	if(world.time <= next_move)
		return

	if(aicamera.in_camera_mode)
		aicamera.camera_mode_off()
		aicamera.captureimage(pixel_turf, usr)
		return
	if(waypoint_mode)
		waypoint_mode = 0
		set_waypoint(A)
		return

	A.attack_ai(src)
	
	if(isturf(A)&&(!modifiers["shift"]))  //Skyrat edit , interact with firelocks by clicking on their turf .It has to check for the modifier because it would close firelock over doors when shift-clicking a turf.
		var/obj/machinery/door/firedoor/TheDoor = locate(/obj/machinery/door/firedoor) in A
		if(TheDoor)
			TheDoor.attack_ai(usr) //Skyrat edit end
/*
	AI has no need for the UnarmedAttack() and RangedAttack() procs,
	because the AI code is not generic;	attack_ai() is used instead.
	The below is only really for safety, or you can alter the way
	it functions and re-insert it above.
*/
/mob/living/silicon/ai/UnarmedAttack(atom/A)
	A.attack_ai(src)
/mob/living/silicon/ai/RangedAttack(atom/A)
	A.attack_ai(src)

/atom/proc/attack_ai(mob/user)
	return

/*
	Since the AI handles shift, ctrl, and alt-click differently
	than anything else in the game, atoms have separate procs
	for AI shift, ctrl, and alt clicking.
*/

/mob/living/silicon/ai/CtrlShiftClickOn(atom/A)
	if(isturf(A)) // Skyrat edit
		var/obj/machinery/door/airlock/airlock = locate(/obj/machinery/door/airlock) in A
		if(airlock)
			airlock.AICtrlShiftClick(src)
	else
		A.AICtrlShiftClick(src) // End of skyrat edit
/mob/living/silicon/ai/ShiftClickOn(atom/A)
	if(isturf(A)) // Skyrat edit
		var/obj/machinery/door/airlock/airlock = locate(/obj/machinery/door/airlock) in A
		if(airlock)
			airlock.AIShiftClick(src)
	else
		A.AIShiftClick(src)
		A.AIExamine(A) // End of Skyrat edit
/mob/living/silicon/ai/CtrlClickOn(atom/A)
	if(isturf(A)) // Skyrat edit
		var/obj/machinery/door/airlock/airlock = locate(/obj/machinery/door/airlock) in A
		if(airlock)
			airlock.AICtrlClick(src)
	else
		A.AICtrlClick(src)
/mob/living/silicon/ai/AltClickOn(atom/A)
	if(isturf(A)) // Skyrat edit
		var/obj/machinery/door/airlock/airlock = locate(/obj/machinery/door/airlock) in A
		if(airlock)
			airlock.AIAltClick(src)
	else
		A.AIAltClick(src) // End of Skyrat edit
/*
	The following criminally helpful code is just the previous code cleaned up;
	I have no idea why it was in atoms.dm instead of respective files.
*/
/* Questions: Instead of an Emag check on every function, can we not add to airlocks onclick if emag return? */

/* Atom Procs */
/atom/proc/AICtrlClick()
	return
/atom/proc/AIAltClick(mob/living/silicon/ai/user)
	AltClick(user)
	return
/atom/proc/AIShiftClick()
	return
/atom/proc/AICtrlShiftClick()
	return
/atom/proc/AIExamine() // Skyrat edit , new proc. Used to prevent airlocks from returning a examine test.Could be used in the future to add AI specific examines.
	usr.examinate(src) // End of skyrat edit
/* Airlocks */
/obj/machinery/door/airlock/AICtrlClick() // Bolts doors
	if(obj_flags & EMAGGED)
		return

	toggle_bolt(usr)
	add_hiddenprint(usr)

/obj/machinery/door/airlock/AIAltClick() // Eletrifies doors.
	if(obj_flags & EMAGGED)
		return

	if(!secondsElectrified)
		shock_perm(usr)
	else
		shock_restore(usr)

/obj/machinery/door/airlock/AIShiftClick()  // Opens and closes doors!
	if(obj_flags & EMAGGED)
		return

	user_toggle_open(usr)
	add_hiddenprint(usr)
	
/obj/machinery/door/airlock/AIExamine() //Skyrat edit , Lets not spam the AI with door examinations
	return // End of skyrat edit

/obj/machinery/door/airlock/AICtrlShiftClick()  // Sets/Unsets Emergency Access Override
	if(obj_flags & EMAGGED)
		return

	toggle_emergency(usr)
	add_hiddenprint(usr)

/* APC */
/obj/machinery/power/apc/AICtrlClick() // turns off/on APCs.
	if(can_use(usr, 1))
		toggle_breaker(usr)

/* AI Turrets */
/obj/machinery/turretid/AIAltClick() //toggles lethal on turrets
	if(ailock)
		return
	toggle_lethal(usr)

/obj/machinery/turretid/AICtrlClick() //turns off/on Turrets
	if(ailock)
		return
	toggle_on(usr)

/* Holopads */
/obj/machinery/holopad/AIAltClick(mob/living/silicon/ai/user)
	hangup_all_calls()
	add_hiddenprint(usr)

//
// Override TurfAdjacent for AltClicking
//

/mob/living/silicon/ai/TurfAdjacent(turf/T)
	return (GLOB.cameranet && GLOB.cameranet.checkTurfVis(T))
