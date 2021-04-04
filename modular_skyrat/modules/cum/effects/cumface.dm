//you got cum on your face bro *licks it off*
/datum/component/cumfaced
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/mutable_appearance/cumface

/datum/component/cumfaced/Initialize()
	if(!is_type_in_typecache(parent, GLOB.creamable))
		return COMPONENT_INCOMPATIBLE

	SEND_SIGNAL(parent, COMSIG_MOB_CUMFACED)

	cumface = mutable_appearance('modular_skyrat/modules/cum/cum.dmi')

	if(ishuman(parent))
		var/mob/living/carbon/human/H = parent
		if(H.dna.species.limbs_id == "lizard")
			cumface.icon_state = "cumface_lizard"
		else if(H.dna.species.limbs_id == "monkey")
			cumface.icon_state = "cumface_monkey"
		else if(H.dna.species.id == "vox")
			cumface.icon_state = "cumface_vox"
		else if(H.dna.species.mutant_bodyparts["snout"])
			cumface.icon_state = "cumface_lizard"
		else
			cumface.icon_state = "cumface_human"
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

/datum/component/cumfaced/big
	dupe_mode = COMPONENT_DUPE_UNIQUE_PASSARGS

	var/mutable_appearance/bigcumface

/datum/component/cumfaced/big/Initialize()
	if(!is_type_in_typecache(parent, GLOB.creamable))
		return COMPONENT_INCOMPATIBLE

	SEND_SIGNAL(parent, COMSIG_MOB_CUMFACED)

	bigcumface = mutable_appearance('modular_skyrat/modules/cum/cum.dmi')

	if(ishuman(parent))
		var/mob/living/carbon/human/H = parent
		if(H.dna.species.limbs_id == "lizard")
			bigcumface.icon_state = "bigcumface_lizard"
		else if(H.dna.species.limbs_id == "monkey")
			bigcumface.icon_state = "bigcumface_monkey"
		else if(H.dna.species.id == "vox")
			bigcumface.icon_state = "bigcumface_vox"
		else if(H.dna.species.mutant_bodyparts["snout"])
			bigcumface.icon_state = "bigcumface_lizard"
		else
			bigcumface.icon_state = "bigcumface_human"
	else if(isAI(parent))
		bigcumface.icon_state = "cumface_ai"

	var/atom/A = parent
	A.add_overlay(bigcumface)

/datum/component/cumfaced/big/Destroy(force, silent)
	var/atom/A = parent
	A.cut_overlay(bigcumface)
	qdel(bigcumface)
	return ..()
