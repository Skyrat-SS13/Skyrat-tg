/obj/item/mmi/posibrain/CtrlClick(mob/living/user)
	eject_posi(user)
	to_chat(user, span_notice("You press the button and release the electronics from the posibrain."))

/obj/item/mmi/posibrain/proc/eject_posi(mob/user)
	var/obj/item/organ/brain/ipc_positron/roboticsmotherboard/brain = new /obj/item/organ/brain/ipc_positron/roboticsmotherboard
	brainmob.container = null //Reset brainmob mmi var.
	brainmob.forceMove(brain) //Throw mob into brain.
	brainmob.set_stat(DEAD)
	brainmob.emp_damage = 0
	brainmob.reset_perspective() //so the brainmob follows the brain organ instead of the mmi. And to update our vision
	brain.brainmob = brainmob //Set the brain to use the brainmob
	brainmob = null //Set mmi brainmob var to null
	brain.forceMove(drop_location())
	if(Adjacent(user))
		user.put_in_hands(brain)
	brain.organ_flags &= ~ORGAN_FROZEN
	brain = null //No more brain in here
	qdel(src)

/obj/item/organ/brain/ipc_positron/roboticsmotherboard
	name = "positronics motherboard"
	slot = ORGAN_SLOT_BRAIN
	zone = BODY_ZONE_CHEST
	status = ORGAN_ROBOTIC
	organ_flags = ORGAN_SYNTHETIC
	desc = "A motherboard housing an artificial consciousness, cannot speak unlike the blocky counterpart."
	icon = 'icons/obj/module.dmi'
	icon_state = "integrated_circuit"

// ===TECH NODES===

/datum/techweb_node/sapient_synth
	id = "sapient_synth"
	display_name = "Sapient synthetic research"
	description = "Machines with autonomy comparable to that of a living crewmember."
	prereq_ids = list("adv_robotics")
	design_ids = list(
		//"newipc_hollow",
		"ipccell",
		"ipccord",
		"ipceyes",
		"ipcears",
		"ipcvoice",
		"ipclungs",
		"ipcheart",
		"ipcliver"
	)
	research_costs = list(TECHWEB_POINT_TYPE_GENERIC = 4000)

/datum/design/newipc_hollow
	name = "I.P.C hollow shell"
	id = "newipc_hollow"
	build_type = MECHFAB
	build_path = /obj/item/ipc_deployer
	materials = list(/datum/material/iron=15000, /datum/material/gold=10000, /datum/material/silver=4000, /datum/material/glass=2000, )
	construction_time = 500
	category = list("Cybernetics")

/datum/design/ipccell
	name = "I.P.C power cell"
	id = "ipccell"
	build_type = MECHFAB
	build_path = /obj/item/organ/stomach/robot_ipc
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	construction_time = 150
	category = list("Cybernetics")

/datum/design/ipccord
	name = "I.P.C power cord"
	id = "ipccord"
	build_type = MECHFAB
	build_path = /obj/item/organ/cyberimp/arm/power_cord
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	construction_time = 150
	category = list("Cybernetics")

/datum/design/ipceyes
	name = "I.P.C eyes"
	id = "ipceyes"
	build_type = MECHFAB
	build_path = /obj/item/organ/eyes/robot_ipc
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	construction_time = 150
	category = list("Cybernetics")

/datum/design/ipcears
	name = "I.P.C auditory sensors"
	id = "ipcears"
	build_type = MECHFAB
	build_path = /obj/item/organ/ears/robot_ipc
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	construction_time = 150
	category = list("Cybernetics")

/datum/design/ipcvoice
	name = "robotic voicebox"
	id = "ipcvoice"
	build_type = MECHFAB
	build_path = /obj/item/organ/tongue/robot_ipc
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	construction_time = 150
	category = list("Cybernetics")

/datum/design/ipclungs
	name = "I.P.C heatsink"
	id = "ipclungs"
	build_type = MECHFAB
	build_path = /obj/item/organ/lungs/robot_ipc
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	construction_time = 150
	category = list("Cybernetics")

/datum/design/ipcheart
	name = "I.P.C hydraulic pump"
	id = "ipcheart"
	build_type = MECHFAB
	build_path = /obj/item/organ/heart/robot_ipc
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	construction_time = 150
	category = list("Cybernetics")

/datum/design/ipcliver
	name = "I.P.C reagent unit"
	id = "ipcliver"
	build_type = MECHFAB
	build_path = /obj/item/organ/liver/robot_ipc
	materials = list(/datum/material/iron = 500, /datum/material/glass = 500)
	construction_time = 150
	category = list("Cybernetics")

// ===IPC PARTS===

/obj/item/ipc_deployer
	name = "I.P.C shell deployer"
	desc = "A kit that contains everything needed to deploy a new and hollow I.P.C shell."
	icon = 'icons/mob/augmentation/augments.dmi'
	icon_state = "robo_suit"

// ===IPC DEPLOYMENT===
///obj/item/ipc_deployer/AltClick(mob/living/user)
/obj/item/bodypart/chest/robot/AltClick(mob/living/user)
	var/mob/living/carbon/human/species/ipc/newipc = new /mob/living/carbon/human/species/ipc
	newipc.forceMove(drop_location())
	qdel(newipc.getorganslot(ORGAN_SLOT_BRAIN))
	qdel(newipc.getorganslot(ORGAN_SLOT_EYES))
	qdel(newipc.getorganslot(ORGAN_SLOT_EARS))
	qdel(newipc.getorganslot(ORGAN_SLOT_TONGUE))
	qdel(newipc.getorganslot(ORGAN_SLOT_LIVER))
	qdel(newipc.getorganslot(ORGAN_SLOT_HEART))
	qdel(newipc.getorganslot(ORGAN_SLOT_LUNGS))
	qdel(newipc.getorganslot(ORGAN_SLOT_STOMACH))
	qdel(newipc.getorganslot(ORGAN_SLOT_LEFT_ARM_AUG))
	qdel(newipc.get_bodypart(BODY_ZONE_L_ARM))
	qdel(newipc.get_bodypart(BODY_ZONE_R_ARM))
	qdel(newipc.get_bodypart(BODY_ZONE_L_LEG))
	qdel(newipc.get_bodypart(BODY_ZONE_R_LEG))
	qdel(newipc.get_bodypart(BODY_ZONE_HEAD))
	newipc.update_body()
	qdel(src)
///obj/item/ipc_deployer/examine(mob/user)
/*
/obj/item/bodypart/chest/robot/examine(mob/user)
	to_chat(user, span_boldnotice("Alt-click to deploy the torso as an I.P.C base, the base initially contains no organs, limbs or brain, those you will have to put in yourself."))
*/
