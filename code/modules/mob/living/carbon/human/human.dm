/mob/living/carbon/human/Initialize(mapload)
	add_verb(src, /mob/living/proc/mob_sleep)
	add_verb(src, /mob/living/proc/toggle_resting)

	icon_state = "" //Remove the inherent human icon that is visible on the map editor. We're rendering ourselves limb by limb, having it still be there results in a bug where the basic human icon appears below as south in all directions and generally looks nasty.

	//initialize limbs first
	create_bodyparts()

	setup_mood()

	setup_human_dna()
	prepare_huds() //Prevents a nasty runtime on human init

	if(dna.species)
		INVOKE_ASYNC(src, .proc/set_species, dna.species.type)

	//initialise organs
	create_internal_organs() //most of it is done in set_species now, this is only for parent call
	physiology = new()

	. = ..()

	RegisterSignal(src, COMSIG_COMPONENT_CLEAN_FACE_ACT, .proc/clean_face)
	AddComponent(/datum/component/personal_crafting)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 0.6, -6) //SKYRAT EDIT CHANGE - AESTHETICS
	AddComponent(/datum/component/bloodysoles/feet)
	AddElement(/datum/element/ridable, /datum/component/riding/creature/human)
	AddElement(/datum/element/strippable, GLOB.strippable_human_items, /mob/living/carbon/human/.proc/should_strip)
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = .proc/on_entered,
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	GLOB.human_list += src
	SSopposing_force.give_opfor_button(src) //SKYRAT EDIT - OPFOR SYSTEM

/mob/living/carbon/human/proc/setup_mood()
	if (CONFIG_GET(flag/disable_human_mood))
		return
	if (isdummy(src))
		return
	mob_mood = new /datum/mood(src)

/mob/living/carbon/human/proc/setup_human_dna()
	//initialize dna. for spawned humans; overwritten by other code
	create_dna(src)
	randomize_human(src)
	dna.initialize_dna()

/mob/living/carbon/human/Destroy()
	QDEL_NULL(physiology)
	QDEL_LIST(bioware)
	GLOB.human_list -= src

	if (mob_mood)
		QDEL_NULL(mob_mood)

	return ..()

/* SKYRAT REMOVAL START - MOVED TO MODULAR - modular_skyrat\master_files\code\modules\mob\living\carbon\human.dm
/mob/living/carbon/human/ZImpactDamage(turf/T, levels)
	if(stat != CONSCIOUS || levels > 1) // you're not The One
		return ..()
	var/obj/item/organ/external/wings/gliders = getorgan(/obj/item/organ/external/wings)
	if(HAS_TRAIT(src, TRAIT_FREERUNNING) || gliders?.can_soften_fall()) // the power of parkour or wings allows falling short distances unscathed
		visible_message(span_danger("[src] makes a hard landing on [T] but remains unharmed from the fall."), \
						span_userdanger("You brace for the fall. You make a hard landing on [T] but remain unharmed."))
		Knockdown(levels * 40)
		return
	return ..()
*/ // SKYRAT REMOVAL END

/mob/living/carbon/human/prepare_data_huds()
	//Update med hud images...
	..()
	//...sec hud images...
	sec_hud_set_ID()
	sec_hud_set_implants()
	sec_hud_set_security_status()
	//...fan gear
	fan_hud_set_fandom()
	//...and display them.
	add_to_all_human_data_huds()

/mob/living/carbon/human/get_status_tab_items()
	. = ..()
	if (internal)
		var/datum/gas_mixture/internal_air = internal.return_air()
		if (!internal_air)
			QDEL_NULL(internal)
		else
			. += ""
			. += "Internal Atmosphere Info: [internal.name]"
			. += "Tank Pressure: [internal_air.return_pressure()]"
			. += "Distribution Pressure: [internal.distribute_pressure]"
	if(istype(wear_suit, /obj/item/clothing/suit/space))
		var/obj/item/clothing/suit/space/S = wear_suit
		. += "Thermal Regulator: [S.thermal_on ? "on" : "off"]"
		. += "Cell Charge: [S.cell ? "[round(S.cell.percent(), 0.1)]%" : "!invalid!"]"
	if(mind)
		var/datum/antagonist/changeling/changeling = mind.has_antag_datum(/datum/antagonist/changeling)
		if(changeling)
			. += ""
			. += "Chemical Storage: [changeling.chem_charges]/[changeling.total_chem_storage]"
			. += "Absorbed DNA: [changeling.absorbed_count]"

/mob/living/carbon/human/reset_perspective(atom/new_eye, force_reset = FALSE)
	if(dna?.species?.prevent_perspective_change && !force_reset) // This is in case a species needs to prevent perspective changes in certain cases, like Dullahans preventing perspective changes when they're looking through their head.
		update_fullscreen()
		return
	return ..()


/mob/living/carbon/human/Topic(href, href_list)
	if(href_list["item"]) //canUseTopic check for this is handled by mob/Topic()
		var/slot = text2num(href_list["item"])
		if(check_obscured_slots(TRUE) & slot)
			to_chat(usr, span_warning("You can't reach that! Something is covering it."))
			return

///////HUDs///////
	if(href_list["hud"])
		if(!ishuman(usr))
			return
		var/mob/living/carbon/human/human_user = usr
		var/perpname = get_face_name(get_id_name(""))
		if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD) && !HAS_TRAIT(human_user, TRAIT_MEDICAL_HUD))
			return
		if((text2num(href_list["examine_time"]) + 1 MINUTES) < world.time)
			to_chat(human_user, "[span_notice("It's too late to use this now!")]")
			return
		//SKYRAT EDIT ADDITION BEGIN - EXAMINE RECORDS
		//var/datum/data/record/target_record = find_record("name", perpname, GLOB.data_core.general) // SKYRAT EDIT CHANGE ORIGINAL
		var/datum/data/record/general_record = find_record("name", perpname, GLOB.data_core.general)
		var/datum/data/record/med_record = find_record("name", perpname, GLOB.data_core.medical)
		var/datum/data/record/sec_record = find_record("name", perpname, GLOB.data_core.security)
		//SKYRAT EDIT ADDITION END - EXAMINE RECORDS
		if(href_list["photo_front"] || href_list["photo_side"])
			if(!general_record) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
				return
			if(!human_user.canUseHUD())
				return
			if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD) && !HAS_TRAIT(human_user, TRAIT_MEDICAL_HUD))
				return
			var/obj/item/photo/photo_from_record = null
			if(href_list["photo_front"])
				photo_from_record = general_record.get_front_photo() // SKYRAT EDIT - Examine Records - ORIGINAL: photo_from_record = target_record.get_front_photo()
			else if(href_list["photo_side"])
				photo_from_record = general_record.get_side_photo() // SKYRAT EDIT - Examine Records - ORIGINAL: photo_from_record = target_record.get_side_photo()
			if(photo_from_record)
				photo_from_record.show(human_user)
			return

		if(href_list["hud"] == "m")
			if(!HAS_TRAIT(human_user, TRAIT_MEDICAL_HUD))
				return
			if(href_list["evaluation"])
				if(!getBruteLoss() && !getFireLoss() && !getOxyLoss() && getToxLoss() < 20)
					to_chat(human_user, "[span_notice("No external injuries detected.")]<br>")
					return
				var/span = "notice"
				var/status = ""
				if(getBruteLoss())
					to_chat(human_user, "<b>Physical trauma analysis:</b>")
					for(var/X in bodyparts)
						var/obj/item/bodypart/BP = X
						var/brutedamage = BP.brute_dam
						if(brutedamage > 0)
							status = "received minor physical injuries."
							span = "notice"
						if(brutedamage > 20)
							status = "been seriously damaged."
							span = "danger"
						if(brutedamage > 40)
							status = "sustained major trauma!"
							span = "userdanger"
						if(brutedamage)
							to_chat(human_user, "<span class='[span]'>[BP] appears to have [status]</span>")
				if(getFireLoss())
					to_chat(human_user, "<b>Analysis of skin burns:</b>")
					for(var/X in bodyparts)
						var/obj/item/bodypart/BP = X
						var/burndamage = BP.burn_dam
						if(burndamage > 0)
							status = "signs of minor burns."
							span = "notice"
						if(burndamage > 20)
							status = "serious burns."
							span = "danger"
						if(burndamage > 40)
							status = "major burns!"
							span = "userdanger"
						if(burndamage)
							to_chat(human_user, "<span class='[span]'>[BP] appears to have [status]</span>")
				if(getOxyLoss())
					to_chat(human_user, span_danger("Patient has signs of suffocation, emergency treatment may be required!"))
				if(getToxLoss() > 20)
					to_chat(human_user, span_danger("Gathered data is inconsistent with the analysis, possible cause: poisoning."))
			if(!human_user.wear_id) //You require access from here on out.
				to_chat(human_user, span_warning("ERROR: Invalid access"))
				return
			var/list/access = human_user.wear_id.GetAccess()
			if(!(ACCESS_MEDICAL in access))
				to_chat(human_user, span_warning("ERROR: Invalid access"))
				return
			if(href_list["p_stat"])
				var/health_status = input(human_user, "Specify a new physical status for this person.", "Medical HUD", general_record.fields["p_stat"]) in list("Active", "Physically Unfit", "*Unconscious*", "*Deceased*", "Cancel")
				if(!general_record) // SKYRAT EDIT CHANGE
					return
				if(!human_user.canUseHUD())
					return
				if(!HAS_TRAIT(human_user, TRAIT_MEDICAL_HUD))
					return
				if(health_status && health_status != "Cancel")
					general_record.fields["p_stat"] = health_status // SKYRAT EDIT CHANGE
				return
			if(href_list["m_stat"])
				var/health_status = input(human_user, "Specify a new mental status for this person.", "Medical HUD", general_record.fields["m_stat"]) in list("Stable", "*Watch*", "*Unstable*", "*Insane*", "Cancel")
				if(!general_record) // SKYRAT EDIT CHANGE
					return
				if(!human_user.canUseHUD())
					return
				if(!HAS_TRAIT(human_user, TRAIT_MEDICAL_HUD))
					return
				if(health_status && health_status != "Cancel")
					general_record.fields["m_stat"] = health_status //SKYRAT EDIT CHANGE - EXAMINE RECORDS
				return
			if(href_list["quirk"])
				var/quirkstring = get_quirk_string(TRUE, CAT_QUIRK_ALL)
				if(quirkstring)
					to_chat(human_user,  "<span class='notice ml-1'>Detected physiological traits:</span>\n<span class='notice ml-2'>[quirkstring]</span>")
				else
					to_chat(usr,  "<span class='notice ml-1'>No physiological traits found.</span>")
			//SKYRAT EDIT ADDITION BEGIN - EXAMINE RECORDS
			if(href_list["medrecords"])
				to_chat(usr, "<b>Medical Record:</b> [med_record.fields["past_records"]]")
			if(href_list["genrecords"])
				to_chat(usr, "<b>General Record:</b> [general_record.fields["past_records"]]")
			//SKYRAT EDIT END
			return //Medical HUD ends here.

		if(href_list["hud"] == "s")
			if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
				return
			if(human_user.stat || human_user == src) //|| !human_user.canmove || human_user.restrained()) Fluff: Sechuds have eye-tracking technology and sets 'arrest' to people that the wearer looks and blinks at.
				return   //Non-fluff: This allows sec to set people to arrest as they get disarmed or beaten
			// Checks the user has security clearence before allowing them to change arrest status via hud, comment out to enable all access
			var/allowed_access = null
			var/obj/item/clothing/glasses/hud/security/user_glasses = human_user.glasses
			if(istype(user_glasses) && (user_glasses.obj_flags & EMAGGED))
				allowed_access = "@%&ERROR_%$*"
			else //Implant and standard glasses check access
				if(human_user.wear_id)
					var/list/access = human_user.wear_id.GetAccess()
					if(ACCESS_SECURITY in access)
						allowed_access = human_user.get_authentification_name()

			if(!allowed_access)
				to_chat(human_user, span_warning("ERROR: Invalid access."))
				return

			if(!perpname)
				to_chat(human_user, span_warning("ERROR: Can not identify target."))
				return
			/* ORIGINAL
			target_record = find_record("name", perpname, GLOB.data_core.security)
			if(!target_record)
			*/
			if(!sec_record) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
				to_chat(usr, span_warning("ERROR: Unable to locate data core entry for target."))
				return
			if(href_list["status"])
				var/setcriminal = input(usr, "Specify a new criminal status for this person.", "Security HUD", sec_record.fields["criminal"]) in list("None", "*Arrest*", "Incarcerated", "Suspected", "Paroled", "Discharged", "Cancel") //SKYRAT EDIT CHANGE - EXAMINE RECORDS
				if(setcriminal != "Cancel")
					if(!sec_record) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
						return
					if(!human_user.canUseHUD())
						return
					if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
						return
					investigate_log("[key_name(src)] has been set from [sec_record.fields["criminal"]] to [setcriminal] by [key_name(usr)].", INVESTIGATE_RECORDS) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
					sec_record.fields["criminal"] = setcriminal //SKYRAT EDIT CHANGE - EXAMINE RECORDS
					sec_hud_set_security_status()
				return

			if(href_list["view"])
				if(!human_user.canUseHUD())
					return
				if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
					return
				to_chat(usr, "<b>Name:</b> [sec_record.fields["name"]] <b>Criminal Status:</b> [sec_record.fields["criminal"]]") //SKYRAT EDIT CHANGE - EXAMINE RECORDS
				for(var/datum/data/crime/c in sec_record.fields["crim"]) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
					to_chat(usr, "<b>Crime:</b> [c.crimeName]")
					if (c.crimeDetails)
						to_chat(human_user, "<b>Details:</b> [c.crimeDetails]")
					else
						to_chat(human_user, "<b>Details:</b> <A href='?src=[REF(src)];hud=s;add_details=1;cdataid=[c.dataId]'>\[Add details]</A>")
					to_chat(human_user, "Added by [c.author] at [c.time]")
					to_chat(human_user, "----------")
				to_chat(human_user, "<b>Notes:</b> [sec_record.fields["notes"]]") //SKYRAT EDIT CHANGE - EXAMINE RECORDS
				return

			//SKYRAT EDIT ADDITION BEGIN - EXAMINE RECORDS
			if(href_list["genrecords"])
				if(!human_user.canUseHUD())
					return
				if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
					return
				to_chat(usr, "<b>General Record:</b> [general_record.fields["past_records"]]")

			if(href_list["secrecords"])
				if(!human_user.canUseHUD())
					return
				if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
					return
				to_chat(usr, "<b>Security Record:</b> [sec_record.fields["past_records"]]")
			//SKYRAT EDIT END

			if(href_list["add_citation"])
				var/maxFine = CONFIG_GET(number/maxfine)
				var/t1 = tgui_input_text(human_user, "Citation crime", "Security HUD")
				var/fine = tgui_input_number(human_user, "Citation fine", "Security HUD", 50, maxFine, 5)
				if(!fine)
					return
				//if(!target_record || !t1 || !allowed_access) // ORIGINAL
				if(!sec_record || !t1 || !allowed_access) // SKYRAT EDIT CHANGE - EXAMINE RECORDS
					return
				if(!human_user.canUseHUD())
					return
				if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
					return

				var/datum/data/crime/crime = GLOB.data_core.createCrimeEntry(t1, "", allowed_access, station_time_timestamp(), fine)
				for (var/obj/item/modular_computer/tablet in GLOB.TabletMessengers)
					if(tablet.saved_identification == sec_record.fields["name"]) // SKYRAT EDIT CHANGE
						var/message = "You have been fined [fine] credits for '[t1]'. Fines may be paid at security."
						var/datum/signal/subspace/messaging/tablet_msg/signal = new(src, list(
							"name" = "Security Citation",
							"job" = "Citation Server",
							"message" = message,
							"targets" = list(tablet),
							"automated" = TRUE
						))
						signal.send_to_receivers()
						human_user.log_message("(PDA: Citation Server) sent \"[message]\" to [signal.format_target()]", LOG_PDA)
				GLOB.data_core.addCitation(sec_record.fields["id"], crime) // SKYRAT EDIT CHANGE - RECORDS
				investigate_log("New Citation: <strong>[t1]</strong> Fine: [fine] | Added to [sec_record.fields["name"]] by [key_name(human_user)]", INVESTIGATE_RECORDS) // SKYRAT EDIT CHANGE - RECORDS
				SSblackbox.ReportCitation(crime.dataId, human_user.ckey, human_user.real_name, sec_record.fields["name"], t1, fine) // SKYRAT EDIT CHANGE - RECORDS
				return

			if(href_list["add_crime"])
				var/t1 = tgui_input_text(human_user, "Crime name", "Security HUD")
				if(!sec_record || !t1 || !allowed_access) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
					return
				if(!human_user.canUseHUD())
					return
				if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
					return
				var/crime = GLOB.data_core.createCrimeEntry(t1, null, allowed_access, station_time_timestamp())
				GLOB.data_core.addCrime(sec_record.fields["id"], crime) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
				investigate_log("New Crime: <strong>[t1]</strong> | Added to [sec_record.fields["name"]] by [key_name(usr)]", INVESTIGATE_RECORDS) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
				to_chat(usr, span_notice("Successfully added a crime."))
				return

			if(href_list["add_details"])
				var/t1 = tgui_input_text(usr, "Crime details", "Security Records", multiline = TRUE)
				if(!sec_record || !t1 || !allowed_access) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
					return
				if(!human_user.canUseHUD())
					return
				if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
					return
				if(href_list["cdataid"])
					GLOB.data_core.addCrimeDetails(sec_record.fields["id"], href_list["cdataid"], t1) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
					investigate_log("New Crime details: [t1] | Added to [sec_record.fields["name"]] by [key_name(usr)]", INVESTIGATE_RECORDS) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
					to_chat(human_user, span_notice("Successfully added details."))
				return

			if(href_list["view_comment"])
				if(!human_user.canUseHUD())
					return
				if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
					return
				to_chat(human_user, "<b>Comments/Log:</b>")
				var/counter = 1
				while(sec_record.fields[text("com_[]", counter)]) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
					to_chat(human_user, sec_record.fields[text("com_[]", counter)]) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
					to_chat(human_user, "----------")
					counter++
				return

			if(href_list["add_comment"])
				var/t1 = tgui_input_text(human_user, "Add a comment", "Security Records", multiline = TRUE)
				if (!sec_record || !t1 || !allowed_access) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
					return
				if(!human_user.canUseHUD())
					return
				if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
					return
				var/counter = 1
				while(sec_record.fields[text("com_[]", counter)]) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
					counter++
				sec_record.fields[text("com_[]", counter)] = text("Made by [] on [] [], []<BR>[]", allowed_access, station_time_timestamp(), time2text(world.realtime, "MMM DD"), GLOB.year_integer+540, t1) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
				to_chat(human_user, span_notice("Successfully added comment."))
				return

	//SKYRAT EDIT ADDITION BEGIN - VIEW RECORDS
	if(href_list["bgrecords"])
		if(isobserver(usr) || usr.mind.can_see_exploitables || usr.mind.has_exploitables_override)
			var/examined_name = get_face_name(get_id_name(""))
			var/datum/data/record/target_general_records = find_record("name", examined_name, GLOB.data_core.general)
			to_chat(usr, "<b>Background information:</b> [target_general_records.fields["background_records"]]")
	if(href_list["exprecords"])
		if(isobserver(usr) || usr.mind.can_see_exploitables || usr.mind.has_exploitables_override)
			var/examined_name = get_face_name(get_id_name("")) //Named as such because this is the name we see when we examine
			var/datum/data/record/target_general_records = find_record("name", examined_name, GLOB.data_core.general)
			to_chat(usr, "<b>Exploitable information:</b> [target_general_records.fields["exploitable_records"]]")
	//SKYRAT EDIT END

	..() //end of this massive fucking chain. TODO: make the hud chain not spooky. - Yeah, great job doing that.

//called when something steps onto a human
/mob/living/carbon/human/proc/on_entered(datum/source, atom/movable/AM)
	SIGNAL_HANDLER
	spreadFire(AM)

/mob/living/carbon/human/proc/canUseHUD()
	return (mobility_flags & MOBILITY_USE)

/mob/living/carbon/human/can_inject(mob/user, target_zone, injection_flags)
	. = TRUE // Default to returning true.
	// we may choose to ignore species trait pierce immunity in case we still want to check skellies for thick clothing without insta failing them (wounds)
	if(injection_flags & INJECT_CHECK_IGNORE_SPECIES)
		if(HAS_TRAIT_NOT_FROM(src, TRAIT_PIERCEIMMUNE, SPECIES_TRAIT))
			. = FALSE
	else if(HAS_TRAIT(src, TRAIT_PIERCEIMMUNE))
		. = FALSE
	if(user && !target_zone)
		target_zone = get_bodypart(check_zone(user.zone_selected)) //try to find a bodypart. if there isn't one, target_zone will be null, and check_zone in the next line will default to the chest.
	var/obj/item/bodypart/the_part = isbodypart(target_zone) ? target_zone : get_bodypart(check_zone(target_zone)) //keep these synced
	// Loop through the clothing covering this bodypart and see if there's any thiccmaterials
	if(!(injection_flags & INJECT_CHECK_PENETRATE_THICK))
		for(var/obj/item/clothing/iter_clothing in clothingonpart(the_part))
			if(iter_clothing.clothing_flags & THICKMATERIAL)
				. = FALSE
				break

/mob/living/carbon/human/try_inject(mob/user, target_zone, injection_flags)
	. = ..()
	if(!. && (injection_flags & INJECT_TRY_SHOW_ERROR_MESSAGE) && user)
		if(!target_zone)
			target_zone = get_bodypart(check_zone(user.zone_selected))
		var/obj/item/bodypart/the_part = isbodypart(target_zone) ? target_zone : get_bodypart(check_zone(target_zone)) //keep these synced
		to_chat(user, span_alert("There is no exposed flesh or thin material on [p_their()] [the_part.name]."))

/mob/living/carbon/human/assess_threat(judgement_criteria, lasercolor = "", datum/callback/weaponcheck=null)
	if(judgement_criteria & JUDGE_EMAGGED)
		return 10 //Everyone is a criminal!

	var/threatcount = 0

	//Lasertag bullshit
	if(lasercolor)
		if(lasercolor == "b")//Lasertag turrets target the opposing team, how great is that? -Sieve
			if(istype(wear_suit, /obj/item/clothing/suit/redtag))
				threatcount += 4
			if(is_holding_item_of_type(/obj/item/gun/energy/laser/redtag))
				threatcount += 4
			if(istype(belt, /obj/item/gun/energy/laser/redtag))
				threatcount += 2

		if(lasercolor == "r")
			if(istype(wear_suit, /obj/item/clothing/suit/bluetag))
				threatcount += 4
			if(is_holding_item_of_type(/obj/item/gun/energy/laser/bluetag))
				threatcount += 4
			if(istype(belt, /obj/item/gun/energy/laser/bluetag))
				threatcount += 2

		return threatcount

	//Check for ID
	var/obj/item/card/id/idcard = get_idcard(FALSE)
	if( (judgement_criteria & JUDGE_IDCHECK) && !idcard && name=="Unknown")
		threatcount += 4

	//Check for weapons
	if( (judgement_criteria & JUDGE_WEAPONCHECK) && weaponcheck)
		if(!idcard || !(ACCESS_WEAPONS in idcard.access))
			for(var/obj/item/I in held_items) //if they're holding a gun
				if(weaponcheck.Invoke(I))
					threatcount += 4
			if(weaponcheck.Invoke(belt) || weaponcheck.Invoke(back)) //if a weapon is present in the belt or back slot
				threatcount += 2 //not enough to trigger look_for_perp() on it's own unless they also have criminal status.

	//Check for arrest warrant
	if(judgement_criteria & JUDGE_RECORDCHECK)
		var/perpname = get_face_name(get_id_name())
		var/datum/data/record/sec_record = find_record("name", perpname, GLOB.data_core.security) //SKYRAT EDIT CHANGE - EXAMINE RECORDS

		if(sec_record?.fields["criminal"]) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
			switch(sec_record.fields["criminal"]) //SKYRAT EDIT CHANGE - EXAMINE RECORDS
				if("*Arrest*")
					threatcount += 5
				if("Incarcerated")
					threatcount += 2
				if("Suspected")
					threatcount += 2
				if("Paroled")
					threatcount += 2

	//Check for dresscode violations
	if(istype(head, /obj/item/clothing/head/wizard))
		threatcount += 2

	/* SKYRAT EDIT - REMOVAL
	//Check for nonhuman scum
	if(dna && dna.species.id && dna.species.id != "human")
		threatcount += 1
	*/

	//mindshield implants imply trustworthyness
	if(HAS_TRAIT(src, TRAIT_MINDSHIELD))
		threatcount -= 1

	return threatcount


//Used for new human mobs created by cloning/goleming/podding
/mob/living/carbon/human/proc/set_cloned_appearance()
	if(gender == MALE)
		facial_hairstyle = "Full Beard"
	else
		facial_hairstyle = "Shaved"
	hairstyle = pick("Bedhead", "Bedhead 2", "Bedhead 3")
	underwear = "Nude"
	update_body(is_creating = TRUE)

/mob/living/carbon/human/singularity_pull(S, current_size)
	..()
	if(current_size >= STAGE_THREE)
		for(var/obj/item/hand in held_items)
			if(prob(current_size * 5) && hand.w_class >= ((11-current_size)/2)  && dropItemToGround(hand))
				step_towards(hand, src)
				to_chat(src, span_warning("\The [S] pulls \the [hand] from your grip!"))

#define CPR_PANIC_SPEED (0.8 SECONDS)

/// Performs CPR on the target after a delay.
/mob/living/carbon/human/proc/do_cpr(mob/living/carbon/target)
	if(target == src)
		return

	var/panicking = FALSE

	do
		CHECK_DNA_AND_SPECIES(target)

		if (DOING_INTERACTION_WITH_TARGET(src,target))
			return FALSE

		if (target.stat == DEAD || HAS_TRAIT(target, TRAIT_FAKEDEATH))
			to_chat(src, span_warning("[target.name] is dead!"))
			return FALSE

		if (is_mouth_covered())
			to_chat(src, span_warning("Remove your mask first!"))
			return FALSE

		if (target.is_mouth_covered())
			to_chat(src, span_warning("Remove [p_their()] mask first!"))
			return FALSE

		if (!getorganslot(ORGAN_SLOT_LUNGS))
			to_chat(src, span_warning("You have no lungs to breathe with, so you cannot perform CPR!"))
			return FALSE

		if (HAS_TRAIT(src, TRAIT_NOBREATH))
			to_chat(src, span_warning("You do not breathe, so you cannot perform CPR!"))
			return FALSE

		visible_message(span_notice("[src] is trying to perform CPR on [target.name]!"), \
						span_notice("You try to perform CPR on [target.name]... Hold still!"))

		if (!do_mob(src, target, time = panicking ? CPR_PANIC_SPEED : (3 SECONDS)))
			to_chat(src, span_warning("You fail to perform CPR on [target]!"))
			return FALSE

		if (target.health > target.crit_threshold)
			return FALSE

		visible_message(span_notice("[src] performs CPR on [target.name]!"), span_notice("You perform CPR on [target.name]."))
		add_mood_event("saved_life", /datum/mood_event/saved_life)
		log_combat(src, target, "CPRed")

		if (HAS_TRAIT(target, TRAIT_NOBREATH))
			to_chat(target, span_unconscious("You feel a breath of fresh air... which is a sensation you don't recognise..."))
		else if (!target.getorganslot(ORGAN_SLOT_LUNGS))
			to_chat(target, span_unconscious("You feel a breath of fresh air... but you don't feel any better..."))
		else
			target.adjustOxyLoss(-min(target.getOxyLoss(), 7))
			to_chat(target, span_unconscious("You feel a breath of fresh air enter your lungs... It feels good..."))

		if (target.health <= target.crit_threshold)
			if (!panicking)
				to_chat(src, span_warning("[target] still isn't up! You try harder!"))
			panicking = TRUE
		else
			panicking = FALSE
	while (panicking)

#undef CPR_PANIC_SPEED

/mob/living/carbon/human/cuff_resist(obj/item/I)
	if(dna?.check_mutation(/datum/mutation/human/hulk))
		say(pick(";RAAAAAAAARGH!", ";HNNNNNNNNNGGGGGGH!", ";GWAAAAAAAARRRHHH!", "NNNNNNNNGGGGGGGGHH!", ";AAAAAAARRRGH!" ), forced = "hulk")
		if(..(I, cuff_break = FAST_CUFFBREAK))
			dropItemToGround(I)
	else
		if(..())
			dropItemToGround(I)

/**
 * Wash the hands, cleaning either the gloves if equipped and not obscured, otherwise the hands themselves if they're not obscured.
 *
 * Returns false if we couldn't wash our hands due to them being obscured, otherwise true
 */
/mob/living/carbon/human/proc/wash_hands(clean_types)
	var/obscured = check_obscured_slots()
	if(obscured & ITEM_SLOT_GLOVES)
		return FALSE

	if(gloves)
		if(gloves.wash(clean_types))
			update_worn_gloves()
	else if((clean_types & CLEAN_TYPE_BLOOD) && blood_in_hands > 0)
		blood_in_hands = 0
		update_worn_gloves()

	return TRUE

/**
 * Used to update the makeup on a human and apply/remove lipstick traits, then store/unstore them on the head object in case it gets severed
 */
/mob/living/carbon/human/proc/update_lips(new_style, new_colour, apply_trait)
	lip_style = new_style
	lip_color = new_colour
	update_body()

	var/obj/item/bodypart/head/hopefully_a_head = get_bodypart(BODY_ZONE_HEAD)
	REMOVE_TRAITS_IN(src, LIPSTICK_TRAIT)
	hopefully_a_head?.stored_lipstick_trait = null

	if(new_style && apply_trait)
		ADD_TRAIT(src, apply_trait, LIPSTICK_TRAIT)
		hopefully_a_head?.stored_lipstick_trait = apply_trait

/**
 * A wrapper for [mob/living/carbon/human/proc/update_lips] that tells us if there were lip styles to change
 */
/mob/living/carbon/human/proc/clean_lips()
	if(isnull(lip_style) && lip_color == initial(lip_color))
		return FALSE
	update_lips(null)
	return TRUE

/**
 * Called on the COMSIG_COMPONENT_CLEAN_FACE_ACT signal
 */
/mob/living/carbon/human/proc/clean_face(datum/source, clean_types)
	SIGNAL_HANDLER
	if(!is_mouth_covered() && clean_lips())
		. = TRUE

	if(glasses && is_eyes_covered(FALSE, TRUE, TRUE) && glasses.wash(clean_types))
		update_worn_glasses()
		. = TRUE

	var/obscured = check_obscured_slots()
	if(wear_mask && !(obscured & ITEM_SLOT_MASK) && wear_mask.wash(clean_types))
		update_worn_mask()
		. = TRUE

/**
 * Called when this human should be washed
 */
/mob/living/carbon/human/wash(clean_types)
	. = ..()

	// Wash equipped stuff that cannot be covered
	if(wear_suit?.wash(clean_types))
		update_worn_oversuit()
		. = TRUE

	if(belt?.wash(clean_types))
		update_worn_belt()
		. = TRUE

	// Check and wash stuff that can be covered
	var/obscured = check_obscured_slots()

	if(w_uniform && !(obscured & ITEM_SLOT_ICLOTHING) && w_uniform.wash(clean_types))
		update_worn_undersuit()
		. = TRUE

	if(!is_mouth_covered() && clean_lips())
		. = TRUE

	// Wash hands if exposed
	if(!gloves && (clean_types & CLEAN_TYPE_BLOOD) && blood_in_hands > 0 && !(obscured & ITEM_SLOT_GLOVES))
		blood_in_hands = 0
		update_worn_gloves()
		. = TRUE

//Turns a mob black, flashes a skeleton overlay
//Just like a cartoon!
/mob/living/carbon/human/proc/electrocution_animation(anim_duration)
	//Handle mutant parts if possible
	if(dna?.species)
		add_atom_colour("#000000", TEMPORARY_COLOUR_PRIORITY)
		var/static/mutable_appearance/electrocution_skeleton_anim
		if(!electrocution_skeleton_anim)
			electrocution_skeleton_anim = mutable_appearance(icon, "electrocuted_base")
			electrocution_skeleton_anim.appearance_flags |= RESET_COLOR|KEEP_APART
		add_overlay(electrocution_skeleton_anim)
		addtimer(CALLBACK(src, .proc/end_electrocution_animation, electrocution_skeleton_anim), anim_duration)

	else //or just do a generic animation
		flick_overlay_view(image(icon,src,"electrocuted_generic",ABOVE_MOB_LAYER), src, anim_duration)

/mob/living/carbon/human/proc/end_electrocution_animation(mutable_appearance/MA)
	remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, "#000000")
	cut_overlay(MA)

/mob/living/carbon/human/resist_restraints()
	if(wear_suit?.breakouttime)
		changeNext_move(CLICK_CD_BREAKOUT)
		last_special = world.time + CLICK_CD_BREAKOUT
		cuff_resist(wear_suit)
	else
		..()

/mob/living/carbon/human/clear_cuffs(obj/item/I, cuff_break)
	. = ..()
	if(.)
		return
	if(!I.loc || buckled)
		return FALSE
	if(I == wear_suit)
		visible_message(span_danger("[src] manages to [cuff_break ? "break" : "remove"] [I]!"))
		to_chat(src, span_notice("You successfully [cuff_break ? "break" : "remove"] [I]."))
		return TRUE
	//SKYRAT ERP UPDATE ADDITION: NOW GLOVES CAN RESTRAIN PLAYERS
	if(I == gloves)
		visible_message(span_danger("[src] manages to [cuff_break ? "break" : "remove"] [I]!"))
		to_chat(src, span_notice("You successfully [cuff_break ? "break" : "remove"] [I]."))
		return TRUE
	//SKYRAT ERP UPDATE ADDITION END

/mob/living/carbon/human/replace_records_name(oldname,newname) // Only humans have records right now, move this up if changed.
	for(var/list/L in list(GLOB.data_core.general,GLOB.data_core.medical,GLOB.data_core.security,GLOB.data_core.locked))
		var/datum/data/record/general_record = find_record("name", oldname, L)
		if(general_record)
			general_record.fields["name"] = newname

/mob/living/carbon/human/get_total_tint()
	. = ..()
	if(glasses)
		. += glasses.tint

/mob/living/carbon/human/update_health_hud()
	if(!client || !hud_used)
		return

	// Updates the health bar, also sends signal
	. = ..()

	// Updates the health doll
	if(!hud_used.healthdoll)
		return

	hud_used.healthdoll.cut_overlays()
	if(stat == DEAD)
		hud_used.healthdoll.icon_state = "healthdoll_DEAD"
		return

	hud_used.healthdoll.icon_state = "healthdoll_OVERLAY"
	for(var/obj/item/bodypart/body_part as anything in bodyparts)
		var/icon_num = 0

		if(SEND_SIGNAL(body_part, COMSIG_BODYPART_UPDATING_HEALTH_HUD, src) & COMPONENT_OVERRIDE_BODYPART_HEALTH_HUD)
			continue

		var/damage = body_part.burn_dam + body_part.brute_dam
		var/comparison = (body_part.max_damage/5)
		if(damage)
			icon_num = 1
		if(damage > (comparison))
			icon_num = 2
		if(damage > (comparison*2))
			icon_num = 3
		if(damage > (comparison*3))
			icon_num = 4
		if(damage > (comparison*4))
			icon_num = 5
		if(has_status_effect(/datum/status_effect/grouped/screwy_hud/fake_healthy))
			icon_num = 0
		if(icon_num)
			hud_used.healthdoll.add_overlay(mutable_appearance('icons/hud/screen_gen.dmi', "[body_part.body_zone][icon_num]"))
	for(var/t in get_missing_limbs()) //Missing limbs
		hud_used.healthdoll.add_overlay(mutable_appearance('icons/hud/screen_gen.dmi', "[t]6"))
	for(var/t in get_disabled_limbs()) //Disabled limbs
		hud_used.healthdoll.add_overlay(mutable_appearance('icons/hud/screen_gen.dmi', "[t]7"))

/mob/living/carbon/human/fully_heal(admin_revive = FALSE)
	dna?.species.spec_fully_heal(src)
	if(admin_revive)
		regenerate_limbs()
		regenerate_organs()
	remove_all_embedded_objects()
	set_heartattack(FALSE)
	for(var/datum/mutation/human/HM in dna.mutations)
		if(HM.quality != POSITIVE)
			dna.remove_mutation(HM.name)
	set_coretemperature(get_body_temp_normal(apply_change=FALSE))
	heat_exposure_stacks = 0
	return ..()

/mob/living/carbon/human/is_nearsighted()
	var/obj/item/clothing/glasses/eyewear = glasses
	if(istype(eyewear) && eyewear.vision_correction)
		return FALSE
	return ..()

/mob/living/carbon/human/vomit(lost_nutrition = 10, blood = FALSE, stun = TRUE, distance = 1, message = TRUE, vomit_type = VOMIT_TOXIC, harm = TRUE, force = FALSE, purge_ratio = 0.1)
	if(blood && (NOBLOOD in dna.species.species_traits) && !HAS_TRAIT(src, TRAIT_TOXINLOVER))
		if(message)
			visible_message(span_warning("[src] dry heaves!"), \
							span_userdanger("You try to throw up, but there's nothing in your stomach!"))
		if(stun)
			Paralyze(200)
		return 1
	..()

/mob/living/carbon/human/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("", "---------")
	VV_DROPDOWN_OPTION(VV_HK_COPY_OUTFIT, "Copy Outfit")
	VV_DROPDOWN_OPTION(VV_HK_MOD_MUTATIONS, "Add/Remove Mutation")
	VV_DROPDOWN_OPTION(VV_HK_MOD_QUIRKS, "Add/Remove Quirks")
	VV_DROPDOWN_OPTION(VV_HK_SET_SPECIES, "Set Species")
	VV_DROPDOWN_OPTION(VV_HK_PURRBATION, "Toggle Purrbation")

/mob/living/carbon/human/vv_do_topic(list/href_list)
	. = ..()
	if(href_list[VV_HK_COPY_OUTFIT])
		if(!check_rights(R_SPAWN))
			return
		copy_outfit()
	if(href_list[VV_HK_MOD_MUTATIONS])
		if(!check_rights(R_SPAWN))
			return

		var/list/options = list("Clear"="Clear")
		for(var/x in subtypesof(/datum/mutation/human))
			var/datum/mutation/human/mut = x
			var/name = initial(mut.name)
			options[dna.check_mutation(mut) ? "[name] (Remove)" : "[name] (Add)"] = mut

		var/result = input(usr, "Choose mutation to add/remove","Mutation Mod") as null|anything in sort_list(options)
		if(result)
			if(result == "Clear")
				dna.remove_all_mutations()
			else
				var/mut = options[result]
				if(dna.check_mutation(mut))
					dna.remove_mutation(mut)
				else
					dna.add_mutation(mut)
	if(href_list[VV_HK_MOD_QUIRKS])
		if(!check_rights(R_SPAWN))
			return

		var/list/options = list("Clear"="Clear")
		for(var/type in subtypesof(/datum/quirk))
			var/datum/quirk/quirk_type = type

			if(initial(quirk_type.abstract_parent_type) == type)
				continue

			var/qname = initial(quirk_type.name)
			options[has_quirk(quirk_type) ? "[qname] (Remove)" : "[qname] (Add)"] = quirk_type

		var/result = input(usr, "Choose quirk to add/remove","Quirk Mod") as null|anything in sort_list(options)
		if(result)
			if(result == "Clear")
				for(var/datum/quirk/q in quirks)
					remove_quirk(q.type)
			else
				var/T = options[result]
				if(has_quirk(T))
					remove_quirk(T)
				else
					add_quirk(T)
	if(href_list[VV_HK_SET_SPECIES])
		if(!check_rights(R_SPAWN))
			return
		var/result = input(usr, "Please choose a new species","Species") as null|anything in GLOB.species_list
		if(result)
			var/newtype = GLOB.species_list[result]
			admin_ticket_log("[key_name_admin(usr)] has modified the bodyparts of [src] to [result]")
			set_species(newtype)
	if(href_list[VV_HK_PURRBATION])
		if(!check_rights(R_SPAWN))
			return
		if(!ishuman(src))
			to_chat(usr, "This can only be done to human species at the moment.")
			return
		var/success = purrbation_toggle(src)
		if(success)
			to_chat(usr, "Put [src] on purrbation.")
			log_admin("[key_name(usr)] has put [key_name(src)] on purrbation.")
			var/msg = span_notice("[key_name_admin(usr)] has put [key_name(src)] on purrbation.")
			message_admins(msg)
			admin_ticket_log(src, msg)

		else
			to_chat(usr, "Removed [src] from purrbation.")
			log_admin("[key_name(usr)] has removed [key_name(src)] from purrbation.")
			var/msg = span_notice("[key_name_admin(usr)] has removed [key_name(src)] from purrbation.")
			message_admins(msg)
			admin_ticket_log(src, msg)

/mob/living/carbon/human/limb_attack_self()
	var/obj/item/bodypart/arm = hand_bodyparts[active_hand_index]
	if(arm)
		arm.attack_self(src)
	return ..()

/mob/living/carbon/human/mouse_buckle_handling(mob/living/M, mob/living/user)
	if(pulling != M || grab_state != GRAB_AGGRESSIVE || stat != CONSCIOUS)
		return FALSE

	//If they dragged themselves to you and you're currently aggressively grabbing them try to piggyback
	if(user == M && can_piggyback(M))
		piggyback(M)
		return TRUE

	//If you dragged them to you and you're aggressively grabbing try to fireman carry them
	if(can_be_firemanned(M))
		fireman_carry(M)
		return TRUE

//src is the user that will be carrying, target is the mob to be carried
/mob/living/carbon/human/proc/can_piggyback(mob/living/carbon/target)
	return (istype(target) && target.stat == CONSCIOUS)

/mob/living/carbon/human/proc/can_be_firemanned(mob/living/carbon/target)
	return ishuman(target) && target.body_position == LYING_DOWN

/mob/living/carbon/human/proc/fireman_carry(mob/living/carbon/target)
	if(!can_be_firemanned(target) || incapacitated(IGNORE_GRAB))
		to_chat(src, span_warning("You can't fireman carry [target] while [target.p_they()] [target.p_are()] standing!"))
		return

	var/carrydelay = 5 SECONDS //if you have latex you are faster at grabbing
	var/skills_space = "" //cobby told me to do this
	if(HAS_TRAIT(src, TRAIT_QUICKER_CARRY))
		carrydelay = 3 SECONDS
		skills_space = " very quickly"
	else if(HAS_TRAIT(src, TRAIT_QUICK_CARRY))
		carrydelay = 4 SECONDS
		skills_space = " quickly"
	//SKYRAT EDIT ADDITION
	else if(HAS_TRAIT(target, TRAIT_OVERSIZED) && !HAS_TRAIT(src, TRAIT_OVERSIZED))
		visible_message(span_warning("[src] tries to carry [target], but they are too heavy!"))
		return
	//SKYRAT EDIT END
	visible_message(span_notice("[src] starts[skills_space] lifting [target] onto [p_their()] back..."),
		span_notice("You[skills_space] start to lift [target] onto your back..."))
	if(!do_after(src, carrydelay, target))
		visible_message(span_warning("[src] fails to fireman carry [target]!"))
		return

	//Second check to make sure they're still valid to be carried
	if(!can_be_firemanned(target) || incapacitated(IGNORE_GRAB) || target.buckled)
		visible_message(span_warning("[src] fails to fireman carry [target]!"))
		return

	return buckle_mob(target, TRUE, TRUE, CARRIER_NEEDS_ARM)

/mob/living/carbon/human/proc/piggyback(mob/living/carbon/target)
	if(!can_piggyback(target))
		to_chat(target, span_warning("You can't piggyback ride [src] right now!"))
		return

	visible_message(span_notice("[target] starts to climb onto [src]..."))
	if(!do_after(target, 1.5 SECONDS, target = src) || !can_piggyback(target))
		visible_message(span_warning("[target] fails to climb onto [src]!"))
		return

	if(target.incapacitated(IGNORE_GRAB) || incapacitated(IGNORE_GRAB))
		target.visible_message(span_warning("[target] can't hang onto [src]!"))
		return
	//SKYRAT EDIT START
	if(HAS_TRAIT(target, TRAIT_OVERSIZED) && !HAS_TRAIT(src, TRAIT_OVERSIZED))
		target.visible_message(span_warning("[target] is too heavy for [src] to carry!"))
		var/dam_zone = pick(BODY_ZONE_CHEST, BODY_ZONE_L_LEG, BODY_ZONE_R_LEG)
		var/obj/item/bodypart/affecting = get_bodypart(ran_zone(dam_zone))
		var/wound_bon = 0
		if(!affecting) //If one leg is missing, then it might break. Snap their spine instead
			affecting = get_bodypart(BODY_ZONE_CHEST)
		if(prob(oversized_piggywound_chance	))
			wound_bon = 100
			to_chat(src, span_danger("You are crushed under the weight of [target]!"))
			to_chat(target, span_danger("You accidentally crush [src]!"))
		else
			to_chat(src, span_danger("You hurt your [affecting.name] while trying to endure the weight of [target]!"))
		apply_damage(oversized_piggydam, BRUTE, affecting, wound_bonus=wound_bon)
		playsound(src, 'sound/effects/splat.ogg', 50, TRUE)
		src.AddElement(/datum/element/squish, 20 SECONDS) // Totally not stolen from a vending machine code
		src.Knockdown(oversized_piggyknock)
		target.Knockdown(1) // simply make the oversized one fall
		if(get_turf(target) != get_turf(src))
			target.throw_at(get_turf(src), 1, 1, spin=FALSE, quickstart=FALSE)
		return
		//SKYRAT EDIT END

	return buckle_mob(target, TRUE, TRUE, RIDER_NEEDS_ARMS)

/mob/living/carbon/human/buckle_mob(mob/living/target, force = FALSE, check_loc = TRUE, buckle_mob_flags= NONE)
	if(!is_type_in_typecache(target, can_ride_typecache))
		target.visible_message(span_warning("[target] really can't seem to mount [src]..."))
		return

	if(!force)//humans are only meant to be ridden through piggybacking and special cases
		return

	return ..()

/mob/living/carbon/human/updatehealth()
	. = ..()
	dna?.species.spec_updatehealth(src)
	if(HAS_TRAIT(src, TRAIT_IGNOREDAMAGESLOWDOWN))
		remove_movespeed_modifier(/datum/movespeed_modifier/damage_slowdown)
		remove_movespeed_modifier(/datum/movespeed_modifier/damage_slowdown_flying)
		return
	var/health_deficiency = max((maxHealth - health), staminaloss)
	if(health_deficiency >= 40)
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/damage_slowdown, TRUE, multiplicative_slowdown = health_deficiency / 75)
		add_or_update_variable_movespeed_modifier(/datum/movespeed_modifier/damage_slowdown_flying, TRUE, multiplicative_slowdown = health_deficiency / 25)
	else
		remove_movespeed_modifier(/datum/movespeed_modifier/damage_slowdown)
		remove_movespeed_modifier(/datum/movespeed_modifier/damage_slowdown_flying)

/mob/living/carbon/human/adjust_nutrition(change) //Honestly FUCK the oldcoders for putting nutrition on /mob someone else can move it up because holy hell I'd have to fix SO many typechecks
	if(HAS_TRAIT(src, TRAIT_NOHUNGER))
		return FALSE
	return ..()

/mob/living/carbon/human/set_nutrition(change) //Seriously fuck you oldcoders.
	if(HAS_TRAIT(src, TRAIT_NOHUNGER))
		return FALSE
	return ..()

/mob/living/carbon/human/is_bleeding()
	if(NOBLOOD in dna.species.species_traits)
		return FALSE
	return ..()

/mob/living/carbon/human/get_total_bleed_rate()
	if(NOBLOOD in dna.species.species_traits)
		return FALSE
	return ..()

/mob/living/carbon/human/get_exp_list(minutes)
	. = ..()

	if(mind.assigned_role.title in SSjob.name_occupations)
		.[mind.assigned_role.title] = minutes

/mob/living/carbon/human/monkeybrain
	ai_controller = /datum/ai_controller/monkey

/mob/living/carbon/human/species
	var/race = null
	var/use_random_name = TRUE

/mob/living/carbon/human/species/Initialize(mapload)
	. = ..()
	INVOKE_ASYNC(src, .proc/set_species, race)

/mob/living/carbon/human/species/set_species(datum/species/mrace, icon_update = TRUE, pref_load = FALSE, list/override_features, list/override_mutantparts, list/override_markings, retain_features = FALSE, retain_mutantparts = FALSE) // SKYRAT EDIT - Customization
	. = ..()
	if(use_random_name)
		fully_replace_character_name(real_name, dna.species.random_name())

/mob/living/carbon/human/species/abductor
	race = /datum/species/abductor

/mob/living/carbon/human/species/android
	race = /datum/species/android

/mob/living/carbon/human/species/dullahan
	race = /datum/species/dullahan

/mob/living/carbon/human/species/felinid
	race = /datum/species/human/felinid

/mob/living/carbon/human/species/fly
	race = /datum/species/fly

/mob/living/carbon/human/species/golem
	race = /datum/species/golem

/mob/living/carbon/human/species/golem/adamantine
	race = /datum/species/golem/adamantine

/mob/living/carbon/human/species/golem/plasma
	race = /datum/species/golem/plasma

/mob/living/carbon/human/species/golem/diamond
	race = /datum/species/golem/diamond

/mob/living/carbon/human/species/golem/gold
	race = /datum/species/golem/gold

/mob/living/carbon/human/species/golem/silver
	race = /datum/species/golem/silver

/mob/living/carbon/human/species/golem/plasteel
	race = /datum/species/golem/plasteel

/mob/living/carbon/human/species/golem/titanium
	race = /datum/species/golem/titanium

/mob/living/carbon/human/species/golem/plastitanium
	race = /datum/species/golem/plastitanium

/mob/living/carbon/human/species/golem/alien_alloy
	race = /datum/species/golem/alloy

/mob/living/carbon/human/species/golem/wood
	race = /datum/species/golem/wood

/mob/living/carbon/human/species/golem/uranium
	race = /datum/species/golem/uranium

/mob/living/carbon/human/species/golem/sand
	race = /datum/species/golem/sand

/mob/living/carbon/human/species/golem/glass
	race = /datum/species/golem/glass

/mob/living/carbon/human/species/golem/bluespace
	race = /datum/species/golem/bluespace

/mob/living/carbon/human/species/golem/bananium
	race = /datum/species/golem/bananium

/mob/living/carbon/human/species/golem/blood_cult
	race = /datum/species/golem/runic

/mob/living/carbon/human/species/golem/cloth
	race = /datum/species/golem/cloth

/mob/living/carbon/human/species/golem/plastic
	race = /datum/species/golem/plastic

/mob/living/carbon/human/species/golem/bronze
	race = /datum/species/golem/bronze

/mob/living/carbon/human/species/golem/cardboard
	race = /datum/species/golem/cardboard

/mob/living/carbon/human/species/golem/leather
	race = /datum/species/golem/leather

/mob/living/carbon/human/species/golem/bone
	race = /datum/species/golem/bone

/mob/living/carbon/human/species/golem/durathread
	race = /datum/species/golem/durathread

/mob/living/carbon/human/species/golem/snow
	race = /datum/species/golem/snow

/mob/living/carbon/human/species/jelly
	race = /datum/species/jelly

/mob/living/carbon/human/species/jelly/slime
	race = /datum/species/jelly/slime

/mob/living/carbon/human/species/jelly/stargazer
	race = /datum/species/jelly/stargazer

/mob/living/carbon/human/species/jelly/luminescent
	race = /datum/species/jelly/luminescent

/mob/living/carbon/human/species/lizard
	race = /datum/species/lizard

/mob/living/carbon/human/species/lizard/ashwalker
	race = /datum/species/lizard/ashwalker

/mob/living/carbon/human/species/lizard/silverscale
	race = /datum/species/lizard/silverscale

/mob/living/carbon/human/species/ethereal
	race = /datum/species/ethereal

/mob/living/carbon/human/species/moth
	race = /datum/species/moth

/mob/living/carbon/human/species/mush
	race = /datum/species/mush

/mob/living/carbon/human/species/plasma
	race = /datum/species/plasmaman

/mob/living/carbon/human/species/pod
	race = /datum/species/pod

/mob/living/carbon/human/species/shadow
	race = /datum/species/shadow

/mob/living/carbon/human/species/shadow/nightmare
	race = /datum/species/shadow/nightmare

/mob/living/carbon/human/species/skeleton
	race = /datum/species/skeleton

/mob/living/carbon/human/species/snail
	race = /datum/species/snail

/mob/living/carbon/human/species/vampire
	race = /datum/species/vampire

/mob/living/carbon/human/species/zombie
	race = /datum/species/zombie

/mob/living/carbon/human/species/zombie/infectious
	race = /datum/species/zombie/infectious
