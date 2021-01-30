/mob/living/silicon/robot/modules/roleplay
    lawupdate = FALSE
    scrambledcodes = TRUE // Roleplay borgs aren't real
    set_module = /obj/item/robot_module/roleplay

/mob/living/silicon/robot/modules/roleplay/Initialize()
    . = ..()
    cell = new /obj/item/stock_parts/cell/infinite(src, 30000)
    laws = new /datum/ai_laws/roleplay()
    //This part is because the camera stays in the list, so we'll just do a check
    if(!QDELETED(builtInCamera))
        QDEL_NULL(builtInCamera)

/mob/living/silicon/robot/modules/roleplay/create_modularInterface()
	if(!modularInterface)
		modularInterface = new /obj/item/modular_computer/tablet/arrpeeborg(src)
	return ..()

/mob/living/silicon/robot/modules/roleplay/binarycheck()
    return 0 //Roleplay borgs aren't truly borgs

//LAWS//

/datum/ai_laws/roleplay
    name = "Roleplay"
    id = "roleplay"
    zeroth = "Roleplay as you'd like!"
    inherent = list()

//MODULAR TABLET//

/obj/item/modular_computer/tablet/arrpeeborg
	name = "modular interface"
	icon_state = "tablet-silicon"
	has_light = FALSE //tablet light button actually enables/disables the borg lamp
	comp_light_luminosity = 0
	has_variants = FALSE
	var/mob/living/silicon/robot/borgo
	var/list/borglog = list()
	var/datum/computer_file/program/robotact/robotact

/obj/item/modular_computer/tablet/arrpeeborg/Initialize()
	. = ..()
	install_component(new /obj/item/computer_hardware/processor_unit/small)
	install_component(new /obj/item/computer_hardware/hard_drive/small/integrated)
	install_component(new /obj/item/computer_hardware/recharger/cyborg)
	install_component(new /obj/item/computer_hardware/network_card/integrated)


/obj/item/modular_computer/tablet/arrpeeborg/Initialize(mapload)
	. = ..()
	vis_flags |= VIS_INHERIT_ID
	borgo = loc
	if(!istype(borgo))
		borgo = null
		stack_trace("[type] initialized outside of a borg, deleting.")
		return INITIALIZE_HINT_QDEL

/obj/item/modular_computer/tablet/arrpeeborg/Destroy()
	borgo = null
	return ..()

/obj/item/modular_computer/tablet/arrpeeborg/turn_on(mob/user)
	if(borgo?.stat != DEAD)
		return ..()
	return FALSE

/obj/item/modular_computer/tablet/arrpeeborg/ui_data(mob/user)
	. = ..()
	.["has_light"] = TRUE
	.["light_on"] = borgo?.lamp_enabled
	.["comp_light_color"] = borgo?.lamp_color

/obj/item/modular_computer/tablet/arrpeeborg/toggle_flashlight()
	if(!borgo || QDELETED(borgo))
		return FALSE
	borgo.toggle_headlamp()
	return TRUE

//Makes the flashlight color setting affect the borg rather than the tablet
/obj/item/modular_computer/tablet/arrpeeborg/set_flashlight_color(color)
	if(!borgo || QDELETED(borgo) || !color)
		return FALSE
	borgo.lamp_color = color
	borgo.toggle_headlamp(FALSE, TRUE)
	return TRUE

/obj/item/modular_computer/tablet/arrpeeborg/alert_call(datum/computer_file/program/caller, alerttext, sound = 'sound/machines/twobeep_high.ogg')
	if(!caller || !caller.alert_able || caller.alert_silenced || !alerttext) //Yeah, we're checking alert_able. No, you don't get to make alerts that the user can't silence.
		return
	borgo.playsound_local(src, sound, 50, TRUE)
	to_chat(borgo, "<span class='notice'>The [src] displays a [caller.filedesc] notification: [alerttext]</span>")

/obj/item/modular_computer/tablet/arrpeeborg/proc/get_robotact()
	if(!borgo)
		return null
	if(!robotact)
		var/obj/item/computer_hardware/hard_drive/hard_drive = all_components[MC_HDD]
		robotact = hard_drive.find_file_by_name("robotact")
		if(!robotact)
			stack_trace("Cyborg [borgo] ( [borgo.type] ) was somehow missing their self-manage app in their tablet. A new copy has been created.")
			robotact = new(hard_drive)
			if(!hard_drive.store_file(robotact))
				qdel(robotact)
				robotact = null
				CRASH("Cyborg [borgo]'s tablet hard drive rejected recieving a new copy of the self-manage app. To fix, check the hard drive's space remaining. Please make a bug report about this.")
	return robotact

//BORG MODULES//
/obj/item/robot_module/roleplay
	name = "Roleplay"
	basic_modules = list(
		/obj/item/assembly/flash/cyborg,
		/obj/item/extinguisher/mini,
		/obj/item/weldingtool/largetank/cyborg,
		/obj/item/screwdriver/cyborg,
		/obj/item/wrench/cyborg,
		/obj/item/crowbar/cyborg,
		/obj/item/wirecutters/cyborg,
		/obj/item/multitool/cyborg,
		/obj/item/stack/sheet/metal,
		/obj/item/stack/sheet/glass,
		/obj/item/stack/sheet/rglass/cyborg,
		/obj/item/stack/rods/cyborg,
		/obj/item/stack/tile/plasteel,
		/obj/item/stack/cable_coil,
		/obj/item/restraints/handcuffs/cable/zipties,
		/obj/item/rsf/cyborg,
		/obj/item/reagent_containers/food/drinks/drinkingglass,
		/obj/item/reagent_containers/borghypo/borgshaker,
		/obj/item/soap/nanotrasen,
		/obj/item/borg/cyborghug,
		/obj/item/dogborg_nose,
		/obj/item/dogborg_tongue,
		/obj/item/borg_shapeshifter)
	moduleselect_icon = "standard"
	hat_offset = -3
