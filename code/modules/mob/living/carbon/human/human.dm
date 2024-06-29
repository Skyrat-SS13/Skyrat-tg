/mob/living/carbon/human/Initialize(mapload)
	add_verb(src, /mob/living/proc/mob_sleep)
	add_verb(src, /mob/living/proc/toggle_resting)

	icon_state = "" //Remove the inherent human icon that is visible on the map editor. We're rendering ourselves limb by limb, having it still be there results in a bug where the basic human icon appears below as south in all directions and generally looks nasty.

	setup_mood()
	// This needs to be called very very early in human init (before organs / species are created at the minimum)
	setup_organless_effects()
	// Physiology needs to be created before species, as some species modify physiology
	setup_physiology()

	create_dna()
	dna.species.create_fresh_body(src)
	setup_human_dna()

	create_carbon_reagents()
	set_species(dna.species.type)

	prepare_huds() //Prevents a nasty runtime on human init

	. = ..()

	RegisterSignal(src, COMSIG_COMPONENT_CLEAN_FACE_ACT, PROC_REF(clean_face))
	AddComponent(/datum/component/personal_crafting)
	AddElement(/datum/element/footstep, FOOTSTEP_MOB_HUMAN, 0.6, -6) //SKYRAT EDIT CHANGE - AESTHETICS
	AddComponent(/datum/component/bloodysoles/feet, FOOTPRINT_SPRITE_SHOES)
	AddElement(/datum/element/ridable, /datum/component/riding/creature/human)
	AddElement(/datum/element/strippable, GLOB.strippable_human_items, TYPE_PROC_REF(/mob/living/carbon/human/, should_strip))
	var/static/list/loc_connections = list(
		COMSIG_ATOM_ENTERED = PROC_REF(on_entered),
		COMSIG_LIVING_DISARM_PRESHOVE = PROC_REF(disarm_precollide),
		COMSIG_LIVING_DISARM_COLLIDE = PROC_REF(disarm_collision),
	)
	AddElement(/datum/element/connect_loc, loc_connections)
	GLOB.human_list += src
	SSopposing_force.give_opfor_button(src) //SKYRAT EDIT - OPFOR SYSTEM

/mob/living/carbon/human/proc/setup_physiology()
	physiology = new()

/mob/living/carbon/human/proc/setup_mood()
	if (CONFIG_GET(flag/disable_human_mood))
		return
	mob_mood = new /datum/mood(src)

/mob/living/carbon/human/dummy/setup_mood()
	return

/// This proc is for holding effects applied when a mob is missing certain organs
/// It is called very, very early in human init because all humans innately spawn with no organs and gain them during init
/// Gaining said organs removes these effects
/mob/living/carbon/human/proc/setup_organless_effects()
	// All start without eyes, and get them via set species
	become_blind(NO_EYES)
	// Mobs cannot taste anything without a tongue; the tongue organ removes this on Insert
	ADD_TRAIT(src, TRAIT_AGEUSIA, NO_TONGUE_TRAIT)

/mob/living/carbon/human/proc/setup_human_dna()
	randomize_human(src, randomize_mutations = TRUE)

/mob/living/carbon/human/Destroy()
	QDEL_NULL(physiology)
	GLOB.human_list -= src

	if (mob_mood)
		QDEL_NULL(mob_mood)

	return ..()

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

/mob/living/carbon/human/reset_perspective(atom/new_eye, force_reset = FALSE)
	if(dna?.species?.prevent_perspective_change && !force_reset) // This is in case a species needs to prevent perspective changes in certain cases, like Dullahans preventing perspective changes when they're looking through their head.
		update_fullscreen()
		return
	return ..()


/mob/living/carbon/human/Topic(href, href_list)

///////HUDs///////
	if(href_list["hud"])
		if(!ishuman(usr) && !isobserver(usr))
			return
		var/mob/human_or_ghost_user = usr
		var/perpname = get_face_name(get_id_name(""))
		if(!HAS_TRAIT(human_or_ghost_user, TRAIT_SECURITY_HUD) && !HAS_TRAIT(human_or_ghost_user, TRAIT_MEDICAL_HUD))
			return
		if((text2num(href_list["examine_time"]) + 1 MINUTES) < world.time)
			to_chat(human_or_ghost_user, "[span_notice("It's too late to use this now!")]")
			return
		var/datum/record/crew/target_record = find_record(perpname)
		if(href_list["photo_front"] || href_list["photo_side"])
			if(!target_record)
				return
			if(ishuman(human_or_ghost_user))
				var/mob/living/carbon/human/human_user = human_or_ghost_user
				if(!human_user.canUseHUD())
					return
			if(!HAS_TRAIT(human_or_ghost_user, TRAIT_SECURITY_HUD) && !HAS_TRAIT(human_or_ghost_user, TRAIT_MEDICAL_HUD))
				return
			var/obj/item/photo/photo_from_record = null
			if(href_list["photo_front"])
				photo_from_record = target_record.get_front_photo()
			else if(href_list["photo_side"])
				photo_from_record = target_record.get_side_photo()
			if(photo_from_record)
				photo_from_record.show(human_or_ghost_user)
			return

		if(ishuman(human_or_ghost_user) && href_list["hud"] == "m")
			var/mob/living/carbon/human/human_user = human_or_ghost_user
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

			if(href_list["physical_status"])
				var/health_status = tgui_input_list(human_user, "Specify a new physical status for this person.", "Medical HUD", PHYSICAL_STATUSES, target_record.physical_status)
				if(!health_status || !target_record || !human_user.canUseHUD() || !HAS_TRAIT(human_user, TRAIT_MEDICAL_HUD))
					return

				target_record.physical_status = health_status
				return

			if(href_list["mental_status"])
				var/health_status = tgui_input_list(human_user, "Specify a new mental status for this person.", "Medical HUD", MENTAL_STATUSES, target_record.mental_status)
				if(!health_status || !target_record || !human_user.canUseHUD() || !HAS_TRAIT(human_user, TRAIT_MEDICAL_HUD))
					return

				target_record.mental_status = health_status
				return

			if(href_list["quirk"])
				var/quirkstring = get_quirk_string(TRUE, CAT_QUIRK_ALL, from_scan = TRUE)
				if(quirkstring)
					to_chat(human_user,  "<span class='notice ml-1'>Detected physiological traits:</span>\n<span class='notice ml-2'>[quirkstring]</span>")
				else
					to_chat(usr,  "<span class='notice ml-1'>No physiological traits found.</span>")
			//SKYRAT EDIT ADDITION BEGIN - EXAMINE RECORDS
			if(href_list["medrecords"])
				to_chat(usr, "<b>Medical Record:</b> [target_record.past_medical_records]")
			if(href_list["genrecords"])
				to_chat(usr, "<b>General Record:</b> [target_record.past_general_records]")
			//SKYRAT EDIT END
			return //Medical HUD ends here.

		if(href_list["hud"] == "s")
			var/allowed_access = null
			if(!HAS_TRAIT(human_or_ghost_user, TRAIT_SECURITY_HUD))
				return
			if(ishuman(human_or_ghost_user))
				var/mob/living/carbon/human/human_user = human_or_ghost_user
				if(human_user.stat || human_user == src) //|| !human_user.canmove || human_user.restrained()) Fluff: Sechuds have eye-tracking technology and sets 'arrest' to people that the wearer looks and blinks at.
					return   //Non-fluff: This allows sec to set people to arrest as they get disarmed or beaten
			// Checks the user has security clearence before allowing them to change arrest status via hud, comment out to enable all access
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
				to_chat(human_or_ghost_user, span_warning("ERROR: Can not identify target."))
				return
			target_record = find_record(perpname)
			if(!target_record)
				to_chat(human_or_ghost_user, span_warning("ERROR: Unable to locate data core entry for target."))
				return
			if(ishuman(human_or_ghost_user) && href_list["status"])
				var/mob/living/carbon/human/human_user = human_or_ghost_user
				var/new_status = tgui_input_list(human_user, "Specify a new criminal status for this person.", "Security HUD", WANTED_STATUSES(), target_record.wanted_status)
				if(!new_status || !target_record || !human_user.canUseHUD() || !HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
					return

				if(new_status == WANTED_ARREST)
					var/datum/crime/new_crime = new(author = human_user, details = "Set by SecHUD.")
					target_record.crimes += new_crime
					investigate_log("SecHUD auto-crime | Added to [target_record.name] by [key_name(human_user)]", INVESTIGATE_RECORDS)

				investigate_log("has been set from [target_record.wanted_status] to [new_status] via HUD by [key_name(human_user)].", INVESTIGATE_RECORDS)
				target_record.wanted_status = new_status
				update_matching_security_huds(target_record.name)
				return

			if(href_list["view"])
				if(ishuman(human_or_ghost_user))
					var/mob/living/carbon/human/human_user = human_or_ghost_user
					if(!human_user.canUseHUD())
						return
				if(!HAS_TRAIT(human_or_ghost_user, TRAIT_SECURITY_HUD))
					return
				var/sec_record_message = ""
				sec_record_message += "<b>Name:</b> [target_record.name]"
				sec_record_message += "\n<b>Criminal Status:</b> [target_record.wanted_status]"
				sec_record_message += "\n<b>Citations:</b> [length(target_record.citations)]"
				sec_record_message += "\n<b>Note:</b> [target_record.security_note || "None"]"
				sec_record_message += "\n<b>Rapsheet:</b> [length(target_record.crimes)] incidents"
				if(length(target_record.crimes))
					for(var/datum/crime/crime in target_record.crimes)
						if(!crime.valid)
							sec_record_message += span_notice("\n-- REDACTED --")
							continue

						sec_record_message += "\n<b>Crime:</b> [crime.name]"
						sec_record_message += "\n<b>Details:</b> [crime.details]"
						sec_record_message += "\nAdded by [crime.author] at [crime.time]"
				to_chat(human_or_ghost_user, examine_block(sec_record_message))
				return
			if(ishuman(human_or_ghost_user))
				var/mob/living/carbon/human/human_user = human_or_ghost_user
				if(href_list["add_citation"])
					var/max_fine = CONFIG_GET(number/maxfine)
					var/citation_name = tgui_input_text(human_user, "Citation crime", "Security HUD")
					var/fine = tgui_input_number(human_user, "Citation fine", "Security HUD", 50, max_fine, 5)
					if(!fine || !target_record || !citation_name || !allowed_access || !isnum(fine) || fine > max_fine || fine <= 0 || !human_user.canUseHUD() || !HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
						return

					var/datum/crime/citation/new_citation = new(name = citation_name, author = allowed_access, fine = fine)

					target_record.citations += new_citation
					new_citation.alert_owner(usr, src, target_record.name, "You have been fined [fine] credits for '[citation_name]'. Fines may be paid at security.")
					investigate_log("New Citation: <strong>[citation_name]</strong> Fine: [fine] | Added to [target_record.name] by [key_name(human_user)]", INVESTIGATE_RECORDS)
					SSblackbox.ReportCitation(REF(new_citation), human_user.ckey, human_user.real_name, target_record.name, citation_name, fine)
					return

				//SKYRAT EDIT ADDITION BEGIN - EXAMINE RECORDS
				if(href_list["genrecords"])
					if(!human_user.canUseHUD())
						return
					if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
						return
					to_chat(human_user, "<b>General Record:</b> [target_record.past_general_records]")

				if(href_list["secrecords"])
					if(!human_user.canUseHUD())
						return
					if(!HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
						return
					to_chat(human_user, "<b>Security Record:</b> [target_record.past_security_records]")
				//SKYRAT EDIT END

				if(href_list["add_crime"])
					var/crime_name = tgui_input_text(human_user, "Crime name", "Security HUD")
					if(!target_record || !crime_name || !allowed_access || !human_user.canUseHUD() || !HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
						return

					var/datum/crime/new_crime = new(name = crime_name, author = allowed_access)

					target_record.crimes += new_crime
					investigate_log("New Crime: <strong>[crime_name]</strong> | Added to [target_record.name] by [key_name(human_user)]", INVESTIGATE_RECORDS)
					to_chat(human_user, span_notice("Successfully added a crime."))

					return

				if(href_list["add_note"])
					var/new_note = tgui_input_text(human_user, "Security note", "Security Records", multiline = TRUE)
					if(!target_record || !new_note || !allowed_access || !human_user.canUseHUD() || !HAS_TRAIT(human_user, TRAIT_SECURITY_HUD))
						return

					target_record.security_note = new_note

					return

	//SKYRAT EDIT ADDITION BEGIN - VIEW RECORDS
	if(href_list["bgrecords"])
		if(isobserver(usr) || usr.mind.can_see_exploitables || usr.mind.has_exploitables_override)
			var/examined_name = get_face_name(get_id_name(""))
			var/datum/record/crew/target_record = find_record(examined_name)
			to_chat(usr, "<b>Background information:</b> [target_record.background_information]")
	if(href_list["exprecords"])
		if(isobserver(usr) || usr.mind.can_see_exploitables || usr.mind.has_exploitables_override)
			var/examined_name = get_face_name(get_id_name("")) //Named as such because this is the name we see when we examine
			var/datum/record/crew/target_record = find_record(examined_name)
			to_chat(usr, "<b>Exploitable information:</b> [target_record.exploitable_information]")
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
		for(var/obj/item/clothing/iter_clothing in get_clothing_on_part(the_part))
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

/mob/living/carbon/human/get_butt_sprite()
	var/obj/item/bodypart/chest/chest = get_bodypart(BODY_ZONE_CHEST)
	return chest?.get_butt_sprite()

/mob/living/carbon/human/get_footprint_sprite()
	var/obj/item/bodypart/leg/L = get_bodypart(BODY_ZONE_R_LEG) || get_bodypart(BODY_ZONE_L_LEG)
	return shoes?.footprint_sprite || L?.footprint_sprite

#define CHECK_PERMIT(item) (item && item.item_flags & NEEDS_PERMIT)

/mob/living/carbon/human/assess_threat(judgement_criteria, lasercolor = "", datum/callback/weaponcheck=null)
	if(judgement_criteria & JUDGE_EMAGGED || HAS_TRAIT(src, TRAIT_ALWAYS_WANTED))
		return 10 //Everyone is a criminal!

	var/threatcount = judgement_criteria & JUDGE_CHILLOUT ? -THREAT_ASSESS_DANGEROUS : 0

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
	threatcount += idcard?.trim.threat_modifier || 0
	if((judgement_criteria & JUDGE_IDCHECK) && isnull(idcard) && name == "Unknown")
		threatcount += 4

	//Check for weapons
	if((judgement_criteria & JUDGE_WEAPONCHECK))
		if(isnull(idcard) || !(ACCESS_WEAPONS in idcard.access))
			for(var/obj/item/toy_gun in held_items) //if they're holding a gun
				if(CHECK_PERMIT(toy_gun))
					threatcount += 4
			if(CHECK_PERMIT(belt) || CHECK_PERMIT(back)) //if a weapon is present in the belt or back slot
				threatcount += 2 //not enough to trigger look_for_perp() on it's own unless they also have criminal status.

	//Check for arrest warrant
	if(judgement_criteria & JUDGE_RECORDCHECK)
		var/perpname = get_face_name(get_id_name())
		var/datum/record/crew/record = find_record(perpname)
		if(record?.wanted_status)
			switch(record.wanted_status)
				if(WANTED_ARREST)
					threatcount += 5
				if(WANTED_PRISONER)
					threatcount += 2
				if(WANTED_SUSPECT)
					threatcount += 2
				if(WANTED_PAROLE)
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

#undef CHECK_PERMIT

//Used for new human mobs created by cloning/goleming/podding
/mob/living/carbon/human/proc/set_cloned_appearance()
	if(gender == MALE)
		set_facial_hairstyle("Full Beard", update = FALSE)
	else
		set_facial_hairstyle("Shaved", update = FALSE)
	set_hairstyle(pick("Bedhead", "Bedhead 2", "Bedhead 3"), update = FALSE)
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
			balloon_alert(src, "[target.p_they()] [target.p_are()] dead!")
			return FALSE

		if (is_mouth_covered())
			balloon_alert(src, "remove your mask first!")
			return FALSE

		if (target.is_mouth_covered())
			balloon_alert(src, "remove [target.p_their()] mask first!")
			return FALSE

		if(HAS_TRAIT_FROM(src, TRAIT_NOBREATH, DISEASE_TRAIT))
			to_chat(src, span_warning("you can't breathe!"))
			return FALSE

		var/obj/item/organ/internal/lungs/human_lungs = get_organ_slot(ORGAN_SLOT_LUNGS)
		if(isnull(human_lungs))
			balloon_alert(src, "you don't have lungs!")
			return FALSE
		if(human_lungs.organ_flags & ORGAN_FAILING)
			balloon_alert(src, "your lungs are too damaged!")
			return FALSE

		visible_message(span_notice("[src] is trying to perform CPR on [target.name]!"), \
						span_notice("You try to perform CPR on [target.name]... Hold still!"))

		if (!do_after(src, delay = panicking ? CPR_PANIC_SPEED : (3 SECONDS), target = target))
			balloon_alert(src, "you fail to perform CPR!")
			return FALSE

		if (target.health > target.crit_threshold)
			return FALSE

		visible_message(span_notice("[src] performs CPR on [target.name]!"), span_notice("You perform CPR on [target.name]."))
		if(HAS_MIND_TRAIT(src, TRAIT_MORBID))
			add_mood_event("morbid_saved_life", /datum/mood_event/morbid_saved_life)
		else
			add_mood_event("saved_life", /datum/mood_event/saved_life)
		log_combat(src, target, "CPRed")

		if (HAS_TRAIT(target, TRAIT_NOBREATH))
			to_chat(target, span_unconscious("You feel a breath of fresh air... which is a sensation you don't recognise..."))
		else if (!target.get_organ_slot(ORGAN_SLOT_LUNGS))
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
 * Called on the COMSIG_COMPONENT_CLEAN_FACE_ACT signal
 */
/mob/living/carbon/human/proc/clean_face(datum/source, clean_types)
	SIGNAL_HANDLER
	if(!is_mouth_covered() && clean_lips())
		. = TRUE

	if(glasses && is_eyes_covered(ITEM_SLOT_MASK|ITEM_SLOT_HEAD) && glasses.wash(clean_types))
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

	if(!(obscured & ITEM_SLOT_ICLOTHING) && w_uniform?.wash(clean_types))
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
	var/mutable_appearance/zap_appearance

	// If we have a species, we need to handle mutant parts and stuff
	if(dna?.species)
		add_atom_colour(COLOR_BLACK, TEMPORARY_COLOUR_PRIORITY)
		var/static/mutable_appearance/shock_animation_dna
		if(!shock_animation_dna)
			shock_animation_dna = mutable_appearance(icon, "electrocuted_base")
			shock_animation_dna.appearance_flags |= RESET_COLOR|KEEP_APART
		zap_appearance = shock_animation_dna

	// Otherwise do a generic animation
	else
		var/static/mutable_appearance/shock_animation_generic
		if(!shock_animation_generic)
			shock_animation_generic = mutable_appearance(icon, "electrocuted_generic")
			shock_animation_generic.appearance_flags |= RESET_COLOR|KEEP_APART
		zap_appearance = shock_animation_generic

	add_overlay(zap_appearance)
	addtimer(CALLBACK(src, PROC_REF(end_electrocution_animation), zap_appearance), anim_duration)

/mob/living/carbon/human/proc/end_electrocution_animation(mutable_appearance/MA)
	remove_atom_colour(TEMPORARY_COLOUR_PRIORITY, COLOR_BLACK)
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
	// SKYRAT EDIT ADDITION: NOW GLOVES CAN RESTRAIN PLAYERS
	if(I == gloves)
		visible_message(span_danger("[src] manages to [cuff_break ? "break" : "remove"] [I]!"))
		to_chat(src, span_notice("You successfully [cuff_break ? "break" : "remove"] [I]."))
		return TRUE
	// SKYRAT EDIT ADDITION END

/mob/living/carbon/human/replace_records_name(oldname, newname) // Only humans have records right now, move this up if changed.
	var/datum/record/crew/crew_record = find_record(oldname)
	var/datum/record/locked/locked_record = find_record(oldname, locked_only = TRUE)

	if(crew_record)
		crew_record.name = newname
	if(locked_record)
		locked_record.name = newname

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

/mob/living/carbon/human/fully_heal(heal_flags = HEAL_ALL)
	if(heal_flags & HEAL_NEGATIVE_MUTATIONS)
		for(var/datum/mutation/human/existing_mutation in dna.mutations)
			if(existing_mutation.quality != POSITIVE && existing_mutation.remove_on_aheal)
				dna.remove_mutation(existing_mutation)

	if(heal_flags & HEAL_TEMP)
		set_coretemperature(get_body_temp_normal(apply_change = FALSE))
		heat_exposure_stacks = 0

	return ..()

/mob/living/carbon/human/vomit(vomit_flags = VOMIT_CATEGORY_DEFAULT, vomit_type = /obj/effect/decal/cleanable/vomit/toxic, lost_nutrition = 10, distance = 1, purge_ratio = 0.1)
	if(!((vomit_flags & MOB_VOMIT_BLOOD) && HAS_TRAIT(src, TRAIT_NOBLOOD) && !HAS_TRAIT(src, TRAIT_TOXINLOVER)))
		return ..()

	if(vomit_flags & MOB_VOMIT_MESSAGE)
		visible_message(
			span_warning("[src] dry heaves!"),
			span_userdanger("You try to throw up, but there's nothing in your stomach!"),
		)
	if(vomit_flags & MOB_VOMIT_STUN)
		Stun(20 SECONDS)
	if(vomit_flags & MOB_VOMIT_KNOCKDOWN)
		Knockdown(20 SECONDS)

	return TRUE

/mob/living/carbon/human/vv_edit_var(var_name, var_value)
	if(var_name == NAMEOF(src, mob_height))
		var/static/list/monkey_heights = list(
			MONKEY_HEIGHT_DWARF,
			MONKEY_HEIGHT_MEDIUM,
		)
		var/static/list/heights = list(
			HUMAN_HEIGHT_SHORTEST,
			HUMAN_HEIGHT_SHORT,
			HUMAN_HEIGHT_MEDIUM,
			HUMAN_HEIGHT_TALL,
			HUMAN_HEIGHT_TALLER,
			HUMAN_HEIGHT_TALLEST
		)
		if(ismonkey(src))
			if(!(var_value in monkey_heights))
				return
		else if(!(var_value in heights))
			return

		. = set_mob_height(var_value)

	if(!isnull(.))
		datum_flags |= DF_VAR_EDITED
		return

	return ..()

/mob/living/carbon/human/vv_get_dropdown()
	. = ..()
	VV_DROPDOWN_OPTION("", "---------")
	VV_DROPDOWN_OPTION(VV_HK_COPY_OUTFIT, "Copy Outfit")
	VV_DROPDOWN_OPTION(VV_HK_MOD_MUTATIONS, "Add/Remove Mutation")
	VV_DROPDOWN_OPTION(VV_HK_MOD_QUIRKS, "Add/Remove Quirks")
	VV_DROPDOWN_OPTION(VV_HK_SET_SPECIES, "Set Species")
	VV_DROPDOWN_OPTION(VV_HK_PURRBATION, "Toggle Purrbation")
	VV_DROPDOWN_OPTION(VV_HK_APPLY_DNA_INFUSION, "Apply DNA Infusion")
	VV_DROPDOWN_OPTION(VV_HK_TURN_INTO_MMI, "Turn into MMI")

/mob/living/carbon/human/vv_do_topic(list/href_list)
	. = ..()

	if(!.)
		return

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
			// SKYRAT EDIT ADDITION START
			if(initial(quirk_type.erp_quirk) && CONFIG_GET(flag/disable_erp_preferences))
				continue
			// SKYRAT EDIT ADDITION END
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
		var/result = input(usr, "Please choose a new species","Species") as null|anything in sortTim(GLOB.species_list, GLOBAL_PROC_REF(cmp_text_asc))
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

	if(href_list[VV_HK_APPLY_DNA_INFUSION])
		if(!check_rights(R_SPAWN))
			return
		if(!ishuman(src))
			to_chat(usr, "This can only be done to human species.")
			return
		var/result = usr.client.grant_dna_infusion(src)
		if(result)
			to_chat(usr, "Successfully applied DNA Infusion [result] to [src].")
			log_admin("[key_name(usr)] has applied DNA Infusion [result] to [key_name(src)].")
		else
			to_chat(usr, "Failed to apply DNA Infusion to [src].")
			log_admin("[key_name(usr)] failed to apply a DNA Infusion to [key_name(src)].")

	if(href_list[VV_HK_TURN_INTO_MMI])
		if(!check_rights(R_DEBUG))
			return

		var/result = input(usr, "This will delete the mob, are you sure?", "Turn into MMI") in list("Yes", "No")
		if(result != "Yes")
			return

		var/obj/item/organ/internal/brain/target_brain = get_organ_slot(ORGAN_SLOT_BRAIN)

		if(isnull(target_brain))
			to_chat(usr, "This mob has no brain to insert into an MMI.")
			return

		var/obj/item/mmi/new_mmi = new(get_turf(src))

		target_brain.Remove(src)
		new_mmi.force_brain_into(target_brain)

		to_chat(usr, "Turned [src] into an MMI.")
		log_admin("[key_name(usr)] turned [key_name_and_tag(src)] into an MMI.")

		qdel(src)



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
	var/skills_space
	var/fitness_level = mind.get_skill_level(/datum/skill/athletics) - 1
	if(HAS_TRAIT(src, TRAIT_QUICKER_CARRY))
		carrydelay -= 2 SECONDS
	else if(HAS_TRAIT(src, TRAIT_QUICK_CARRY))
		carrydelay -= 1 SECONDS

	// can remove up to 2 seconds at legendary
	carrydelay -= fitness_level * (1/3) SECONDS

	if(carrydelay <= 3 SECONDS)
		skills_space = " very quickly"
	else if(carrydelay <= 4 SECONDS)
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
		AddElement(/datum/element/squish, 20 SECONDS) // Totally not stolen from a vending machine code
		Knockdown(oversized_piggyknock) // Knocking down the unlucky guy
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

/mob/living/carbon/human/reagent_check(datum/reagent/chem, seconds_per_tick, times_fired)
	. = ..()
	if(. & COMSIG_MOB_STOP_REAGENT_CHECK)
		return
	return dna.species.handle_chemical(chem, src, seconds_per_tick, times_fired)

/mob/living/carbon/human/updatehealth()
	. = ..()
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

/mob/living/carbon/human/is_bleeding()
	if(HAS_TRAIT(src, TRAIT_NOBLOOD))
		return FALSE
	return ..()

/mob/living/carbon/human/get_total_bleed_rate()
	if(HAS_TRAIT(src, TRAIT_NOBLOOD))
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

/mob/living/carbon/human/species/create_dna()
	dna = new /datum/dna(src)
	if (!isnull(race))
		dna.species = new race

/mob/living/carbon/human/species/set_species(datum/species/mrace, icon_update = TRUE, pref_load = FALSE, list/override_features, list/override_mutantparts, list/override_markings, retain_features = FALSE, retain_mutantparts = FALSE) // SKYRAT EDIT - Customization
	. = ..()
	if(use_random_name)
		fully_replace_character_name(real_name, generate_random_mob_name())

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
