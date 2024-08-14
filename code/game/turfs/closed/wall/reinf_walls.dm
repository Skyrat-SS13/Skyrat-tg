/turf/closed/wall/r_wall
	name = "reinforced wall"
	desc = "A huge chunk of reinforced metal used to separate rooms."
<<<<<<< HEAD
	icon = 'icons/turf/walls/reinforced_wall.dmi' //ICON OVERRIDDEN IN SKYRAT AESTHETICS - SEE MODULE
	icon_state = "reinforced_wall-0"
	base_icon_state = "reinforced_wall"
=======
	icon = 'icons/turf/walls/reinforced_wall.dmi'
>>>>>>> 4b4e9dff1d7d (Wallening [IDB IGNORE] [MDB IGNORE] (#85491))
	opacity = TRUE
	density = TRUE
	turf_flags = IS_SOLID
	smoothing_flags = SMOOTH_BITMASK
	hardness = 10
	sheet_type = /obj/item/stack/sheet/plasteel
	sheet_amount = 1
	girder_type = /obj/structure/girder/reinforced
	explosive_resistance = 2
	rad_insulation = RAD_HEAVY_INSULATION
	rust_resistance = RUST_RESISTANCE_REINFORCED
	heat_capacity = 312500 //a little over 5 cm thick , 312500 for 1 m by 2.5 m by 0.25 m plasteel wall. also indicates the temperature at wich the wall will melt (currently only able to melt with H/E pipes)
	///Dismantled state, related to deconstruction.
	var/d_state = INTACT
	///List of icons for deconstruction steps, indexed by d_state
	var/static/list/decon_icons = list(
		SUPPORT_LINES = 'icons/turf/walls/reinforced_wall_decon1.dmi',
		COVER = 'icons/turf/walls/reinforced_wall_decon2.dmi',
		CUT_COVER = 'icons/turf/walls/reinforced_wall_decon3.dmi',
		ANCHOR_BOLTS = 'icons/turf/walls/reinforced_wall_decon4.dmi',
		SUPPORT_RODS = 'icons/turf/walls/reinforced_wall_decon5.dmi',
		SHEATH = 'icons/turf/walls/reinforced_wall_decon6.dmi',
		)

/turf/closed/wall/r_wall/deconstruction_hints(mob/user)
	switch(d_state)
		if(INTACT)
			return span_notice("The outer <b>grille</b> is fully intact.")
		if(SUPPORT_LINES)
			return span_notice("The outer <i>grille</i> has been cut, and the support lines are <b>screwed</b> securely to the outer cover.")
		if(COVER)
			return span_notice("The support lines have been <i>unscrewed</i>, and the metal cover is <b>welded</b> firmly in place.")
		if(CUT_COVER)
			return span_notice("The metal cover has been <i>sliced through</i>, and is <b>connected loosely</b> to the girder.")
		if(ANCHOR_BOLTS)
			return span_notice("The outer cover has been <i>pried away</i>, and the bolts anchoring the support rods are <b>wrenched</b> in place.")
		if(SUPPORT_RODS)
			return span_notice("The bolts anchoring the support rods have been <i>loosened</i>, but are still <b>welded</b> firmly to the girder.")
		if(SHEATH)
			return span_notice("The support rods have been <i>sliced through</i>, and the outer sheath is <b>connected loosely</b> to the girder.")

/turf/closed/wall/r_wall/devastate_wall()
	new sheet_type(src, sheet_amount)
	new /obj/item/stack/sheet/iron(src, 2)

/turf/closed/wall/r_wall/hulk_recoil(obj/item/bodypart/arm, mob/living/carbon/human/hulkman, damage = 41)
	return ..()

/turf/closed/wall/r_wall/try_decon(obj/item/W, mob/user)
	//DECONSTRUCTION
	switch(d_state)
		if(INTACT)
			if(W.tool_behaviour == TOOL_WIRECUTTER)
				W.play_tool_sound(src, 100)
				decon_change(SUPPORT_LINES)
				to_chat(user, span_notice("You cut the outer grille."))
				return TRUE

		if(SUPPORT_LINES)
			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, span_notice("You begin unsecuring the support lines..."))
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_LINES)
						return TRUE
					decon_change(COVER)
					to_chat(user, span_notice("You unsecure the support lines."))
				return TRUE

			else if(W.tool_behaviour == TOOL_WIRECUTTER)
				W.play_tool_sound(src, 100)
				decon_change(INTACT)
				to_chat(user, span_notice("You repair the outer grille."))
				return TRUE

		if(COVER)
			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=2))
					return
				to_chat(user, span_notice("You begin slicing through the metal cover..."))
				if(W.use_tool(src, user, 60, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != COVER)
						return TRUE
					decon_change(CUT_COVER)
					to_chat(user, span_notice("You press firmly on the cover, dislodging it."))
				return TRUE

			if(W.tool_behaviour == TOOL_SCREWDRIVER)
				to_chat(user, span_notice("You begin securing the support lines..."))
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != COVER)
						return TRUE
					decon_change(SUPPORT_LINES)
					to_chat(user, span_notice("The support lines have been secured."))
				return TRUE

		if(CUT_COVER)
			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, span_notice("You struggle to pry off the cover..."))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != CUT_COVER)
						return TRUE
					decon_change(ANCHOR_BOLTS)
					to_chat(user, span_notice("You pry off the cover."))
				return TRUE

			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=2))
					return
				to_chat(user, span_notice("You begin welding the metal cover back to the frame..."))
				if(W.use_tool(src, user, 60, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != CUT_COVER)
						return TRUE
					decon_change(COVER)
					to_chat(user, span_notice("The metal cover has been welded securely to the frame."))
				return TRUE

		if(ANCHOR_BOLTS)
			if(W.tool_behaviour == TOOL_WRENCH)
				to_chat(user, span_notice("You start loosening the anchoring bolts which secure the support rods to their frame..."))
				if(W.use_tool(src, user, 40, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != ANCHOR_BOLTS)
						return TRUE
					decon_change(SUPPORT_RODS)
					to_chat(user, span_notice("You remove the bolts anchoring the support rods."))
				return TRUE

			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, span_notice("You start to pry the cover back into place..."))
				if(W.use_tool(src, user, 20, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != ANCHOR_BOLTS)
						return TRUE
					decon_change(CUT_COVER)
					to_chat(user, span_notice("The metal cover has been pried back into place."))
				return TRUE

		if(SUPPORT_RODS)
			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=2))
					return
				to_chat(user, span_notice("You begin slicing through the support rods..."))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_RODS)
						return TRUE
					decon_change(SHEATH)
					to_chat(user, span_notice("You slice through the support rods."))
				return TRUE

			if(W.tool_behaviour == TOOL_WRENCH)
				to_chat(user, span_notice("You start tightening the bolts which secure the support rods to their frame..."))
				W.play_tool_sound(src, 100)
				if(W.use_tool(src, user, 40))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SUPPORT_RODS)
						return TRUE
					decon_change(ANCHOR_BOLTS)
					to_chat(user, span_notice("You tighten the bolts anchoring the support rods."))
				return TRUE

		if(SHEATH)
			if(W.tool_behaviour == TOOL_CROWBAR)
				to_chat(user, span_notice("You struggle to pry off the outer sheath..."))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SHEATH)
						return TRUE
					to_chat(user, span_notice("You pry off the outer sheath."))
					dismantle_wall()
				return TRUE

			if(W.tool_behaviour == TOOL_WELDER)
				if(!W.tool_start_check(user, amount=0))
					return
				to_chat(user, span_notice("You begin welding the support rods back together..."))
				if(W.use_tool(src, user, 100, volume=100))
					if(!istype(src, /turf/closed/wall/r_wall) || d_state != SHEATH)
						return TRUE
					decon_change(SUPPORT_RODS)
					to_chat(user, span_notice("You weld the support rods back together."))
				return TRUE
	return FALSE

/turf/closed/wall/r_wall/proc/decon_change(new_state)
	if (d_state == new_state)
		return
<<<<<<< HEAD
	if (!(updates & UPDATE_SMOOTHING))
		return
	smoothing_flags = SMOOTH_BITMASK
	QUEUE_SMOOTH_NEIGHBORS(src)
	QUEUE_SMOOTH(src)

// We don't react to smoothing changing here because this else exists only to "revert" intact changes
/turf/closed/wall/r_wall/update_icon_state()
	if(d_state != INTACT)
		icon = 'modular_skyrat/modules/aesthetics/walls/icons/reinforced_wall.dmi' // SKYRAT EDIT CHANGE - ORIGINAL: icon = 'icons/turf/walls/reinforced_states.dmi'
		icon_state = "[base_decon_state]-[d_state]"
	else
		icon = 'modular_skyrat/modules/aesthetics/walls/icons/reinforced_wall.dmi' // SKYRAT EDIT CHANGE - ORIGINAL: icon = 'icons/turf/walls/reinforced_wall.dmi'
		icon_state = "[base_icon_state]-[smoothing_junction]"
	return ..()
=======
	if(color)
		RemoveElement(/datum/element/split_visibility, icon, color)
	else
		RemoveElement(/datum/element/split_visibility, icon)
	d_state = new_state
	icon = (d_state != INTACT ? decon_icons[d_state] : initial(icon))
	if(color)
		AddElement(/datum/element/split_visibility, icon, color)
	else
		AddElement(/datum/element/split_visibility, icon)
>>>>>>> 4b4e9dff1d7d (Wallening [IDB IGNORE] [MDB IGNORE] (#85491))

/turf/closed/wall/r_wall/wall_singularity_pull(current_size)
	if(current_size >= STAGE_FIVE)
		if(prob(30))
			dismantle_wall()

/turf/closed/wall/r_wall/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	if(the_rcd.canRturf || the_rcd.construction_mode == RCD_WALLFRAME)
		return ..()


/turf/closed/wall/r_wall/rcd_act(mob/user, obj/item/construction/rcd/the_rcd, list/rcd_data)
	if(the_rcd.canRturf || rcd_data[RCD_DESIGN_MODE] == RCD_WALLFRAME)
		return ..()

/turf/closed/wall/r_wall/rust_turf()
	if(HAS_TRAIT(src, TRAIT_RUSTY))
		ChangeTurf(/turf/closed/wall/rust)
		return
	return ..()


/turf/closed/wall/r_wall/syndicate
	name = "hull"
	desc = "The armored hull of an ominous looking ship."
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	explosive_resistance = 20
	sheet_type = /obj/item/stack/sheet/mineral/plastitanium
	hardness = 25 //plastitanium
	turf_flags = IS_SOLID
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	smoothing_groups = SMOOTH_GROUP_PLASTITANIUM_WALLS + SMOOTH_GROUP_WALLS + SMOOTH_GROUP_TALL_WALLS + SMOOTH_GROUP_CLOSED_TURFS + SMOOTH_GROUP_SYNDICATE_WALLS
	canSmoothWith = SMOOTH_GROUP_PLASTITANIUM_WALLS + SMOOTH_GROUP_SYNDICATE_WALLS
	rust_resistance = RUST_RESISTANCE_TITANIUM


/turf/closed/wall/r_wall/syndicate/rcd_vals(mob/user, obj/item/construction/rcd/the_rcd)
	return FALSE

/turf/closed/wall/r_wall/syndicate/nodiagonal
	icon = 'icons/turf/walls/plastitanium_wall.dmi'
	smoothing_flags = SMOOTH_BITMASK

/turf/closed/wall/r_wall/syndicate/overspace
	smoothing_flags = SMOOTH_BITMASK | SMOOTH_DIAGONAL_CORNERS
	fixed_underlay = list("space" = TRUE)
