/obj/machinery/computer/station_goal
	name = "station goal console"
	desc = "A console used for setting the stations goal."
	icon_screen = "comm"
	icon_keyboard = "tech_key"
	req_access = list(ACCESS_CENT_CAPTAIN)
	circuit = /obj/item/circuitboard/computer/station_goal
	light_color = LIGHT_COLOR_BLUE

	var/list/station_goal_cache = list()

	var/goal_assigned = FALSE

/obj/item/circuitboard/computer/station_goal
	name = "Station Goal (Computer Board)"
	greyscale_colors = CIRCUIT_COLOR_ENGINEERING
	build_path = /obj/machinery/computer/station_goal

/obj/machinery/computer/station_goal/Initialize()
	. = ..()
	station_goal_cache = subtypesof(/datum/station_goal)

/obj/machinery/computer/station_goal/ui_interact(mob/user)
	. = ..()
	var/list/dat = list("<b>STATION GOAL SELECTION - OFFICIAL USE ONLY</b>")
	if(!goal_assigned)
		dat += "Please select ONE goal to assign to [station_name()]"
		for(var/datum/station_goal/iterating_goal as anything in station_goal_cache)
			dat += "<b><a href='byond://?src=[REF(src)];selected_goal=[initial(iterating_goal.name)]'>[initial(iterating_goal.name)]</a></b>"

		dat += "Once you select a goal, it will be assigned to the station."
	else
		dat += "<b>GOAL HAS BEEN ASSIGNED.</b>"

	var/datum/browser/popup = new(user, "station_goals","Station Goals", 400, 400, src)
	popup.set_content(dat.Join("<br>"))
	popup.open()
	onclose(user, "station_goals")

/obj/machinery/computer/station_goal/Topic(href, href_list)
	if(..())
		return

	if(goal_assigned)
		return

	if(machine_stat & (NOPOWER|BROKEN|MAINT))
		return

	usr.set_machine(src)

	var/selected_goal = href_list["selected_goal"]

	if(href_list["close"])
		usr << browse(null, "window=station_goals")
		return

	for(var/datum/station_goal/iterating_goal as anything in station_goal_cache)
		if(initial(iterating_goal.name) == selected_goal)
			var/datum/station_goal/goal_to_set = new iterating_goal()
			goal_to_set.send_report()
			GLOB.station_goals += goal_to_set
			goal_assigned = TRUE
			break
	updateUsrDialog()
