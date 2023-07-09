//
// ANTAG INFO
//

/datum/antagonist/ert/request_911
	name = "911 Responder"
	antag_hud_name = "hud_spacecop"
	suicide_cry = "FOR THE SOL FEDERATION!!"
	/// Used in the greet() text to say what kind of assistance the responder is providing
	var/department = "(Report Me!)"

/datum/antagonist/ert/request_911/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are responding to emergency calls from the station for immediate SolFed [department] assistance!\n"
	missiondesc += "<BR>Use the Cell Phone in your backpack to confer with fellow first responders!\n"
	missiondesc += "<BR><B>911 Transcript is as follows</B>:"
	missiondesc += "<BR> [GLOB.call_911_msg]"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact [GLOB.caller_of_911] and assist them in resolving the matter."
	missiondesc += "<BR> <B>2.</B> Protect, ensure, and uphold the rights of Sol Federation citizens on board [station_name()]."
	missiondesc += "<BR> <B>3.</B> If you believe yourself to be in danger, unable to do the job assigned to you due to a dangerous situation, \
		or that the 911 call was made in error, you can use the S.W.A.T. Backup Caller in your backpack to vote on calling a S.W.A.T. team to assist in the situation. \
		This will fine the station 20k credits."
	missiondesc += "<BR> <B>4.</B> When you have finished with your work on the station, use the Beamout Tool in your backpack to beam out yourself \
		along with anyone you are pulling."
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

/datum/antagonist/ert/request_911/apply_innate_effects(mob/living/mob_override)
	..()
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		var/atom/movable/screen/wanted/giving_wanted_lvl = new /atom/movable/screen/wanted()
		H.wanted_lvl = giving_wanted_lvl
		giving_wanted_lvl.hud = H
		H.infodisplay += giving_wanted_lvl
		H.mymob.client.screen += giving_wanted_lvl

/datum/antagonist/ert/request_911/remove_innate_effects(mob/living/mob_override)
	var/mob/living/M = mob_override || owner.current
	if(M.hud_used)
		var/datum/hud/H = M.hud_used
		H.infodisplay -= H.wanted_lvl
		QDEL_NULL(H.wanted_lvl)
	..()

// MARSHALS
/datum/antagonist/ert/request_911/police
	name = "SolFed Marshal"
	role = "Marshal"
	department = "Marshal"
	outfit = /datum/outfit/request_911/police

// ATMOS
/datum/antagonist/ert/request_911/atmos
	name = "Adv. Atmos Tech"
	role = "Adv. Atmospherics Technician"
	department = "Breach Control"
	outfit = /datum/outfit/request_911/atmos

// MEDICAL
/datum/antagonist/ert/request_911/emt
	name = "Emergency Medical Technician"
	role = "EMT"
	department = "Emergency Medical"
	outfit = /datum/outfit/request_911/emt

// SWAT
/datum/antagonist/ert/request_911/condom_destroyer
	name = "Armed S.W.A.T. Officer"
	role = "S.W.A.T. Officer"
	department = "Police"
	outfit = /datum/outfit/request_911/condom_destroyer

/datum/antagonist/ert/request_911/condom_destroyer/leader
	name = "Armed S.W.A.T. Leader"
	role = "S.W.A.T. Leader"
	outfit = /datum/outfit/request_911/condom_destroyer/leader

/datum/antagonist/ert/request_911/condom_destroyer/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are here to backup the 911 first responders, as they have requested assistance.\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact the first responders using the Cell Phone in your backpack to figure out the situation."
	missiondesc += "<BR> <B>2.</B> Arrest anyone who interferes the work of the first responders."
	missiondesc += "<BR> <B>3.</B> If subjects do not comply or engage in hostility, and can not be handled non-lethally, then lethal force is authorized."
	missiondesc += "<BR> <B>4.</B> If you believe the station is engaging in treason and is attacking first responders and S.W.A.T. members, use the \
		Treason Reporter in your backpack to call the military."
	missiondesc += "<BR> <B>5.</B> When you have finished with your work on the station, use the Beamout Tool in your backpack to beam out yourself \
		along with anyone you are pulling."
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)

// MILITARY
/datum/antagonist/ert/request_911/treason_destroyer
	name = "Sol Federation Military"
	role = "Private"
	department = "Military"
	outfit = /datum/outfit/request_911/treason_destroyer

/datum/antagonist/ert/request_911/treason_destroyer/leader
	name = "Sol Federation Military"
	role = "Sergeant"
	department = "Military"
	outfit = /datum/outfit/request_911/treason_destroyer/leader

/datum/antagonist/ert/request_911/treason_destroyer/greet()
	var/missiondesc =  ""
	missiondesc += "<B><font size=5 color=red>You are NOT a Nanotrasen Employee. You work for the Sol Federation as a [role].</font></B>"
	missiondesc += "<BR>You are here to assume control of [station_name()] due to the occupants engaging in Treason as reported by our SWAT team.\n"
	missiondesc += "<BR><B>Your Mission</B>:"
	missiondesc += "<BR> <B>1.</B> Contact the SWAT Team and the First Responders via your cell phone to get the situation from them."
	missiondesc += "<BR> <B>2.</B> Arrest all suspects involved in the treason attempt."
	missiondesc += "<BR> <B>3.</B> Assume control of the station for the Sol Federation, and initiate evacuation procedures to get non-offending citizens \
		away from the scene."
	missiondesc += "<BR> <B>4.</B> Lethal force is authorized, but strongly advised against. Try to show SolFed in a good light."
	to_chat(owner, missiondesc)
	var/mob/living/greeted_mob = owner.current
	greeted_mob.playsound_local(greeted_mob, 'sound/effects/families_police.ogg', 100, FALSE, pressure_affected = FALSE, use_reverb = FALSE)


//
// OUTFITS
//

// Base type for the sake of setting ID stuff on post_equip
/datum/outfit/request_911
	name = "911 Response: Base"
	back = /obj/item/storage/backpack/duffelbag/cops
	backpack_contents = list(/obj/item/solfed_reporter/swat_caller = 1)

	id_trim = /datum/id_trim/space_police

/datum/outfit/request_911/post_equip(mob/living/carbon/human/human_to_equip, visualsOnly = FALSE)
	if(visualsOnly)
		return

	var/obj/item/card/id/ID_to_give = human_to_equip.wear_id
	if(istype(ID_to_give))
		shuffle_inplace(ID_to_give.access) // Shuffle access list to make NTNet passkeys less predictable
		ID_to_give.registered_name = human_to_equip.real_name
		if(human_to_equip.age)
			ID_to_give.registered_age = human_to_equip.age
		ID_to_give.update_label()
		ID_to_give.update_icon()
		human_to_equip.sec_hud_set_ID()

// MARSHALS
/datum/outfit/request_911/police
	name = "911 Response: SolFed Marshal"
	back = /obj/item/storage/backpack/duffelbag/cops
	uniform = /obj/item/clothing/under/rank/centcom/skyrat/solfed/marshal
	shoes = /obj/item/clothing/shoes/combat
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	belt = /obj/item/gun/energy/disabler
	r_pocket = /obj/item/lighter
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/solfed
	backpack_contents = list(/obj/item/storage/box/survival = 1,
		/obj/item/sol_evasion_kit,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/solfed_reporter/swat_caller = 1,
		/obj/item/beamout_tool = 1)

	id_trim = /datum/id_trim/solfed

// ATMOS
/datum/outfit/request_911/atmos
	name = "811 Response: Advanced Atmospherics"
	back = /obj/item/mod/control/pre_equipped/advanced/atmos
	uniform = /obj/item/clothing/under/rank/engineering/atmospheric_technician/skyrat/utility/advanced
	shoes = /obj/item/clothing/shoes/jackboots
	ears = /obj/item/radio/headset/headset_solfed/atmos
	mask = /obj/item/clothing/mask/gas/atmos/glass
	belt = /obj/item/storage/belt/utility/full/powertools/ircd
	suit_store = /obj/item/tank/internals/oxygen/yellow
	id = /obj/item/card/id/advanced/solfed
	backpack_contents = list(/obj/item/storage/box/rcd_ammo = 1,
		/obj/item/storage/box/smart_metal_foam = 1,
		/obj/item/multitool = 1,
		/obj/item/extinguisher/advanced = 1,
		/obj/item/rwd/loaded = 1,
		/obj/item/beamout_tool = 1,
		/obj/item/solfed_reporter/swat_caller = 1,
		)
	id_trim = /datum/id_trim/solfed/atmos

// MEDICAL
/datum/outfit/request_911/emt
	name = "911 Response: EMT"
	back = /obj/item/storage/backpack/duffelbag/cops
	uniform = /obj/item/clothing/under/rank/medical/paramedic
	shoes = /obj/item/clothing/shoes/sneakers/white
	ears = /obj/item/radio/headset/headset_med
	head = /obj/item/clothing/head/soft/paramedic
	id = /obj/item/card/id/advanced/solfed
	suit =  /obj/item/clothing/suit/toggle/labcoat/paramedic
	gloves = /obj/item/clothing/gloves/latex/nitrile
	belt = /obj/item/storage/belt/medical/paramedic
	suit_store = /obj/item/flashlight/pen/paramedic
	backpack_contents = list(/obj/item/storage/box/survival = 1,
		/obj/item/roller = 1,
		/obj/item/storage/medkit/surgery = 1,
		/obj/item/solfed_reporter/swat_caller = 1,
		/obj/item/beamout_tool = 1)

	id_trim = /datum/id_trim/solfed

// SWAT
/datum/outfit/request_911/condom_destroyer
	name = "911 Response: Armed S.W.A.T. Officer"
	back = /obj/item/storage/backpack/duffelbag/cops
	uniform = /obj/item/clothing/under/rank/centcom/skyrat/solfed/marshal
	shoes = /obj/item/clothing/shoes/combat
	mask = /obj/item/clothing/mask/balaclava
	gloves = /obj/item/clothing/gloves/tackler/combat
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	head = /obj/item/clothing/head/helmet/toggleable/riot/sol
	belt = /obj/item/gun/energy/disabler
	suit = /obj/item/clothing/suit/armor/riot/sol
	r_pocket = /obj/item/lighter
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/solfed
	l_hand = /obj/item/gun/ballistic/shotgun/riot
	backpack_contents = list(/obj/item/storage/box/survival = 1,
		/obj/item/storage/box/handcuffs = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/storage/box/lethalshot = 2,
		/obj/item/solfed_reporter/treason_reporter = 1,
		/obj/item/beamout_tool = 1)

	id_trim = /datum/id_trim/solfed

/datum/outfit/request_911/condom_destroyer/leader
	mask = null
	head = /obj/item/clothing/head/beret/sol
	suit = /obj/item/clothing/suit/armor/riot/sol/leader
	r_pocket = /obj/item/megaphone

// MILITARY
/datum/outfit/request_911/treason_destroyer
	name = "911 Response: SolFed Military"

	uniform = /obj/item/clothing/under/rank/security/officer/hecu
	head = /obj/item/clothing/head/helmet/toggleable/riot/sol
	mask = /obj/item/clothing/mask/gas/hecu2
	gloves = /obj/item/clothing/gloves/combat
	suit = /obj/item/clothing/suit/armor/vest/alt/sol
	shoes = /obj/item/clothing/shoes/combat

	back = /obj/item/storage/backpack/duffelbag/cops
	glasses = /obj/item/clothing/glasses/sunglasses
	ears = /obj/item/radio/headset/headset_sec/alt
	l_pocket = /obj/item/restraints/handcuffs
	id = /obj/item/card/id/advanced/solfed
	r_hand = /obj/item/gun/ballistic/automatic/m16
	backpack_contents = list(/obj/item/storage/box/handcuffs = 1,
		/obj/item/melee/baton/security/loaded = 1,
		/obj/item/ammo_box/magazine/m16 = 4
	)

	id_trim = /datum/id_trim/solfed

/datum/outfit/request_911/treason_destroyer/leader
	head = /obj/item/clothing/head/beret/sol
	suit = /obj/item/clothing/suit/armor/riot/sol/leader
	r_pocket = /obj/item/megaphone
