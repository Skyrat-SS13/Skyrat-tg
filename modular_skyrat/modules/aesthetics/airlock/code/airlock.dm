/obj/machinery/door/airlock
	doorOpen = 'modular_skyrat/modules/aesthetics/airlock/sound/open.ogg'
	doorClose = 'modular_skyrat/modules/aesthetics/airlock/sound/close.ogg'
	boltUp = 'modular_skyrat/modules/aesthetics/airlock/sound/bolts_up.ogg'
	boltDown = 'modular_skyrat/modules/aesthetics/airlock/sound/bolts_down.ogg'
	var/forcedOpen = 'modular_skyrat/modules/aesthetics/airlock/sound/open_force.ogg' //Come on guys, why aren't all the sound files like this.
	var/forcedClosed = 'modular_skyrat/modules/aesthetics/airlock/sound/close_force.ogg'

	/// For those airlocks you might want to have varying "fillings" for, without having to
	/// have an icon file per door with a different filling.
	var/fill_state_suffix = null
	/// For the airlocks that use a greyscale accent door color, set this color to the accent color you want it to be.
	var/greyscale_accent_color = null
	/// Does this airlock emit a light?
	var/has_environment_lights = TRUE
	/// Is this door external? E.g. does it lead to space? Shuttle docking systems bolt doors with this flag.
	var/external = FALSE

/obj/machinery/door/airlock/external
	external = TRUE

/obj/machinery/door/airlock/shuttle
	external = TRUE

/obj/machinery/door/airlock/power_change()
	..()
	update_icon()

/obj/machinery/door/airlock/update_overlays()
	. = ..()
	var/frame_state
	var/light_state = AIRLOCK_LIGHT_POWERON
	var/pre_light_color
	switch(airlock_state)
		if(AIRLOCK_CLOSED)
			frame_state = AIRLOCK_FRAME_CLOSED
			if(locked)
				light_state = AIRLOCK_LIGHT_BOLTS
				pre_light_color = AIRLOCK_BOLTS_LIGHT_COLOR
			else if(emergency)
				light_state = AIRLOCK_LIGHT_EMERGENCY
				pre_light_color = AIRLOCK_EMERGENCY_LIGHT_COLOR
			else if(fire_active)
				light_state = AIRLOCK_LIGHT_FIRE
				pre_light_color = AIRLOCK_FIRE_LIGHT_COLOR
			else if(engineering_override)
				light_state = AIRLOCK_LIGHT_ENGINEERING
				pre_light_color = AIRLOCK_ENGINEERING_LIGHT_COLOR
			else
				pre_light_color = AIRLOCK_POWERON_LIGHT_COLOR
		if(AIRLOCK_DENY)
			frame_state = AIRLOCK_FRAME_CLOSED
			light_state = AIRLOCK_LIGHT_DENIED
			pre_light_color = AIRLOCK_DENY_LIGHT_COLOR
		if(AIRLOCK_EMAG)
			frame_state = AIRLOCK_FRAME_CLOSED
		if(AIRLOCK_CLOSING)
			frame_state = AIRLOCK_FRAME_CLOSING
			light_state = AIRLOCK_LIGHT_CLOSING
			pre_light_color = AIRLOCK_ACCESS_LIGHT_COLOR
		if(AIRLOCK_OPEN)
			frame_state = AIRLOCK_FRAME_OPEN
			if(locked)
				light_state = AIRLOCK_LIGHT_BOLTS
				pre_light_color = AIRLOCK_BOLTS_LIGHT_COLOR
			else if(emergency)
				light_state = AIRLOCK_LIGHT_EMERGENCY
				pre_light_color = AIRLOCK_EMERGENCY_LIGHT_COLOR
			else if(fire_active)
				light_state = AIRLOCK_LIGHT_FIRE
				pre_light_color = AIRLOCK_FIRE_LIGHT_COLOR
			else if(engineering_override)
				light_state = AIRLOCK_LIGHT_ENGINEERING
				pre_light_color = AIRLOCK_ENGINEERING_LIGHT_COLOR
			else
				pre_light_color = AIRLOCK_POWERON_LIGHT_COLOR
			light_state += "_open"
		if(AIRLOCK_OPENING)
			frame_state = AIRLOCK_FRAME_OPENING
			light_state = AIRLOCK_LIGHT_OPENING
			pre_light_color = AIRLOCK_ACCESS_LIGHT_COLOR

	. += get_airlock_overlay(frame_state, icon, src, em_block = TRUE)
	if(airlock_material)
		. += get_airlock_overlay("[airlock_material]_[frame_state]", overlays_file, src, em_block = TRUE)
	else
		. += get_airlock_overlay("fill_[frame_state + fill_state_suffix]", icon, src, em_block = TRUE)

	if(lights && hasPower() && has_environment_lights)
		. += get_airlock_overlay("lights_[light_state]", overlays_file, src, em_block = FALSE)
		. += emissive_appearance(overlays_file, "lights_[light_state]", src, alpha = src.alpha)

		if(multi_tile && filler)
			filler.set_light(l_range = AIRLOCK_LIGHT_RANGE, l_power = AIRLOCK_LIGHT_POWER, l_color = pre_light_color, l_on = TRUE)

		set_light(l_range = AIRLOCK_LIGHT_RANGE, l_power = AIRLOCK_LIGHT_POWER, l_color = pre_light_color, l_on = TRUE)
	else
		set_light(l_on = FALSE)

	if(greyscale_accent_color)
		. += get_airlock_overlay("[frame_state]_accent", overlays_file, src, em_block = TRUE, state_color = greyscale_accent_color)

	if(panel_open)
		. += get_airlock_overlay("panel_[frame_state][security_level ? "_protected" : null]", overlays_file, src, em_block = TRUE)
	if(frame_state == AIRLOCK_FRAME_CLOSED && welded)
		. += get_airlock_overlay("welded", overlays_file, src, em_block = TRUE)

	if(airlock_state == AIRLOCK_EMAG)
		. += get_airlock_overlay("sparks", overlays_file, src, em_block = FALSE)

	if(hasPower())
		if(frame_state == AIRLOCK_FRAME_CLOSED)
			if(atom_integrity < integrity_failure * max_integrity)
				. += get_airlock_overlay("sparks_broken", overlays_file, src, em_block = FALSE)
			else if(atom_integrity < (0.75 * max_integrity))
				. += get_airlock_overlay("sparks_damaged", overlays_file, src, em_block = FALSE)
		else if(frame_state == AIRLOCK_FRAME_OPEN)
			if(atom_integrity < (0.75 * max_integrity))
				. += get_airlock_overlay("sparks_open", overlays_file, src, em_block = FALSE)

	if(note)
		. += get_airlock_overlay(get_note_state(frame_state), note_overlay_file, src, em_block = TRUE)

	if(frame_state == AIRLOCK_FRAME_CLOSED && seal)
		. += get_airlock_overlay("sealed", overlays_file, src, em_block = TRUE)

	if(hasPower() && unres_sides)
		for(var/heading in list(NORTH,SOUTH,EAST,WEST))
			if(!(unres_sides & heading))
				continue
			var/mutable_appearance/floorlight = mutable_appearance('icons/obj/doors/airlocks/station/overlays.dmi', "unres_[heading]", FLOAT_LAYER, src, ABOVE_LIGHTING_PLANE)
			switch (heading)
				if (NORTH)
					floorlight.pixel_x = 0
					floorlight.pixel_y = 32
				if (SOUTH)
					floorlight.pixel_x = 0
					floorlight.pixel_y = -32
				if (EAST)
					floorlight.pixel_x = 32
					floorlight.pixel_y = 0
				if (WEST)
					floorlight.pixel_x = -32
					floorlight.pixel_y = 0
			. += floorlight

//STATION AIRLOCKS
/obj/machinery/door/airlock
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/public.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/overlays.dmi'

/obj/machinery/door/airlock/command
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/command.dmi'

/obj/machinery/door/airlock/security
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/security.dmi'

/obj/machinery/door/airlock/security/old
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/security2.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_sec/old

/obj/machinery/door/airlock/security/old/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/engineering
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/engineering.dmi'

/obj/machinery/door/airlock/medical
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/medical.dmi'

/obj/machinery/door/airlock/maintenance
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/maintenance.dmi'

/obj/machinery/door/airlock/maintenance/external
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/maintenanceexternal.dmi'

/obj/machinery/door/airlock/mining
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/mining.dmi'

/obj/machinery/door/airlock/atmos
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/atmos.dmi'

/obj/machinery/door/airlock/research
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/research.dmi'

/obj/machinery/door/airlock/freezer
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/freezer.dmi'

/obj/machinery/door/airlock/science
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/science.dmi'

/obj/machinery/door/airlock/virology
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/virology.dmi'

//STATION CUSTOM ARILOCKS
/obj/machinery/door/airlock/corporate
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/corporate.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_corporate
	normal_integrity = 450

/obj/machinery/door/airlock/corporate/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/service
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/service.dmi'
	assemblytype = /obj/structure/door_assembly/door_assembly_service

/obj/machinery/door/airlock/service/glass
	opacity = FALSE
	glass = TRUE

/obj/machinery/door/airlock/captain
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/cap.dmi'

/obj/machinery/door/airlock/hop
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hop.dmi'

/obj/machinery/door/airlock/hos
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hos.dmi'

/obj/machinery/door/airlock/hos/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/ce
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/ce.dmi'

/obj/machinery/door/airlock/ce/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/rd
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/rd.dmi'

/obj/machinery/door/airlock/rd/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/qm
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/qm.dmi'

/obj/machinery/door/airlock/qm/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/cmo
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/cmo.dmi'

/obj/machinery/door/airlock/cmo/glass
	opacity = FALSE
	glass = TRUE
	normal_integrity = 400

/obj/machinery/door/airlock/psych
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/psych.dmi'

/obj/machinery/door/airlock/asylum
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/asylum.dmi'

/obj/machinery/door/airlock/bathroom
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/bathroom.dmi'

//STATION MINERAL AIRLOCKS
/obj/machinery/door/airlock/gold
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/gold.dmi'

/obj/machinery/door/airlock/silver
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/silver.dmi'

/obj/machinery/door/airlock/diamond
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/diamond.dmi'

/obj/machinery/door/airlock/uranium
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/uranium.dmi'

/obj/machinery/door/airlock/plasma
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/plasma.dmi'

/obj/machinery/door/airlock/bananium
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/bananium.dmi'

/obj/machinery/door/airlock/sandstone
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/sandstone.dmi'

/obj/machinery/door/airlock/wood
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/wood.dmi'

//STATION 2 AIRLOCKS

/obj/machinery/door/airlock/public
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station2/glass.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station2/overlays.dmi'

//EXTERNAL AIRLOCKS
/obj/machinery/door/airlock/external
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/external/external.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/external/overlays.dmi'

//CENTCOM
/obj/machinery/door/airlock/centcom
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/centcom/centcom.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/centcom/overlays.dmi'

/obj/machinery/door/airlock/grunge
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/centcom/centcom.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/centcom/overlays.dmi'

//VAULT
/obj/machinery/door/airlock/vault
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/vault/vault.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/vault/overlays.dmi'

//HATCH
/obj/machinery/door/airlock/hatch
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hatch/centcom.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hatch/overlays.dmi'

/obj/machinery/door/airlock/maintenance_hatch
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hatch/maintenance.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hatch/overlays.dmi'

//HIGH SEC
/obj/machinery/door/airlock/highsecurity
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/highsec/highsec.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/highsec/overlays.dmi'

//TITANIUM / SHUTTLE
/obj/machinery/door/airlock/titanium
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/shuttle/shuttle.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/shuttle/overlays.dmi'

/obj/machinery/door/airlock/shuttle
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/shuttle/shuttle.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/shuttle/overlays.dmi'

//SHUTTLE2
/obj/machinery/door/airlock/shuttle/ferry
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/shuttle2/erokez.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/shuttle2/overlays.dmi'

/obj/machinery/door/airlock/external/wagon
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/shuttle2/wagon.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/shuttle2/overlays.dmi'

//SURVIVAL
/obj/machinery/door/airlock/survival_pod
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/survival/overlays.dmi'

//ABDUCTOR
/obj/machinery/door/airlock/abductor
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/abductor/overlays.dmi'

//CULT
/obj/machinery/door/airlock/cult
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/cult/runed/overlays.dmi'

/obj/machinery/door/airlock/cult/unruned
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/cult/unruned/overlays.dmi'

//CLOCKWORK
/obj/machinery/door/airlock/bronze
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/clockwork/overlays.dmi'

//MULTI-TILE

/obj/machinery/door/airlock/multi_tile
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/multi_tile/glass.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/multi_tile/glass_overlays.dmi'

/obj/machinery/door/airlock/multi_tile/glass
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/multi_tile/glass.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/multi_tile/glass_overlays.dmi'

/obj/machinery/door/airlock/multi_tile/metal
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/multi_tile/metal.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/multi_tile/metal_overlays.dmi'

//TRAM

/obj/machinery/door/airlock/tram
	name = "tram door"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/tram/tram.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/tram/tram_overlays.dmi'
	doorOpen = 'sound/machines/tramopen.ogg'
	doorClose = 'sound/machines/tramclose.ogg'

/obj/machinery/door/airlock/tram/set_light(l_range, l_power, l_color = NONSENSICAL_VALUE, l_angle, l_dir, l_height, l_on)
	return

//ASSEMBLYS
/obj/structure/door_assembly/door_assembly_public
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station2/glass.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station2/overlays.dmi'

/obj/structure/door_assembly/door_assembly_com
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/command.dmi'

/obj/structure/door_assembly/door_assembly_sec
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/security.dmi'

/obj/structure/door_assembly/door_assembly_sec/old
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/security2.dmi'

/obj/structure/door_assembly/door_assembly_eng
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/engineering.dmi'

/obj/structure/door_assembly/door_assembly_min
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/mining.dmi'

/obj/structure/door_assembly/door_assembly_atmo
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/atmos.dmi'

/obj/structure/door_assembly/door_assembly_research
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/research.dmi'

/obj/structure/door_assembly/door_assembly_science
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/science.dmi'

/obj/structure/door_assembly/door_assembly_viro
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/virology.dmi'

/obj/structure/door_assembly/door_assembly_med
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/medical.dmi'

/obj/structure/door_assembly/door_assembly_mai
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/maintenance.dmi'

/obj/structure/door_assembly/door_assembly_extmai
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/maintenanceexternal.dmi'

/obj/structure/door_assembly/door_assembly_ext
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/external/external.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/external/overlays.dmi'

/obj/structure/door_assembly/door_assembly_fre
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/freezer.dmi'

/obj/structure/door_assembly/door_assembly_hatch
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hatch/centcom.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hatch/overlays.dmi'

/obj/structure/door_assembly/door_assembly_mhatch
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hatch/maintenance.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hatch/overlays.dmi'

/obj/structure/door_assembly/door_assembly_highsecurity
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/highsec/highsec.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/highsec/overlays.dmi'

/obj/structure/door_assembly/door_assembly_vault
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/vault/vault.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/vault/overlays.dmi'


/obj/structure/door_assembly/door_assembly_centcom
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/centcom/centcom.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/centcom/overlays.dmi'

/obj/structure/door_assembly/door_assembly_grunge
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/centcom/centcom.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/centcom/overlays.dmi'

/obj/structure/door_assembly/door_assembly_gold
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/gold.dmi'

/obj/structure/door_assembly/door_assembly_silver
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/silver.dmi'

/obj/structure/door_assembly/door_assembly_diamond
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/diamond.dmi'

/obj/structure/door_assembly/door_assembly_uranium
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/uranium.dmi'

/obj/structure/door_assembly/door_assembly_plasma
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/plasma.dmi'

/obj/structure/door_assembly/door_assembly_bananium
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/bananium.dmi'

/obj/structure/door_assembly/door_assembly_sandstone
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/sandstone.dmi'

/obj/structure/door_assembly/door_assembly_wood
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/wood.dmi'

/obj/structure/door_assembly/door_assembly_corporate
	name = "corporate airlock assembly"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/corporate.dmi'
	glass_type = /obj/machinery/door/airlock/corporate/glass
	airlock_type = /obj/machinery/door/airlock/corporate

/obj/structure/door_assembly/door_assembly_service
	name = "service airlock assembly"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/service.dmi'
	base_name = "service airlock"
	glass_type = /obj/machinery/door/airlock/service/glass
	airlock_type = /obj/machinery/door/airlock/service

/obj/structure/door_assembly/door_assembly_captain
	name = "captain airlock assembly"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/cap.dmi'
	glass_type = /obj/machinery/door/airlock/command/glass
	airlock_type = /obj/machinery/door/airlock/captain

/obj/structure/door_assembly/door_assembly_hop
	name = "head of personnel airlock assembly"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hop.dmi'
	glass_type = /obj/machinery/door/airlock/command/glass
	airlock_type = /obj/machinery/door/airlock/hop

/obj/structure/door_assembly/hos
	name = "head of security airlock assembly"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/hos.dmi'
	glass_type = /obj/machinery/door/airlock/hos/glass
	airlock_type = /obj/machinery/door/airlock/hos

/obj/structure/door_assembly/door_assembly_cmo
	name = "chief medical officer airlock assembly"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/cmo.dmi'
	glass_type = /obj/machinery/door/airlock/cmo/glass
	airlock_type = /obj/machinery/door/airlock/cmo

/obj/structure/door_assembly/door_assembly_ce
	name = "chief engineer airlock assembly"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/ce.dmi'
	glass_type = /obj/machinery/door/airlock/ce/glass
	airlock_type = /obj/machinery/door/airlock/ce

/obj/structure/door_assembly/door_assembly_rd
	name = "research director airlock assembly"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/rd.dmi'
	glass_type = /obj/machinery/door/airlock/rd/glass
	airlock_type = /obj/machinery/door/airlock/rd

/obj/structure/door_assembly/door_assembly_qm
	name = "quartermaster airlock assembly"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/qm.dmi'
	glass_type = /obj/machinery/door/airlock/qm/glass
	airlock_type = /obj/machinery/door/airlock/qm

/obj/structure/door_assembly/door_assembly_psych
	name = "psychologist airlock assembly"
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/psych.dmi'
	glass_type = /obj/machinery/door/airlock/medical/glass
	airlock_type = /obj/machinery/door/airlock/psych

/obj/structure/door_assembly/door_assembly_asylum
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/asylum.dmi'

/obj/structure/door_assembly/door_assembly_bathroom
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/bathroom.dmi'

/obj/machinery/door/airlock/hydroponics
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/botany.dmi'

/obj/structure/door_assembly/door_assembly_hydro
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/botany.dmi'

/obj/structure/door_assembly/
	icon = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/public.dmi'
	overlays_file = 'modular_skyrat/modules/aesthetics/airlock/icons/airlocks/station/overlays.dmi'
