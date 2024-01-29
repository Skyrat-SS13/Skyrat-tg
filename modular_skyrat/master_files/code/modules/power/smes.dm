// the SMES
// stores power

#define SMESRATE 0.05 // rate of internal charge to external power

//Cache defines
#define SMES_CLEVEL_1 1
#define SMES_CLEVEL_2 2
#define SMES_CLEVEL_3 3
#define SMES_CLEVEL_4 4
#define SMES_CLEVEL_5 5
#define SMES_OUTPUTTING 6
#define SMES_NOT_OUTPUTTING 7
#define SMES_INPUTTING 8
#define SMES_INPUT_ATTEMPT 9

#define SMESEMPTIME 20 SECONDS // the time it takes for the SMES to go back to normal operation when emped




/obj/machinery/power/smes
	icon = 'modular_skyrat/master_files/icons/obj/machines/power/smes.dmi'

	var/emp_timer = TIMER_ID_NULL
	/// checks if SMES was EMPED OR NO, purerly cosmetic
	var/is_emped = FALSE


/obj/machinery/power/smes/attackby(obj/item/I, mob/user, params)
	//opening using screwdriver
	if(default_deconstruction_screwdriver(user, icon_state, icon_state, I))
		update_icon()
		return

/obj/machinery/power/smes/emp_act(severity)
	. = ..()
	if(. & EMP_PROTECT_SELF)
		return
	emp_timer = addtimer(CALLBACK(src, .proc/emp_end, output_attempt), SMESEMPTIME, TIMER_UNIQUE | TIMER_OVERRIDE)
	is_emped = TRUE
	input_attempt = rand(0,1)
	inputting = input_attempt
	output_attempt = rand(0,1)
	outputting = output_attempt
	output_level = rand(0, output_level_max)
	input_level = rand(0, input_level_max)
	charge -= 1e6/severity
	if (charge < 0)
		charge = 0
	update_appearance()
	log_smes()

/obj/machinery/power/smes/update_overlays()
	. = ..()
	SSvis_overlays.remove_vis_overlay(src, managed_vis_overlays)

	if(panel_open)
		. += "panel"
		return

	if(machine_stat & BROKEN)
		return

	var/clevel = chargedisplay()
	if(clevel>0)
		. += "charge[clevel]"
		SSvis_overlays.add_vis_overlay(src, icon, "charge[clevel]", layer, plane, dir)
		SSvis_overlays.add_vis_overlay(src, icon, "charge[clevel]", layer, EMISSIVE_PLANE, dir)
	if(is_emped)
		. += "emp"
		SSvis_overlays.add_vis_overlay(src, icon, "emp", layer, plane, dir)
		SSvis_overlays.add_vis_overlay(src, icon, "emp", layer, EMISSIVE_PLANE, dir)
	else
		if(inputting)
			if(clevel == SMES_CLEVEL_5)
				. += "input-2"
				SSvis_overlays.add_vis_overlay(src, icon, "input-2", layer, plane, dir)
				SSvis_overlays.add_vis_overlay(src, icon, "input-2", layer, EMISSIVE_PLANE, dir)
			else
				. += "input-1"
				SSvis_overlays.add_vis_overlay(src, icon, "input-1", layer, plane, dir)
				SSvis_overlays.add_vis_overlay(src, icon, "input-1", layer, EMISSIVE_PLANE, dir)
		else if(input_attempt)
			. += "input-0"
			SSvis_overlays.add_vis_overlay(src, icon, "input-0", layer, plane, dir)
			SSvis_overlays.add_vis_overlay(src, icon, "input-0", layer, EMISSIVE_PLANE, dir)
		else
			. += "input-off"
			SSvis_overlays.add_vis_overlay(src, icon, "input-off", layer, plane, dir)
			SSvis_overlays.add_vis_overlay(src, icon, "input-off", layer, EMISSIVE_PLANE, dir)

		if(outputting)
			if(clevel == SMES_CLEVEL_5)
				. += "output2"
				SSvis_overlays.add_vis_overlay(src, icon, "output2", layer, plane, dir)
				SSvis_overlays.add_vis_overlay(src, icon, "output2", layer, EMISSIVE_PLANE, dir)
			else
				. += "output1"
				SSvis_overlays.add_vis_overlay(src, icon, "output1", layer, plane, dir)
				SSvis_overlays.add_vis_overlay(src, icon, "output1", layer, EMISSIVE_PLANE, dir)
		else
			. += "output0"
			SSvis_overlays.add_vis_overlay(src, icon, "output0", layer, plane, dir)
			SSvis_overlays.add_vis_overlay(src, icon, "output0", layer, EMISSIVE_PLANE, dir)



/obj/machinery/power/smes/proc/emp_end() //used to check if SMES was EMPED
	is_emped = FALSE
	update_icon()
	log_smes()





#undef SMESRATE

#undef SMES_CLEVEL_1
#undef SMES_CLEVEL_2
#undef SMES_CLEVEL_3
#undef SMES_CLEVEL_4
#undef SMES_CLEVEL_5
#undef SMES_OUTPUTTING
#undef SMES_NOT_OUTPUTTING
#undef SMES_INPUTTING
#undef SMES_INPUT_ATTEMPT
