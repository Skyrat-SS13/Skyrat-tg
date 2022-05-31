// MODULAR ID TRIM ACCESS OVERRIDES GO HERE!!

/datum/id_trim/job/head_of_security
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'

/datum/id_trim/job/warden
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'

/datum/id_trim/job/security_officer
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'

/datum/id_trim/job/head_of_security/New()
	. = ..()

	minimal_access |= list(ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP)

/datum/id_trim/job/warden/New()
	. = ..()

	minimal_access |= list(ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP)

/datum/id_trim/job/security_officer/New()
	. = ..()

	minimal_access |= list(ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP)

/datum/id_trim/job/chief_engineer/New()
	. = ..()

	minimal_access |= ACCESS_WEAPONS

/datum/id_trim/job/atmospheric_technician/New()
	. = ..()

	minimal_access |= ACCESS_ENGINE_EQUIP

/datum/id_trim/job/chief_medical_officer/New()
	. = ..()

	minimal_access |= ACCESS_WEAPONS

/datum/id_trim/job/research_director/New()
	. = ..()

	minimal_access |= ACCESS_WEAPONS


/datum/id_trim/job/head_of_personnel/New()
	. = ..()

	minimal_access |= ACCESS_WEAPONS

/datum/id_trim/job/quartermaster/New()
	. = ..()

	minimal_access |= list(ACCESS_BRIG_ENTRANCE, ACCESS_COMMAND, ACCESS_KEYCARD_AUTH, ACCESS_WEAPONS)

/datum/id_trim/job/blueshield
	assignment = "Blueshield"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_blueshield"
	sechud_icon_state = SECHUD_BLUESHIELD
	extra_access = list(ACCESS_SECURITY, ACCESS_BRIG, ACCESS_COURT, ACCESS_CARGO, ACCESS_GATEWAY) // Someone needs to come back and order these alphabetically, this is a nightmare
	minimal_access = list(
		ACCESS_DETECTIVE, ACCESS_BRIG_ENTRANCE, ACCESS_MEDICAL, ACCESS_CONSTRUCTION, ACCESS_ENGINEERING, ACCESS_MAINT_TUNNELS, ACCESS_RESEARCH,
		ACCESS_RC_ANNOUNCE, ACCESS_COMMAND, ACCESS_WEAPONS, ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP
		)
	minimal_wildcard_access = list(ACCESS_CAPTAIN)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CHANGE_IDS)

/datum/id_trim/job/nanotrasen_consultant
	assignment = "Nanotrasen Consultant"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_nanotrasenconsultant"
	sechud_icon_state = SECHUD_NT_CONSULTANT
	extra_access = list()
	minimal_access = list(ACCESS_SECURITY, ACCESS_BRIG_ENTRANCE, ACCESS_COURT, ACCESS_WEAPONS,
				ACCESS_MEDICAL, ACCESS_PSYCHOLOGY, ACCESS_ENGINEERING, ACCESS_CHANGE_IDS, ACCESS_AI_UPLOAD, ACCESS_EVA, ACCESS_COMMAND,
				ACCESS_ALL_PERSONAL_LOCKERS, ACCESS_MAINT_TUNNELS, ACCESS_BAR, ACCESS_JANITOR, ACCESS_CONSTRUCTION, ACCESS_MORGUE,
				ACCESS_CREMATORIUM, ACCESS_KITCHEN, ACCESS_HYDROPONICS, ACCESS_LAWYER,
				ACCESS_MECH_ENGINE, ACCESS_MECH_SCIENCE, ACCESS_MECH_SECURITY, ACCESS_MECH_MEDICAL,
				ACCESS_THEATRE, ACCESS_CHAPEL_OFFICE, ACCESS_LIBRARY, ACCESS_RESEARCH, ACCESS_VAULT, ACCESS_MINING_STATION,
				ACCESS_HOP, ACCESS_RC_ANNOUNCE, ACCESS_KEYCARD_AUTH, ACCESS_GATEWAY, ACCESS_MINERAL_STOREROOM, ACCESS_AUX_BASE, ACCESS_TELEPORTER, ACCESS_CENT_GENERAL)
	minimal_wildcard_access = list(ACCESS_CAPTAIN, ACCESS_CENT_GENERAL)
	template_access = list(ACCESS_CAPTAIN, ACCESS_CHANGE_IDS)

/datum/id_trim/job/security_medic
	assignment = "Security Medic"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_securitymedic"
	sechud_icon_state = SECHUD_SECURITY_MEDIC
	extra_access = list(ACCESS_DETECTIVE)
	minimal_access = list(ACCESS_SECURITY, ACCESS_BRIG_ENTRANCE, ACCESS_BRIG, ACCESS_COURT, ACCESS_WEAPONS, ACCESS_MECH_SECURITY, ACCESS_MINERAL_STOREROOM,
	ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP, ACCESS_MAINT_TUNNELS)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)

/datum/id_trim/job/security_medic/New()
	. = ..()

	// Config check for if sec has maint access.
	if(CONFIG_GET(flag/security_has_maint_access))
		access |= list(ACCESS_MAINT_TUNNELS)

/datum/id_trim/job/expeditionary_trooper
	assignment = "Vanguard Operative"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_expeditionarytrooper"
	sechud_icon_state = SECHUD_VANGUARD_OPERATIVE
	extra_access = list()
	minimal_access = list(ACCESS_MAINT_TUNNELS, ACCESS_EVA, ACCESS_EXTERNAL_AIRLOCKS, ACCESS_TELEPORTER, ACCESS_GATEWAY, ACCESS_TECH_STORAGE,
		ACCESS_CENT_GENERAL, ACCESS_RESEARCH, ACCESS_SCIENCE)

/datum/id_trim/job/brigoff
	assignment = "Corrections Officer"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_brigoff"
	sechud_icon_state = SECHUD_CORRECTIONS_OFFICER
	extra_access = list()
	minimal_access = list(ACCESS_SECURITY, ACCESS_BRIG_ENTRANCE, ACCESS_BRIG, ACCESS_COURT,
				ACCESS_MAINT_TUNNELS, ACCESS_ENTER_GENPOP, ACCESS_LEAVE_GENPOP)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOS, ACCESS_CHANGE_IDS)
	job = /datum/job/brigoff

/datum/id_trim/job/barber
	assignment = "Barber"
	trim_icon = 'modular_skyrat/master_files/icons/obj/card.dmi'
	trim_state = "trim_barber"
	sechud_icon_state = SECHUD_BARBER
	extra_access = list()
	minimal_access = list(ACCESS_THEATRE, ACCESS_MAINT_TUNNELS, ACCESS_BARBER, ACCESS_SERVICE)
	template_access = list(ACCESS_CAPTAIN, ACCESS_HOP, ACCESS_CHANGE_IDS)
	job = /datum/job/barber
