/datum/station_trait/cybernetic_revolution/New()
	job_to_cybernetic += list(
		/datum/job/blueshield = /obj/item/organ/internal/cyberimp/brain/anti_stun,
		/datum/job/nanotrasen_consultant = /obj/item/organ/internal/heart/cybernetic/tier3,
		/datum/job/barber = /obj/item/organ/internal/ears/cybernetic/upgraded,
		/datum/job/corrections_officer = /obj/item/organ/internal/cyberimp/arm/flash,
		/datum/job/orderly = /obj/item/organ/internal/cyberimp/brain/anti_drop,
		/datum/job/science_guard = /obj/item/organ/internal/cyberimp/arm/flash,
		/datum/job/customs_agent = /obj/item/organ/internal/cyberimp/eyes/hud/security,
		/datum/job/bouncer = /obj/item/organ/internal/cyberimp/arm/muscle,
		/datum/job/engineering_guard = /obj/item/organ/internal/cyberimp/arm/flash,
	return ..()
