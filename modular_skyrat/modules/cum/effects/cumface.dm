//you got cum on your face bro *licks it off*
/datum/component/cumfaced
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/mutable_appearance/cumface

/datum/component/cumfaced/Initialize()
	if(!is_type_in_typecache(parent, GLOB.creamable))
		return COMPONENT_INCOMPATIBLE

	SEND_SIGNAL(parent, COMSIG_MOB_CUMFACED)

	cumface = mutable_appearance('modular_skyrat/modules/cum/cumface.dmi')

	if(ishuman(parent))
		var/mob/living/carbon/human/H = parent
		if(H.dna.species.limbs_id == "lizard")
			cumface.icon_state = "cumface_lizard"
		else if(H.dna.species.limbs_id == "monkey")
			cumface.icon_state = "cumface_monkey"
		else
			cumface.icon_state = "cumface_human"
//	else if(iscorgi(parent))
//		creamface.icon_state = "cumface_corgi"
//im not fucking letting people cum on the corgi
	else if(isAI(parent))
		cumface.icon_state = "cumface_ai"

	var/atom/A = parent
	A.add_overlay(cumface)

/datum/component/cumfaced/Destroy(force, silent)
	var/atom/A = parent
	A.cut_overlay(cumface)
	qdel(cumface)
	return ..()

/datum/component/cumfaced/RegisterWithParent()
	RegisterSignal(parent, list(
		COMSIG_COMPONENT_CLEAN_ACT,
		COMSIG_COMPONENT_CLEAN_FACE_ACT),
		.proc/clean_up)

/datum/component/cumfaced/UnregisterFromParent()
	UnregisterSignal(parent, list(
		COMSIG_COMPONENT_CLEAN_ACT,
		COMSIG_COMPONENT_CLEAN_FACE_ACT))

///Callback to remove pieface
/datum/component/cumfaced/proc/clean_up(datum/source, clean_types)
	SIGNAL_HANDLER

	. = NONE
	if(!(clean_types & CLEAN_TYPE_BLOOD))
		qdel(src)
		return COMPONENT_CLEANED
