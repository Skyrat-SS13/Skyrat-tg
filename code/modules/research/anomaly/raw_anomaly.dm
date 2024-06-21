/**
 * # Raw Anomaly Cores
 *
 * The current precursor to anomaly cores, these are manufactured into 'finished' anomaly cores for use in research, items, and more.
 *
 * The current amounts created is stored in `SSresearch.created_anomaly_types[ANOMALY_CORE_TYPE_DEFINE] = amount`.
 * The hard limits are in `code/__DEFINES/anomalies.dm`.
 */
/obj/item/raw_anomaly_core
	name = "raw anomaly core"
	desc = "You shouldn't be seeing this. Someone screwed up."
	icon = 'icons/obj/devices/new_assemblies.dmi'
	icon_state = "broken_state"

	/// Anomaly type
	var/anomaly_type

/obj/item/raw_anomaly_core/bluespace
	name = "raw bluespace core"
	desc = "The raw core of a bluespace anomaly, glowing and full of potential."
	anomaly_type = /obj/item/assembly/signaler/anomaly/bluespace
	icon_state = "rawcore_bluespace"

/obj/item/raw_anomaly_core/vortex
	name = "raw vortex core"
	desc = "The raw core of a vortex anomaly. Feels heavy to the touch."
	anomaly_type = /obj/item/assembly/signaler/anomaly/vortex
	icon_state = "rawcore_vortex"

/obj/item/raw_anomaly_core/grav
	name = "raw gravity core"
	desc = "The raw core of a gravity anomaly. The air seems attracted to it."
	anomaly_type = /obj/item/assembly/signaler/anomaly/grav
	icon_state = "rawcore_grav"

/obj/item/raw_anomaly_core/pyro
	desc = "The raw core of a pyro anomaly. It is warm to the touch."
	name = "raw pyro core"
	anomaly_type = /obj/item/assembly/signaler/anomaly/pyro
	icon_state = "rawcore_pyro"

/obj/item/raw_anomaly_core/flux
	name = "raw flux core"
	desc = "The raw core of a flux anomaly, faintly crackling with energy."
	anomaly_type = /obj/item/assembly/signaler/anomaly/flux
	icon_state = "rawcore_flux"

/obj/item/raw_anomaly_core/hallucination
	name = "raw hallucination core"
	desc = "The raw core of a hallucination anomaly, makes your head spin."
	anomaly_type = /obj/item/assembly/signaler/anomaly/hallucination
	icon_state = "rawcore_hallucination"

/obj/item/raw_anomaly_core/random
	name = "random raw core"
	desc = "You should not see this!"
	icon_state = "rawcore_bluespace"

/obj/item/raw_anomaly_core/bioscrambler
	name = "raw bioscrambler core"
	desc = "The raw core of a bioscrambler anomaly, it squirms."
	anomaly_type = /obj/item/assembly/signaler/anomaly/bioscrambler
	icon_state = "rawcore_bioscrambler"

/obj/item/raw_anomaly_core/dimensional
	name = "raw dimensional core"
	desc = "The raw core of a dimensional anomaly, vibrating with infinite potential."
	anomaly_type = /obj/item/assembly/signaler/anomaly/dimensional
	icon_state = "rawcore_dimensional"

/obj/item/raw_anomaly_core/ectoplasm //Has no cargo order option, but can sometimes be a roundstart pick
	name = "raw ectoplasm core"
	desc = "The raw core of an ectoplasmic anomaly. It wants to share its secrets with you."
	anomaly_type = /obj/item/assembly/signaler/anomaly/ectoplasm
	icon_state = "rawcore_dimensional"

/obj/item/raw_anomaly_core/random/Initialize(mapload)
	. = ..()
	var/path = pick(subtypesof(/obj/item/raw_anomaly_core))
	new path(loc)
	return INITIALIZE_HINT_QDEL

/**
 * Created the resulting core after being "made" into it.
 *
 * Arguments:
 * * newloc - Where the new core will be created
 * * del_self - should we qdel(src)
 * * count_towards_limit - should we increment the amount of created cores on SSresearch
 */
/obj/item/raw_anomaly_core/proc/create_core(newloc, del_self = FALSE, count_towards_limit = FALSE)
	. = new anomaly_type(newloc)
	if(count_towards_limit)
		SSresearch.increment_existing_anomaly_cores(anomaly_type)
	if(del_self)
		qdel(src)

/// Doesn't do anything, consolation prize if you neu
/obj/item/inert_anomaly
	name = "inert anomaly core"
	desc = "A chunk of fused exotic materials. Useless to you, but some other lab might purchase it."
	icon = 'icons/obj/devices/new_assemblies.dmi'
	icon_state = "rawcore_inert"
